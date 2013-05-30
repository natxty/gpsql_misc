import csv
import itertools

cu_itype = {
	'customerservice':'Customer Service',
	'technicalsupport':'Technical Support',
	'distributers':'Sales and Distribution',
	'locations':'Locations'	
}

def flatten2dict(li,f1='name',f2='id'):
	d = {}
	[d.update({i[f1] :int(i[f2]) }) for i in li]
	return d

def cu_contacts_data():
	fieldnames = ['contact_id', 'informationtype', 'productservicetype', 'productserviceline', 'productservicename', 'location_id', 'dateadded'];
	contactsReader = csv.DictReader(open('/Users/temp/Documents/Gen-Probe/Contact Us Revision/cu_contacts.csv', 'rb'), fieldnames);
	contactsList = list(contactsReader)[1:];
	return contactsList

def cu_locations_data():
	fieldnames = ['location_id', 'dropdownname', 'locationname', 'contactname', 'addressline1', 'addressline2', 'addressline3', 'phone1', 'phone2', 'phone3', 'fax1', 'fax2', 'email', 'website', 'locationtext', 'locationcomments', 'addr_id', 'addressoverride', 'sortorder'];
	reader = csv.DictReader(open('/Users/temp/Documents/Gen-Probe/Contact Us Revision/cu_locations.csv', 'rb'), fieldnames);
	li = list(reader)[1:];
	return li

def readerList(fieldnames, path, hasColumnNames = True):
	contactsReader = csv.DictReader(open(path, 'rb'), fieldnames);

	if hasColumnNames:
		contactsList = list(contactsReader)[1:];
	else:
		contactsList = list(contactsReader)
		
	return contactsList

def csv_data(file,fieldnames):
	reader = csv.DictReader(open('/Users/temp/Documents/Gen-Probe/Contact Us Revision/%s.csv' % (file), 'rb'), fieldnames);
	li = list(reader)[1:];
	return li

