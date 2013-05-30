DECLARE @tbl Table (
	to_location_id int,
	to_contact_id int
)

-- Get all *to_location id's
INSERT INTO @tbl
SELECT 
	informationtype_productservicetype_productservicename_to_location.id,
	informationtype_productservicetype_productservicename_location_to_contact.id
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
	informationtype.name = 'Sales and Distribution'
	AND
	productservicename.name IN
	('AccuProbe COCCIDIOIDES IMMITIS Culture Identification Test', 'AccuProbe Culture Identification Reagent Kit', 'AccuProbe GROUP B STREPTOCOCCUS Culture Identification Test', 'AccuProbe HAEMOPHILUS INFLUENZAE Culture Identification Test', 'AccuProbe HISTOPLASMA CAPSULATUM Culture Identification Test', 'AccuProbe LISTERIA MONOCYTOGENES Culture Identification Test', 'AccuProbe MYCOBACTERIUM AVIUM Complex Culture Identification Test', 'AccuProbe MYCOBACTERIUM AVIUM Culture Identification Test', 'AccuProbe MYCOBACTERIUM GORDONAE Culture Identification Test', 'AccuProbe MYCOBACTERIUM INTRACELLULARE Culture Identification Test', 'AccuProbe MYCOBACTERIUM KANSASII Culture Identification Test', 'AccuProbe MYCOBACTERIUM TUBERCULOSIS Complex Culture Identification Test', 'AccuProbe NEISSERIA GONORRHOEAE Culture Identification Test', 'AccuProbe STAPHYLOCOCCUS AUREUS Culture Identification Test', 'AccuProbe STREPTOCOCCUS PNEUMONIAE Culture Identification Test', 'AMPLIFIED MTD (Mycobacterium Tuberculosis Direct) Test', 'GASDirect Test', 'Gen-Probe Detection Reagent Kit', 'LEADER 450i', 'LEADER 50i', 'Pace 2 CT', 'Pace 2 CT PCA', 'Pace 2 CT/GC', 'Pace 2 GC', 'Pace 2 GC PCA')
	AND
	location.name = 'Peru'

DELETE FROM informationtype_productservicetype_productservicename_location_to_contact WHERE id IN (
	SELECT 
		to_contact_id
	FROM
		@tbl
)

DELETE FROM informationtype_productservicetype_productservicename_to_location WHERE id IN (
	SELECT 
		to_location_id
	FROM
		@tbl
)

-- Product or Service Line

DELETE FROM @tbl

-- Get all *to_location id's
INSERT INTO @tbl
SELECT 
	informationtype_productserviceline_productservicename_to_location.id,
	informationtype_productserviceline_productservicename_location_to_contact.id
FROM 
	informationtype_productserviceline_productservicename_to_location
INNER JOIN
	informationtype_productserviceline_to_productservicename
ON
	informationtype_productserviceline_productservicename_to_location.informationtype_productserviceline_productservicename_id = informationtype_productserviceline_to_productservicename.id
INNER JOIN
	informationtype_to_productserviceline
ON
	informationtype_productserviceline_to_productservicename.informationtype_productserviceline_id = informationtype_to_productserviceline.id
INNER JOIN
	informationtype
ON
	informationtype.id = informationtype_to_productserviceline.informationtype_id
INNER JOIN
	productserviceline
ON 
	productserviceline.id = informationtype_to_productserviceline.productserviceline_id
INNER JOIN
	productservicename
ON
	productservicename.id = informationtype_productserviceline_to_productservicename.productservicename_id
INNER JOIN
	location
ON
	location.id = informationtype_productserviceline_productservicename_to_location.location_id
INNER JOIN
	informationtype_productserviceline_productservicename_location_to_contact
ON
	informationtype_productserviceline_productservicename_location_to_contact.informationtype_productserviceline_productservicename_location_id = informationtype_productserviceline_productservicename_to_location.id
INNER JOIN
	contact
ON
	informationtype_productserviceline_productservicename_location_to_contact.contact_id = contact.id
INNER JOIN 
	contact_to_facility
ON
	contact.id = contact_to_facility.contact_id
INNER JOIN
	facility
ON
	contact_to_facility.facility_id = facility.id
