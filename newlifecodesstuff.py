itypes = [2];
ptypes = [13,14,15]
plines = [34,35,36]

locations = [201,50,202]
psnames = [131, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127, 128, 129];


def itypes_to_types_lines():
	for itype in itypes:
		for ptype in ptypes:
			print "INSERT INTO informationtype_to_productservicetype (informationtype_id,productservicetype_id) VALUES (%s,%s);" % (itype,ptype);
			
		for pline in plines:
			print "INSERT INTO informationtype_to_productserviceline (informationtype_id,productserviceline_id) VALUES (%s,%s);" % (itype,pline);


def itype_pstype_to_psname():
	#Coagulation
	for i in [136,130,127]:
		print "INSERT INTO informationtype_productservicetype_to_productservicename (informationtype_productservicetype_id,productservicename_id) VALUES (%s,%s);" % (i,131);
	
	#Transplant
	for i in [129,132,138]:
		for psname in [117,118,122,123,124,125,126,127,128,129]:
			print "INSERT INTO informationtype_productservicetype_to_productservicename (informationtype_productservicetype_id,productservicename_id) VALUES (%s,%s);" % (i,psname);
	
	#Transfusion		
	for i in [128,131,137]:
		for psname in [117,118,119,120,121]:
			print "INSERT INTO informationtype_productservicetype_to_productservicename (informationtype_productservicetype_id,productservicename_id) VALUES (%s,%s);" % (i,psname);


def itype_psline_to_psname():
	#Coagulation
	for i in [82,85,92]:
		print "INSERT INTO informationtype_productserviceline_to_productservicename (informationtype_productserviceline_id,productservicename_id) VALUES (%s,%s);" % (i,131);
	
	#Transplant
	for i in [84,87,91]:
		for psname in [117,118,122,123,124,125,126,127,128,129]:
			print "INSERT INTO informationtype_productserviceline_to_productservicename (informationtype_productserviceline_id,productservicename_id) VALUES (%s,%s);" % (i,psname);
	
	#Transfusion		
	for i in [83,86,93]:
		for psname in [117,118,119,120,121]:
			print "INSERT INTO informationtype_productserviceline_to_productservicename (informationtype_productserviceline_id,productservicename_id) VALUES (%s,%s);" % (i,psname);


def itype_pstype_psname_to_locat():
	itype_pstype_psname_ids = [513, 514, 515, 516, 517, 518, 519, 520, 521, 522, 523, 524, 525, 526, 527, 528, 529, 530, 531, 532, 533, 534, 535, 536, 537, 538, 539, 540, 541, 542, 543, 544, 545, 546, 547, 548, 549, 550, 551, 552, 553, 554, 555, 556, 557, 558, 559, 560];
	locations = [201,50,202];

	for location in locations:
		for _id in itype_pstype_psname_ids:
			print "INSERT INTO informationtype_productservicetype_productservicename_to_location (informationtype_productservicetype_productservicename_id,location_id) VALUES (%s,%s);" % (_id,location);

def itype_psline_psname_to_locat():
	itype_psline_psname_ids = [515, 516, 517, 518, 519, 520, 521, 522, 523, 524, 525, 526, 527, 528, 529, 530, 531, 532, 533, 534, 535, 536, 537, 538, 539, 540, 541, 542, 543, 544, 545, 546, 547, 548, 549, 550, 551, 552, 553, 554, 555, 556, 557, 558, 559, 560]
	locations = [201,50,202];

	for location in locations:
		for _id in itype_psline_psname_ids:
			print "INSERT INTO informationtype_productserviceline_productservicename_to_location (informationtype_productserviceline_productservicename_id,location_id) VALUES (%s,%s);" % (_id,location);


