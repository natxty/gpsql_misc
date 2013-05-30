DECLARE @pstypetbl Table (
	to_location_id int
)

DECLARE @pslinetbl Table (
	to_location_id int
)

-- Collect PsType to_location ids
INSERT INTO @pstypetbl 
	SELECT
		informationtype_productservicetype_productservicename_location_to_contact.informationtype_productservicetype_productservicename_location_id
	FROM
		contact
	INNER JOIN
		contact_to_facility
	ON
		contact_to_facility.contact_id = contact.id
	INNER JOIN
		facility
	ON
		contact_to_facility.facility_id = facility.id
	INNER JOIN
		informationtype_productservicetype_productservicename_location_to_contact
	ON
		informationtype_productservicetype_productservicename_location_to_contact.contact_id = contact.id
	WHERE
		facility.name IN
		(
			'Gen-Probe Technical Sales Representative (Canada - Manitoba, Saskatchewan)',
			'Gen-Probe Technical Sales Representative (Canada - Ontario)',
			'Gen-Probe Technical Sales Representative (Canada - Newfoundland, New Brunswick, Nova Scotia, Quebec)',
			'Gen-Probe Technical Sales Representative (Canada - Alberta, British Columbia)'
		)
	GROUP BY
		informationtype_productservicetype_productservicename_location_to_contact.informationtype_productservicetype_productservicename_location_id
		
-- Collect PsLine to_location ids
INSERT INTO @pslinetbl 
	SELECT
		informationtype_productservicetype_productservicename_location_to_contact.informationtype_productservicetype_productservicename_location_id
	FROM
		contact
	INNER JOIN
		contact_to_facility
	ON
		contact_to_facility.contact_id = contact.id
	INNER JOIN
		facility
	ON
		contact_to_facility.facility_id = facility.id
	INNER JOIN
		informationtype_productservicetype_productservicename_location_to_contact
	ON
		informationtype_productservicetype_productservicename_location_to_contact.contact_id = contact.id
	WHERE
		facility.name IN
		(
			'Gen-Probe Technical Sales Representative (Canada - Manitoba, Saskatchewan)',
			'Gen-Probe Technical Sales Representative (Canada - Ontario)',
			'Gen-Probe Technical Sales Representative (Canada - Newfoundland, New Brunswick, Nova Scotia, Quebec)',
			'Gen-Probe Technical Sales Representative (Canada - Alberta, British Columbia)'
		)
	GROUP BY
		informationtype_productservicetype_productservicename_location_to_contact.informationtype_productservicetype_productservicename_location_id		


-- Delete all uses of the current contacts in PSType
DELETE FROM informationtype_productservicetype_productservicename_location_to_contact WHERE id IN 
	(
	SELECT
		informationtype_productservicetype_productservicename_location_to_contact.id
	FROM
		contact
	INNER JOIN
		contact_to_facility
	ON
		contact_to_facility.contact_id = contact.id
	INNER JOIN
		facility
	ON
		contact_to_facility.facility_id = facility.id
	INNER JOIN
		informationtype_productservicetype_productservicename_location_to_contact
	ON
		informationtype_productservicetype_productservicename_location_to_contact.contact_id = contact.id
	WHERE
		facility.name IN
		(
			'Gen-Probe Technical Sales Representative (Canada - Manitoba, Saskatchewan)',
			'Gen-Probe Technical Sales Representative (Canada - Ontario)',
			'Gen-Probe Technical Sales Representative (Canada - Newfoundland, New Brunswick, Nova Scotia, Quebec)',
			'Gen-Probe Technical Sales Representative (Canada - Alberta, British Columbia)'
		)
	)

-- Delete all uses of the current contacts in PSLine
DELETE FROM informationtype_productserviceline_productservicename_location_to_contact WHERE id IN 
	(
	SELECT
		informationtype_productserviceline_productservicename_location_to_contact.id
	FROM
		contact
	INNER JOIN
		contact_to_facility
	ON
		contact_to_facility.contact_id = contact.id
	INNER JOIN
		facility
	ON
		contact_to_facility.facility_id = facility.id
	INNER JOIN
		informationtype_productserviceline_productservicename_location_to_contact
	ON
		informationtype_productserviceline_productservicename_location_to_contact.contact_id = contact.id
	WHERE
		facility.name IN
		(
			'Gen-Probe Technical Sales Representative (Canada - Manitoba, Saskatchewan)',
			'Gen-Probe Technical Sales Representative (Canada - Ontario)',
			'Gen-Probe Technical Sales Representative (Canada - Newfoundland, New Brunswick, Nova Scotia, Quebec)',
			'Gen-Probe Technical Sales Representative (Canada - Alberta, British Columbia)'
		)
	)

