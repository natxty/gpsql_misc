

DECLARE @SQL Varchar(max)
SET @SQL = ''

SELECT
	@SQL = @SQL
		+ 'EXECUTE ContactPath '
		+ '''' + informationtype.name + ''','
		+ '''' + productservicetype.name + ''','
		+ 'NULL,'
		+ '''' + 'Prodesse ProGastro SSCS' + ''','
		+ '''' + location.name + ''', '
		+ 'NULL, NULL, NULL, NULL, NULL, NULL, '
		+ CAST(contact.id as varchar(max))
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
	productservicename.name = 'ProGastro Cd'

EXEC(@SQL)



DECLARE @SQL Varchar(max)
SET @SQL = ''

SELECT
	@SQL = @SQL
		+ 'EXECUTE ContactPath '
		+ '''' + informationtype.name + ''','
		+ 'NULL,'
		+ '''' + productserviceline.name + ''','
		+ '''' + 'Prodesse ProGastro SSCS' + ''','
		+ '''' + location.name + ''', '
		+ 'NULL, NULL, NULL, NULL, NULL, NULL, '
		+ CAST(contact.id as varchar(max))
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
	productservicename.name = 'ProGastro Cd'

EXEC(@SQL)

-- Find the original, change it!

SELECT * FROM productservicename WHERE name = 'ProGrasto Cd'