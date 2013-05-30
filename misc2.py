def sql1():
	for i in [119,120,123,132]:
		print "INSERT INTO informationtype_productservicetype_to_productservicename (informationtype_productservicetype_id, productservicename_id) VALUES (%s,%s);" % (102,i);
		print "INSERT INTO informationtype_productserviceline_to_productservicename (informationtype_productserviceline_id, productservicename_id) VALUES (%s,%s);" % (33,i);
		
		
def compare_locations():
	li = ['Brazil', 'Canada', 'Qatar', 'Italy', 'Czech Republic', 'Kuwait', 'Panama', 'Slovakia', 'Peru', 'Republica Muldova', 'Bahrain', 'Israel', 'Australia', 'Columbia', 'Algeria', 'Singapore', 'Turkey', 'Jordan', 'China', 'Chile', 'Germany', 'Iraq', 'Poland', 'Spain', 'Europe', 'Libya', 'Oman', 'Fyrom', 'Indonesia', 'Saudi Arabia', 'Morocco', 'Albania', 'Thailand', 'New Zealand', 'Taiwan', 'Bulgaria', 'Romania', 'Benelux-France', 'Portugal', 'Mexico', 'Tunisia', 'United Arab Emirates', 'South Africa', 'India', 'United Kingdom', 'Malaysia', 'Austria', 'Greece', 'Hungary', 'South Korea', 'Former Yugoslavia']

	_li = ['Brazil', 'Turkey', 'Qatar', 'Italy', 'Czech Republic', 'Kuwait', 'Panama', 'Slovakia', 'Peru', 'Republica Muldova', 'Bahrain', 'Israel', 'Australia', 'Algeria', 'Malaysia', 'Jordan', 'China', 'Chile', 'Germany', 'Iraq', 'Poland', 'Spain', 'ROW', 'Europe', 'Libya', 'Oman', 'Fyrom', 'Indonesia', 'Saudi Arabia', 'United States', 'Morocco', 'Albania', 'Thailand', 'New Zealand', 'Bulgaria', 'Romania', 'Benelux-France', 'Portugal', 'Mexico', 'Tunisia', 'United Arab Emirates', 'Singapore', 'India', 'South Africa', 'United Kingdom', 'South Korea', 'Austria', 'Former Yugoslavia', 'Columbia', 'Greece', 'Hungary', 'Taiwan']
	
	"""
	for i in li:
		if i not in _li:
			print i
			
	print '-'*10;
	
	for i in _li:
		if i not in li:
			print i
	"""

	d = {}	
	for i in li:
		d.update({i:[]});
		
	locatids = {}
	for line in file('/Users/temp/Documents/Gen-Probe/Contact Us Revision/locatname_to_locatid.txt'):
		name,id = [i.strip() for i in line.split('\t') if i]
		locatids.update({name:id})
		
	psnameslist = []
	for line in file('/Users/temp/Documents/Gen-Probe/Contact Us Revision/salesdistpsnames.txt'):
		psnameslist.append(line.strip());
	
	# PS TYPE
	def do_pstype():
		psnameids = {}
		for line in file('/Users/temp/Documents/Gen-Probe/Contact Us Revision/psname_to_psnameid.txt'):
			name,id = [i.strip() for i in line.split('\t') if i]
			psnameids.update({name:id})	
		
		psnames = []
		
		for line in file('/Users/temp/Documents/Gen-Probe/Contact Us Revision/current_pstolocat.txt'):
			psname, locat = [i.strip() for i in line.split('\t') if i]
			if locat not in d.keys(): continue
			d[locat].append(psname)
			psnames.append(psname)
			
		psnames = list(set(psnames));
		for locat, pslist in d.iteritems():
			notfound = []
			for i in psnames:
				if i not in pslist:
					notfound.append(i)
			if notfound:
				for psname in psnameslist:
					if psname not in psnames:
						notfound.append(psname);
						
				for psname in notfound:
					print "-- %s for %s" % (locat,psname);
					print "INSERT INTO informationtype_productservicetype_productservicename_to_location (informationtype_productservicetype_productservicename_id, location_id) VALUES (%s,%s);" % (psnameids[psname],locatids[locat])
					pass
				#print '%s missing %s' % (locat,', '.join(notfound))
				#print
	
	
	# PS LINE
	def do_psline():
		psnameids = {}
		for line in file('/Users/temp/Documents/Gen-Probe/Contact Us Revision/psname_to_itype_psline_psname.txt'):
			name,id = [i.strip() for i in line.split('\t') if i]
			psnameids.update({name:id})	
		
		psnames = []
		
		for line in file('/Users/temp/Documents/Gen-Probe/Contact Us Revision/current_pstolocat_psline.txt'):
			psname, locat = [i.strip() for i in line.split('\t') if i]
			if locat not in d.keys(): continue
			d[locat].append(psname)
			psnames.append(psname)
			
		psnames = list(set(psnames));
		for locat, pslist in d.iteritems():
			notfound = []
			for i in psnames:
				if i not in pslist:
					notfound.append(i)
					
			for psname in psnameslist:
				if psname not in psnames:
					notfound.append(psname);
										
			if notfound:
				for psname in notfound:
					if psname == 'LIFECODES Coagulation Products':
						print "-- %s for %s" % (locat,psname);
						print "INSERT INTO informationtype_productserviceline_productservicename_to_location (informationtype_productserviceline_productservicename_id, location_id) VALUES (%s,%s);" % (psnameids[psname],locatids[locat])
						pass
				#print '%s missing %s' % (locat,', '.join(notfound))
				#print
	
	do_psline();

	
def locationforcoag():
	locatids = {}
	for line in file('/Users/temp/Documents/Gen-Probe/Contact Us Revision/locatname_to_locatid.txt'):
		name,id = [i.strip() for i in line.split('\t') if i]
		locatids.update({name:id})
		
	for locat in locatids.keys():
		print "-- %s for %s" % (locat,'Coag');	
		print "INSERT INTO informationtype_productservicetype_productservicename_to_location (informationtype_productservicetype_productservicename_id, location_id) VALUES (%s,%s);" % (566,locatids[locat])
	
	
def psnamelist():
	s= """
	Gen-Probe Fluoroanalyzer
LIFECODES HLA Genotyping
LIFECODES KIR Genotyping  
LIFECODES Cytokine SNP Typing 
LIFECODES Red Cell Genotyping 
LIFECODES Screen & Identification  
LIFECODES LSA Single Antigen 
LIFECODES Donor Specific Antibody 
LIFECODES LSA MIC 
LIFECODES Serology Products 
LIFECODES Platelet Antibody Detection Products 
LIFECODES HPA Genotyping 
LIFECODES Donor Screening """
	li = [i.strip() for i in s.split('\n') if i]
	print li



if __name__ == '__main__':
	locationforcoag()