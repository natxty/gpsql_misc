
-- Waukesha Amends
-- https://basecamp.com/1765062/projects/39961-gen-probe/messages/2069456-contact-us

---- Clean up our productservicenames 

DECLARE @psnames Table (
	id int,
	name varchar(255)
)

INSERT INTO @psnames
SELECT 
	MIN(id), name 
FROM 
	productservicename
GROUP BY 
	name

------- Slick update checking if id doesn't match found name

-------- (PSTYPE)

UPDATE
	informationtype_productservicetype_to_productservicename
SET
	informationtype_productservicetype_to_productservicename.productservicename_id = psn.id
FROM
	informationtype_productservicetype_to_productservicename
INNER JOIN
	productservicename
ON
	informationtype_productservicetype_to_productservicename.productservicename_id = productservicename.id
INNER JOIN
	@psnames as psn
ON
	productservicename.name = psn.name
WHERE
	productservicename.id != psn.id
	
-------- (PSLINE)
	
UPDATE
	informationtype_productserviceline_to_productservicename
SET
	informationtype_productserviceline_to_productservicename.productservicename_id = psn.id
FROM
	informationtype_productserviceline_to_productservicename
INNER JOIN
	productservicename
ON
	informationtype_productserviceline_to_productservicename.productservicename_id = productservicename.id
INNER JOIN
	@psnames as psn
ON
	productservicename.name = psn.name
WHERE
	productservicename.id != psn.id

------ Delete our dupes
	
DELETE FROM
	productservicename
WHERE
	productservicename.id NOT IN ( SELECT id FROM @psnames )

---- Dynamic SQL running our Contact Path Stored Procedure

------ (PSTYPE)

DECLARE @SQL Varchar(max)
SET @SQL = ''