def main():
	itype_to_pstype = readerList(['itype_name', 'pstype_name', 'id'],'/Users/temp/Documents/Gen-Probe/Contact Us Revision/itype_to_pstype.csv',False);
	itype_to_psline = readerList(['itype_name', 'psline_name', 'id'],'/Users/temp/Documents/Gen-Probe/Contact Us Revision/itype_to_psline.csv',False);

	itype_pstype_to_psname = readerList(['id', 'informationtype_productservicetype_id', 'productservicename_id'], '/Users/temp/Documents/Gen-Probe/Contact Us Revision/itype_pstype_to_psname.csv',False);
	itype_psline_to_psname = readerList(['id', 'informationtype_productserviceline_id', 'productservicename_id'], '/Users/temp/Documents/Gen-Probe/Contact Us Revision/itype_psline_to_psname.csv',False);
	
	location = readerList(['id','name'], '/Users/temp/Documents/Gen-Probe/Contact Us Revision/location.csv', False);
	locationList = {}
	for row in location:
		locationList[row['name'].strip()] = row['id'];

	productservicename = readerList(['id','name'],'/Users/temp/Documents/Gen-Probe/Contact Us Revision/neu_productservicename.csv',False);
	psnameList = {}
	for row in productservicename:
		psnameList[row['name'].strip()] = row['id']
		
	cu_contacts = cu_contacts_data();
	cu_locations = cu_locations_data();
	
	cu_locationsList = {}
	for row in cu_locations:
		cu_locationsList[row['location_id']] = row['dropdownname'].strip();
	

	cu_locationsNameList = {}
	for row in cu_locations:
		cu_locationsNameList[row['location_id']] = row['locationname'].strip();
	
	contact = readerList(['id','label','ref_id'],'/Users/temp/Documents/Gen-Probe/Contact Us Revision/neu_contact.csv',False)
	contact_dict = flatten2dict(contact, 'ref_id','id');

	sqlStatements = [];
	
	simpleDB = {};
	
	
	itype_pstype_psname_to_locat = readerList(['id','informationtype_productservicetype_productservicename_id', 'location_id'],'/Users/temp/Documents/Gen-Probe/Contact Us Revision/itype_psline_psname_to_locat.csv',False);
	
	
	itype_psline_psname_to_locat = readerList(['id','informationtype_productserviceline_productservicename_id', 'location_id'],'/Users/temp/Documents/Gen-Probe/Contact Us Revision/itype_pstype_psname_to_locat.csv',False);
	
	
	for row in cu_contacts:
		itype = cu_itype[row['informationtype'].strip()];
		pstype = row['productservicetype'].strip();
		psline = row['productserviceline'].strip();
		psname = row['productservicename'].strip();
		locat_id  = row['location_id'].strip();
		
		for _row in itype_to_pstype:
			_itype = _row['itype_name'].strip();
			_pstype = _row['pstype_name'].strip();
			
			if _itype == itype and _pstype == pstype:
			
				if psname in psnameList.keys():

					for __row in itype_pstype_to_psname:
						itype_pstype_id = __row['informationtype_productservicetype_id'];
						psname_id = psnameList[psname];
						_psname_id = __row['productservicename_id'];

						if _row['id'] == itype_pstype_id and psname_id == _psname_id:							
							locatname = cu_locationsList[locat_id];
							
							if locatname in locationList.keys():
								for ___row in itype_pstype_psname_to_locat:
									itype_pstype_psname_id = ___row['informationtype_productservicetype_productservicename_id'];
									_locat_id = ___row['location_id'];
									if _locat_id == locationList[locatname] and __row['id'] == itype_pstype_psname_id:
										s = "INSERT INTO informationtype_productservicetype_productservicename_location_to_contact (informationtype_productservicetype_productservicename_location_id, contact_id) VALUES (%s,%s);" % (___row['id'], contact_dict[locat_id]);
										sqlStatements.append(s);
										#facilityname = cu_locationsNameList[locat_id];
										#print "itype:%s -> pstype:%s -> psname:%s -> locatname:%s -> facilityname:%s" % (itype, pstype, psname,locatname,facilityname );
								pass
							else:
								#print 'NOT FOUND: %s' % (locatname);
								#print "itype:%s -> pstype:%s -> psname:%s -> locatname:%s" % (itype, pstype, psname, locatname)
								pass
					pass
				else:
					#print "Product Name Not found: %s" % (psname)
					pass
					
		for _row in itype_to_psline:
			_itype = _row['itype_name'].strip();
			_psline = _row['psline_name'].strip();
			
			if _itype == itype and _psline == psline:
			
				if psname in psnameList.keys():

					for __row in itype_psline_to_psname:
						itype_psline_id = __row['informationtype_productserviceline_id'];
						psname_id = psnameList[psname];
						_psname_id = __row['productservicename_id'];

						if _row['id'] == itype_psline_id and psname_id == _psname_id:							
							locatname = cu_locationsList[locat_id];
							
							if locatname in locationList.keys():
								for ___row in itype_psline_psname_to_locat:
									itype_psline_psname_id = ___row['informationtype_productserviceline_productservicename_id'];
									_locat_id = ___row['location_id'];
									if _locat_id == locationList[locatname] and __row['id'] == itype_psline_psname_id:
										s = "INSERT INTO informationtype_productserviceline_productservicename_location_to_contact (informationtype_productserviceline_productservicename_location_id, contact_id) VALUES (%s,%s);" % (___row['id'], contact_dict[locat_id]);
										sqlStatements.append(s);
										#facilityname = cu_locationsNameList[locat_id];
										#print "itype:%s -> psline:%s -> psname:%s -> locatname:%s -> facilityname:%s" % (itype, psline, psname,locatname,facilityname );
								pass
							else:
								#print 'NOT FOUND: %s' % (locatname);
								#print "itype:%s -> psline:%s -> psname:%s -> locatname:%s" % (itype, psline, psname, locatname)
								pass
					pass
				else:
					#print "Product Name Not found: %s" % (psname)
					pass
					
						
	f = open('/Users/temp/Documents/Gen-Probe/Contact Us Revision/contactlinking.sql','wb');
	f.write('\n'.join(set(sqlStatements)));
	f.close();				
	#print len(sqlStatements), len(set(sqlStatements))
	#print len(simpleDB.keys());			
		
def main2():

	"""
	contact = csv_data('contact', ['id','name']);
	contact_dict = flatten2dict(contact);
	
	address = csv_data('address', ['id','address']);
	address_dict = flatten2dict(address, 'address');

	website = csv_data('website', ['id','url']);
	website_dict = flatten2dict(website, 'url');
	
	phone = csv_data('phone',['id','number']);
	phone_dict = flatten2dict(phone, 'number');
	
	locations = csv_data('locations',['id','name']);
	locations_dict = flatten2dict(locations);
	
	fax = csv_data('fax',['id','number']);
	fax_dict = flatten2dict(fax, 'number');
	
	email = csv_data('email',['id','email']);
	email_dict = flatten2dict(email, 'email');
	"""
	
	cu_locations = cu_locations_data();
	
	for row in cu_locations:
		print "INSERT INTO contact ('ref_id') VALUES (%s);" % ( row['location_id'] );
	
	

