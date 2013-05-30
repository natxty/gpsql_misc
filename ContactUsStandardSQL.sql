-- Informationtype to Productservicetype

SELECT
	informationtype.name as itypename,
	informationtype.id as itypeid,
	productservicetype.name as ptypename,
	productservicetype.id as ptypeid,
	informationtype_to_productservicetype.id
FROM
	informationtype_to_productservicetype
INNER JOIN
	informationtype
ON
	informationtype.id = informationtype_to_productservicetype.informationtype_id
INNER JOIN
	productservicetype
ON
	productservicetype.id = informationtype_to_productservicetype.productservicetype_id

-- Informatiotype to Productserviceline

SELECT
	informationtype.name as itypename, informationtype.id as itypeid, productserviceline.name as plinename, productserviceline.id as plineid, informationtype_to_productserviceline.id
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


-- Informationtype Productservicetype to Productservicename


SELECT
	informationtype.name as itypename,
	informationtype.id as itypeid,
	productservicetype.name as ptypename,
	productservicetype.id as ptypeid,
	productservicename.name as psname,
	productservicename.id as psnameid,
	informationtype_productservicetype_to_productservicename.id
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
	productservicename.id > 116

-- Informationtype Productserviceline to Productservicename

SELECT
	informationtype.name as itypename,
	informationtype.id as itypeid,
	productserviceline.name as plinename,
	productserviceline.id as plineid,
	productservicename.name as psname,
	productservicename.id as psnameid,
	informationtype_productserviceline_to_productservicename.id
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
	productservicename.id > 116

-- Informationtype Productservicetype Productservicename to Location


SELECT
	informationtype.name as itypename,
	informationtype.id as itypeid,
	productservicetype.name as ptypename,
	productservicetype.id as ptypeid,
	productservicename.name as psname,
	productservicename.id as psnameid,
	location.name as locatname,
	location.id as locatid,
	informationtype_productservicetype_productservicename_to_location.id
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
	productservicename.id > 116


-- Informationtype productserviceline Productservicename to Location


SELECT
	informationtype.name as itypename,
	informationtype.id as itypeid,
	productserviceline.name as plinename,
	productserviceline.id as plineid,
	productservicename.name as psname,
	productservicename.id as psnameid,
	location.name as locatname,
	location.id as locatid,
	informationtype_productserviceline_productservicename_to_location.id
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
	productservicename.id > 116


-- Informationtype Productservicetype Productservicename Location to Contact



SELECT
	informationtype.name as itypename,
	informationtype.id as itypeid,
	productservicetype.name as ptypename,
	productservicetype.id as ptypeid,
	productservicename.name as psname,
	productservicename.id as psnameid,
	location.name as locatname,
	location.id as locatid,
	facility.name as facilityname,
	contact.id as contactid
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
	productservicetype.name = 'Transplant & Transfusion Medicine'
ORDER BY
	locatname


-- Informationtype Productserviceline Productservicename Location to Contact


SELECT
	informationtype.name as itypename,
	informationtype.id as itypeid,
	productserviceline.name as plinename,
	productserviceline.id as plineid,
	productservicename.name as psname,
	productservicename.id as psnameid,
	location.name as locatname,
	location.id as locatid,
	facility.name as facilityname,
	contact.id as contactid
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
	productserviceline.name = 'Transplant & Transfusion Medicine'
ORDER BY
	locatname

-- CONTACT INFO

SELECT
	contact.id as contactid,
	STUFF((SELECT ', ' + [name] FROM facility INNER JOIN contact_to_facility ON contact_to_facility.facility_id = facility.id WHERE (contact_to_facility.contact_id = contact.id) FOR XML PATH ('')),1,2,'') AS fulladdress,
	STUFF((SELECT ', ' + [address] FROM address INNER JOIN contact_to_address ON contact_to_address.address_id = address.id WHERE (contact_to_address.contact_id = contact.id) ORDER BY contact_to_address.item_order FOR XML PATH ('')),1,2,'') AS fulladdress,
	STUFF((SELECT ', ' + [number] FROM phone INNER JOIN contact_to_phone ON contact_to_phone.phone_id = phone.id WHERE (contact_to_phone.contact_id = contact.id) ORDER BY contact_to_phone.item_order FOR XML PATH ('')),1,2,'') AS fullphone,
	STUFF((SELECT ', ' + [number] FROM fax INNER JOIN contact_to_fax ON contact_to_fax.fax_id = fax.id WHERE (contact_to_fax.contact_id = contact.id) ORDER BY contact_to_fax.item_order FOR XML PATH ('')),1,2,'') AS fullfax,
	STUFF((SELECT ', ' + [email] FROM email INNER JOIN contact_to_email ON contact_to_email.email_id = email.id WHERE (contact_to_email.contact_id = contact.id) ORDER BY contact_to_email.item_order FOR XML PATH ('')),1,2,'') AS fullemail,
	STUFF((SELECT ', ' + [url] FROM website INNER JOIN contact_to_website ON contact_to_website.website_id = website.id WHERE (contact_to_website.contact_id = contact.id) ORDER BY contact_to_website.item_order FOR XML PATH ('')),1,2,'') AS fullwebsite,
	STUFF((SELECT ', ' + [name] FROM person INNER JOIN contact_to_person ON contact_to_person.person_id = person.id WHERE (contact_to_person.contact_id = contact.id) ORDER BY contact_to_person.item_order FOR XML PATH ('')),1,2,'') AS fullperson
