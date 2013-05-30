
-- DELETE Cardiff
DELETE FROM informationtype_to_location
	WHERE
		location_id = 174
		AND
		informationtype_id = 4
				
DECLARE @contact_id int

EXECUTE CreateAddress
	-- Contact Label
		NULL,
	-- Facility	
		'Gen-Probe - Waukesha (LIFECODES & PRODESSE)',		
	-- Person
		Null,		
	-- Address 1
		'20925 Crossroads Circle',
	-- Address 2
		'Waukesha, WI 53186 USA',
	-- Address 3		
		NULL,
	-- Phone 1
		'(Toll Free) 800.233.1843',		
	-- Phone 2
		'+262.754.1000',
	-- Fax 1
		'+262.754.9831',
	-- Fax 2
		Null,
	-- Email
		'customerservice@gen-probe.com',
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

DELETE FROM informationtype_to_location
    WHERE 
        informationtype_id = 4
        AND
        location_id = 181
        
INSERT INTO informationtype_to_location (location_id, contact_id, informationtype_id) VALUES (181, @contact_id, 4)