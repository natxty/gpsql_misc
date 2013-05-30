-- Create Nucleon Mouse Tail PSName

DECLARE @mousetailId varchar(255)

SELECT @mousetailId = id FROM productservicename WHERE name = 'Nucleon Mouse Tail'

IF ( @mousetailId IS NULL )
	BEGIN
	INSERT INTO productservicename (name) VALUES ('Nucleon Mouse Tail')	
	SET @mousetailId = @@IDENTITY
	END


-- Create Nucleon Mouse Tail PSLine category

DECLARE @mousetailLineID varchar (255)

INSERT INTO productserviceline (name) VALUES ('Nucleon Mouse Tail')	
SET @mousetailLineID = @@IDENTITY

-- Change Nucleon Hard et Soft Tissue PSLine category to Nucleon Mouse Tail

UPDATE
	informationtype_to_productserviceline
SET
	informationtype_to_productserviceline.productserviceline_id = @mousetailLineID
FROM 
	informationtype_to_productserviceline 
INNER JOIN
	productserviceline
ON
	informationtype_to_productserviceline.productserviceline_id = productserviceline.id
WHERE
	productserviceline.name = 'Nucleon Hard & Soft Tissue'

-- Change Nucleon Non-Chloroform Mousetail Kit - Large/Small to delete Large/Small

UPDATE
	productservicename
SET
	name = 'Nucleon Non-Chloroform Mousetail Kit'
WHERE
	name = 'Nucleon Non-Chloroform Mousetail Kit - Large/Small'

-- Find any products that use Non-Chloroform Mousetail Kit - Small et Large and change it to our updated id above

UPDATE
	informationtype_productserviceline_to_productservicename
SET
	informationtype_productserviceline_to_productservicename.productservicename_id = (SELECT TOP 1 id FROM productservicename WHERE name = 'Nucleon Non-Chloroform Mousetail Kit')
FROM 
	informationtype_productserviceline_to_productservicename
INNER JOIN
	productservicename
ON
	productservicename.id = informationtype_productserviceline_to_productservicename.productservicename_id
WHERE
	productservicename.name = 'Non-Chloroform Mousetail Kit - Small & Large'	

-- Create a no-email version of the Wiesbaden contact // Gen-Probe Wiesbaden 

DECLARE @wiesbaden_id int

EXECUTE CreateAddress
	-- Contact Label
		NULL,
	-- Facility	
		'Gen-Probe Wiesbaden',		
	-- Person
		NULL,		
	-- Address 1
		NULL,
	-- Address 2
		NULL,
	-- Address 3		
		NULL,
	-- Phone 1
		'+49 6122 707 6451',		
	-- Phone 2
		NULL,
	-- Fax 1
		'+49 6122 707 6155',
	-- Fax 2
		NULL,
	-- Email
		NULL,
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
		@wiesbaden_id OUTPUT
	
-- Change Hard Tissue to Mouse Tail

---- (PSTYPE)

UPDATE
	informationtype_productservicetype_to_productservicename
SET
	informationtype_productservicetype_to_productservicename.productservicename_id = @mousetailId	
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
WHERE
	productservicename.name like '%Hard Tissue%'
	
---- (PSLINE)

UPDATE
	informationtype_productserviceline_to_productservicename
SET
	informationtype_productserviceline_to_productservicename.productservicename_id = @mousetailId
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
WHERE
	productservicename.name like '%Hard Tissue%'
	
-- Change BACC 1 / 2 / 3 to BACC 2 / 3

---- First clean up PSName entries, create our new PSName
	
DECLARE @baccId varchar(255)

SELECT @baccId = id FROM productservicename WHERE name = 'Nucleon BACC 2/ BACC 3'

IF ( @baccId IS NULL )
	BEGIN
	INSERT INTO productservicename (name) VALUES ('Nucleon BACC 2/ BACC 3')	
	SET @baccId = @@IDENTITY
	END
	
---- Change any PSName entries using a BACC PSName to the new one 

------ (PSTYPE)

UPDATE
	informationtype_productservicetype_to_productservicename
SET
	informationtype_productservicetype_to_productservicename.productservicename_id = @baccId
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
WHERE
	productservicename.name like '%bacc%'

------ (PSLINE)

UPDATE
	informationtype_productserviceline_to_productservicename
SET
	informationtype_productserviceline_to_productservicename.productservicename_id = @baccId
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
WHERE
	productservicename.name like '%bacc%'	

-- Delete PSLine Categories and contained products / locations

---- Delete location to contact info

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
	productserviceline.name IN ( 
		'Nucleon Automated DNA Kits',
		'Nucleon Plant Tissue'
		)
	
---- Delete psname to location info

DELETE
	informationtype_productserviceline_productservicename_to_location
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
WHERE
	productserviceline.name IN ( 
		'Nucleon Automated DNA Kits',
		'Nucleon Plant Tissue'
		)
		
---- Delete psline to psname

DELETE
	informationtype_productserviceline_to_productservicename
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
WHERE
	productserviceline.name IN ( 
		'Nucleon Automated DNA Kits',
		'Nucleon Plant Tissue'
		)

---- Delete infotype to psline info

DELETE
	informationtype_to_productserviceline
FROM 
	informationtype_to_productserviceline
INNER JOIN
	informationtype
ON
	informationtype.id = informationtype_to_productserviceline.informationtype_id
INNER JOIN
	productserviceline
ON 
	productserviceline.id = informationtype_to_productserviceline.productserviceline_id