DECLARE @contact_id int

-- Address 1
EXECUTE CreateAddress
	-- Contact Label
		NULL,
	-- Facility	
		'Gen-Probe Technical Sales Representative (Canada – Alberta, British Columbia, Manitoba, Saskatchewan)',		
	-- Person
		'Alex Cherniavsky',		
	-- Address 1
		'10210 Genetic Center Drive',
	-- Address 2
		'San Diego, CA 92121',
	-- Address 3		
		NULL,
	-- Phone 1
		'1-800-523-5001 Ext. 5325',		
	-- Phone 2
		NULL,
	-- Fax 1
		NULL,
	-- Fax 2
		NULL,
	-- Email
		'alex.cherniavsky@gen-probe.com',
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
		
INSERT INTO informationtype_productservicetype_productservicename_location_to_contact
	(informationtype_productservicetype_productservicename_location_id, contact_id)
	SELECT
		to_location_id,
		@contact_id
	FROM
		@pstypetbl
		
INSERT INTO informationtype_productserviceline_productservicename_location_to_contact
	(informationtype_productserviceline_productservicename_location_id, contact_id)
	SELECT
		to_location_id,
		@contact_id
	FROM
		@pslinetbl

-- Address 2
EXECUTE CreateAddress
	-- Contact Label
		NULL,
	-- Facility	
		'Gen-Probe Technical Sales Representative (Canada - Newfoundland, New Brunswick, Nova Scotia, Ontario, Quebec)',		
	-- Person
		'Martin Daoust',		
	-- Address 1
		'10210 Genetic Center Drive',
	-- Address 2
		'San Diego, CA 92121',
	-- Address 3		
		NULL,
	-- Phone 1
		'1-800-523-5001 Ext. 5388',		
	-- Phone 2
		NULL,
	-- Fax 1
		NULL,
	-- Fax 2
		NULL,
	-- Email
		'martin.daoust@gen-probe.com',
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
		
INSERT INTO informationtype_productservicetype_productservicename_location_to_contact
	(informationtype_productservicetype_productservicename_location_id, contact_id)
	SELECT
		to_location_id,
		@contact_id
	FROM
		@pstypetbl
		
INSERT INTO informationtype_productserviceline_productservicename_location_to_contact
	(informationtype_productserviceline_productservicename_location_id, contact_id)
	SELECT
		to_location_id,
		@contact_id
	FROM
		@pslinetbl		
		
		
-- Delete Duplicates
DELETE FROM informationtype_productservicetype_productservicename_location_to_contact WHERE id IN 
(
	SELECT
		informationtype_productservicetype_productservicename_location_to_contact.id
	FROM
		contact
	INNER JOIN
		contact_to_facility
	ON
		contact_to_facility.contact_id = contact.id
	INNER JOIN
		facility
	ON
		contact_to_facility.facility_id = facility.id
	INNER JOIN
		informationtype_productservicetype_productservicename_location_to_contact
	ON
		informationtype_productservicetype_productservicename_location_to_contact.contact_id = contact.id
	WHERE
		facility.name IN
		(
			'Gen-Probe Technical Sales Representative (Canada – Alberta, British Columbia, Manitoba, Saskatchewan)'
		)
		AND
		informationtype_productservicetype_productservicename_location_to_contact.id NOT IN
		(
			SELECT
				min(informationtype_productservicetype_productservicename_location_to_contact.id)
			FROM
				contact
			INNER JOIN
				contact_to_facility
			ON
				contact_to_facility.contact_id = contact.id
			INNER JOIN
				facility
			ON
				contact_to_facility.facility_id = facility.id
			INNER JOIN
				informationtype_productservicetype_productservicename_location_to_contact
			ON
				informationtype_productservicetype_productservicename_location_to_contact.contact_id = contact.id
			WHERE
				facility.name IN
				(
					'Gen-Probe Technical Sales Representative (Canada – Alberta, British Columbia, Manitoba, Saskatchewan)'
				)
			GROUP BY
				informationtype_productservicetype_productservicename_location_to_contact.informationtype_productservicetype_productservicename_location_id
			HAVING 
				COUNT(*) > 1
		)
)

