Declare @T Table (
	contact_id int,
	ref_id int,
	locationname nvarchar(100),
	addressline1 nvarchar(300),
	addressline2 nvarchar(300),
	addressline3 nvarchar(100),
	phone1 nvarchar(300),
	phone2 nvarchar(100),
	phone3 nvarchar(100),
	fax1 nvarchar(100),
	fax2 nvarchar(50),
	email nvarchar(200),
	website nvarchar(200),
	Processed tinyint
);



-- insert new DB vals into temp table, structured similarly to the old table:
INSERT INTO @T (contact_id, ref_id, locationname, addressline1, addressline2, addressline3, phone1, phone2, phone3, fax1, fax2, email, website, Processed) 
SELECT
	contact.id as contact_id,
	MAX(contact.ref_id) as ref_id,
	(SELECT '' + [name] FROM facility INNER JOIN contact_to_facility ON contact_to_facility.facility_id = facility.id WHERE (contact_to_facility.contact_id = contact.id AND contact_to_facility.item_order = 1) FOR XML PATH ('')) AS locationname,
	(SELECT '' + [address] FROM address INNER JOIN contact_to_address ON contact_to_address.address_id = address.id WHERE (contact_to_address.contact_id = contact.id AND contact_to_address.item_order = 1) ORDER BY contact_to_address.item_order FOR XML PATH ('')) AS address1,	
	(SELECT '' + [address] FROM address INNER JOIN contact_to_address ON contact_to_address.address_id = address.id WHERE (contact_to_address.contact_id = contact.id AND contact_to_address.item_order = 2) ORDER BY contact_to_address.item_order FOR XML PATH ('')) AS address2	,
	(SELECT '' + [address] FROM address INNER JOIN contact_to_address ON contact_to_address.address_id = address.id WHERE (contact_to_address.contact_id = contact.id AND contact_to_address.item_order = 3) ORDER BY contact_to_address.item_order FOR XML PATH ('')) AS address3,
	
	--phones
	(SELECT '' + [number] FROM phone INNER JOIN contact_to_phone ON contact_to_phone.phone_id = phone.id WHERE (contact_to_phone.contact_id = contact.id AND contact_to_phone.item_order = 1) ORDER BY contact_to_phone.item_order FOR XML PATH ('')) AS phone1,
	(SELECT '' + [number] FROM phone INNER JOIN contact_to_phone ON contact_to_phone.phone_id = phone.id WHERE (contact_to_phone.contact_id = contact.id AND contact_to_phone.item_order = 2) ORDER BY contact_to_phone.item_order FOR XML PATH ('')) AS phone2,
	(SELECT '' + [number] FROM phone INNER JOIN contact_to_phone ON contact_to_phone.phone_id = phone.id WHERE (contact_to_phone.contact_id = contact.id AND contact_to_phone.item_order = 3) ORDER BY contact_to_phone.item_order FOR XML PATH ('')) AS phone3,
	
	-- faxes
	(SELECT '' + [number] FROM fax INNER JOIN contact_to_fax ON contact_to_fax.fax_id = fax.id WHERE (contact_to_fax.contact_id = contact.id AND contact_to_fax.item_order = 1) ORDER BY contact_to_fax.item_order FOR XML PATH ('')) AS fax1,
	(SELECT '' + [number] FROM fax INNER JOIN contact_to_fax ON contact_to_fax.fax_id = fax.id WHERE (contact_to_fax.contact_id = contact.id AND contact_to_fax.item_order = 2) ORDER BY contact_to_fax.item_order FOR XML PATH ('')) AS fax2,
	
	-- email
	(SELECT '' + [email] FROM email INNER JOIN contact_to_email ON contact_to_email.email_id = email.id WHERE (contact_to_email.contact_id = contact.id AND contact_to_email.item_order = 1) ORDER BY contact_to_email.item_order FOR XML PATH ('')) AS email,
	
	-- website
	(SELECT '' + [url] FROM website INNER JOIN contact_to_website ON contact_to_website.website_id = website.id WHERE (contact_to_website.contact_id = contact.id AND contact_to_website.item_order = 1) ORDER BY contact_to_website.item_order FOR XML PATH ('')) AS website,
	
	--Processed
	0
	
FROM
	contact
GROUP BY
	 contact.id

SELECT MIN(TableName) as TableName, id, locationname, addressline1, addressline2, addressline3, phone1, phone2, phone3, fax1, fax2, email, website
FROM
(
  SELECT 'cu_locations' as TableName, location_id as id, locationname, addressline1, addressline2, addressline3, phone1, phone2, phone3, fax1, fax2, email, website
  FROM genpro03.dbo.cu_locations
  UNION ALL
  SELECT 'contactus' as TableName, ref_id as id, locationname, addressline1, addressline2, addressline3, phone1, phone2, phone3, fax1, fax2, email, website
  FROM @T
) tmp
GROUP BY id, locationname, addressline1, addressline2, addressline3, phone1, phone2, phone3, fax1, fax2, email, website
HAVING COUNT(*) = 1
ORDER BY ID