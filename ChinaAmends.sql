DECLARE @contact_id int

EXECUTE CreateAddress
	-- Contact Label
		NULL,
	-- Facility
		'BFR Gene Diagnostics Ltd.',
	-- Person
		'Liu Xiangjun',
	-- Address 1
		'12 HongDa North Road, Chuang Xin',
	-- Address 2
		'Da Sha, Building B, Block 3, Suite 418',
	-- Address 3
		'BDA Beijing 100176 China',
	-- Phone 1
		'010-67867868.218',
	-- Phone 2
		Null,
	-- Fax 1
		Null,
	-- Fax 2
		Null,
	-- Email
		'xjliu@bfrbiotech.com.cn',
	-- Website
		NULL,
	-- Contact Id
		NULL,
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
		NULL,
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
    	Null,
    -- Address 2
    	Null,
    -- Address 3
    	Null,
    -- Phone 1
    	Null,
    -- Phone 2
    	Null,
    -- Fax 1
    	Null,
    -- Fax 2
    	Null,
    -- Email
    	'xjliu@bfrbiotech.com.cn',
    -- Website
    	NULL,
    -- Contact Id
    	@contact_id,
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
    	NULL,
    -- OUTPUT
    	@contact_id OUTPUT


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
	    'LIFECODES LSA MIC',
	    'LIFECODES LSA Single Antigen',
	    'LIFECODES Fluoroanalyzer',
		'LIFECODES HLA Genotyping', -- (SSO Typing)
		'LIFECODES Screen & Identification', -- (BEAD-based)
		'LIFECODES KIR Genotyping',
		'LIFECODES Red Cell Genotyping', -- (LUMINEX based Typing)
		'LIFECODES Donor Specific Antibody' -- (BEAD-based)
		)
	AND
	location.name = 'China'
	AND
	contact.id = 1595

DELETE FROM informationtype_productservicetype_productservicename_location_to_contact
	WHERE id in (SELECT informationtype_productservicetype_productservicename_location_to_contact_id FROM @t)

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
				WHEN 'LIFECODES Donor Specific Antibody' THEN '''Bead-based'''
				WHEN 'LIFECODES Screen & Identification' THEN '''Bead-based'''
			    WHEN 'LIFECODES HLA Genotyping'  THEN '''SSO Typing'''
			    WHEN 'LIFECODES Red Cell Genotyping' THEN '''Luminex-based Typing'''
			    ELSE 'NULL' END AS 'NULL'
		  )
		+ ', NULL, NULL, NULL, NULL, NULL, '
		+ CAST(@contact_id as varchar(max))
		+', 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1; '
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
	SELECT 'China' AS name
	) newlocations
WHERE
	productservicetype.name IN
	(
	'Transplant & Transfusion Medicine'
	)
	AND
	productservicename.name IN
	(
	    'LIFECODES LSA MIC',
	    'LIFECODES LSA Single Antigen',
	    'LIFECODES Fluoroanalyzer',
		'LIFECODES HLA Genotyping', -- (SSO Typing)
		'LIFECODES Screen & Identification', -- (BEAD-based)
		'LIFECODES KIR Genotyping',
		'LIFECODES Red Cell Genotyping', -- (LUMINEX based Typing)
		'LIFECODES Donor Specific Antibody' -- (BEAD-based)
	)

EXEC (@SQL)

-- PSLINE

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
    	'LIFECODES Transplant products'
    )
	AND
	productservicename.name IN (
	    'LIFECODES LSA MIC',
	    'LIFECODES LSA Single Antigen',
	    'LIFECODES Fluoroanalyzer',
		'LIFECODES HLA Genotyping', -- (SSO Typing)
		'LIFECODES Screen & Identification', -- (BEAD-based)
		'LIFECODES KIR Genotyping',
		'LIFECODES Red Cell Genotyping', -- (LUMINEX based Typing)
		'LIFECODES Donor Specific Antibody' -- (BEAD-based)
		)
	AND
	location.name = 'China'
	AND
	contact.id = 1595

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
				WHEN 'LIFECODES Donor Specific Antibody' THEN '''Bead-based'''
				WHEN 'LIFECODES Screen & Identification' THEN '''Bead-based'''
			    WHEN 'LIFECODES HLA Genotyping'  THEN '''SSO Typing'''
			    WHEN 'LIFECODES Red Cell Genotyping' THEN '''Luminex-based Typing'''
			    ELSE 'NULL' END AS 'NULL'
		  )
  		+ ', NULL, NULL, NULL, NULL, NULL, '
  		+ CAST(@contact_id as varchar(max))
  		+', 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1; '
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
	SELECT 'China' AS name
	) newlocations
WHERE
	productserviceline.name IN
	(
	'LIFECODES Transfusion medicine',
	'LIFECODES Transplant products',
	)
	AND
	productservicename.name IN
	(
	    'LIFECODES LSA MIC',
	    'LIFECODES LSA Single Antigen',
	    'LIFECODES Fluoroanalyzer',
		'LIFECODES HLA Genotyping', -- (SSO Typing)
		'LIFECODES Screen & Identification', -- (BEAD-based)
		'LIFECODES KIR Genotyping',
		'LIFECODES Red Cell Genotyping', -- (LUMINEX based Typing)
		'LIFECODES Donor Specific Antibody' -- (BEAD-based)
	)

EXEC (@SQL)