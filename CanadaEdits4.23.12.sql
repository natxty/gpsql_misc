DECLARE @contact_id int

-- Get our contact id for this location
SELECT
	@contact_id = contact.id
FROM
	contact
INNER JOIN
	contact_to_facility
ON
	contact_to_facility.contact_id = contact.id
INNER JOIN
	facility
ON
	facility.id = contact_to_facility.facility_id
INNER JOIN
	contact_to_person
ON
	contact_to_person.contact_id = contact.id
INNER JOIN
	person
ON
	contact_to_person.person_id = person.id
WHERE
	facility.name = 'Gen-Probe Technical Sales Representative (Canada - Manitoba, Saskatchewan)'
	AND
	person.name = 'Mark Stevens'

-- Update Person, Email and Phone for that contact
UPDATE contact_to_person SET person_id = (SELECT TOP 1 person.id FROM person WHERE name = 'Alex Cherniavsky') WHERE contact_id = @contact_id

UPDATE contact_to_email SET email_id = (SELECT TOP 1 email.id FROM email WHERE email = 'alex.cherniavsky@gen-probe.com') WHERE contact_id = @contact_id

IF ( (SELECT TOP 1 phone.id FROM phone WHERE number = '1-800-523-5001 Ext. 5325') IS NULL )
	BEGIN
	INSERT INTO phone (number) VALUES ('1-800-523-5001 Ext. 5325')
	END

UPDATE contact_to_phone SET phone_id = (SELECT TOP 1 phone.id FROM phone WHERE number = '1-800-523-5001 Ext. 5325') WHERE contact_id = @contact_id

-- Update Martin Doaust to Martin Daoust
UPDATE person SET name = 'Martin Daoust' WHERE name = 'Martin Doaust'

-- Update martin.doaust@gen-probe.com to martin.daoust@gen-probe.com
UPDATE email SET email = 'martin.daoust@gen-probe.com' WHERE email = 'martin.doaust@gen-probe.com'
	