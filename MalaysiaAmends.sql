-- Select all products that have Tree Med facility

DECLARE @t Table (
	informationtype_productservicetype_productservicename_location_to_contact_id int
)

INSERT INTO @t
SELECT
	informationtype_productservicetype_productservicename_location_to_contact.id
FROM
	informationtype
INNER JOIN
	informationtype_to_productservicetype
ON
	informationtype.id = informationtype_to_productservicetype.informationtype_id
INNER JOIN
	productservicetype
ON
	productservicetype.id = informationtype_to_productservicetype.productservicetype_id
INNER JOIN
	informationtype_productservicetype_to_productservicename
ON
	informationtype_to_productservicetype.id = informationtype_productservicetype_to_productservicename.informationtype_productservicetype_id
INNER JOIN
	productservicename
ON
	productservicename.id = informationtype_productservicetype_to_productservicename.productservicename_id
INNER JOIN
	informationtype_productservicetype_productservicename_to_location
ON
	informationtype_productservicetype_to_productservicename.id = informationtype_productservicetype_productservicename_to_location.informationtype_productservicetype_productservicename_id
INNER JOIN
	location
ON
	location.id = informationtype_productservicetype_productservicename_to_location.location_id
INNER JOIN
	informationtype_productservicetype_productservicename_location_to_contact
ON
	informationtype_productservicetype_productservicename_to_location.id = informationtype_productservicetype_productservicename_location_to_contact.informationtype_productservicetype_productservicename_location_id
INNER JOIN
	contact
ON
	contact.id = informationtype_productservicetype_productservicename_location_to_contact.contact_id
INNER JOIN
	contact_to_facility
ON
	contact.id = contact_to_facility.contact_id
INNER JOIN
	facility
ON
	facility.id = contact_to_facility.facility_id
WHERE
	informationtype.name = 'Sales and Distribution'
	AND
	productservicetype.name IN ('Transplant & Transfusion Medicine', 'Coagulation Products')
	AND
	productservicename.name IN (
		'LIFECODES Coagulation products',
		'LIFECODES HLA Genotyping', -- (SSP Typing)
		'LIFECODES Screen & Identification', -- (ELISA-based) 
		'LIFECODES Platelet Antibody Detection Products', 
		'LIFECODES HPA Genotyping', 
		'LIFECODES Donor Screening', 
		'LIFECODES Serology Products',
		-- Don't add back
		'LIFECODES Red Cell Genotyping', -- (E-Gel based Typing)
		'LIFECODES Donor Specific Antibody' -- (ELISA-based)
		)
	AND
	location.name = 'Malaysia'
	AND
	contact.id = 1590

DELETE FROM informationtype_productservicetype_productservicename_location_to_contact 
	WHERE id in (SELECT informationtype_productservicetype_productservicename_location_to_contact_id FROM @t)

/*
DECLARE @bioMarketingID int

SELECT 
	@bioMarketingID = contact.id
FROM
	contact
INNER JOIN
	contact_to_facility
ON
    contact.id = contact_to_facility.contact_id
INNER JOIN
    facility
ON
    facility.id = contact_to_facility.facility_id
WHERE
	facility.name = 'Biomarketing Services (M) Sdn Bhd'
*/

-- Big SQL Path Statement...

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
				WHEN 'LIFECODES Donor Specific Antibody' THEN '''ELISA-based'''
				WHEN 'LIFECODES Screen & Identification' THEN '''ELISA-based'''
			    WHEN 'LIFECODES HLA Genotyping'  THEN '''SSP Typing'''
			    WHEN 'LIFECODES Red Cell Genotyping' THEN '''E-Gel based Typing'''
			    ELSE 'NULL' END AS 'NULL'
		  )	  			
		+ ', NULL, NULL, NULL, NULL, NULL, 74, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1; '
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
	SELECT 'Malaysia' AS name 
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
    'LIFECODES HLA Genotyping', -- (SSP Typing)
    'LIFECODES Screen & Identification', -- (ELISA-based) 
    'LIFECODES Platelet Antibody Detection Products', 
    'LIFECODES HPA Genotyping', 
    'LIFECODES Donor Screening', 
    'LIFECODES Serology Products'
	)
	
EXEC (@SQL)