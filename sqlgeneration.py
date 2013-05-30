import csv
import itertools

nljoin = lambda li: '\n'.join(li)
distinct = lambda li: list(set(li));	
fromKey = lambda k,li: map(lambda d: d[k].strip(), li)
extract = lambda f,li: sorted(distinct(fromKey(f,li)))

def cu_contacts_data():
	fieldnames = ['contact_id', 'informationtype', 'productservicetype', 'productserviceline', 'productservicename', 'location_id', 'dateadded'];
	contactsReader = csv.DictReader(open('/Users/temp/Documents/Gen-Probe/Contact Us Revision/cu_contacts.csv', 'rb'), fieldnames);
	contactsList = list(contactsReader)[1:];
	return contactsList

def db_prep_inserts():
	contactsList = cu_contacts_data();
	
	informationtype_li = sorted(distinct(fromKey('informationtype',contactsList)));
	productservicetype_li = sorted(distinct(fromKey('productservicetype',contactsList)));
	productserviceline_li = sorted(distinct(fromKey('productserviceline',contactsList)));
	productservicename_li = sorted(distinct(fromKey('productservicename',contactsList)));
	
	nljoin = lambda li: '\n'.join(li)
	
	"""
	print nljoin(informationtype_li)
	print '-'*10
	print nljoin(productservicetype_li)
	print '-'*10
	print nljoin(productserviceline_li)
	print '-'*10
	print nljoin(productservicename_li)
	"""
	
	gensql = lambda t,c,li: map(lambda i:"INSERT INTO %s (%s) VALUES ('%s');" % (t,c,i), li)
	
	print nljoin(gensql('informationtype', 'name', informationtype_li));
	print nljoin(gensql('productservicetype', 'name', productservicetype_li));
	print nljoin(gensql('productserviceline', 'name', productserviceline_li));
	print nljoin(gensql('productservicename', 'name', productservicename_li));

def flatten2dict(li,f1='name',f2='id'):
	d = {}
	[d.update({i[f1] :int(i[f2]) }) for i in li]
	return d

def informationtype_data():
	fieldnames = ['id','name'];
	reader = csv.DictReader(open('/Users/temp/Documents/Gen-Probe/Contact Us Revision/informationtype.csv', 'rb'), fieldnames);
	li = list(reader)[1:];
	return li
	
def productservicetype_data():
	fieldnames = ['id','name'];
	reader = csv.DictReader(open('/Users/temp/Documents/Gen-Probe/Contact Us Revision/productservicetype.csv', 'rb'), fieldnames);
	li = list(reader)[1:];
	return li
	
def productserviceline_data():
	fieldnames = ['id','name'];
	reader = csv.DictReader(open('/Users/temp/Documents/Gen-Probe/Contact Us Revision/productserviceline.csv', 'rb'), fieldnames);
	li = list(reader)[1:];
	return li

def productservicename_data():
	fieldnames = ['id','name'];
	reader = csv.DictReader(open('/Users/temp/Documents/Gen-Probe/Contact Us Revision/productservicename.csv', 'rb'), fieldnames);
	li = list(reader)[1:];
	return li
	
def map_informationtype_to_productservicetype():
 	informationtype = informationtype_data();
 	informationtype_dict = flatten2dict(informationtype)
 	
 	productservicetype = productservicetype_data();
	productservicetype_dict = flatten2dict(productservicetype)
	
 	contacts = cu_contacts_data();
 	
 	pairs = []
 	for row in contacts:
 		it = row['informationtype'].strip()
 		pst = row['productservicetype'].strip()
 		pairs.append( (informationtype_dict[it], productservicetype_dict[pst]) );
 		
 	pairs = sorted(pairs)
 	pairs = list(pairs for pairs,_ in itertools.groupby(pairs));
 	gensql = lambda t:"INSERT INTO %s (informationtype_id,productservicetype_id) VALUES (%s,%s);" % ('informationtype_to_productservicetype',t[0],t[1])
 	print nljoin(map(gensql, pairs)) 	

def map_informationtype_to_productserviceline():
 	informationtype = informationtype_data();
 	informationtype_dict = flatten2dict(informationtype)
 	
 	productserviceline = productserviceline_data();
	productserviceline_dict = flatten2dict(productserviceline)
	
 	contacts = cu_contacts_data();
 	
 	pairs = []
 	for row in contacts:
 		it = row['informationtype'].strip()
 		pst = row['productserviceline'].strip()
 		pairs.append( (informationtype_dict[it], productserviceline_dict[pst]) );
 		
 	pairs = sorted(pairs)
 	pairs = list(pairs for pairs,_ in itertools.groupby(pairs));
 	gensql = lambda t:"INSERT INTO %s (informationtype_id,productserviceline_id) VALUES (%s,%s);" % ('informationtype_to_productserviceline',t[0],t[1])
 	print nljoin(map(gensql, pairs)) 

