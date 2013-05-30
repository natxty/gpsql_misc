-- Remove UK Sales & Orders from Diaclone Products

---- (PSTYPE)

DECLARE @tbl Table (
	to_location_id int,
	to_contact_id int
)

INSERT INTO @tbl
SELECT 
	informationtype_productservicetype_productservicename_to_location.id,
	informationtype_productservicetype_productservicename_location_to_contact.id
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
	informationtype.name IN ( 'Customer Service', 'Technical Support' )
	AND
	productservicetype.name = 'Immunology Products'
	AND
	productservicename.name IN
	(
		'Diaclone DIAplex',
		'Diaclone ELISA',
		'Diaclone ELISpot',
		'Diaclone Monoclonal Antibodies',
		'Diaclone mAB'
	)
	AND
	location.name = 'UK Sales & Orders'

DELETE 
	informationtype_productservicetype_productservicename_location_to_contact
FROM
	@tbl as t
INNER JOIN
	informationtype_productservicetype_productservicename_location_to_contact
ON
	informationtype_productservicetype_productservicename_location_to_contact.id = t.to_contact_id
	
DELETE 
	informationtype_productservicetype_productservicename_to_location
FROM
	@tbl as t
INNER JOIN
	informationtype_productservicetype_productservicename_to_location
ON
	informationtype_productservicetype_productservicename_to_location.id = t.to_location_id
	
------ Do this again to catch orphans

	
	
	
---- (PSLINE)

DELETE FROM @tbl

INSERT INTO @tbl
SELECT 
	informationtype_productserviceline_productservicename_to_location.id,
	informationtype_productserviceline_productservicename_location_to_contact.id
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
	informationtype.name IN ( 'Customer Service', 'Technical Support' )
	AND
	productserviceline.name = 'Diaclone'
	AND
	productservicename.name IN
	(
		'Diaclone DIAplex',
		'Diaclone ELISA',
		'Diaclone ELISpot',
		'Diaclone Monoclonal Antibodies',
		'Diaclone mAB'
	)
	AND
	location.name = 'UK Sales & Orders'

DELETE 
	informationtype_productserviceline_productservicename_location_to_contact
FROM
	@tbl as t
INNER JOIN
	informationtype_productserviceline_productservicename_location_to_contact
ON
	informationtype_productserviceline_productservicename_location_to_contact.id = t.to_contact_id
	
DELETE 
	informationtype_productserviceline_productservicename_to_location
FROM
	@tbl as t
INNER JOIN
	informationtype_productserviceline_productservicename_to_location
ON
	informationtype_productserviceline_productservicename_to_location.id = t.to_location_id
	
-- Misc Other changes (all for Sales & Distribution)

---- Belgium and Netherlands: change contact name to Patrick Bier

DECLARE @patrickBier int
INSERT INTO person (name) VALUES ('Patrick Bier')
SET @patrickBier = @@IDENTITY

UPDATE
	contact_to_person
SET
	person_id = @patrickBier
WHERE
	contact_id in (99, 128)
	
---- Remove listings

------ (PSTYPE)

DELETE FROM @tbl

INSERT INTO @tbl
SELECT 
	informationtype_productservicetype_productservicename_to_location.id,
	informationtype_productservicetype_productservicename_location_to_contact.id
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
	productservicename.name IN
	(
		'Diaclone DIAplex',
		'Diaclone ELISA',
		'Diaclone ELISpot',
		'Diaclone Monoclonal Antibodies',
		'Diaclone mAB'
	)
	AND
	location.name IN 
	(
		'Czech Republic',
		'Egypt',
		'Iran',
		'Switzerland',
		'Syria',
		'Ukraine'
	)

DELETE 
	informationtype_productservicetype_productservicename_location_to_contact
FROM
	@tbl as t
INNER JOIN
	informationtype_productservicetype_productservicename_location_to_contact
ON
	informationtype_productservicetype_productservicename_location_to_contact.id = t.to_contact_id
	
DELETE 
	informationtype_productservicetype_productservicename_to_location
FROM
	@tbl as t
INNER JOIN
	informationtype_productservicetype_productservicename_to_location
ON
	informationtype_productservicetype_productservicename_to_location.id = t.to_location_id
	
-------- Redo this to catch any that didn't have contacts (orphans)

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
	informationtype.name = 'Sales and Distribution'
	AND
	productservicetype.name = 'Immunology Products'
	AND
	productservicename.name IN
	(
		'Diaclone DIAplex',
		'Diaclone ELISA',
		'Diaclone ELISpot',
		'Diaclone Monoclonal Antibodies',
		'Diaclone mAB'
	)
	AND
	location.name IN 
	(
		'Czech Republic',
		'Egypt',
		'Iran',
		'Switzerland',
		'Syria',
		'Ukraine'
	)
	
