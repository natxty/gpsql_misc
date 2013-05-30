CREATE PROCEDURE Contact_to_Address_Query
	-- Add the parameters for the stored procedure here
	@contact_id int 
AS
BEGIN
    -- Insert statements for procedure here
	SELECT 
		address.address, contact_to_address.item_order 
	FROM 
		address 
	INNER JOIN 
		contact_to_address 
	ON 
		contact_to_address.contact_id=@contact_id 
		AND 
		contact_to_address.address_id=address.id 
	ORDER BY 
		contact_to_address.item_order
END


CREATE PROCEDURE Contact_to_Email_Query
	-- Add the parameters for the stored procedure here
	@contact_id int 
AS
BEGIN
    -- Insert statements for procedure here
	SELECT 
		email.email, contact_to_email.item_order 
	FROM 
		email
	INNER JOIN 
		contact_to_email 
	ON 
		contact_to_email.contact_id=@contact_id 
		AND 
		contact_to_email.email_id=email.id 
	ORDER BY 
		contact_to_email.item_order
END


CREATE PROCEDURE Contact_to_Fax_Query
	-- Add the parameters for the stored procedure here
	@contact_id int 
AS
BEGIN
    -- Insert statements for procedure here
	SELECT 
		fax.number, contact_to_fax.item_order 
	FROM 
		fax
	INNER JOIN 
		contact_to_fax 
	ON 
		contact_to_fax.contact_id=@contact_id 
		AND 
		contact_to_fax.fax_id=fax.id 
	ORDER BY 
		contact_to_fax.item_order
END


CREATE PROCEDURE Contact_to_Phone_Query
	-- Add the parameters for the stored procedure here
	@contact_id int 
AS
BEGIN
    -- Insert statements for procedure here
	SELECT 
		phone.number, contact_to_phone.item_order 
	FROM 
		phone 
	INNER JOIN 
		contact_to_phone 
	ON 
		contact_to_phone.contact_id=@contact_id 
		AND 
		contact_to_phone.phone_id=phone.id 
	ORDER BY 
		contact_to_phone.item_order
END


CREATE PROCEDURE Contact_to_Website_Query
	-- Add the parameters for the stored procedure here
	@contact_id int 
AS
BEGIN
    -- Insert statements for procedure here
	SELECT 
		website.url, contact_to_website.item_order 
	FROM 
		website
	INNER JOIN 
		contact_to_website 
	ON 
		contact_to_website.contact_id=@contact_id 
		AND 
		contact_to_website.website_id=website.id 
	ORDER BY 
		contact_to_website.item_order
END


CREATE PROCEDURE Contact_to_Facility_Query
	-- Add the parameters for the stored procedure here
	@contact_id int 
AS
BEGIN
    -- Insert statements for procedure here
	SELECT 
		facility.url, contact_to_facility.item_order 
	FROM 
		website
	INNER JOIN 
		contact_to_facility
	ON 
		contact_to_facility.contact_id=@contact_id 
		AND 
		contact_to_facility.facility_id=facility.id 
	ORDER BY 
		contact_to_facility.item_order
END




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
		* 
	FROM 
		contact
	WHERE 
		contact.id 
	IN 
		(
			SELECT 
				informationtype_productserviceline_productservicename_location_to_contact.contact_id
			FROM
				informationtype_to_productserviceline
			INNER JOIN
				informationtype_productserviceline_to_productservicename
			ON 
				informationtype_to_productserviceline.id = informationtype_productserviceline_to_productservicename.informationtype_productserviceline_id
			INNER JOIN
				informationtype_productserviceline_productservicename_to_location
			ON
				 informationtype_productserviceline_productservicename_to_location.informationtype_productserviceline_productservicename_id	= informationtype_productserviceline_to_productservicename.id
			INNER JOIN
				informationtype_productserviceline_productservicename_location_to_contact
			ON
				informationtype_productserviceline_productservicename_location_to_contact.informationtype_productserviceline_productservicename_location_id = informationtype_productserviceline_productservicename_to_location.id
			WHERE
				informationtype_to_productserviceline.informationtype_id = @informationtype_id
				AND
				informationtype_to_productserviceline.productserviceline_id = @productserviceline_id
				AND
				informationtype_productserviceline_to_productservicename.productservicename_id = @productservicename_id
				AND
				informationtype_productserviceline_productservicename_to_location.location_id = @location_id
		)		
END


