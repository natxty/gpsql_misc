-- CZECH Edits

DECLARE @contact_id int

-- Address 1
EXECUTE CreateAddress
	-- Contact Label
		NULL,
	-- Facility	
		'Gen-Probe European Direct Sales',		
	-- Person
		'Lenka Fűssiová',		
	-- Address 1
		NULL,
	-- Address 2
		NULL,
	-- Address 3		
		NULL,
	-- Phone 1
		'+420 739 634 395',		
	-- Phone 2
		NULL,
	-- Fax 1
		NULL,
	-- Fax 2
		NULL,
	-- Email
		'lenka.fussiova@seznam.cz',
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
		
-- Change the case of the second email

UPDATE
	email
SET
	email.email = 'lenka.fussiova@gen-probe.com'
WHERE
	email.email = 'lenka.fussiova@gen-probe.com'


-- Manually Add our second email:

Declare @email_id int

INSERT INTO email
	(email)
VALUES
	('lenka.fussiova@gen-probe.com')

SET @email_id = @@IDENTITY

INSERT INTO contact_to_email
	(contact_id, email_id, item_order)
VALUES
	( 
	@contact_id,
	@email_id,
	2
	)
	
-- Swap out for PSTYPE

---- Update statement here...


UPDATE
	informationtype_productservicetype_productservicename_location_to_contact
SET
	informationtype_productservicetype_productservicename_location_to_contact.contact_id = @contact_id
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
	productservicetype.name IN
	(
		'Instrument Systems',
		'Microbial Infectious Diseases',
		'Respiratory Infectious Diseases',
		'Sexually Transmitted Diseases',
		'Virals'
	)	
	AND
	location.name = 'Czech Republic'

-- Swap out PSLINE


UPDATE
	informationtype_productserviceline_productservicename_location_to_contact
SET
	informationtype_productserviceline_productservicename_location_to_contact.contact_id = @contact_id
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
	productserviceline.name IN
	(
	
		'AMPLIFIED MTD'
		,'APTIMA Trichomonas vaginalis'
		,'APTIMA'
		,'APTIMA HCV Qualitative Kit'
		,'APTIMA HIV-1 RNA Qualitative Assay'
		,'Aptima'
		,'Aptima HPV'
		,'Bacterial Culture Identification'
		,'DTS'
		,'DTS Systems'
		,'Fungal Culture Identification'
		,'LEADER'
		,'LEADER Systems'
		,'Mycobacterial Culture Identification'
		,'PACE'
		,'Prodesse'
		,'Streptococcus - GASDirect'
		,'Streptococcus - Group B'
		,'TIGRIS'
		,'PANTHER System'
	)	
	AND
	location.name = 'Czech Republic'

           