DECLARE @ukc_dm_id int

EXECUTE CreateAddress
	-- Contact Label
		NULL,
	-- Facility
		'UK Central',
	-- Person
		'Diane Mennim',
	-- Address 1
		Null,
	-- Address 2
		Null,
	-- Address 3
		Null,
	-- Phone 1
		'+44 (0)7979 770766',
	-- Phone 2
		Null,
	-- Fax 1
		Null,
	-- Fax 2
		Null,
	-- Email
		'Diane.Mennim@hologic.com',
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
		@ukc_dm_id OUTPUT

SELECT @ukc_dm_id -- 1694

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

-- Fix the email Address

DECLARE @contact_id int

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
		'Diane.Mennim@hologic.com',
	-- Website
		NULL,
	-- Contact Id
		1694,
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