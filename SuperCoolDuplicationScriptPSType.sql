DECLARE @tbl Table (
	id int NOT NULL IDENTITY(1,1), 
	informationtype_productservicetype_id int,
	location_id int,
	contact_id int,
	processed bit
)

INSERT INTO @tbl (informationtype_productservicetype_id, location_id, contact_id, processed)
SELECT 
	informationtype_to_productservicetype.id,
	location.id as location_id,
	contact.id as contact_id,
	0
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
	productservicetype.name = 'Sexually Transmitted Diseases'
	AND 
	productservicename.name = 'Aptima Combo 2 Assay'

DECLARE @id int

DECLARE @informationtype_productservicetype_id int
DECLARE @informationtype_productservicetype_productservicename_id int
DECLARE @informationtype_productservicetype_productservicename_location_id int

DECLARE @productservicename_id int
DECLARE @location_id int
DECLARE @contact_id int

SET @productservicename_id = 135

WHILE EXISTS ( SELECT * FROM @tbl WHERE processed = 0)
BEGIN   --Get the Id of the first row
       	SELECT Top 1 @id = id FROM @tbl WHERE processed = 0	
		
		SET @informationtype_productservicetype_productservicename_id  = Null
		SET @informationtype_productservicetype_productservicename_location_id = Null
		
		SELECT 
			@informationtype_productservicetype_id = informationtype_productservicetype_id,
			@location_id = location_id, 
			@contact_id = contact_id
		FROM
			@tbl
		WHERE
			id = @id
		
		INSERT INTO informationtype_productservicetype_to_productservicename
			(informationtype_productservicetype_id, productservicename_id)
		VALUES 
			(@informationtype_productservicetype_id, @productservicename_id)
		
		SET @informationtype_productservicetype_productservicename_id = @@IDENTITY
		
		INSERT INTO informationtype_productservicetype_productservicename_to_location
			(informationtype_productservicetype_productservicename_id, location_id)
		VALUES
			(@informationtype_productservicetype_productservicename_id, @location_id)
		
		SET @informationtype_productservicetype_productservicename_location_id = @@IDENTITY
		
		INSERT INTO informationtype_productservicetype_productservicename_location_to_contact
			(informationtype_productservicetype_productservicename_location_id, contact_id)
		VALUES
			(@informationtype_productservicetype_productservicename_location_id, @contact_id)
 
       	
        UPDATE @tbl SET processed = 1 WHERE id = @id
END