------ (PSLINE)

DELETE FROM @tbl

INSERT INTO @tbl
SELECT 
	informationtype_productserviceline_productservicename_to_location.id,
	informationtype_productserviceline_productservicename_location_to_contact.id
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
	productserviceline.name = 'Diaclone'
	AND
	productservicename.name IN
	(
		'Diaclone DIAplex',
		'Diaclone ELISA',
		'Diaclone ELISpot',
		'Diaclone Monoclonal Antibodies',
		'Diaclone mAB'
	)
	AND
	location.name IN 
	(
		'Czech Republic',
		'Egypt',
		'Iran',
		'Switzerland',
		'Syria',
		'Ukraine'
	)

DELETE 
	informationtype_productserviceline_productservicename_location_to_contact
FROM
	@tbl as t
INNER JOIN
	informationtype_productserviceline_productservicename_location_to_contact
ON
	informationtype_productserviceline_productservicename_location_to_contact.id = t.to_contact_id
	
DELETE 
	informationtype_productserviceline_productservicename_to_location
FROM
	@tbl as t
INNER JOIN
	informationtype_productserviceline_productservicename_to_location
ON
	informationtype_productserviceline_productservicename_to_location.id = t.to_location_id
	
---- Replace Contacts in Germany with HÖLZEL DIAGNOSTIKA Handels GmbH (id = 1634)

------ (PSTYPE)

DELETE FROM @tbl

INSERT INTO @tbl
SELECT
	informationtype_productservicetype_productservicename_to_location.id,
	informationtype_productservicetype_productservicename_location_to_contact.id
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
	productservicename.name IN
	(
		'Diaclone DIAplex',
		'Diaclone ELISA',
		'Diaclone ELISpot',
		'Diaclone Monoclonal Antibodies',
		'Diaclone mAB'
	)
	AND
	location.name IN 
	(
		'Germany'
	)
	
DELETE 
	informationtype_productservicetype_productservicename_location_to_contact
FROM
	@tbl as t
INNER JOIN
	informationtype_productservicetype_productservicename_location_to_contact
ON
	informationtype_productservicetype_productservicename_location_to_contact.id = t.to_contact_id
	
INSERT INTO informationtype_productservicetype_productservicename_location_to_contact (informationtype_productservicetype_productservicename_location_id, contact_id)
SELECT
	t.to_location_id,
	1634
FROM
	(
	SELECT 
		MIN(informationtype_productservicetype_productservicename_to_location.id) as to_location_id
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
		productservicetype.name = 'Immunology Products'
		AND
		productservicename.name IN
		(
			'Diaclone DIAplex',
			'Diaclone ELISA',
			'Diaclone ELISpot',
			'Diaclone Monoclonal Antibodies',
			'Diaclone mAB'
		)
		AND	
		location.name = 'Germany'
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
	) as t

------ (PSLINE)

DELETE FROM @tbl

INSERT INTO @tbl
SELECT
	informationtype_productserviceline_productservicename_to_location.id,
	informationtype_productserviceline_productservicename_location_to_contact.id
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
	productserviceline.name = 'Diaclone'
	AND
	productservicename.name IN
	(
		'Diaclone DIAplex',
		'Diaclone ELISA',
		'Diaclone ELISpot',
		'Diaclone Monoclonal Antibodies',
		'Diaclone mAB'
	)
	AND
	location.name IN 
	(
		'Germany'
	)
	
DELETE 
	informationtype_productserviceline_productservicename_location_to_contact
FROM
	@tbl as t
INNER JOIN
	informationtype_productserviceline_productservicename_location_to_contact
ON
	informationtype_productserviceline_productservicename_location_to_contact.id = t.to_contact_id
	
INSERT INTO informationtype_productserviceline_productservicename_location_to_contact (informationtype_productserviceline_productservicename_location_id, contact_id)
SELECT
	t.to_location_id,
	1634
FROM
	(
	SELECT 
		MIN(informationtype_productserviceline_productservicename_to_location.id) as to_location_id
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
		productserviceline.name = 'Diaclone'
		AND
		productservicename.name IN
		(
			'Diaclone DIAplex',
			'Diaclone ELISA',
			'Diaclone ELISpot',
			'Diaclone Monoclonal Antibodies',
			'Diaclone mAB'
		)
		AND	
		location.name = 'Germany'
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
	) as t
 
	
---- Change GENETIMES TECHNOLOGY INC info

DECLARE @SusanShu int
INSERT INTO person (name) VALUES ('Susan Shu')
SET @SusanShu = @@IDENTITY