def itype_pstype_psname_locat_to_cont():
	li = [[7110, 1587], [7120, 1587], [7130, 1587], [7140, 1587], [7145, 1587], [7150, 1587], [7151, 1587], [7146, 1587], [7141, 1587], [7131, 1587], [7121, 1587], [7111, 1587], [7142, 1587], [7147, 1587], [7152, 1587], [7153, 1587], [7148, 1587], [7143, 1587], [7144, 1587], [7149, 1587], [7154, 1587], [7132, 1587], [7112, 1587], [7122, 1587], [7123, 1587], [7113, 1587], [7133, 1587], [7134, 1587], [7114, 1587], [7124, 1587], [7125, 1587], [7115, 1587], [7135, 1587], [7136, 1587], [7116, 1587], [7126, 1587], [7127, 1587], [7117, 1587], [7137, 1587], [7138, 1587], [7118, 1587], [7128, 1587], [7129, 1587], [7119, 1587], [7139, 1587], [7107, 1587], [7108, 1587], [7109, 1587], [7157, 1586], [7156, 1586], [7155, 1586], [7187, 1586], [7167, 1586], [7177, 1586], [7176, 1585], [7166, 1585], [7186, 1585], [7185, 1585], [7165, 1585], [7175, 1585], [7174, 1585], [7164, 1585], [7184, 1585], [7183, 1585], [7163, 1585], [7173, 1585], [7172, 1585], [7162, 1585], [7182, 1585], [7181, 1586], [7161, 1586], [7171, 1586], [7170, 1585], [7160, 1585], [7180, 1585], [7202, 1586], [7197, 1586], [7192, 1586], [7191, 1586], [7196, 1586], [7201, 1586], [7200, 1586], [7195, 1586], [7190, 1586], [7159, 1585], [7169, 1585], [7179, 1585], [7189, 1586], [7194, 1586], [7199, 1586], [7198, 1585], [7193, 1585], [7188, 1585], [7178, 1586], [7168, 1586], [7158, 1586], [7072, 1585], [7082, 1585], [7092, 1585], [7097, 1586], [7102, 1586], [7103, 1586], [7098, 1586], [7093, 1586], [7083, 1585], [7073, 1585], [7063, 1585], [7094, 1586], [7099, 1586], [7104, 1586], [7105, 1586], [7100, 1586], [7095, 1586], [7096, 1586], [7101, 1586], [7106, 1586], [7084, 1585], [7064, 1585], [7074, 1585], [7075, 1586], [7065, 1586], [7085, 1586], [7086, 1585], [7066, 1585], [7076, 1585], [7077, 1585], [7067, 1585], [7087, 1585], [7088, 1585], [7068, 1585], [7078, 1585], [7079, 1585], [7069, 1585], [7089, 1585], [7090, 1585], [7070, 1585], [7080, 1585], [7081, 1586], [7071, 1586], [7091, 1586], [7059, 1586], [7060, 1586], [7061, 1586], [7062, 1586]];
	
	for i in li:
		print "INSERT INTO informationtype_productservicetype_productservicename_location_to_contact (informationtype_productservicetype_productservicename_location_id, contact_id) VALUES (%s,%s);" % (i[0], i[1])


def itype_psline_psname_locat_to_cont():
	li = [[8071, 1587], [8081, 1587], [8091, 1587], [8101, 1587], [8106, 1587], [8111, 1587], [8117, 1585], [8127, 1585], [8137, 1585], [8147, 1586], [8152, 1586], [8157, 1586], [8065, 1585], [8025, 1585], [8035, 1585], [8045, 1586], [8055, 1586], [8060, 1586], [8072, 1587], [8082, 1587], [8102, 1587], [8092, 1587], [8112, 1587], [8107, 1587], [8118, 1586], [8138, 1586], [8128, 1586], [8158, 1585], [8153, 1585], [8148, 1585], [8066, 1586], [8061, 1586], [8056, 1586], [8046, 1585], [8036, 1585], [8026, 1585], [8068, 1587], [8069, 1587], [8070, 1587], [8114, 1586], [8115, 1586], [8116, 1586], [8022, 1586], [8023, 1586], [8024, 1586], [8074, 1587], [8084, 1587], [8094, 1587], [8120, 1586], [8130, 1586], [8140, 1586], [8028, 1586], [8038, 1586], [8048, 1586], [8096, 1587], [8086, 1587], [8076, 1587], [8142, 1585], [8132, 1585], [8122, 1585], [8050, 1585], [8040, 1585], [8030, 1585], [8079, 1587], [8089, 1587], [8099, 1587], [8125, 1585], [8135, 1585], [8145, 1585], [8033, 1585], [8043, 1585], [8053, 1585], [8104, 1587], [8109, 1587], [8150, 1586], [8155, 1586], [8058, 1586], [8063, 1586], [8073, 1587], [8083, 1587], [8093, 1587], [8119, 1585], [8139, 1585], [8129, 1585], [8047, 1585], [8037, 1585], [8027, 1585], [8085, 1587], [8095, 1587], [8075, 1587], [8131, 1585], [8141, 1585], [8121, 1585], [8029, 1585], [8039, 1585], [8049, 1585], [8077, 1587], [8097, 1587], [8087, 1587], [8123, 1585], [8143, 1585], [8133, 1585], [8051, 1585], [8041, 1585], [8031, 1585], [8103, 1587], [8113, 1587], [8108, 1587], [8159, 1586], [8154, 1586], [8149, 1586], [8067, 1586], [8062, 1586], [8057, 1586], [8105, 1587], [8110, 1587], [8151, 1586], [8156, 1586], [8059, 1586], [8064, 1586], [8078, 1587], [8098, 1587], [8088, 1587], [8124, 1585], [8134, 1585], [8144, 1585], [8052, 1585], [8032, 1585], [8042, 1585], [8090, 1587], [8100, 1587], [8080, 1587], [8136, 1586], [8126, 1586], [8146, 1586], [8034, 1586], [8044, 1586], [8054, 1586]];
	
	for i in li:
		print "INSERT INTO informationtype_productserviceline_productservicename_location_to_contact (informationtype_productserviceline_productservicename_location_id, contact_id) VALUES (%s,%s);" % (i[0], i[1])




if __name__ == '__main__':
	itype_psline_psname_locat_to_cont()