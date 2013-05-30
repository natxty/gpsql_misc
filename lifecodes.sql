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
	
	
-- Contact Id to Facility Name
SELECT 
	contact.id as contactid,
	facility.name as facilityname
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
WHERE
	facility.name like '%%'
		
-- Stamford

INSERT INTO contact_to_facility
	(contact_id, facility_id,item_order)
VALUES
	(1585,71,1);
	
INSERT INTO contact_to_address
	(contact_id, address_id,item_order)
VALUES
	(1585,281,1);
	
INSERT INTO contact_to_address
	(contact_id, address_id,item_order)
VALUES
	(1585,145,2);
	
INSERT INTO contact_to_phone
	(contact_id, phone_id,item_order)
VALUES
	(1585,185,1);

INSERT INTO contact_to_fax
	(contact_id, fax_id,item_order)
VALUES
	(1585,36,1);
	
INSERT INTO contact_to_email
	(contact_id, email_id,item_order)
VALUES
	(1585,31,1);
	

-- Waukesha

INSERT INTO contact_to_facility
	(contact_id, facility_id,item_order)
VALUES
	(1586,72,1);
	
INSERT INTO contact_to_address
	(contact_id, address_id,item_order)
VALUES
	(1586,382,1);
	
INSERT INTO contact_to_address
	(contact_id, address_id,item_order)
VALUES
	(1586,28,2);
	
INSERT INTO contact_to_phone
	(contact_id, phone_id,item_order)
VALUES
	(1586,232,1);

INSERT INTO contact_to_phone
	(contact_id, phone_id,item_order)
VALUES
	(1586,233,2);

INSERT INTO contact_to_fax
	(contact_id, fax_id,item_order)
VALUES
	(1586,185,1);
	
INSERT INTO contact_to_email
	(contact_id, email_id,item_order)
VALUES
	(1586,31,1);
	
-- BERLIN

INSERT INTO contact_to_facility
	(contact_id, facility_id,item_order)
VALUES
	(1587,74,1);
	
INSERT INTO contact_to_address
	(contact_id, address_id,item_order)
VALUES
	(1587,245,1);
	
INSERT INTO contact_to_person
	(contact_id, person_id,item_order)
VALUES
	(1587,22,1);
	
INSERT INTO contact_to_phone
	(contact_id, phone_id,item_order)
VALUES
	(1587,86,1);

INSERT INTO contact_to_fax
	(contact_id, fax_id,item_order)
VALUES
	(1587,99,1);
	
INSERT INTO contact_to_email
	(contact_id, email_id,item_order)
VALUES
	(1587,22,1);
	
	
CREATE PROCEDURE Contact_to_Person_Query
	-- Add the parameters for the stored procedure here
	@contact_id int 
AS
BEGIN
    -- Insert statements for procedure here
	SELECT 
		person.name, contact_to_person.item_order 
	FROM 
		person
	INNER JOIN 
		contact_to_person 
	ON 
		contact_to_person.contact_id=@contact_id 
		AND 
		contact_to_person.person_id=person.id 
	ORDER BY 
		contact_to_person.item_order
END
	
		