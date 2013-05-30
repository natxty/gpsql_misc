CREATE PROCEDURE InformationType_ProductServiceType_to_ProductServiceName_Query
	-- Add the parameters for the stored procedure here
	@informationtype_id int,
	@productservicetype_id int,
	@us_site bit,
	@gl_site bit
AS
BEGIN

	IF (@us_site IS NULL)
		BEGIN
		SET @us_site = 0
		END
		
	IF (@gl_site IS NULL)
		BEGIN
		SET @gl_site = 0
		END

	SELECT 
		* 
	FROM 
		productservicename
	WHERE
		productservicename.id 
	IN 
		(
			SELECT 
				informationtype_productservicetype_to_productservicename.productservicename_id
			FROM 
				informationtype_to_productservicetype
			INNER JOIN
				informationtype_productservicetype_to_productservicename
			ON 
				informationtype_to_productservicetype.id = informationtype_productservicetype_to_productservicename.informationtype_productservicetype_id
			WHERE
				informationtype_to_productservicetype.informationtype_id = @informationtype_id 
				AND
				informationtype_to_productservicetype.productservicetype_id = @productservicetype_id
				AND
				(
					(
						informationtype_productservicetype_to_productservicename.both = 1 
						AND 
						informationtype_productservicetype_to_productservicename.both = 1
					)
					OR 
					( 
						informationtype_productservicetype_to_productservicename.both = 0 
						AND
						(
						(@gl_site  = 1 AND informationtype_productservicetype_to_productservicename.gl = 1) 
						OR
						(@gl_site != 1 AND informationtype_productservicetype_to_productservicename.gl = 0)
						)
						AND
						(
						(@us_site  = 1 AND informationtype_productservicetype_to_productservicename.us = 1) 
						OR
						(@us_site != 1 AND informationtype_productservicetype_to_productservicename.us = 0)
						)	
					)			
				)				
		)
END