def map_productservicetype_to_productservicename():
 	productservicetype = productservicetype_data();
	productservicetype_dict = flatten2dict(productservicetype)
 	
 	productservicename = productservicename_data();
	productservicename_dict = flatten2dict(productservicename)
	
 	contacts = cu_contacts_data();
 	
 	pairs = []
 	for row in contacts:
 		it = row['productservicetype'].strip()
 		pst = row['productservicename'].strip()
 		if (not it or not pst): continue;
 		pairs.append( (productservicetype_dict[it], productservicename_dict[pst]) );
 		
 	pairs = sorted(pairs)
 	pairs = list(pairs for pairs,_ in itertools.groupby(pairs));
 	gensql = lambda t:"INSERT INTO %s (productservicetype_id,productservicename_id) VALUES (%s,%s);" % ('productservicetype_to_productservicename',t[0],t[1])
 	print nljoin(map(gensql, pairs)) 

def map_productserviceline_to_productservicename():
 	productserviceline = productserviceline_data();
	productserviceline_dict = flatten2dict(productserviceline)
 	
 	productservicename = productservicename_data();
	productservicename_dict = flatten2dict(productservicename)
	
 	contacts = cu_contacts_data();
 	
 	pairs = []
 	for row in contacts:
 		it = row['productserviceline'].strip()
 		pst = row['productservicename'].strip()
 		if (not it or not pst): continue;
 		pairs.append( (productserviceline_dict[it], productservicename_dict[pst]) );
 		
 	pairs = sorted(pairs)
 	pairs = list(pairs for pairs,_ in itertools.groupby(pairs));
 	gensql = lambda t:"INSERT INTO %s (productserviceline_id,productservicename_id) VALUES (%s,%s);" % ('productserviceline_to_productservicename',t[0],t[1])
 	print nljoin(map(gensql, pairs)) 

def cu_locations_data():
	fieldnames = ['location_id', 'dropdownname', 'locationname', 'contactname', 'addressline1', 'addressline2', 'addressline3', 'phone1', 'phone2', 'phone3', 'fax1', 'fax2', 'email', 'website', 'locationtext', 'locationcomments', 'addr_id', 'addressoverride', 'sortorder'];
	reader = csv.DictReader(open('/Users/temp/Documents/Gen-Probe/Contact Us Revision/cu_locations.csv', 'rb'), fieldnames);
	li = list(reader)[1:];
	return li

def locations_data_prep():
	locations = cu_locations_data()
	
	dropdownname = extract('dropdownname',locations)
	
	addressline1 = extract('addressline1',locations)
	addressline2 = extract('addressline2',locations)
	addressline3 = extract('addressline3',locations)
	addresses = []
	addresses.extend(addressline1)
	addresses.extend(addressline2)
	addresses.extend(addressline3)		
	
	
	phone1 = extract('phone1',locations)
	phone2 = extract('phone2',locations)
	phone3 = extract('phone3',locations)
	phones = []
	phones.extend(phone1)
	phones.extend(phone2)
	phones.extend(phone3)
	
	fax1 = extract('fax1',locations)
	fax2 = extract('fax2',locations)
	faxes = []
	faxes.extend(fax1)
	faxes.extend(fax2)

	website = extract('website',locations)
	email = extract('email',locations)
	
	contactname = extract('contactname',locations)
	locationname = extract('locationname',locations)
	
	gensql = lambda t,c,li: map(lambda i:"INSERT INTO %s (%s) VALUES ('%s');" % (t,c,i), li)
	
	print nljoin(gensql('contact', 'name', contactname));
	print nljoin(gensql('locations', 'name', locationname));	
	
	output = ''
	
	output += nljoin(gensql('address', 'address', distinct(addresses)));
	output += nljoin(gensql('phone', 'number', distinct(phones)));
	output += nljoin(gensql('fax', 'number', distinct(faxes)));
	output += nljoin(gensql('website', 'url', website));
	output += nljoin(gensql('dropdownname', 'name', dropdownname));
	output += nljoin(gensql('email', 'email', email));
	
	"""
	f = open('/Users/temp/Documents/Gen-Probe/Contact Us Revision/location_sql.txt','w')
	f.write(output)
	f.close();
	"""

def csv_data(file,fieldnames):
	reader = csv.DictReader(open('/Users/temp/Documents/Gen-Probe/Contact Us Revision/%s.csv' % (file), 'rb'), fieldnames);
	li = list(reader)[1:];
	return li

