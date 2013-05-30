-- Create new address

DECLARE @contact_id int

EXECUTE CreateAddress
	-- Contact Label
		NULL,
	-- Facility	
		'Beijing Biolead Biology Sci & Tech Co. Ltd',		
	-- Person
		NULL,		
	-- Address 1
		'South Room, 9B Yangming Plaza',
	-- Address 2
		'No. 10, Xiaoying Road',
	-- Address 3		
		'Chaoyang, Beijing, China, PC 100101',
	-- Phone 1
		'86 10 51653916 / 84650405 / 84640949',		
	-- Phone 2
		NULL,
	-- Fax 1
		'89 10 84650405',
	-- Fax 2
		NULL,
	-- Email
		'biolead@hotmail.com',
	-- Website
		'http://www.biolead.com.cn',	
			
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
		

-- Select * Products from S&D / Immunology

DECLARE @tbl Table (
	productservicename varchar(255),
	pstype_to_contact_id int,
	psline_to_contact_id int
)

INSERT INTO @tbl
SELECT
	productservicename.name,
	informationtype_productservicetype_productservicename_location_to_contact.id,
	null
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
	productservicetype.name = 'Immunology Products'
	AND
	location.name = 'China'
	AND
	contact.id = 102

UPDATE 
	@tbl
SET
	psline_to_contact_id = informationtype_productserviceline_productservicename_location_to_contact.id	
FROM
	@tbl as t
INNER JOIN
	productservicename
ON
	t.productservicename = productservicename.name
INNER JOIN
	informationtype_productserviceline_to_productservicename
ON
	productservicename.id = informationtype_productserviceline_to_productservicename.productservicename_id	
INNER JOIN
	informationtype_productserviceline_productservicename_to_location
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
	location.name = 'China'
	AND
	contact.id = 102

-- Update our PSTYPE contacts

UPDATE 
	informationtype_productservicetype_productservicename_location_to_contact
SET
	informationtype_productservicetype_productservicename_location_to_contact.contact_id = @contact_id
FROM
	@tbl as t
INNER JOIN
	informationtype_productservicetype_productservicename_location_to_contact
ON
	informationtype_productservicetype_productservicename_location_to_contact.id = t.pstype_to_contact_id
	
-- Update our PSLINE contacts

UPDATE 
	informationtype_productserviceline_productservicename_location_to_contact
SET
	informationtype_productserviceline_productservicename_location_to_contact.contact_id = @contact_id
FROM
	@tbl as t
INNER JOIN
	informationtype_productserviceline_productservicename_location_to_contact
ON
	informationtype_productserviceline_productservicename_location_to_contact.id = t.psline_to_contact_id
	