DELETE FROM informationtype_productserviceline_productservicename_location_to_contact WHERE id IN 
(
	SELECT
		informationtype_productserviceline_productservicename_location_to_contact.id
	FROM
		contact
	INNER JOIN
		contact_to_facility
	ON
		contact_to_facility.contact_id = contact.id
	INNER JOIN
		facility
	ON
		contact_to_facility.facility_id = facility.id
	INNER JOIN
		informationtype_productserviceline_productservicename_location_to_contact
	ON
		informationtype_productserviceline_productservicename_location_to_contact.contact_id = contact.id
	WHERE
		facility.name IN
		(
			'Gen-Probe Technical Sales Representative (Canada – Alberta, British Columbia, Manitoba, Saskatchewan)'
		)
		AND
		informationtype_productserviceline_productservicename_location_to_contact.id NOT IN
		(
			SELECT
				min(informationtype_productserviceline_productservicename_location_to_contact.id)
			FROM
				contact
			INNER JOIN
				contact_to_facility
			ON
				contact_to_facility.contact_id = contact.id
			INNER JOIN
				facility
			ON
				contact_to_facility.facility_id = facility.id
			INNER JOIN
				informationtype_productserviceline_productservicename_location_to_contact
			ON
				informationtype_productserviceline_productservicename_location_to_contact.contact_id = contact.id
			WHERE
				facility.name IN
				(
					'Gen-Probe Technical Sales Representative (Canada – Alberta, British Columbia, Manitoba, Saskatchewan)'
				)
			GROUP BY
				informationtype_productserviceline_productservicename_location_to_contact.informationtype_productserviceline_productservicename_location_id
			HAVING 
				COUNT(*) > 1
		)
)

DELETE FROM informationtype_productservicetype_productservicename_location_to_contact WHERE id IN 
(
	SELECT
		informationtype_productservicetype_productservicename_location_to_contact.id
	FROM
		contact
	INNER JOIN
		contact_to_facility
	ON
		contact_to_facility.contact_id = contact.id
	INNER JOIN
		facility
	ON
		contact_to_facility.facility_id = facility.id
	INNER JOIN
		informationtype_productservicetype_productservicename_location_to_contact
	ON
		informationtype_productservicetype_productservicename_location_to_contact.contact_id = contact.id
	WHERE
		facility.name IN
		(
			'Gen-Probe Technical Sales Representative (Canada - Newfoundland, New Brunswick, Nova Scotia, Ontario, Quebec)'
		)
		AND
		informationtype_productservicetype_productservicename_location_to_contact.id NOT IN
		(
			SELECT
				min(informationtype_productservicetype_productservicename_location_to_contact.id)
			FROM
				contact
			INNER JOIN
				contact_to_facility
			ON
				contact_to_facility.contact_id = contact.id
			INNER JOIN
				facility
			ON
				contact_to_facility.facility_id = facility.id
			INNER JOIN
				informationtype_productservicetype_productservicename_location_to_contact
			ON
				informationtype_productservicetype_productservicename_location_to_contact.contact_id = contact.id
			WHERE
				facility.name IN
				(
					'Gen-Probe Technical Sales Representative (Canada - Newfoundland, New Brunswick, Nova Scotia, Ontario, Quebec)'
				)
			GROUP BY
				informationtype_productservicetype_productservicename_location_to_contact.informationtype_productservicetype_productservicename_location_id
			HAVING 
				COUNT(*) > 1
		)
)

DELETE FROM informationtype_productserviceline_productservicename_location_to_contact WHERE id IN 
(
	SELECT
		informationtype_productserviceline_productservicename_location_to_contact.id
	FROM
		contact
	INNER JOIN
		contact_to_facility
	ON
		contact_to_facility.contact_id = contact.id
	INNER JOIN
		facility
	ON
		contact_to_facility.facility_id = facility.id
	INNER JOIN
		informationtype_productserviceline_productservicename_location_to_contact
	ON
		informationtype_productserviceline_productservicename_location_to_contact.contact_id = contact.id
	WHERE
		facility.name IN
		(
			'Gen-Probe Technical Sales Representative (Canada - Newfoundland, New Brunswick, Nova Scotia, Ontario, Quebec)'
		)
		AND
		informationtype_productserviceline_productservicename_location_to_contact.id NOT IN
		(
			SELECT
				min(informationtype_productserviceline_productservicename_location_to_contact.id)
			FROM
				contact
			INNER JOIN
				contact_to_facility
			ON
				contact_to_facility.contact_id = contact.id
			INNER JOIN
				facility
			ON
				contact_to_facility.facility_id = facility.id
			INNER JOIN
				informationtype_productserviceline_productservicename_location_to_contact
			ON
				informationtype_productserviceline_productservicename_location_to_contact.contact_id = contact.id
			WHERE
				facility.name IN
				(
					'Gen-Probe Technical Sales Representative (Canada - Newfoundland, New Brunswick, Nova Scotia, Ontario, Quebec)'
				)
			GROUP BY
				informationtype_productserviceline_productservicename_location_to_contact.informationtype_productserviceline_productservicename_location_id
			HAVING 
				COUNT(*) > 1
		)
)