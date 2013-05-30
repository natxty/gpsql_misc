-- Create the PANTHER System PSLine category

DECLARE @pantherLineID int

INSERT INTO
	productserviceline
	(name)
VALUES
	('PANTHER System')

SET @pantherLineID = @@IDENTITY

-- Create PANTHER productservicename

DECLARE @pantherPsID int

INSERT INTO
	productservicename
	(name)
VALUES
	('PANTHER')

SET @pantherPsID = @@IDENTITY

-- Create a temporary table to store all the itype, locations, and contacts from PSType

DECLARE @tbl Table (
	informationtype_id int,
	location_id int,
	contact_id int
)

INSERT INTO @tbl
SELECT
	MIN(informationtype.id), 
	MIN(location.id),
	MIN(contact.id)
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
	productservicename.name like '%Panther%'
GROUP BY
	location.name,
	productservicename.name,
	contact.id

-- Create a path for PSLine

INSERT INTO
	informationtype_to_productserviceline 
	(informationtype_id, productserviceline_id)
SELECT
	informationtype.id,
	@pantherLineID
FROM
	informationtype
	
-- Create a path for PSName

INSERT INTO 
	informationtype_productserviceline_to_productservicename
	(informationtype_productserviceline_id, productservicename_id, us, gl, both)
SELECT
	informationtype_to_productserviceline.id, 
	@pantherPsID,
	0,
	0,
	1
FROM
	informationtype_to_productserviceline
INNER JOIN
	productserviceline
ON
	informationtype_to_productserviceline.productserviceline_id = productserviceline.id
WHERE
	productserviceline.id = @pantherLineID

-- Go through our stored information and apply it 

---- Location

INSERT INTO
	informationtype_productserviceline_productservicename_to_location
	(informationtype_productserviceline_productservicename_id, location_id, us, gl, both)
SELECT
	informationtype_productserviceline_to_productservicename.id, 
	t.location_id,
	0,
	0,
	1
FROM
	@tbl as t
INNER JOIN
	informationtype_to_productserviceline
ON
	informationtype_to_productserviceline.informationtype_id = t.informationtype_id
INNER JOIN
	informationtype_productserviceline_to_productservicename
ON
	informationtype_productserviceline_to_productservicename.informationtype_productserviceline_id = informationtype_to_productserviceline.id
WHERE
	informationtype_productserviceline_to_productservicename.productservicename_id = @pantherPsID
	
-- Contact

INSERT INTO
	informationtype_productserviceline_productservicename_location_to_contact
	(informationtype_productserviceline_productservicename_location_id, contact_id)
SELECT
	informationtype_productserviceline_productservicename_to_location.id, 
	t.contact_id
FROM
	@tbl as t
INNER JOIN
	informationtype_to_productserviceline
ON
	informationtype_to_productserviceline.informationtype_id = t.informationtype_id
INNER JOIN
	informationtype_productserviceline_to_productservicename
ON
	informationtype_productserviceline_to_productservicename.informationtype_productserviceline_id = informationtype_to_productserviceline.id
INNER JOIN
	informationtype_productserviceline_productservicename_to_location
ON
	informationtype_productserviceline_productservicename_to_location.informationtype_productserviceline_productservicename_id = informationtype_productserviceline_to_productservicename.id
WHERE
	informationtype_productserviceline_to_productservicename.productservicename_id = @pantherPsID
	AND
	informationtype_productserviceline_productservicename_to_location.location_id = t.location_id
	
-- Delete Duplicated Contacts

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
	productservicename.name like '%Panther%'
	AND 
	informationtype_productserviceline_productservicename_location_to_contact.id NOT IN 
	(
		SELECT
			MIN(informationtype_productserviceline_productservicename_location_to_contact.id)
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
			productservicename.name like '%Panther%'
		GROUP BY
			location.name,
			productservicename.name,
			contact.id
	)
	
-- Add it into Locations (for some reason our query above doesn't get this)
	
EXECUTE ContactPath
	'Locations', 		--informationtype
	NULL, 		--productservicetype
	'PANTHER System',		--productserviceline
	'PANTHER',		--productservicename
	'Gen-Probe Incorporated',		--location
	NULL,		--contact_label
	NULL,		--informationtype_id
	NULL,		--productservicetype_id
	NULL,		--productserviceline_id
	NULL,		--productservicename_id
	NULL,		--location_id
	1,		--contact_id
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