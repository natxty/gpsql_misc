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
	contact.id IN 
	(
		SELECT
			contact_id
		FROM
			informationtype_productservicetype_productservicename_location_to_contact
		GROUP BY
			contact_id
		UNION ALL
		SELECT 
			contact_id
		FROM
			informationtype_productserviceline_productservicename_location_to_contact
		GROUP BY
			contact_id
	)
GROUP BY
	 contact.id, facility.name