import csv
import itertools

"""
SELECT
	informationtype.name as itype, productservicetype.name as pstype, productservicename.name as psname, location.name as locat, informationtype_productservicetype_productservicename_to_location.id as id
FROM
	informationtype_productservicetype_productservicename_to_location
INNER JOIN
	informationtype_productservicetype_to_productservicename
ON
	informationtype_productservicetype_productservicename_to_location.informationtype_productservicetype_productservicename_id = informationtype_productservicetype_to_productservicename.id
INNER JOIN
	informationtype_to_productservicetype
ON
	informationtype_productservicetype_to_productservicename.informationtype_productservicetype_id = informationtype_to_productservicetype.id
INNER JOIN
	informationtype
ON
	informationtype_to_productservicetype.informationtype_id = informationtype.id
INNER JOIN
	productservicetype
ON
	informationtype_to_productservicetype.productservicetype_id = productservicetype.id
INNER JOIN
	productservicename
ON
	informationtype_productservicetype_to_productservicename.productservicename_id = productservicename.id
INNER JOIN
	location
ON
	informationtype_productservicetype_productservicename_to_location.location_id = location.id
"""


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
	

def get_cu_comparison_list():
	cu_contacts 	= cu_contacts_data();
	cu_locations 	= cu_locations_data();
	cu_comparison_list = []
	
	for contact in cu_contacts:
		location_id = contact['location_id'];
		for location in cu_locations:
			if location['location_id'] == location_id:
				# we have our match... now to store it somewhere...
				comp = {}
				comp.update(contact)
				comp.update(location)
				[comp.update({key:value.strip()}) for key,value in comp.iteritems()]
				comp.update({'informationtype':cu_itype[comp['informationtype']]});
				cu_comparison_list.append(comp)
	
	#print cu_comparison_list
	return cu_comparison_list

def readerList(fieldnames, path, hasColumnNames = True):
	contactsReader = csv.DictReader(open(path, 'rb'), fieldnames);
	if hasColumnNames:
		contactsList = list(contactsReader)[1:];
	else:
		contactsList = list(contactsReader)
	return contactsList

def get_contact_dict():
	contact = readerList(['id','label','ref_id'],'/Users/temp/Documents/Gen-Probe/Contact Us Revision/neu_contact.csv',False)
	contact_dict = flatten2dict(contact, 'ref_id','id');
	return contact_dict;

def ptype_columns_to_contact_comp_data():
	fieldnames = ['itype', 'pstype', 'psname', 'locat', 'id'];
	reader = csv.DictReader(open('/Users/temp/Documents/Gen-Probe/Contact Us Revision/ptype_columns_to_contact_comp.csv', 'rb'), fieldnames);
	li = list(reader);
	return li

def pline_columns_to_contact_comp_data():
	fieldnames = ['itype', 'psline', 'psname', 'locat', 'id'];
	reader = csv.DictReader(open('/Users/temp/Documents/Gen-Probe/Contact Us Revision/pline_columns_to_contact_comp.csv', 'rb'), fieldnames);
	li = list(reader);
	return li
	
def ptype_all_to_contact():
	ptype_columns_to_contact_comp = ptype_columns_to_contact_comp_data();
	cu_comparison_list = get_cu_comparison_list();
	contact_dict = get_contact_dict();
	sql = [];
	
	for cu in cu_comparison_list:
		for ptcol in ptype_columns_to_contact_comp:
			if cu['informationtype'] == ptcol['itype'] and cu['productservicetype']==ptcol['pstype'] and cu['productservicename']==ptcol['psname'] and cu['dropdownname']==ptcol['locat']:
				# we have a match!
				s = "INSERT INTO informationtype_productservicetype_productservicename_location_to_contact (informationtype_productservicetype_productservicename_location_id, contact_id) VALUES (%s,%s);" % (ptcol['id'], contact_dict[cu['location_id']]);
				sql.append(s);
	
	f = open('/Users/temp/Documents/Gen-Probe/Contact Us Revision/to_contacts.sql','wb');
	f.write('\n'.join(sql));
	f.close();
	
def pline_all_to_contact():
	pline_columns_to_contact_comp = pline_columns_to_contact_comp_data();
	cu_comparison_list = get_cu_comparison_list();
	contact_dict = get_contact_dict();
	sql = [];
	
	for cu in cu_comparison_list:
		for ptcol in pline_columns_to_contact_comp:
			if cu['informationtype'] == ptcol['itype'] and cu['productserviceline']==ptcol['psline'] and cu['productservicename']==ptcol['psname'] and cu['dropdownname']==ptcol['locat']:
				# we have a match!
				s = "INSERT INTO informationtype_productserviceline_productservicename_location_to_contact (informationtype_productserviceline_productservicename_location_id, contact_id) VALUES (%s,%s);" % (ptcol['id'], contact_dict[cu['location_id']]);
				sql.append(s);
	
	f = open('/Users/temp/Documents/Gen-Probe/Contact Us Revision/to_contacts.sql','wb');
	f.write('\n'.join(sql));
	f.close();	
	
if __name__ == '__main__':
	pline_all_to_contact();