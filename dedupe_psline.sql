DECLARE @tbl Table (
	informationtype_productserviceline_productservicename_location_id int, 
	contact_id int,
	fullfacility varchar(255),
	fulladdress varchar(255), 
	fullphone varchar(255),
	fullfax varchar(255),
	fullemail varchar(255),
	fullwebsite varchar(255),
	fullperson varchar(255)
)

INSERT INTO @tbl (informationtype_productserviceline_productservicename_location_id, contact_id, fullfacility, fulladdress, fullphone, fullfax, fullemail, fullwebsite, fullperson)
SELECT 
	informationtype_productserviceline_productservicename_location_to_contact.informationtype_productserviceline_productservicename_location_id as informationtype_productserviceline_productservicename_location_id,
	contact.id as contact_id,
	STUFF((SELECT ', ' + [name] FROM facility INNER JOIN contact_to_facility ON contact_to_facility.facility_id = facility.id WHERE (contact_to_facility.contact_id = contact.id) FOR XML PATH ('')),1,2,'') AS fullfacility,	
	STUFF((SELECT ', ' + [address] FROM address INNER JOIN contact_to_address ON contact_to_address.address_id = address.id WHERE (contact_to_address.contact_id = contact.id) ORDER BY contact_to_address.item_order FOR XML PATH ('')),1,2,'') AS fulladdress,
	STUFF((SELECT ', ' + [number] FROM phone INNER JOIN contact_to_phone ON contact_to_phone.phone_id = phone.id WHERE (contact_to_phone.contact_id = contact.id) ORDER BY contact_to_phone.item_order FOR XML PATH ('')),1,2,'') AS fullphone,
	STUFF((SELECT ', ' + [number] FROM fax INNER JOIN contact_to_fax ON contact_to_fax.fax_id = fax.id WHERE (contact_to_fax.contact_id = contact.id) ORDER BY contact_to_fax.item_order FOR XML PATH ('')),1,2,'') AS fullfax,
	STUFF((SELECT ', ' + [email] FROM email INNER JOIN contact_to_email ON contact_to_email.email_id = email.id WHERE (contact_to_email.contact_id = contact.id) ORDER BY contact_to_email.item_order FOR XML PATH ('')),1,2,'') AS fullemail,
	STUFF((SELECT ', ' + [url] FROM website INNER JOIN contact_to_website ON contact_to_website.website_id = website.id WHERE (contact_to_website.contact_id = contact.id) ORDER BY contact_to_website.item_order FOR XML PATH ('')),1,2,'') AS fullwebsite,
	STUFF((SELECT ', ' + [name] FROM person INNER JOIN contact_to_person ON contact_to_person.person_id = person.id WHERE (contact_to_person.contact_id = contact.id) ORDER BY contact_to_person.item_order FOR XML PATH ('')),1,2,'') AS fullperson
FROM
	contact
INNER JOIN
	informationtype_productserviceline_productservicename_location_to_contact
ON
	informationtype_productserviceline_productservicename_location_to_contact.contact_id = contact.id
WHERE
	 informationtype_productserviceline_productservicename_location_to_contact.informationtype_productserviceline_productservicename_location_id in 
	(
		SELECT 
			 informationtype_productserviceline_productservicename_location_id
		FROM 
			informationtype_productserviceline_productservicename_location_to_contact
		WHERE 
			label is Null
		GROUP BY
			informationtype_productserviceline_productservicename_location_id
		HAVING COUNT(*) > 1
	)
GROUP BY
	 contact.id, informationtype_productserviceline_productservicename_location_to_contact.informationtype_productserviceline_productservicename_location_id
ORDER BY
	informationtype_productserviceline_productservicename_location_to_contact.informationtype_productserviceline_productservicename_location_id
	

DECLARE @tbl2 Table (
	informationtype_productserviceline_productservicename_location_contact_id int,
	contact_id int,
	informationtype_productserviceline_productservicename_location_id int,
	itypename varchar(255), 
	itypeid int, 
	plinename varchar(255), 
	plineid int, 
	psname varchar(255), 
	psnameid int,
	locatname varchar(255),
	locatid int,
	facilityname varchar(255)
)
INSERT INTO @tbl2 (
	informationtype_productserviceline_productservicename_location_contact_id, 
	contact_id, 
	informationtype_productserviceline_productservicename_location_id,
	itypename,
	itypeid, 
	plinename, 
	plineid, 
	psname, 
	psnameid,
	locatname,
	locatid
	)
SELECT 
	MIN(informationtype_productserviceline_productservicename_location_to_contact.id) as informationtype_productserviceline_productservicename_location_contact_id,
	MIN(contact.id) as contact_id,
	informationtype_productserviceline_productservicename_to_location.id as informationtype_productserviceline_productservicename_location_id,
	informationtype.name as itypename, 
	informationtype.id as itypeid, 
	productserviceline.name as plinename, 
	productserviceline.id as plineid, 
	productservicename.name as psname, 
	productservicename.id as psnameid,
	location.name as locatname,
	location.id as locatid
FROM
	@tbl as tbl
INNER JOIN
	informationtype_productserviceline_productservicename_to_location
ON
	tbl.informationtype_productserviceline_productservicename_location_id = informationtype_productserviceline_productservicename_to_location.id
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
WHERE
	contact.id = tbl.contact_id
	AND
	productserviceline.name not in (
		'LIFECODES Transfusion Medicine',
		'LIFECODES Transplant Products'
	)
GROUP BY
	informationtype_productserviceline_productservicename_to_location.id,
	informationtype.name, 
	informationtype.id, 
	productserviceline.name, 
	productserviceline.id, 
	productservicename.name, 
	productservicename.id,
	location.name,
	location.id
HAVING COUNT(*) > 1
ORDER BY
	informationtype_productserviceline_productservicename_to_location.id

	DELETE FROM 
		informationtype_productserviceline_productservicename_location_to_contact 
	WHERE 
		id IN (
				SELECT 
					informationtype_productserviceline_productservicename_location_contact_id 
				FROM 
					@tbl2 
			)