FROM
	contact
INNER JOIN
	contact_to_facility
ON
	contact.id = contact_to_facility.contact_id
INNER JOIN
	facility
ON
	facility.id = contact_to_facility.facility_id
WHERE
	 facility.name like '%Gen-Probe%'
GROUP BY
	 contact.id



-- W/ address

SELECT
	contact.id as contactid,
	STUFF((SELECT ', ' + [name] FROM facility INNER JOIN contact_to_facility ON contact_to_facility.facility_id = facility.id WHERE (contact_to_facility.contact_id = contact.id) FOR XML PATH ('')),1,2,'') AS fulladdress,
	STUFF((SELECT ', ' + [address] FROM address INNER JOIN contact_to_address ON contact_to_address.address_id = address.id WHERE (contact_to_address.contact_id = contact.id) ORDER BY contact_to_address.item_order FOR XML PATH ('')),1,2,'') AS fulladdress,
	STUFF((SELECT ', ' + [number] FROM phone INNER JOIN contact_to_phone ON contact_to_phone.phone_id = phone.id WHERE (contact_to_phone.contact_id = contact.id) ORDER BY contact_to_phone.item_order FOR XML PATH ('')),1,2,'') AS fullphone,
	STUFF((SELECT ', ' + [number] FROM fax INNER JOIN contact_to_fax ON contact_to_fax.fax_id = fax.id WHERE (contact_to_fax.contact_id = contact.id) ORDER BY contact_to_fax.item_order FOR XML PATH ('')),1,2,'') AS fullfax,
	STUFF((SELECT ', ' + [email] FROM email INNER JOIN contact_to_email ON contact_to_email.email_id = email.id WHERE (contact_to_email.contact_id = contact.id) ORDER BY contact_to_email.item_order FOR XML PATH ('')),1,2,'') AS fullemail,
	STUFF((SELECT ', ' + [url] FROM website INNER JOIN contact_to_website ON contact_to_website.website_id = website.id WHERE (contact_to_website.contact_id = contact.id) ORDER BY contact_to_website.item_order FOR XML PATH ('')),1,2,'') AS fullwebsite,
	STUFF((SELECT ', ' + [name] FROM person INNER JOIN contact_to_person ON contact_to_person.person_id = person.id WHERE (contact_to_person.contact_id = contact.id) ORDER BY contact_to_person.item_order FOR XML PATH ('')),1,2,'') AS fullperson
FROM
	contact
INNER JOIN
	contact_to_address
ON
	contact.id = contact_to_address.contact_id
INNER JOIN
	address
ON
	address.id = contact_to_address.address_id
WHERE
	 address.address like '%UK%'
GROUP BY
	 contact.id

-- By ID

