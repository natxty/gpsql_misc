-- Change both to just us

---- PSTYPE

UPDATE
	informationtype_productservicetype_productservicename_to_location
SET
	informationtype_productservicetype_productservicename_to_location.us = 1,
	informationtype_productservicetype_productservicename_to_location.both = 0
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
	informationtype.name IN ('Customer Service', 'Technical Support')
	AND
	productservicename.name = 'Prodesse ProGastro SSCS'

SELECT
	informationtype.name as itypename,
	informationtype.id as itypeid,
	productservicetype.name as ptypename,
	productservicetype.id as ptypeid,
	productservicename.name as psname,
	productservicename.id as psnameid,
	location.name as locatname,
	location.id as locatid,
	facility.name as facilityname,
	contact.id as contactid,
	informationtype_productservicetype_productservicename_to_location.*
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
	informationtype.name IN ('Customer Service', 'Locations', 'Technical Support')
	AND
	productservicename.name = 'Prodesse ProGastro SSCS'
ORDER BY
	locatname

---- PSLINE

UPDATE
	informationtype_productserviceline_productservicename_to_location
SET
	informationtype_productserviceline_productservicename_to_location.us = 1,
	informationtype_productserviceline_productservicename_to_location.both = 0
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
	informationtype.name IN ('Customer Service', 'Technical Support')
	AND
	productservicename.name = 'Prodesse ProGastro SSCS'

SELECT
	informationtype.name as itypename,
	informationtype.id as itypeid,
	productserviceline.name as ptypename,
	productserviceline.id as ptypeid,
	productservicename.name as psname,
	productservicename.id as psnameid,
	location.name as locatname,
	location.id as locatid,
	facility.name as facilityname,
	contact.id as contactid,
	informationtype_productserviceline_productservicename_to_location.*
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
	informationtype.name IN ('Customer Service', 'Locations', 'Technical Support')
	AND
	productservicename.name = 'Prodesse ProGastro SSCS'
ORDER BY
	locatname


-- Add information to CD and SSCS

DECLARE @SQL Varchar(max)

---- PSTYPE

SET @SQL = ''
SELECT
	@SQL = @SQL
		+ 'EXECUTE ContactPath '
		+ '''' + informationtype.name + ''','
		+ '''Microbial Infectious Diseases'','
		+ 'NULL,'
		+ '''' + 'Prodesse ProGastro SSCS' + ''','
		+ '''' + location.name + ''', '
		+ 'NULL, NULL, NULL, NULL, NULL, NULL, '
		+ CAST(contact.id as varchar(max))
		+', 0, 0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 1; '
		+ 'EXECUTE ContactPath '
		+ '''' + informationtype.name + ''','
		+ '''Microbial Infectious Diseases'','
		+ 'NULL,'
		+ '''' + 'Prodesse ProGastro Cd' + ''','
		+ '''' + location.name + ''', '
		+ 'NULL, NULL, NULL, NULL, NULL, NULL, '
		+ CAST(contact.id as varchar(max))
		+', 0, 0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 1; '
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
	informationtype.name IN ('Customer Service', 'Technical Support')
	AND
	informationtype_productservicetype_productservicename_to_location.gl = 1
	AND
	productservicename.name = 'Prodesse ProFlu+'



---- PSLINE

SET @SQL = ''
SELECT
	@SQL = @SQL
		+ 'EXECUTE ContactPath '
		+ '''' + informationtype.name + ''','
		+ 'NULL,'
		+ '''Prodesse'','
		+ '''' + 'Prodesse ProGastro SSCS' + ''','
		+ '''' + location.name + ''', '
		+ 'NULL, NULL, NULL, NULL, NULL, NULL, '
		+ CAST(contact.id as varchar(max))
		+', 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 1, 0; '
		+ 'EXECUTE ContactPath '
		+ '''' + informationtype.name + ''','
		+ 'NULL,'
		+ '''Prodesse'','
		+ '''' + 'Prodesse ProGastro Cd' + ''','
		+ '''' + location.name + ''', '
		+ 'NULL, NULL, NULL, NULL, NULL, NULL, '
		+ CAST(contact.id as varchar(max))
		+', 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 1, 0; '
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
	informationtype.name IN ('Customer Service', 'Technical Support')
	AND
	informationtype_productserviceline_productservicename_to_location.gl = 1
	AND
	productservicename.name = 'Prodesse ProFlu+'

EXEC(@SQL)

INSERT INTO informationtype_productservicetype_productservicename_to_location (informationtype_productservicetype_productservicename_id, location_id, us, gl, both)
VALUES (866, 191, 1,0,0)

insert into salesrepgroup_to_productservicename (salesrepgroup_id, productservicename_id) values (4, 141)



INSERT INTO informationtype_productserviceline_productservicename_to_location (informationtype_productserviceline_productservicename_id, location_id, us, gl, both)
VALUES (776, 191, 1,0,0)