WHERE
	informationtype.name = 'Sales and Distribution'
	AND
	productservicename.name IN
	('AccuProbe COCCIDIOIDES IMMITIS Culture Identification Test', 'AccuProbe Culture Identification Reagent Kit', 'AccuProbe GROUP B STREPTOCOCCUS Culture Identification Test', 'AccuProbe HAEMOPHILUS INFLUENZAE Culture Identification Test', 'AccuProbe HISTOPLASMA CAPSULATUM Culture Identification Test', 'AccuProbe LISTERIA MONOCYTOGENES Culture Identification Test', 'AccuProbe MYCOBACTERIUM AVIUM Complex Culture Identification Test', 'AccuProbe MYCOBACTERIUM AVIUM Culture Identification Test', 'AccuProbe MYCOBACTERIUM GORDONAE Culture Identification Test', 'AccuProbe MYCOBACTERIUM INTRACELLULARE Culture Identification Test', 'AccuProbe MYCOBACTERIUM KANSASII Culture Identification Test', 'AccuProbe MYCOBACTERIUM TUBERCULOSIS Complex Culture Identification Test', 'AccuProbe NEISSERIA GONORRHOEAE Culture Identification Test', 'AccuProbe STAPHYLOCOCCUS AUREUS Culture Identification Test', 'AccuProbe STREPTOCOCCUS PNEUMONIAE Culture Identification Test', 'AMPLIFIED MTD (Mycobacterium Tuberculosis Direct) Test', 'GASDirect Test', 'Gen-Probe Detection Reagent Kit', 'LEADER 450i', 'LEADER 50i', 'Pace 2 CT', 'Pace 2 CT PCA', 'Pace 2 CT/GC', 'Pace 2 GC', 'Pace 2 GC PCA')
	AND
	location.name = 'Peru'

DELETE FROM informationtype_productserviceline_productservicename_location_to_contact WHERE id IN (
	SELECT 
		to_contact_id
	FROM
		@tbl
)

DELETE FROM informationtype_productserviceline_productservicename_to_location WHERE id IN (
	SELECT 
		to_location_id
	FROM
		@tbl
)

-- Change all for Sexually Transmitted Diseases for PTYPE
UPDATE informationtype_productservicetype_productservicename_location_to_contact SET contact_id = 1678 WHERE id IN (
	SELECT
		informationtype_productservicetype_productservicename_location_to_contact.id
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
		informationtype.name = 'Sales and Distribution'
		AND
		productservicetype.name = 'Sexually Transmitted Diseases'
		AND
		location.name = 'Peru'
)

-- Change all for Sexually Transmitted Diseases for PLINE
UPDATE informationtype_productserviceline_productservicename_location_to_contact SET contact_id = 1678 WHERE id IN (
	SELECT
		informationtype_productserviceline_productservicename_location_to_contact.id
	FROM 
		informationtype_productserviceline_productservicename_to_location
	INNER JOIN
		informationtype_productserviceline_to_productservicename
	ON
		informationtype_productserviceline_productservicename_to_location.informationtype_productserviceline_productservicename_id = informationtype_productserviceline_to_productservicename.id
	INNER JOIN
		informationtype_to_productserviceline
	ON
		informationtype_productserviceline_to_productservicename.informationtype_productserviceline_id = informationtype_to_productserviceline.id
	INNER JOIN
		informationtype
	ON
		informationtype.id = informationtype_to_productserviceline.informationtype_id
	INNER JOIN
		productserviceline
	ON 
		productserviceline.id = informationtype_to_productserviceline.productserviceline_id
	INNER JOIN
		productservicename
	ON
		productservicename.id = informationtype_productserviceline_to_productservicename.productservicename_id
	INNER JOIN
		location
	ON
		location.id = informationtype_productserviceline_productservicename_to_location.location_id
	INNER JOIN
		informationtype_productserviceline_productservicename_location_to_contact
	ON
		informationtype_productserviceline_productservicename_location_to_contact.informationtype_productserviceline_productservicename_location_id = informationtype_productserviceline_productservicename_to_location.id
	INNER JOIN
		contact
	ON
		informationtype_productserviceline_productservicename_location_to_contact.contact_id = contact.id
	INNER JOIN 
		contact_to_facility
	ON
		contact.id = contact_to_facility.contact_id
	INNER JOIN
		facility
	ON
		contact_to_facility.facility_id = facility.id
	WHERE
		informationtype.name = 'Sales and Distribution'
		AND
		productservicename.name IN ('APTIMA Unisex Swab Specimen Collection Kit for Endovervical and Male Urethral Swab Specimens', 'APTIMA Auto Detect Reagents', 'APTIMA GC Assay', 'APTIMA Vaginal Swab Specimen Collection Kit', 'APTIMA COMBO 2 Assay', 'APTIMA Specimen Transfer Kit for use with Liquid Pap Specimens', 'APTIMA Urine Specimen Collection Kit for Male and Female Urine Specimens', 'APTIMA HPV Assay', 'APTIMA CT Assay', 'APTIMA Trichomonas vaginalis')
		AND
		location.name = 'Peru'
)