CREATE PROCEDURE InformationType_ProductServiceLine_to_Location_Query
	-- Add the parameters for the stored procedure here
	@informationtype_id int,
	@productserviceline_id int
AS
BEGIN
	SELECT 
		* 
	FROM 
		location
	WHERE 
		location.id 
	IN 
		(
			SELECT 
				informationtype_productserviceline_productservicename_to_location.location_id
			FROM
				informationtype_productserviceline_productservicename_to_location
			WHERE
				informationtype_productserviceline_productservicename_to_location.informationtype_productserviceline_productservicename_id	
			IN
					(	
						SELECT
							informationtype_productserviceline_to_productservicename.id
						FROM
							informationtype_productserviceline_to_productservicename
						INNER JOIN
							informationtype_to_productserviceline
						ON 
							informationtype_to_productserviceline.id = informationtype_productserviceline_to_productservicename.informationtype_productserviceline_id
						WHERE
							informationtype_to_productserviceline.informationtype_id = @informationtype_id
							AND
							informationtype_to_productserviceline.productserviceline_id = @productserviceline_id				
					)
		)
END


CREATE PROCEDURE InformationType_ProductServiceType_to_Location_Query
	-- Add the parameters for the stored procedure here
	@informationtype_id int,
	@productservicetype_id int
AS
BEGIN
	SELECT 
		* 
	FROM 
		location
	WHERE 
		location.id 
	IN 
		(
			SELECT 
				informationtype_productservicetype_productservicename_to_location.location_id
			FROM
				informationtype_productservicetype_productservicename_to_location
			WHERE
				informationtype_productservicetype_productservicename_to_location.informationtype_productservicetype_productservicename_id	
			IN
					(	
						SELECT
							informationtype_productservicetype_to_productservicename.id
						FROM
							informationtype_productservicetype_to_productservicename
						INNER JOIN
							informationtype_to_productservicetype
						ON 
							informationtype_to_productservicetype.id = informationtype_productservicetype_to_productservicename.informationtype_productservicetype_id
						WHERE
							informationtype_to_productservicetype.informationtype_id = @informationtype_id
							AND
							informationtype_to_productservicetype.productservicetype_id = @productservicetype_id				
					)
		)
END