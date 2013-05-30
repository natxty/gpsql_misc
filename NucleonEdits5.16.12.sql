
-- New Nucleon Edits

---- Add Nucleon Non-Chloroform Blood Kit to DNA for S'nD

EXECUTE ContactPath
	'Sales and Distribution', 		--informationtype
	'DNA Extraction Products', 		--productservicetype
	NULL,		--productserviceline
	'Nucleon Non-Chloroform Blood Kit',		--productservicename
	'Gen-Probe Life Sciences Ltd.  UK',		--location
	NULL,		--contact_label
	NULL,		--informationtype_id
	NULL,		--productservicetype_id
	NULL,		--productserviceline_id
	NULL,		--productservicename_id
	NULL,		--location_id
	1682,		--contact_id
	0,		--informationtype_productservicetype_productservicename_us
	0,		--informationtype_productservicetype_productservicename_gl
	1,		--informationtype_productservicetype_productservicename_both
	0,		--informationtype_productservicetype_productservicename_location_us
	0,		--informationtype_productservicetype_productservicename_location_gl
	1,		--informationtype_productservicetype_productservicename_location_both
	0,		--informationtype_productserviceline_productservicename_us
	0,		--informationtype_productserviceline_productservicename_gl
	1,		--informationtype_productserviceline_productservicename_both
	0,		--informationtype_productserviceline_productservicename_location_us
	0,		--informationtype_productserviceline_productservicename_location_gl
	1		--informationtype_productserviceline_productservicename_location_both
	
---- Delete Mousetail

DELETE
	informationtype_productservicetype_to_productservicename
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
	informationtype.id = informationtype_to_productservicetype.informationtype_id
INNER JOIN
	productservicetype
ON 
	productservicetype.id = informationtype_to_productservicetype.productservicetype_id
INNER JOIN
	productservicename
ON
	productservicename.id = informationtype_productservicetype_to_productservicename.productservicename_id
INNER JOIN
	location
ON
	location.id = informationtype_productservicetype_productservicename_to_location.location_id
INNER JOIN
	informationtype_productservicetype_productservicename_location_to_contact
ON
	informationtype_productservicetype_productservicename_location_to_contact.informationtype_productservicetype_productservicename_location_id = informationtype_productservicetype_productservicename_to_location.id
INNER JOIN
	contact
ON
	informationtype_productservicetype_productservicename_location_to_contact.contact_id = contact.id
INNER JOIN 
	contact_to_facility
ON
	contact.id = contact_to_facility.contact_id
INNER JOIN
	facility
ON
	contact_to_facility.facility_id = facility.id
WHERE
	productservicename.name IN (
		'Nucleon Non-Chloroform Mousetail Kit',
		'Nucleon Non-Chloroform Mousetail Kit - Large/Small',
		'Non-Chloroform Mousetail Kit - Small & Large'
		)
		
		