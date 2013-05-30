import csv

path = '/Users/temp/Documents/Gen-Probe/Contact Us Revision/';

def readerList(fieldnames, path, hasColumnNames = True):
	contactsReader = csv.DictReader(open(path, 'rb'), fieldnames);
	if hasColumnNames:
		contactsList = list(contactsReader)[1:];
	else:
		contactsList = list(contactsReader)
	return contactsList

def FacilityToId():
	d = {}
	for line in file(path+'bigimportexports/facility_to_id.txt'):
		facilityname, facilityid = [i.strip() for i in line.split('\t') if i]
		d.update({facilityname:facilityid});
	
	return d;


def CompareFacilities():
	facilities = FacilityToId();
	li= []
	for facname in app.contacts:
		if facname in facilities.keys():
			li.append('-- %s found' % (facname));
			
	print '\n'.join(sorted(li));

def KZ_Excel():
	fieldnames = ['productservicetype','productserviceline','productservicename','contactlabel','location','contactfacility']
	filepath = path+'salesdistlargerevision.txt';
	return list(csv.DictReader(open(filepath, 'rU'), fieldnames=fieldnames, delimiter='\t'));

def KZ_Classes():
	return [EXCELData(row) for row in KZ_Excel()];

def check_KZ_Excel():
	kz_excel = KZ_Excel()
	
	errorstr = "ROW %s %s mismatch on %s";
	c = 1;
	for row in kz_excel:
		ed = EXCELData(row);
		if ed.productservicetype not in app.productservicetypes:	
			print errorstr % (c,'productservicetype',ed.productservicetype);
		if ed.productserviceline not in app.productservicelines:	
			print errorstr % (c,'productserviceline',ed.productserviceline);
		if ed.productservicename not in app.productservicenames:	
			print errorstr % (c,'productservicename',ed.productservicename);
		if ed.location and ed.location not in app.locations:	
			print errorstr % (c,'location',ed.location);						
		if ed.contactfacility and ed.contactfacility not in app.contacts:	
			print errorstr % (c,'contactfacility',ed.contactfacility);
		c+=1
		
		
def DB_Exports():
	pstype = readerList(['productservicetype','productservicename','location','itype_pstype_psname_locat_id'], path+'bigimportexports/pstype.csv',False)
	psline = readerList(['productserviceline','productservicename','location','itype_psline_psname_locat_id'], path+'bigimportexports/psline.csv',False)
	pstypewcontacts = readerList(['productservicetype','productservicename','location','contactfacility','contactid','itype_pstype_psname_locat_id'], path+'bigimportexports/pstypewithcontacts.csv',False)
	pslinewcontacts = readerList(['productserviceline','productservicename','location','contactfacility','contactid','itype_psline_psname_locat_id'], path+'bigimportexports/pslinewithcontacts.csv',False)
	
	pstype.extend(pstypewcontacts)
	psline.extend(pslinewcontacts)
	
	pstype = [ProductServiceTypeData(i) for i in pstype]
	psline = [ProductServiceLineData(i) for i in psline]
	
	return (pstype,psline);
	
def check_DB_Exports():
	pstype,psline = DB_Exports();
	
	errorstr = "ROW %s %s mismatch on %s";
	
	print '-'*5, "Product Service Type"
	c = 1;
	for cl in pstype:
		if cl.productservicetype not in app.productservicetypes:	
			print errorstr % (c,'productservicetype',cl.productservicetype);
		if cl.productservicename not in app.productservicenames:	
			print errorstr % (c,'productservicename',cl.productservicename);
		if cl.location and cl.location not in app.locations:	
			print errorstr % (c,'location',cl.location);						
		if cl.hasContactInfo() and cl.contactfacility and cl.contactfacility not in app.contacts:	
			print errorstr % (c,'contactfacility',cl.contactfacility);			
		c+=1	

	print '-'*5, "Product Service Line"
	c = 1;
	for cl in psline:
		if cl.productserviceline not in app.productservicelines:	
			print errorstr % (c,'productservicetype',cl.productservicetype);
		if cl.productservicename not in app.productservicenames:	
			print errorstr % (c,'productservicename',cl.productservicename);
		if cl.location and cl.location not in app.locations:	
			print errorstr % (c,'location',cl.location);						
		if cl.hasContactInfo() and cl.contactfacility and cl.contactfacility not in app.contacts:	
			print errorstr % (c,'contactfacility',cl.contactfacility);			
		c+=1


