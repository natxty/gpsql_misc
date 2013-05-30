-- Make our addresses

DECLARE @ukn_hp_id int

EXECUTE CreateAddress
	-- Contact Label
		NULL,
	-- Facility
		'UK North',
	-- Person
		'Helen Petrakis',
	-- Address 1
		Null,
	-- Address 2
		Null,
	-- Address 3
		Null,
	-- Phone 1
		'+44 (0)7876 688643',
	-- Phone 2
		Null,
	-- Fax 1
		Null,
	-- Fax 2
		Null,
	-- Email
		'helen.petrakis@hologic.com',
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
		@ukn_hp_id OUTPUT


DECLARE @ukwi_rg_id int

EXECUTE CreateAddress
	-- Contact Label
		NULL,
	-- Facility
		'UK West/Ireland',
	-- Person
		'Rachel Gratland',
	-- Address 1
		Null,
	-- Address 2
		Null,
	-- Address 3
		Null,
	-- Phone 1
		'+44 (0)7554 451118',
	-- Phone 2
		Null,
	-- Fax 1
		Null,
	-- Fax 2
		Null,
	-- Email
		'rachel.gratland@hologic.com',
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
		@ukwi_rg_id OUTPUT


DECLARE @ukc_rg_id int

EXECUTE CreateAddress
	-- Contact Label
		NULL,
	-- Facility
		'UK Central',
	-- Person
		'Rachel Gratland',
	-- Address 1
		Null,
	-- Address 2
		Null,
	-- Address 3
		Null,
	-- Phone 1
		'+44 (0)7554 451118',
	-- Phone 2
		Null,
	-- Fax 1
		Null,
	-- Fax 2
		Null,
	-- Email
		'rachel.gratland@hologic.com',
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
		@ukc_rg_id OUTPUT

DECLARE @uke_jf_id int

EXECUTE CreateAddress
	-- Contact Label
		NULL,
	-- Facility
		'UK East',
	-- Person
		'Jo Frost',
	-- Address 1
		Null,
	-- Address 2
		Null,
	-- Address 3
		Null,
	-- Phone 1
		'+44 (0)7917 155105',
	-- Phone 2
		Null,
	-- Fax 1
		Null,
	-- Fax 2
		Null,
	-- Email
		'jo.frost@hologic.com',
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
		@uke_jf_id OUTPUT

DECLARE @uks_dk_id int

EXECUTE CreateAddress
	-- Contact Label
		NULL,
	-- Facility
		'UK South',
	-- Person
		'Doug Kirkwood',
	-- Address 1
		Null,
	-- Address 2
		Null,
	-- Address 3
		Null,
	-- Phone 1
		'+44 (0)7825 752530',
	-- Phone 2
		Null,
	-- Fax 1
		Null,
	-- Fax 2
		Null,
	-- Email
		'doug.kirkwood@hologic.com',
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
		@uks_dk_id OUTPUT

DECLARE @ukw_rsd_id int

EXECUTE CreateAddress
	-- Contact Label
		NULL,
	-- Facility
		'UK South West',
	-- Person
		'Rebekah Selby-Davis',
	-- Address 1
		Null,
	-- Address 2
		Null,
	-- Address 3
		Null,
	-- Phone 1
		'+44 (0)7780 992092',
	-- Phone 2
		Null,
	-- Fax 1
		Null,
	-- Fax 2
		Null,
	-- Email
		'rebekah.selby-davis@hologic.com',
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
		@ukw_rsd_id OUTPUT

SELECT @ukw_rsd_id, @uks_dk_id, @uke_jf_id, @ukc_rg_id, @ukwi_rg_id, @ukn_hp_id


DECLARE @ukw_rsd_id int
DECLARE @uks_dk_id int
DECLARE @uke_jf_id int
DECLARE @ukc_rg_id int
DECLARE @ukwi_rg_id int
DECLARE @ukn_hp_id int

SET @ukw_rsd_id = 1693 
SET @uks_dk_id = 1692
SET @uke_jf_id = 1691
SET @ukc_rg_id = 1690
SET @ukwi_rg_id = 1689
SET @ukn_hp_id = 1688

-- Delete these...

---- PSTYPE

DELETE
	informationtype_productservicetype_productservicename_location_to_contact
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
	productservicetype.name IN (
		'Instrument Systems',
		'Sexually Transmitted Diseases',
		'Virals')
	AND
	location.name = 'United Kingdom'
	AND
	productservicename.name NOT LIKE '%pace%'

---- PSLINE

DELETE
	informationtype_productserviceline_productservicename_location_to_contact
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
	productserviceline.name IN (
		'Aptima',
		'APTIMA HCV Qualitative Kit',
		'APTIMA HIV-1 RNA Qualitative Assay',
		'Aptima HPV',
		'APTIMA Trichomonas vaginalis',
		'DTS Systems',
		'LEADER Systems',
		'PANTHER System',
		'TIGRIS')
	AND
	location.name = 'United Kingdom'
	AND
	productservicename.name NOT LIKE '%pace%'

-- Actually add the new contacts

-- PSTYPE

DECLARE @SQL Varchar(max)
SET @SQL = ''

SELECT
	@SQL = @SQL
		+ 'EXECUTE ContactPath ''Sales and Distribution'','
		+ '''' + productservicetype.name + ''','
		+ 'NULL,'
		+ '''' + productservicename.name + ''','
		+ '''' + location.name + ''', '
		+ 'NULL, NULL, NULL, NULL, NULL, NULL, '
		+ CAST(newcontacts.id as varchar(max))
		+', 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1; '
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
CROSS JOIN
	(
	SELECT @ukw_rsd_id AS id
	UNION ALL
	SELECT @uks_dk_id
	UNION ALL
	SELECT @uke_jf_id
	UNION ALL
	SELECT @ukc_rg_id
	UNION ALL
	SELECT @ukwi_rg_id
	UNION ALL
	SELECT @ukn_hp_id
	) newcontacts
WHERE
	informationtype.name = 'Sales and Distribution'
	AND
	productservicetype.name IN (
		'Instrument Systems',
		'Sexually Transmitted Diseases',
		'Virals')
	AND
	location.name = 'United Kingdom'
	AND
	productservicename.name NOT LIKE '%pace%'

EXEC (@SQL)

-- PSLINE

SET @SQL = ''

SELECT
	@SQL = @SQL
		+ 'EXECUTE ContactPath ''Sales and Distribution'','
		+ 'NULL,'
		+ '''' + productserviceline.name + ''','
		+ '''' + productservicename.name + ''','
		+ '''' + location.name + ''', '
		+ 'NULL, NULL, NULL, NULL, NULL, NULL, '
		+ CAST(newcontacts.id as varchar(max))
		+', 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1; '
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
CROSS JOIN
	(
	SELECT @ukw_rsd_id AS id
	UNION ALL
	SELECT @uks_dk_id
	UNION ALL
	SELECT @uke_jf_id
	UNION ALL
	SELECT @ukc_rg_id
	UNION ALL
	SELECT @ukwi_rg_id
	UNION ALL
	SELECT @ukn_hp_id
	) newcontacts
WHERE
	informationtype.name = 'Sales and Distribution'
	AND
	productserviceline.name IN (
		'Aptima',
		'APTIMA HCV Qualitative Kit',
		'APTIMA HIV-1 RNA Qualitative Assay',
		'Aptima HPV',
		'APTIMA Trichomonas vaginalis',
		'DTS Systems',
		'LEADER Systems',
		'PANTHER System',
		'TIGRIS')
	AND
	location.name = 'United Kingdom'
	AND
	productservicename.name NOT LIKE '%pace%'

EXEC (@SQL)