WHERE
	productserviceline.name IN ( 
		'Nucleon Automated DNA Kits',
		'Nucleon Plant Tissue'
		)
		
-- Delete all PSLine products that aren't BACC or Mouse Tail

---- Delete location to contact info

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
	productservicename.name NOT IN (
		'Nucleon Mouse Tail',
		'Nucleon BACC 2/ BACC 3',
		'Nucleon Non-Chloroform Blood Kit',
		'Nucleon Non-Chloroform Mousetail Kit'
	)
	AND
	productservicename.name LIKE '%Nucleo%'
	
---- Delete psname to location info 
	
DELETE
	informationtype_productserviceline_productservicename_to_location
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
WHERE
	productservicename.name NOT IN (
		'Nucleon Mouse Tail',
		'Nucleon BACC 2/ BACC 3',
		'Nucleon Non-Chloroform Blood Kit',
		'Nucleon Non-Chloroform Mousetail Kit'
	)
	AND
	productservicename.name LIKE '%Nucleo%'

---- Delete psline to psname

DELETE
	informationtype_productserviceline_to_productservicename
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
WHERE
	productservicename.name NOT IN (
		'Nucleon Mouse Tail',
		'Nucleon BACC 2/ BACC 3',
		'Nucleon Non-Chloroform Blood Kit',
		'Nucleon Non-Chloroform Mousetail Kit'
	)
	AND
	productservicename.name LIKE '%Nucleo%'
	
-- Delete all PSType products that aren't BACC or Mouse Tail

---- Delete location to contact info

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
	productservicename.name NOT IN (
		'Nucleon Mouse Tail',
		'Nucleon BACC 2/ BACC 3',
		'Nucleon Non-Chloroform Blood Kit',
		'Nucleon Non-Chloroform Mousetail Kit'
	)
	AND
	productservicename.name LIKE '%Nucleo%'
	
---- Delete psname to location info 
	
DELETE
	informationtype_productservicetype_productservicename_to_location
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
WHERE
	productservicename.name NOT IN (
		'Nucleon Mouse Tail',
		'Nucleon BACC 2/ BACC 3',
		'Nucleon Non-Chloroform Blood Kit',
		'Nucleon Non-Chloroform Mousetail Kit'
	)
	AND
	productservicename.name LIKE '%Nucleo%'

---- Delete pstype to psname

DELETE
	informationtype_productservicetype_to_productservicename
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
WHERE
	productservicename.name NOT IN (
		'Nucleon Mouse Tail',
		'Nucleon BACC 2/ BACC 3',
		'Nucleon Non-Chloroform Blood Kit',
		'Nucleon Non-Chloroform Mousetail Kit'
	)
	AND
	productservicename.name LIKE '%Nucleo%'
	
-- Change UK facility to Wiesbaden 

---- (PSLINE)

------ Customer Service

UPDATE
	informationtype_productserviceline_productservicename_location_to_contact
SET
	informationtype_productserviceline_productservicename_location_to_contact.contact_id = 1578
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
	productservicename.name like '%Nucleo%'
	AND
	location.name IN (
		'UK',
		'Gen-Probe Life Sciences Ltd.  UK'
	)
	AND
	informationtype.name = 'Customer Service'

------ Technical Support

UPDATE
	informationtype_productserviceline_productservicename_location_to_contact
SET
	informationtype_productserviceline_productservicename_location_to_contact.contact_id = 1579
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
	productservicename.name like '%Nucleo%'
	AND
	location.name IN (
		'UK',
		'Gen-Probe Life Sciences Ltd.  UK'
	)
	AND
	informationtype.name = 'Technical Support'
	
------ Sales and Distrbution / Locations

UPDATE
	informationtype_productserviceline_productservicename_location_to_contact
SET
	informationtype_productserviceline_productservicename_location_to_contact.contact_id = @wiesbaden_id
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
	productservicename.name like '%Nucleon%'
	AND
	location.name IN (
		'UK',
		'Gen-Probe Life Sciences Ltd.  UK'
	)
	AND
	informationtype.name IN (
		'Sales and Distribution',
		'Locations'
		)

---- (PSTYPE)

------ Customer Service

UPDATE
	informationtype_productservicetype_productservicename_location_to_contact
SET
	informationtype_productservicetype_productservicename_location_to_contact.contact_id = 1578
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
	productservicename.name like '%Nucleo%'
	AND
	location.name IN (
		'UK',
		'Gen-Probe Life Sciences Ltd.  UK'
	)
	AND
	informationtype.name = 'Customer Service'

------ Technical Support

UPDATE
	informationtype_productservicetype_productservicename_location_to_contact
SET
	informationtype_productservicetype_productservicename_location_to_contact.contact_id = 1579
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
	productservicename.name like '%Nucleo%'
	AND
	location.name IN (
		'UK',
		'Gen-Probe Life Sciences Ltd.  UK'
	)
	AND
	informationtype.name = 'Technical Support'
	
------ Sales and Distrbution / Locations

UPDATE
	informationtype_productservicetype_productservicename_location_to_contact
SET
	informationtype_productservicetype_productservicename_location_to_contact.contact_id = @wiesbaden_id
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
	productservicename.name like '%Nucleo%'
	AND
	location.name IN (
		'UK',
		'Gen-Probe Life Sciences Ltd.  UK'
	)
	AND
	informationtype.name IN (
		'Sales and Distribution',
		'Locations'
		)


 