def compare():
	pstypes,pslines = DB_Exports();
	kz_excel = KZ_Classes()
	
	
	deletes = []

	"""
	for pstype in pstypes:
		match = 0
		for kz in kz_excel:
			if pstype.match(kz):
				match = 1
				if pstype.hasContactInfo():
					if kz.contactfacility and kz.contactfacility != pstype.contactfacility:
						#print kz.contactlabel, ':', pstype.contactfacility, '->', kz.contactfacility, pstype.printIdentity()
						#We have to print both an insert and delete statement here...
						print pstype.printInsert(kz);
						#So our delete statement needs the itype_pstype_psname_locat_id
						deletes.append(pstype.printDelete());
						pass
					elif kz.contactfacility and kz.contactlabel:
						#print kz.contactlabel, ':', pstype.contactfacility, '->', kz.contactfacility, pstype.printIdentity()
						#We're assuming that pstypes here already have contacts linked to them, we're just updating the label
						print pstype.printInsert(kz);
				else:
					if kz.contactfacility:
						#print kz.contactlabel, ':', 'None', '->', kz.contactfacility, pstype.printIdentity()
						#These will just be insert statements...
						print pstype.printInsert(kz);
						pass
		if not match:
			#print pstype.printIdentity()
			pass
	"""

	for psline in pslines:
		match = 0
		for kz in kz_excel:
			if psline.match(kz):
				match = 1
				if psline.hasContactInfo():
					if kz.contactfacility and kz.contactfacility != psline.contactfacility:
						#print kz.contactlabel, ':', psline.contactfacility, '->', kz.contactfacility, psline.printIdentity()
						#We have to print both an insert and delete statement here...
						print psline.printInsert(kz);
						#So our delete statement needs the itype_psline_psname_locat_id
						deletes.append(psline.printDelete());
						pass
					elif kz.contactfacility and kz.contactlabel:
						#print kz.contactlabel, ':', psline.contactfacility, '->', kz.contactfacility, psline.printIdentity()
						#We're assuming that pslines here already have contacts linked to them, we're just updating the label
						print psline.printInsert(kz);
				else:
					if kz.contactfacility:
						#print kz.contactlabel, ':', 'None', '->', kz.contactfacility, psline.printIdentity()
						#These will just be insert statements...
						print psline.printInsert(kz);
						pass
		if not match:
			#print psline.printIdentity()
			pass


	print '\n'.join(list(set(deletes)));
					