SELECT
	contact.id as contactid,
	STUFF((SELECT ', ' + [name] FROM facility INNER JOIN contact_to_facility ON contact_to_facility.facility_id = facility.id WHERE (contact_to_facility.contact_id = contact.id) FOR XML PATH ('')),1,2,'') AS fulladdress,
	STUFF((SELECT ', ' + [address] FROM address INNER JOIN contact_to_address ON contact_to_address.address_id = address.id WHERE (contact_to_address.contact_id = contact.id) ORDER BY contact_to_address.item_order FOR XML PATH ('')),1,2,'') AS fulladdress,
	STUFF((SELECT ', ' + [number] FROM phone INNER JOIN contact_to_phone ON contact_to_phone.phone_id = phone.id WHERE (contact_to_phone.contact_id = contact.id) ORDER BY contact_to_phone.item_order FOR XML PATH ('')),1,2,'') AS fullphone,
	STUFF((SELECT ', ' + [number] FROM fax INNER JOIN contact_to_fax ON contact_to_fax.fax_id = fax.id WHERE (contact_to_fax.contact_id = contact.id) ORDER BY contact_to_fax.item_order FOR XML PATH ('')),1,2,'') AS fullfax,
	STUFF((SELECT ', ' + [email] FROM email INNER JOIN contact_to_email ON contact_to_email.email_id = email.id WHERE (contact_to_email.contact_id = contact.id) ORDER BY contact_to_email.item_order FOR XML PATH ('')),1,2,'') AS fullemail,
	STUFF((SELECT ', ' + [url] FROM website INNER JOIN contact_to_website ON contact_to_website.website_id = website.id WHERE (contact_to_website.contact_id = contact.id) ORDER BY contact_to_website.item_order FOR XML PATH ('')),1,2,'') AS fullwebsite,
	STUFF((SELECT ', ' + [name] FROM person INNER JOIN contact_to_person ON contact_to_person.person_id = person.id WHERE (contact_to_person.contact_id = contact.id) ORDER BY contact_to_person.item_order FOR XML PATH ('')),1,2,'') AS fullperson
FROM
	contact
WHERE
	contact.id = '4155'
GROUP BY
	 contact.id


--

SELECT
	contact.id as contactid,
	(SELECT ', ' + [name] FROM facility INNER JOIN contact_to_facility ON contact_to_facility.facility_id = facility.id WHERE (contact_to_facility.contact_id = contact.id AND contact_to_facility.item_order = 1) FOR XML PATH ('')) AS locationname,
	(SELECT ', ' + [address] FROM address INNER JOIN contact_to_address ON contact_to_address.address_id = address.id WHERE (contact_to_address.contact_id = contact.id AND contact_to_address.item_order = 1) ORDER BY contact_to_address.item_order FOR XML PATH ('')) AS address1,
	(SELECT ', ' + [address] FROM address INNER JOIN contact_to_address ON contact_to_address.address_id = address.id WHERE (contact_to_address.contact_id = contact.id AND contact_to_address.item_order = 2) ORDER BY contact_to_address.item_order FOR XML PATH ('')) AS address2,
FROM
	contact
GROUP BY
	 contact.id

--

SELECT
	contact.id as contactid,
	STUFF((SELECT ', ' + [name] FROM facility INNER JOIN contact_to_facility ON contact_to_facility.facility_id = facility.id WHERE (contact_to_facility.contact_id = contact.id) FOR XML PATH ('')),1,2,'') AS fulladdress,
	STUFF((SELECT ', ' + [address] FROM address INNER JOIN contact_to_address ON contact_to_address.address_id = address.id WHERE (contact_to_address.contact_id = contact.id) ORDER BY contact_to_address.item_order FOR XML PATH ('')),1,2,'') AS fulladdress,
	STUFF((SELECT ', ' + [number] FROM phone INNER JOIN contact_to_phone ON contact_to_phone.phone_id = phone.id WHERE (contact_to_phone.contact_id = contact.id) ORDER BY contact_to_phone.item_order FOR XML PATH ('')),1,2,'') AS fullphone,
	STUFF((SELECT ', ' + [number] FROM fax INNER JOIN contact_to_fax ON contact_to_fax.fax_id = fax.id WHERE (contact_to_fax.contact_id = contact.id) ORDER BY contact_to_fax.item_order FOR XML PATH ('')),1,2,'') AS fullfax,
	STUFF((SELECT ', ' + [email] FROM email INNER JOIN contact_to_email ON contact_to_email.email_id = email.id WHERE (contact_to_email.contact_id = contact.id) ORDER BY contact_to_email.item_order FOR XML PATH ('')),1,2,'') AS fullemail,
	STUFF((SELECT ', ' + [url] FROM website INNER JOIN contact_to_website ON contact_to_website.website_id = website.id WHERE (contact_to_website.contact_id = contact.id) ORDER BY contact_to_website.item_order FOR XML PATH ('')),1,2,'') AS fullwebsite,
	STUFF((SELECT ', ' + [name] FROM person INNER JOIN contact_to_person ON contact_to_person.person_id = person.id WHERE (contact_to_person.contact_id = contact.id) ORDER BY contact_to_person.item_order FOR XML PATH ('')),1,2,'') AS fullperson
FROM
	contact
INNER JOIN
    contact_to_person
ON
    contact.id = contact_to_person.contact_id
INNER JOIN
    person
ON
    person.id = contact_to_person.person_id
WHERE
    person.name = 'Alex Cherniavsky'
GROUP BY
	 contact.id