DECLARE @SusanEmail int
INSERT INTO email (email) VALUES ('shushougui@genetimes.com.cn')
SET @SusanEmail = @@IDENTITY

UPDATE
	contact_to_person
SET
	person_id = @SusanShu
WHERE
	contact_id in (103, 115)
	
UPDATE
	contact_to_email
SET
	email_id = @SusanEmail
WHERE
	contact_id in (103, 115)
	
---- Israel: Change contact name and email address to Zuri Levin and Zuri@enco.co.il

DECLARE @ZuriLevin int
INSERT INTO person (name) VALUES ('Zuri Levin')
SET @ZuriLevin = @@IDENTITY

DECLARE @ZuriEmail int
INSERT INTO email (email) VALUES ('Zuri@enco.co.il')
SET @ZuriEmail = @@IDENTITY

UPDATE
	contact_to_person
SET
	person_id = @ZuriLevin
WHERE
	contact_id in (120)
	
UPDATE
	contact_to_email
SET
	email_id = @ZuriEmail
WHERE
	contact_id in (120)
	
---- Japan, change address

DECLARE @contact_id int

EXECUTE CreateAddress
	-- Contact Label
		NULL,
	-- Facility	
		'COSMO BIO CO., LTD',		
	-- Person
		'Tomoko Mimura',		
	-- Address 1
		NULL,
	-- Address 2
		NULL,
	-- Address 3		
		NULL,
	-- Phone 1
		'+81-3-5632-9610',		
	-- Phone 2
		NULL,
	-- Fax 1
		'+81-3-5632-9619',
	-- Fax 2
		NULL,
	-- Email
		'mail@cosmobio.co.jp',
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
		
-------- For some reason this doesn't insert the fax or email...

EXECUTE CreateAddress
	-- Contact Label
		NULL,
	-- Facility	
		NULL,		
	-- Person
		NULL,		
	-- Address 1
		NULL,
	-- Address 2
		NULL,
	-- Address 3		
		NULL,
	-- Phone 1
		NULL,		
	-- Phone 2
		NULL,
	-- Fax 1
		'+81-3-5632-9619',
	-- Fax 2
		NULL,
	-- Email
		'mail@cosmobio.co.jp',
	-- Website
		NULL,	
	-- Contact Id
		@contact_id,
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
		
------ (PSTYPE)

INSERT INTO 
	informationtype_productservicetype_productservicename_location_to_contact (informationtype_productservicetype_productservicename_location_id, contact_id)
SELECT
	informationtype_productservicetype_productservicename_to_location.id,
	@contact_id
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
	productservicename.name IN
	(
		'Diaclone DIAplex',
		'Diaclone ELISA',
		'Diaclone ELISpot',
		'Diaclone Monoclonal Antibodies',
		'Diaclone mAB'
	)
	AND
	location.name IN 
	(
		'Japan'
	)	

------ (PSLINE)

INSERT INTO 
	informationtype_productserviceline_productservicename_location_to_contact (informationtype_productserviceline_productservicename_location_id, contact_id)
SELECT
	informationtype_productserviceline_productservicename_to_location.id,
	@contact_id
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
	productserviceline.name = 'Diaclone'
	AND
	productservicename.name IN
	(
		'Diaclone DIAplex',
		'Diaclone ELISA',
		'Diaclone ELISpot',
		'Diaclone Monoclonal Antibodies',
		'Diaclone mAB'
	)
	AND
	location.name IN 
	(
		'Japan'
	)	

---- UK sales and Orders: change this to United Kingdom (id = 185) ie no need for 'sales and orders'

------ (PSTYPE)

UPDATE	
	informationtype_productservicetype_productservicename_to_location
SET
	informationtype_productservicetype_productservicename_to_location.location_id = 185
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
	productservicename.name IN
	(
		'Diaclone DIAplex',
		'Diaclone ELISA',
		'Diaclone ELISpot',
		'Diaclone Monoclonal Antibodies',
		'Diaclone mAB'
	)
	AND
	location.name IN 
	(
		'UK Sales & Orders'
	)
	
-------- Remove orphan from Diaclone Diaplex 


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
	informationtype.name IN ( 'Sales and Distribution' )
	AND
	productservicetype.name = 'Immunology Products'
	AND
	productservicename.name IN
	(
		'Diaclone DIAplex'
	)
	AND
	location.name = 'UK Sales & Orders'	
	
------ (PSLINE)

UPDATE	
	informationtype_productserviceline_productservicename_to_location