class App:
	def __init__(self):
		self.productservicenames = ['Gen-Probe Fluoroanalyzer', 'LIFECODES HLA Genotyping', 'LIFECODES HLA Genotyping', 'LIFECODES KIR Genotyping', 'LIFECODES Red Cell Genotyping', 'LIFECODES Red Cell Genotyping', 'LIFECODES Screen & Identification', 'LIFECODES Screen & Identification', 'LIFECODES LSA Single Antigen', 'LIFECODES Donor Specific Antibody', 'LIFECODES Donor Specific Antibody', 'LIFECODES LSA MIC', 'LIFECODES Serology Products', 'LIFECODES Platelet Antibody Detection Products', 'LIFECODES HPA Genotyping', 'LIFECODES Donor Screening', 'LIFECODES Coagulation Products'];
	
		self.productservicetypes = ['Transplant & Transfusion Medicine','Coagulation Products']
		self.productservicelines = ['LIFECODES']
	
		self.locations = ['Brazil', 'Canada', 'Qatar', 'Italy', 'Czech Republic', 'Kuwait', 'Panama', 'Former Yugoslavia', 'Slovakia', 'Peru', 'Republica Muldova', 'Bahrain', 'Israel', 'Australia', 'Columbia', 'Algeria', 'Singapore', 'Turkey', 'Jordan', 'China', 'Chile', 'Germany', 'Iraq', 'Poland', 'Spain', 'Europe', 'Libya', 'Oman', 'Fyrom', 'Indonesia', 'Saudi Arabia', 'Morocco', 'Albania', 'Thailand', 'New Zealand', 'Taiwan', 'Bulgaria', 'Romania', 'Benelux-France', 'Portugal', 'Mexico', 'Tunisia', 'United Arab Emirates', 'South Africa', 'India', 'United Kingdom', 'Malaysia', 'Austria', 'Greece', 'Hungary', 'South Korea','United States']
	
		self.contacts = ['Chen Ken Hoong, Biomarketing Services (M) Sdn Bhd', 'INOCHEM S.A. de C.V.', 'LeanGene for Medical & Electronic Supplies', 'Saudi Technology & Equipment Co', 'Gen-Probe GTI Diagnostics, Inc.', 'Al-Zahrawi Medical Services Co.', 'Bader Sultan & Bros Co. w.l.l.', 'Tree Med SDN, BHD', 'GTI ITALIA s.r.l.', 'Biosciences SAS', 'Bios Ingenieria Gentica SA', 'ANTISEL Selidis Bros s.a.', 'DIAGNOSTICA LONGWOOD s.l.', 'AMD', 'QUEST BIOMEDICAL', 'CPC Diagnostics PVT Ltd', 'Laboratoires AAZ', 'Zhuhai Bioyamei Investment Co., Ltd.', 'Bio Lab S.A.', 'Gen-Probe Belgium BVBA', 'The Bio Group - PH7ID', 'Metek Lab Inc.', 'ATQ Biyoteknloij', 'IEPSA', 'Lab Depot S.A.', 'Tae Yeong CnL', 'Diagnostic Solutions', 'Mind Biomeds Pvt. Ltd.', 'Inno-Train Diagnostics GmbH', 'Inter Medico', 'Innovative Biotech Pte Ltd', 'Beijing Rose Co-Win Medical Tech. Co., Ltd.', 'Tarom Applied Technologies Ltd.', 'UNIPARTS, S.A.']
	
		self.facilities = FacilityToId();
	
		self.pstypeSql = "INSERT INTO informationtype_productservicetype_productservicename_location_to_contact (informationtype_productservicetype_productservicename_location_id, contact_id, label) VALUES (%s,%s,'%s');"
		self.pslineSql = "INSERT INTO informationtype_productserviceline_productservicename_location_to_contact (informationtype_productserviceline_productservicename_location_id, contact_id, label) VALUES (%s,%s,'%s');"
	
		self.pstypeDeleteSql = "DELETE FROM informationtype_productservicetype_productservicename_location_to_contact WHERE informationtype_productservicetype_productservicename_location_id = %s AND contact_id = %s;"
		self.pslineDeleteSql = "DELETE FROM informationtype_productserviceline_productservicename_location_to_contact WHERE informationtype_productserviceline_productservicename_location_id = %s AND contact_id = %s;"

		self.pstypeUpdateSql = "UPDATE informationtype_productservicetype_productservicename_location_to_contact SET label='%s' WHERE informationtype_productservicetype_productservicename_location_id = %s AND contact_id = %s;"
		self.pslineUpdateSql = "UPDATE informationtype_productserviceline_productservicename_location_to_contact SET label='%s' WHERE informationline_productservicetype_productservicename_location_id = %s AND contact_id = %s;"


	def formatDelete(self, opt, id1, id2):
		if opt == 'productservicetype':
			return self.pstypeDeleteSql % (id1, id2)
		else:
			return self.pslineDeleteSql % (id1, id2)
			
	def formatInsert(self, opt, id1, id2, label):
		if opt == 'productservicetype':
			return self.pstypeSql % (id1, id2, label)
		else:
			return self.pslineSql % (id1, id2, label)

	def formatUpdate(self, opt, id1, id2, label):
		if opt == 'productservicetype':
			return self.pstypeUpdateSql % (label, id1, id2)
		else:
			return self.pslineUpdateSql % (label, id1, id2)

