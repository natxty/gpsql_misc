-- Delete all uses of the new contacts in PSType

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
			'Gen-Probe Technical Sales Representative (Canada – Alberta, British Columbia, Manitoba, Saskatchewan)',
			'Gen-Probe Technical Sales Representative (Canada - Newfoundland, New Brunswick, Nova Scotia, Ontario, Quebec)'
		)
	)

DECLARE @pslinetbl Table (
	to_location_id int
)

INSERT INTO @pslinetbl
SELECT 
	MIN(informationtype_productserviceline_productservicename_to_location.id)
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
	informationtype.name = 'Sales and Distribution'
	AND
	-- Find Canada locations in S&D PSLine
	location.name = 'Canada'
	AND
	-- Find any that don't have contacts	
		(
			SELECT
				TOP 1 informationtype_productserviceline_productservicename_location_to_contact.id
			FROM
				informationtype_productserviceline_productservicename_location_to_contact				
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
				informationtype_productserviceline_productservicename_location_to_contact.informationtype_productserviceline_productservicename_location_id = informationtype_productserviceline_productservicename_to_location.id
			) IS NULL
GROUP BY
	productservicename.name, location.name

INSERT INTO informationtype_productserviceline_productservicename_location_to_contact
	(informationtype_productserviceline_productservicename_location_id, contact_id)
	SELECT
		t.to_location_id,
		c.contact_id
	FROM
		@pslinetbl as t
	CROSS JOIN
		(SELECT 1679 as contact_id UNION ALL SELECT 1680) c

-- Find all Canada Locations missing contacts in PSType and add the correct Canada contacts (PSType Fix)

DECLARE @pstypetbl Table (
	to_location_id int
)

INSERT INTO @pstypetbl
SELECT 
	MIN(informationtype_productservicetype_productservicename_to_location.id)
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
	informationtype.name = 'Sales and Distribution'
	AND
	-- Find Canada locations in S&D PSLine
	location.name = 'Canada'
	AND
	-- Find any that don't have contacts	
		(
			SELECT
				TOP 1 informationtype_productservicetype_productservicename_location_to_contact.id
			FROM
				informationtype_productservicetype_productservicename_location_to_contact				
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
				informationtype_productservicetype_productservicename_location_to_contact.informationtype_productservicetype_productservicename_location_id = informationtype_productservicetype_productservicename_to_location.id
			) IS NULL
GROUP BY
	productservicename.name, location.name

INSERT INTO informationtype_productservicetype_productservicename_location_to_contact
	(informationtype_productservicetype_productservicename_location_id, contact_id)
	SELECT
		t.to_location_id,
		c.contact_id
	FROM
		@pstypetbl as t
	CROSS JOIN
		(SELECT 1679 as contact_id UNION ALL SELECT 1680) c
		