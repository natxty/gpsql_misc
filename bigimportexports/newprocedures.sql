-- ProductServiceType
CREATE PROCEDURE InformationType_ProductServiceType_ProductServiceName_Location_to_Contact_Query
	-- Add the parameters for the stored procedure here
	@informationtype_id int,
	@productservicetype_id int, 
	@productservicename_id int,
	@location_id int
AS
BEGIN
    -- Insert statements for procedure here		
	SELECT 
		contact.id as id,
		informationtype_productservicetype_productservicename_location_to_contact.label as label
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
	WHERE
		informationtype_to_productservicetype.informationtype_id = @informationtype_id
		AND
		informationtype_to_productservicetype.productservicetype_id = @productservicetype_id
		AND
		informationtype_productservicetype_to_productservicename.productservicename_id = @productservicename_id
		AND
		informationtype_productservicetype_productservicename_to_location.location_id = @location_id		
END


-- ProductServiceLine
CREATE PROCEDURE InformationType_ProductServiceLine_ProductServiceName_Location_to_Contact_Query
	-- Add the parameters for the stored procedure here
	@informationtype_id int,
	@productserviceline_id int, 
	@productservicename_id int,
	@location_id int
AS
BEGIN
    -- Insert statements for procedure here		
	SELECT 
		contact.id as id,
		informationtype_productserviceline_productservicename_location_to_contact.label as label
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
	WHERE
		informationtype_to_productserviceline.informationtype_id = @informationtype_id
		AND
		informationtype_to_productserviceline.productserviceline_id = @productserviceline_id
		AND
		informationtype_productserviceline_to_productservicename.productservicename_id = @productservicename_id
		AND
		informationtype_productserviceline_productservicename_to_location.location_id = @location_id		
END