class EXCELData:
	def __init__(self, row):
		self.informationtype = 'Sales and Distribution';
		self.productservicetype = row['productservicetype'].strip();
		self.productserviceline = row['productserviceline'].strip();
		self.productservicename = row['productservicename'].strip();
		self.location = row['location'].strip();
		self.contactlabel = row['contactlabel'].strip();
		self.contactfacility = row['contactfacility'].strip();
		
	def getFacilityID(self):
		return app.facilities[self.contactfacility]
				
class ContactData(object):
	def __init__(self,row):
		self.informationtype = 'Sales and Distribution';
		self.productservicename = row['productservicename'].strip();
		self.location = row['location'].strip();
		if 'contactfacility' in row.keys():
			self.contactfacility = row['contactfacility'].strip();
			self.contactid = row['contactid'].strip();
			
	def hasContactInfo(self):
		return 'contactfacility' in self.__dict__.keys();
		
	def printIdentity(self):
		return "-- %s : %s : %s" % (self.productservicetype, self.productservicename, self.location);
		


class ProductServiceTypeData(ContactData):
	def __init__(self, row):
		self.productservicetype = row['productservicetype'].strip();
		self.itype_pstype_psname_locat_id = row['itype_pstype_psname_locat_id'].strip();
		super(ProductServiceTypeData, self).__init__(row)
		
	def match(self, other):
		pstype = self.productservicetype == other.productservicetype;
		psname = self.productservicename == other.productservicename
		locat = self.location == other.location
		if pstype and psname and locat:
			return True
		else:
			return False
			
	def printInsert(self,other):
		id1 = self.itype_pstype_psname_locat_id;
		# we need the facilityname to ID to happen here
		id2 = other.getFacilityID();
		label = other.contactlabel;
		return app.formatInsert('productservicetype', id1, id2, label);
		
	def printDelete(self):
		return app.formatDelete('productservicetype', self.itype_pstype_psname_locat_id, self.contactid);
	
	def printUpdate(self,other):
		id1 = self.itype_pstype_psname_locat_id;
		# we need the facilityname to ID to happen here
		id2 = other.getFacilityID();
		label = other.contactlabel;
		return app.formatUpdate('productservicetype', id1, id2, label);		
		
	
class ProductServiceLineData(ContactData):
	def __init__(self, row):
		self.productserviceline = row['productserviceline'].strip();
		self.itype_psline_psname_locat_id = row['itype_psline_psname_locat_id'].strip();
		super(ProductServiceLineData, self).__init__(row)		


	def match(self, other):
		psline = self.productserviceline == other.productserviceline;
		psname = self.productservicename == other.productservicename
		locat = self.location == other.location
		if psline and psname and locat:
			return True
		else:
			return False
			
	def printInsert(self,other):
		id1 = self.itype_psline_psname_locat_id;
		# we need the facilityname to ID to happen here
		id2 = other.getFacilityID();
		label = other.contactlabel;
		return app.formatInsert('productserviceline', id1, id2, label);
		
	def printDelete(self):
		return app.formatDelete('productserviceline', self.itype_psline_psname_locat_id, self.contactid);
	
	def printUpdate(self,other):
		id1 = self.itype_psline_psname_locat_id;
		# we need the facilityname to ID to happen here
		id2 = other.getFacilityID();
		label = other.contactlabel;
		return app.formatUpdate('productserviceline', id1, id2, label);			
				
if __name__ == '__main__':
	app = App()
	#check_KZ_Excel()
	#check_DB_Exports()
	compare()
	#CompareFacilities()		