def main3():

	def makeQuery( table, col1, col2, colval1, colval2, item_order, li ):
		s="INSERT INTO %s (%s,%s,item_order) VALUES (%s,%s,%s);" % (table, col1, col2, colval1, colval2, item_order)
		li.append(s);

	#create ref_id key to contact_id value dict
	contact = readerList(['id','label','ref_id'],'/Users/temp/Documents/Gen-Probe/Contact Us Revision/neu_contact.csv',False)
	contact_dict = flatten2dict(contact, 'ref_id','id');

	person = csv_data('person', ['id','name']);
	person_dict = flatten2dict(person);
	
	address = csv_data('address', ['id','address']);
	address_dict = flatten2dict(address, 'address');

	website = csv_data('website', ['id','url']);
	website_dict = flatten2dict(website, 'url');
	
	phone = csv_data('phone',['id','number']);
	phone_dict = flatten2dict(phone, 'number');
	
	facility = csv_data('facility',['id','name']);
	facility_dict = flatten2dict(facility);
	
	fax = csv_data('fax',['id','number']);
	fax_dict = flatten2dict(fax, 'number');
	
	email = csv_data('email',['id','email']);
	email_dict = flatten2dict(email, 'email');

	#iterate over the cu_locations matching to the ref_id
	cu_locations = cu_locations_data();
	
	sql = [];
	incomplete = {};
	
	#['location_id', 'dropdownname', 'locationname', 'contactname', 'addressline1', 'addressline2', 'addressline3', 'phone1', 'phone2', 'phone3', 'fax1', 'fax2', 'email', 'website', 'locationtext', 'locationcomments', 'addr_id', 'addressoverride', 'sortorder']
	
	for row in cu_locations:
		
		contact_id 	= contact_dict[ row['location_id'] ];
		address1 	= row['addressline1']
		address2 	= row['addressline2']
		address3 	= row['addressline3']
		facility 	= row['locationname']
		phone1 		= row['phone1']
		phone2		= row['phone2']
		phone3		= row['phone3']
		fax1		= row['fax1']
		fax2		= row['fax2']
		email		= row['email']
		website		= row['website']
		person		= row['contactname']
		incomplete[contact_id] = [];
		
		"""
		if address1 and (address1 in address_dict.keys()):
			makeQuery('contact_to_address', 'contact_id', 'address_id', contact_id, address_dict[address1], 1, sql);
		elif address1:
			incomplete[contact_id].append(('address1',address1));

		if address2 and (address2 in address_dict.keys()):
			makeQuery('contact_to_address', 'contact_id', 'address_id', contact_id, address_dict[address2], 2, sql);
		elif address2:
			incomplete[contact_id].append(('address2',address2));

		if address3 and (address3 in address_dict.keys()):
			makeQuery('contact_to_address', 'contact_id', 'address_id', contact_id, address_dict[address3], 3, sql);
		elif address2:
			incomplete[contact_id].append(('address3',address3));

		if facility and (facility in facility_dict.keys()):
			makeQuery('contact_to_facility', 'contact_id', 'facility_id', contact_id, facility_dict[facility], 1, sql);
		elif facility:
			incomplete[contact_id].append(('facility',facility));

		if phone1 and (phone1 in phone_dict.keys()):
			makeQuery('contact_to_phone', 'contact_id', 'phone_id', contact_id, phone_dict[phone1], 1, sql);
		elif phone1:
			incomplete[contact_id].append(('phone1',phone1));

		if phone2 and (phone2 in phone_dict.keys()):
			makeQuery('contact_to_phone', 'contact_id', 'phone_id', contact_id, phone_dict[phone2], 2, sql);
		elif phone2:
			incomplete[contact_id].append(('phone2',phone2));

		if phone3 and (phone3 in phone_dict.keys()):
			makeQuery('contact_to_phone', 'contact_id', 'phone_id', contact_id, phone_dict[phone3], 3, sql);
		elif phone3:
			incomplete[contact_id].append(('phone3',phone3));

		if fax1 and (fax1 in fax_dict.keys()):
			makeQuery('contact_to_fax', 'contact_id', 'fax_id', contact_id, fax_dict[fax1], 1, sql);
		elif fax1:
			incomplete[contact_id].append(('fax1',fax1));

		if fax2 and (fax2 in fax_dict.keys()):
			makeQuery('contact_to_fax', 'contact_id', 'fax_id', contact_id, fax_dict[fax2], 2, sql);
		elif fax2:
			incomplete[contact_id].append(('fax2',fax2));
			
		if email and (email in email_dict.keys()):
			makeQuery('contact_to_email', 'contact_id', 'email_id', contact_id, email_dict[email], 1, sql);
		elif email:
			incomplete[contact_id].append(('email',email));
			
		if website and (website in website_dict.keys()):
			makeQuery('contact_to_website', 'contact_id', 'website_id', contact_id, website_dict[website], 1, sql);
		elif website:
			incomplete[contact_id].append(('website',website));						
		"""
		if person and (person in person_dict.keys()):
			makeQuery('contact_to_person', 'contact_id', 'person_id', contact_id, person_dict[person], 1, sql);
		elif person:
			incomplete[contact_id].append(('person',person));		

	"""
	fs = [];
	for key in sorted(incomplete.keys()):
		value = incomplete[key];
		if not value: continue;
		s =  "%s:\n\t\t%s\n\n" % (key,value)
		fs.append(s);
		
	f = open('/Users/temp/Documents/Gen-Probe/Contact Us Revision/revise.txt','wb');
	f.write(''.join(fs));
	f.close();		
	"""

	f = open('/Users/temp/Documents/Gen-Probe/Contact Us Revision/contactsql.sql','wb');
	f.write('\n'.join(sql));
	f.close();	
	
	#pull in the correct id's from the other contact information tables (address, website etc... export facility btw)


if __name__ == '__main__':
	main3()