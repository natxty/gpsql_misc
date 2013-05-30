DECLARE @tbl Table (
	informationtype_productserviceline_productservicename_id int,
	processed bit
)

INSERT INTO @tbl (informationtype_productserviceline_productservicename_id,processed)
SELECT 
	informationtype_productserviceline_to_productservicename.id, 0
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
	informationtype.name in ('Customer Service', 'Technical Support')
	AND
	productserviceline.name in ('APTIMA', 'Elucigene', 'Prodesse')
	AND
	productservicename.name in (
'APTIMA COMBO 2',
'APTIMA CT/GC',
'APTIMA HPV',
'APTIMA Trich',
'Prodesse Pro hMPV+',
'Prodesse ProFAST+',
'Prodesse ProFlu+',
'Prodesse ProFlu-ST',
'Prodesse ProParaflu+',
'Prodesse ProPneumo-1',
'Elucigene AAT (Alpha-1-Antitrypsin) Products',
'Elucigene Ashkenazi Screening',
'Elucigene CF (Cystic Fibrosis) Products',
'Elucigene FH20 (Familial Hypercholesterolaemia)',
'Elucigene QST*R Products',
'Elucigene TRP (Thrombosis) Products'
)

DECLARE @tbl1 Table (
	informationtype_productserviceline_productservicename_id int,
	location_id int,
	processed bit
)

DECLARE @Id int

WHILE EXISTS ( SELECT * FROM @tbl WHERE processed = 0)
BEGIN   --Get the Id of the first row
       	SELECT Top 1 @Id = informationtype_productserviceline_productservicename_id FROM @tbl WHERE processed = 0
       	
       	INSERT INTO @tbl1 (informationtype_productserviceline_productservicename_id, location_id, processed)
    	SELECT
    		@Id, location.id, 0
    	FROM
    		gl_locats_temp as gltbl
    	INNER JOIN
    		location
    	ON
    		location.name = gltbl.location
    	       	
        UPDATE @tbl SET processed = 1 WHERE informationtype_productserviceline_productservicename_id = @Id
END


DECLARE @location_id int

WHILE EXISTS ( SELECT * FROM @tbl1 WHERE processed = 0)
BEGIN   --Get the Id of the first row
       	SELECT Top 1 @Id = informationtype_productserviceline_productservicename_id, @location_id = location_id FROM @tbl1 WHERE processed = 0
       	
       	INSERT INTO informationtype_productserviceline_productservicename_to_location (informationtype_productserviceline_productservicename_id, location_id, us, gl, both)
       	VALUES (@Id, @location_id, 0, 1, 0)
       	
      	INSERT INTO informationtype_productserviceline_productservicename_location_to_contact (informationtype_productserviceline_productservicename_location_id, contact_id)
       	SELECT 
       		@@IDENTITY, contact.id
       	FROM
       		location
       	INNER JOIN
       		gl_locats_temp
       	ON
       		location.name = gl_locats_temp.location
       	INNER JOIN
       		facility
       	ON
       		facility.name = gl_locats_temp.facility
       	INNER JOIN
       		contact_to_facility
       	ON
       		contact_to_facility.facility_id = facility.id
       	INNER JOIN
       		contact
       	ON
       		contact.id = contact_to_facility.contact_id
       	WHERE
       		location.id = @location_id
       	
        UPDATE @tbl1 SET processed = 1 WHERE informationtype_productserviceline_productservicename_id = @Id AND location_id = @location_id
END
       