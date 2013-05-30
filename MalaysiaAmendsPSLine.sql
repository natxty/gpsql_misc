-- Select all products that have Tree Med facility

DECLARE @contact_id int
EXECUTE CreateAddress
	-- Contact Label
		NULL,
	-- Facility	
		Null,		
	-- Person
		Null,		
	-- Address 1
		NULL,
	-- Address 2
		NULL,
	-- Address 3		
		NULL,
	-- Phone 1
		Null,		
	-- Phone 2
		'(Mobile) +6012 297 2604',
	-- Fax 1
		'+ 603 6272 0093',
	-- Fax 2
		NULL,
	-- Email
		Null,
	-- Website
		'www.biomarketing.com.my',	
	-- Contact Id
		74,
	-- Facility Id	
		NULL,
	-- Person Id		
		NULL,
	-- Address 1 Id
		NULL,
	-- Address 2 Id
		NULL,
	-- Address 3 Id
		NULL,
	-- Phone 1 Id
		NULL,
	-- Phone 2 Id
		NULL,
	-- Fax 1 Id
		NULL,
	-- Fax 2 Id
		NULL,
	-- Email Id
		NULL,
	-- Website Id
		Null,
	-- OUTPUT	
		@contact_id OUTPUT

EXECUTE CreateAddress
	-- Contact Label
		NULL,
	-- Facility	
		Null,		
	-- Person
		Null,		
	-- Address 1
		NULL,
	-- Address 2
		NULL,
	-- Address 3		
		NULL,
	-- Phone 1
		Null,		
	-- Phone 2
		Null,
	-- Fax 1
		'+ 603 6272 0093',
	-- Fax 2
		NULL,
	-- Email
		Null,
	-- Website
		'www.biomarketing.com.my',	
	-- Contact Id
		74,
	-- Facility Id	
		NULL,
	-- Person Id		
		NULL,
	-- Address 1 Id
		NULL,
	-- Address 2 Id
		NULL,
	-- Address 3 Id
		NULL,
	-- Phone 1 Id
		NULL,
	-- Phone 2 Id
		NULL,
	-- Fax 1 Id
		NULL,
	-- Fax 2 Id
		NULL,
	-- Email Id
		NULL,
	-- Website Id
		Null,
	-- OUTPUT	
		@contact_id OUTPUT

DECLARE @t Table (
	informationtype_productserviceline_productservicename_location_to_contact_id int
)

INSERT INTO @t
SELECT
	informationtype_productserviceline_productservicename_location_to_contact.id
FROM
	informationtype
INNER JOIN
	informationtype_to_productserviceline
ON
	informationtype.id = informationtype_to_productserviceline.informationtype_id
INNER JOIN
	productserviceline
ON
	productserviceline.id = informationtype_to_productserviceline.productserviceline_id
INNER JOIN
	informationtype_productserviceline_to_productservicename
ON
	informationtype_to_productserviceline.id = informationtype_productserviceline_to_productservicename.informationtype_productserviceline_id
INNER JOIN
	productservicename
ON
	productservicename.id = informationtype_productserviceline_to_productservicename.productservicename_id
INNER JOIN
	informationtype_productserviceline_productservicename_to_location
ON
	informationtype_productserviceline_to_productservicename.id = informationtype_productserviceline_productservicename_to_location.informationtype_productserviceline_productservicename_id
INNER JOIN
	location
ON
	location.id = informationtype_productserviceline_productservicename_to_location.location_id
INNER JOIN
	informationtype_productserviceline_productservicename_location_to_contact
ON
	informationtype_productserviceline_productservicename_to_location.id = informationtype_productserviceline_productservicename_location_to_contact.informationtype_productserviceline_productservicename_location_id
INNER JOIN
	contact
ON
	contact.id = informationtype_productserviceline_productservicename_location_to_contact.contact_id
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
	productserviceline.name IN (
	    'LIFECODES Transfusion medicine',
    	'LIFECODES Transplant products',
    	'LIFECODES Coagulation'
    )
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

DELETE FROM informationtype_productserviceline_productservicename_location_to_contact 
	WHERE id in (SELECT informationtype_productserviceline_productservicename_location_to_contact_id FROM @t)

-- Big SQL Path Statement...

DECLARE @SQL Varchar(max)
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
				WHEN 'LIFECODES Donor Specific Antibody' THEN '''ELISA-based'''
				WHEN 'LIFECODES Screen & Identification' THEN '''ELISA-based'''
			    WHEN 'LIFECODES HLA Genotyping'  THEN '''SSP Typing'''
			    WHEN 'LIFECODES Red Cell Genotyping' THEN '''E-Gel based Typing'''
			    ELSE 'NULL' END AS 'NULL'
		  )	  			
		+ ', NULL, NULL, NULL, NULL, NULL, 74, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1; '
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
	SELECT 'Malaysia' AS name 
	) newlocations	
WHERE
	productserviceline.name IN
	(
	'LIFECODES Transfusion medicine',
	'LIFECODES Transplant products',
	'LIFECODES Coagulation'
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