def locations_relational_sync():
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
	
	dropdownname = csv_data('dropdownname',['id','name'])
	dropdownname_dict = flatten2dict(dropdownname);
	
	locations = cu_locations_data()
	
	#combine_by_ids(locations,'contactname','locationname',contact_dict,locations_dict,'locations_to_contact','contact_id','locations_id',1)
	#combine_by_ids(locations,'email','locationname',email_dict,locations_dict,'locations_to_email','email_id','locations_id',1)
	#combine_by_ids(locations,'dropdownname','locationname',dropdownname_dict,locations_dict,'locations_to_dropdownname','dropdownname_id','locations_id',0)
	#combine_by_ids(locations,'addressline1','locationname',address_dict,locations_dict,'locations_to_address','address_id','locations_id',1)
	#combine_by_ids(locations,'addressline2','locationname',address_dict,locations_dict,'locations_to_address','address_id','locations_id',2)
	#combine_by_ids(locations,'addressline3','locationname',address_dict,locations_dict,'locations_to_address','address_id','locations_id',3)
	
	#combine_by_ids(locations,'fax1','locationname',fax_dict,locations_dict,'locations_to_fax','fax_id','locations_id',1)
	#combine_by_ids(locations,'fax2','locationname',fax_dict,locations_dict,'locations_to_fax','fax_id','locations_id',2)
	
	#combine_by_ids(locations,'phone1','locationname',phone_dict,locations_dict,'locations_to_phone','phone_id','locations_id',1)
	#combine_by_ids(locations,'phone2','locationname',phone_dict,locations_dict,'locations_to_phone','phone_id','locations_id',2)
	#combine_by_ids(locations,'phone3','locationname',phone_dict,locations_dict,'locations_to_phone','phone_id','locations_id',3)
	
	combine_by_ids(locations,'website','locationname',website_dict,locations_dict,'locations_to_website','website_id','locations_id',1)	

def combine_by_ids(csv_data,col1_name,col2_name,tbl1_data,tbl2_data,table,table_col1,table_col2,item_order):
 	pairs = []
 	for row in csv_data: 		
 		v1 = row[col1_name].strip()
 		v2 = row[col2_name].strip()
 		
 		if not v1 or not v2: 
 			continue;
  		if not v1 in tbl1_data.keys(): 
  			continue;
 		if not v2 in tbl2_data.keys():
 			continue;		
 		
 		pairs.append( (tbl1_data[v1], tbl2_data[v2]) );
 		
 	pairs = sorted(pairs)	
 	pairs = list(pairs for pairs,_ in itertools.groupby(pairs));
 	
 	if not item_order:
 		gensql = lambda t:"INSERT INTO %s (%s,%s) VALUES (%s,%s);" % (table,table_col1,table_col2,t[0],t[1])
 	else:
 		gensql = lambda t:"INSERT INTO %s (%s,%s,item_order) VALUES (%s,%s,%s);" % (table,table_col1,table_col2,t[0],t[1],item_order)

 	print nljoin(map(gensql, pairs))


def contacts_to_locations():
	cu_contacts = cu_contacts_data();
	cu_locations = cu_locations_data();
	
	cu_locations_dict = flatten2dict(cu_locations,'locationname','location_id')
	cu_locations_dict = dict((v,k) for k, v in cu_locations_dict.iteritems())
	
	locations_data = csv_data('locations_neu',['id','name']);
	locations_data_dict = flatten2dict(locations_data)
	
	productservicename_data = csv_data('productservicename',['id','name']);
	productservicename_data_dict = flatten2dict(productservicename_data)
		
	pairs = []
	for row in cu_contacts:
		locations_id = int(row['location_id'].strip())
		productservicename = row['productservicename'].strip()
		
		if not locations_id or not productservicename: continue
		
		if not locations_id in cu_locations_dict.keys(): continue
		
		v1 = cu_locations_dict[locations_id]
		
		if not v1 in locations_data_dict.keys(): continue
		v2 = locations_data_dict[v1]
				
		pairs.append( ( v2, productservicename_data_dict[productservicename] ) );
	
 	pairs = sorted(pairs)
 	pairs = list(pairs for pairs,_ in itertools.groupby(pairs));
 	 	
  	gensql = lambda t:"INSERT INTO productservicename_to_locations (locations_id,productservicename_id) VALUES (%s,%s);" % (t[0],t[1])
 	print nljoin(map(gensql, pairs))	

	#locations = csv_data('locations_neu',['id','name']);
	#productservicename = csv_data('productservicename',['id','name']);
	
	
	

if __name__ == '__main__':
	#map_informationtype_to_productservicetype()
	#map_informationtype_to_productserviceline();
	#map_productservicetype_to_productservicename();	
 	#map_productserviceline_to_productservicename()
 	#locations_data_prep()
 	locations_relational_sync()
 	#contacts_to_locations();
 	