SET
	informationtype_productserviceline_productservicename_to_location.location_id = 185
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
	productserviceline.name = 'Diaclone'
	AND
	productservicename.name IN
	(
		'Diaclone DIAplex',
		'Diaclone ELISA',
		'Diaclone ELISpot',
		'Diaclone Monoclonal Antibodies',
		'Diaclone mAB'
	)
	AND
	location.name IN 
	(
		'UK Sales & Orders'
	)
	
---- Add All Countries 

EXECUTE CreateAddress
	-- Contact Label
		NULL,
	-- Facility	
		'Gen-Probe Diaclone SAS',		
	-- Person
		'Pascale Brancher',		
	-- Address 1
		'1 Bd A Fleming, BP 1985',
	-- Address 2
		'F-25020 Besancon Cedex, France',
	-- Address 3		
		NULL,
	-- Phone 1
		'+33 3 81 41 38 38',		
	-- Phone 2
		NULL,
	-- Fax 1
		'+33 3 81 41 36 36',
	-- Fax 2
		NULL,
	-- Email
		'diaclone@gen-probe.com',
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

------ (PSTYPE)

DECLARE @SQL Varchar(max)
SET @SQL = ''

SELECT 
	@SQL = @SQL 
		+ 'EXECUTE ContactPath ''Sales and Distribution'', ''' 
		+ productservicetype.name 
		+ ''', NULL, ''' 
		+ productservicename.name + ''', ''' 
		+ 'All other Countries'', ' 			
		+ ' NULL, NULL, NULL, NULL, NULL, NULL, ' + CAST(@contact_id AS varchar(255)) + ', 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1; '
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
	informationtype.name = 'Sales and Distribution'
	AND
	productservicetype.name = 'Immunology Products'
	AND
	productservicename.name IN
	(
		'Diaclone DIAplex',
		'Diaclone ELISA',
		'Diaclone ELISpot',
		'Diaclone Monoclonal Antibodies',
		'Diaclone mAB'
	)
	
EXEC (@SQL)

------ (PSLINE)

SET @SQL = ''

SELECT 
	@SQL = @SQL 
		+ 'EXECUTE ContactPath ''Sales and Distribution'', NULL, ''' 
		+ productserviceline.name 
		+ ''', ''' 
		+ productservicename.name + ''', ''' 
		+ 'All other Countries'', ' 			
		+ ' NULL, NULL, NULL, NULL, NULL, NULL, ' + CAST(@contact_id AS varchar(255)) + ', 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1; '
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
	informationtype.name = 'Sales and Distribution'
	AND
	productserviceline.name = 'Diaclone'
	AND
	productservicename.name IN
	(
		'Diaclone DIAplex',
		'Diaclone ELISA',
		'Diaclone ELISpot',
		'Diaclone Monoclonal Antibodies',
		'Diaclone mAB'
	)
	
EXEC (@SQL)

---- Italy: Remove Inalco details (id=121)

------ (PSTYPE)

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
	productservicetype.name = 'Immunology Products'
	AND
	productservicename.name IN
	(
		'Diaclone DIAplex',
		'Diaclone ELISA',
		'Diaclone ELISpot',
		'Diaclone Monoclonal Antibodies',
		'Diaclone mAB'
	)
	AND
	location.name IN 
	(
		'Italy'
	)
	AND
	contact.id = 121
	
------ (PSLINE)

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
	informationtype.name = 'Sales and Distribution'
	AND
	productserviceline.name = 'Diaclone'
	AND
	productservicename.name IN
	(
		'Diaclone DIAplex',
		'Diaclone ELISA',
		'Diaclone ELISpot',
		'Diaclone Monoclonal Antibodies',
		'Diaclone mAB'
	)
	AND
	location.name IN 
	(
		'Italy'
	)
	AND
	contact.id = 121
	
---- Delete Canada GP Corporate Contacts

------ (PSTYPE)

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
	productservicetype.name = 'Immunology Products'
	AND
	productservicename.name IN
	(
		'Diaclone DIAplex',
		'Diaclone ELISA',
		'Diaclone ELISpot',
		'Diaclone Monoclonal Antibodies',
		'Diaclone mAB'
	)
	AND
	location.name IN 
	(
		'Canada'
	)
	AND
	contact.id IN (
		1679,
		1680
	) 
	
------ (PSLINE)

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
	informationtype.name = 'Sales and Distribution'
	AND
	productserviceline.name = 'Diaclone'
	AND
	productservicename.name IN
	(
		'Diaclone DIAplex',
		'Diaclone ELISA',
		'Diaclone ELISpot',
		'Diaclone Monoclonal Antibodies',
		'Diaclone mAB'
	)
	AND
	location.name IN 
	(
		'Canada'
	)
	AND
	contact.id IN (
		1679,
		1680
	)

