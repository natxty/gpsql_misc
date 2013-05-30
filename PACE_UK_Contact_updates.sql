-- Make our addresses

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
	productservicetype.name = 'Sexually Transmitted Diseases'
	AND
	productservicename.name LIKE '%PACE%'
	AND
	location.name = 'United Kingdom'
	AND
	facility.name <> 'bioMérieux'
ORDER BY
	locatname


SELECT
	informationtype.name as itypename,
	informationtype.id as itypeid,
	productserviceline.name as plinename,
	productserviceline.id as plineid,
	productservicename.name as psname,
	productservicename.id as psnameid,
	location.name as locatname,
	location.id as locatid,
	facility.name as facilityname,
	contact.id as contactid
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
	productserviceline.name = 'Pace'
	AND
	productservicename.name LIKE '%PACE%'
	AND
	location.name = 'United Kingdom'
	AND
	facility.name <> 'bioMérieux'
ORDER BY
	locatname


-- Inset the addresses


---- PSTYPE

DECLARE @SQL Varchar(max)
SET @SQL = ''

SELECT
	@SQL = @SQL
		+ 'EXECUTE ContactPath '
		+ '''Sales and Distribution'','
		+ '''Sexually Transmitted Diseases'','
		+ 'NULL,'
		+ '''' + productservicename.name + ''','
		+ '''United Kingdom'', '
		+ 'NULL, NULL, NULL, NULL, NULL, NULL, '
		+ CAST(new_contact.id as varchar(max))
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
	(SELECT 1693 as id 
		UNION ALL SELECT 1692
		UNION ALL SELECT 1691
		UNION ALL SELECT 1690
		UNION ALL SELECT 1689
		UNION ALL SELECT 1688
	) new_contact
WHERE
	informationtype.name = 'Sales and Distribution'
	AND
	productservicetype.name = 'Sexually Transmitted Diseases'
	AND
	productservicename.name LIKE '%PACE%'


---- PSLINE

SELECT
	@SQL = @SQL
		+ 'EXECUTE ContactPath '
		+ '''Sales and Distribution'','
		+ 'NULL,'
		+ '''Pace'','
		+ '''' + productservicename.name + ''','
		+ '''United Kingdom'', '
		+ 'NULL, NULL, NULL, NULL, NULL, NULL, '
		+ CAST(new_contact.id as varchar(max))
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
	(SELECT 1693 as id 
		UNION ALL SELECT 1692
		UNION ALL SELECT 1691
		UNION ALL SELECT 1690
		UNION ALL SELECT 1689
		UNION ALL SELECT 1688
	) new_contact
WHERE
	informationtype.name = 'Sales and Distribution'
	AND
	productserviceline.name = 'Pace'
	AND
	productservicename.name LIKE '%PACE%'

EXEC(@SQL)


-- Follow Up fix from Colin's:

UPDATE
	informationtype_productserviceline_productservicename_location_to_contact
SET
	contact_id = 1694
WHERE
	contact_id = 1690

UPDATE
	informationtype_productservicetype_productservicename_location_to_contact
SET
	contact_id = 1694
WHERE
	contact_id = 1690