SELECT 
	@SQL = @SQL 
		+ 'EXECUTE ContactPath ''Sales and Distribution'', ''' 
		+ productservicetype.name 
		+ ''', NULL, ''' 
		+ productservicename.name + ''', ''' 
		+ newlocations.name + ''', ' 
		+ ( 
			SELECT CASE 
				productservicename.name
				WHEN 'LIFECODES Donor Specific Antibody' THEN '''Elisa Based'''
				WHEN 'LIFECODES Screen & Identification' THEN '''Elisa Based'''
			    WHEN 'LIFECODES HLA Genotyping'  THEN '''SSP Typing'''
			    WHEN 'LIFECODES Red Cell Genotyping' THEN '''E Gel Based Typing'''
			    ELSE 'NULL' END AS 'NULL'
		  )	  			
		+ ', NULL, NULL, NULL, NULL, NULL, 59, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1; '
FROM 
	informationtype_productservicetype_to_productservicename
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
CROSS JOIN
	(	
	SELECT 'Denmark' AS name 
	UNION ALL
	SELECT 'Finland'
	UNION ALL 
	SELECT 'Netherlands'
	UNION ALL
	SELECT 'Norway'
	UNION ALL
	SELECT 'Sweden'
	UNION ALL
	SELECT 'Switzerland'
	) newlocations	
WHERE
	productservicetype.name IN
	(
	'Transplant & Transfusion Medicine',
	'Coagulation Products'
	)
	AND
	productservicename.name IN 
	(
	'LIFECODES Coagulation Products',
	'LIFECODES Platelet Antibody Detection Products',
	'LIFECODES HPA Genotyping',
	'LIFECODES Donor Screening',
	'LIFECODES Serology Products',
	'LIFECODES Donor Specific Antibody', -- Elisa Based
	'LIFECODES HLA Genotyping', -- SSP Typing
	'LIFECODES Red Cell Genotyping', -- E Gel Based Typing
	'LIFECODES Screen & Identification' -- ELISA based	
	)
	
EXEC (@SQL)

------ (PSLINE)

SET @SQL = ''

SELECT 
	@SQL = @SQL 
		+ 'EXECUTE ContactPath ''Sales and Distribution'', NULL, ''' 
		+ productserviceline.name + ''', '''
		+ productservicename.name + ''', ''' 
		+ newlocations.name + ''', ' 
		+ ( 
			SELECT CASE 
				productservicename.name
				WHEN 'LIFECODES Donor Specific Antibody' THEN '''Elisa Based'''
				WHEN 'LIFECODES Screen & Identification' THEN '''Elisa Based'''
			    WHEN 'LIFECODES HLA Genotyping'  THEN '''SSP Typing'''
			    WHEN 'LIFECODES Red Cell Genotyping' THEN '''E Gel Based Typing'''
			    ELSE 'NULL' END AS 'NULL'
		  )	  			
		+ ', NULL, NULL, NULL, NULL, NULL, 59, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1; '
FROM 
	informationtype_productserviceline_to_productservicename
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
CROSS JOIN
	(	
	SELECT 'Denmark' AS name 
	UNION ALL
	SELECT 'Finland'
	UNION ALL 
	SELECT 'Netherlands'
	UNION ALL
	SELECT 'Norway'
	UNION ALL
	SELECT 'Sweden'
	UNION ALL
	SELECT 'Switzerland'
	) newlocations	
WHERE
	productserviceline.name IN
	(
	'LIFECODES Coagulation',
	'LIFECODES Transfusion Medicine',
	'LIFECODES Transplant Products'
	)
	AND
	productservicename.name IN 
	(
	'LIFECODES Coagulation Products',
	'LIFECODES Platelet Antibody Detection Products',
	'LIFECODES HPA Genotyping',
	'LIFECODES Donor Screening',
	'LIFECODES Serology Products',
	'LIFECODES Donor Specific Antibody', -- Elisa Based
	'LIFECODES HLA Genotyping', -- SSP Typing
	'LIFECODES Red Cell Genotyping', -- E Gel Based Typing
	'LIFECODES Screen & Identification' -- ELISA based	
	)
	
EXEC (@SQL)

---- Add Labels to existing Switzerland contacts

------ (PSTYPE)

UPDATE
	informationtype_productservicetype_productservicename_location_to_contact
SET
	informationtype_productservicetype_productservicename_location_to_contact.label = ( 
	SELECT CASE 
		productservicename.name
		WHEN 'LIFECODES Donor Specific Antibody' THEN 'Bead Based'
		WHEN 'LIFECODES Screen & Identification' THEN 'Bead Based'
	    WHEN 'LIFECODES HLA Genotyping'  THEN 'SSO Typing'
	    WHEN 'LIFECODES Red Cell Genotyping' THEN 'Luminex Based Typing'
	    ELSE NULL END AS name
	)	
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
	productservicetype.name IN
	(
	'Transplant & Transfusion Medicine',
	'Coagulation Products'
	)
	AND
	productservicename.name IN 
	(
	'LIFECODES Donor Specific Antibody', -- Elisa Based
	'LIFECODES HLA Genotyping', -- SSP Typing
	'LIFECODES Red Cell Genotyping', -- E Gel Based Typing
	'LIFECODES Screen & Identification' -- ELISA based	
	)
	AND
	location.name = 'Switzerland'
	AND
	informationtype_productservicetype_productservicename_location_to_contact.label IS NULL
	
------ (PSLINE)


UPDATE
	informationtype_productserviceline_productservicename_location_to_contact
SET
	informationtype_productserviceline_productservicename_location_to_contact.label = ( 
	SELECT CASE 
		productservicename.name
		WHEN 'LIFECODES Donor Specific Antibody' THEN 'Bead Based'
		WHEN 'LIFECODES Screen & Identification' THEN 'Bead Based'
	    WHEN 'LIFECODES HLA Genotyping'  THEN 'SSO Typing'
	    WHEN 'LIFECODES Red Cell Genotyping' THEN 'Luminex Based Typing'
	    ELSE NULL END AS name
	)	
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
	productserviceline.name IN
	(
	'LIFECODES Coagulation',
	'LIFECODES Transfusion Medicine',
	'LIFECODES Transplant Products'
	)
	AND
	productservicename.name IN 
	(
	'LIFECODES Donor Specific Antibody', -- Elisa Based
	'LIFECODES HLA Genotyping', -- SSP Typing
	'LIFECODES Red Cell Genotyping', -- E Gel Based Typing
	'LIFECODES Screen & Identification' -- ELISA based	
	)
	AND
	location.name = 'Switzerland'
	AND
	informationtype_productserviceline_productservicename_location_to_contact.label IS NULL