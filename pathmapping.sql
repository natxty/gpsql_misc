DECLARE @tbl Table (
	id int,
	informationtype varchar(255),
	productservicename_id int, 
	productservicetype varchar(255),
	productservicetype_id int,
	informationtype_productservicetype_id int,
	productserviceline varchar(255),
	productserviceline_id int,
	informationtype_productserviceline_id int,
	location varchar(255),
	location_id int,
	facility varchar(255),
	contact_id int,
	processed bit
)

INSERT INTO  @tbl (id,informationtype, productservicename_id, productservicetype, productservicetype_id, informationtype_productservicetype_id, productserviceline, productserviceline_id,  informationtype_productserviceline_id, location, location_id, facility, contact_id, processed)
SELECT
	MIN(cu_contacts.contact_id) as id,

	cu_informationtypes.dropdownname as informationtype,
	
	51, -- Productservicename_id
	
	cu_contacts.productservicetype as productservicetype,
	productservicetype.id as productservicetype_id,
	informationtype_to_productservicetype.id as informationtype_productservicetype_id,
	
	cu_contacts.productserviceline as productserviceline,
	productserviceline.id as productserviceline_id,
	informationtype_to_productserviceline.id as informationtype_productserviceline_id,

	cu_locations.dropdownname as location,
	location.id as locationId,
	cu_locations.locationname as facility,
	MIN(contact.id) as contact_id, 
	
	0
FROM 
	genpro03.dbo.cu_contacts as cu_contacts
LEFT JOIN
	genpro03.dbo.cu_locations as cu_locations
ON
	cu_contacts.location_id = cu_locations.location_id
LEFT JOIN
	genpro03.dbo.cu_informationtypes as cu_informationtypes
ON
	cu_informationtypes.informationtype = cu_contacts.informationtype
LEFT JOIN
	informationtype
ON
	informationtype.name = cu_informationtypes.dropdownname

LEFT JOIN
	facility
ON
	facility.name = LTRIM(RTRIM(cu_locations.locationname))
LEFT JOIN
	contact_to_facility
ON
	facility.id = contact_to_facility.facility_id
INNER JOIN
	contact
ON
	contact.id = contact_to_facility.contact_id
LEFT JOIN
	location
ON
	location.name = cu_locations.dropdownname

LEFT JOIN
	productservicetype
ON
	productservicetype.name = cu_contacts.productservicetype
LEFT JOIN
	productserviceline
ON
	productserviceline.name = cu_contacts.productserviceline

LEFT JOIN
	informationtype_to_productservicetype
ON
	informationtype_to_productservicetype.informationtype_id = informationtype.id
	AND
	informationtype_to_productservicetype.productservicetype_id = productservicetype.id
LEFT JOIN
	informationtype_to_productserviceline
ON
	informationtype_to_productserviceline.informationtype_id = informationtype.id
	AND
	informationtype_to_productserviceline.productserviceline_id = productserviceline.id

WHERE 
	cu_contacts.productservicename like 'Diaclone Elispot'
	AND
	informationtype.name in ('Customer Service', 'Technical Support')
GROUP BY
	cu_informationtypes.dropdownname,
	cu_contacts.productservicetype,
	productservicetype.id,
	informationtype_to_productservicetype.id,
	cu_contacts.productserviceline,
	productserviceline.id,
	informationtype_to_productserviceline.id,
	cu_locations.dropdownname,
	location.id ,
	cu_locations.locationname
	
Declare @Id int

-- start to loop through the unprocessed:
WHILE EXISTS ( SELECT * FROM @tbl WHERE processed = 0)
BEGIN   --Get the Id of the first row
       	SELECT Top 1 @Id = id FROM @tbl WHERE processed= 0
                 
        --do processing here
        
        -- PSTYPE
        INSERT INTO informationtype_productservicetype_to_productservicename (informationtype_productservicetype_id, productservicename_id) 
        	SELECT informationtype_productservicetype_id, productservicename_id
        	FROM @tbl 
        	WHERE id = @Id
        	GROUP BY informationtype_productservicetype_id, productservicename_id
        
        INSERT INTO informationtype_productservicetype_productservicename_to_location (informationtype_productservicetype_productservicename_id, location_id)
        	SELECT @@IDENTITY, location_id
        	FROM @tbl as tbl
        	INNER JOIN
        		informationtype_productservicetype_to_productservicename
        	ON
        		informationtype_productservicetype_to_productservicename.informationtype_productservicetype_id = tbl.informationtype_productservicetype_id
        		AND
        		informationtype_productservicetype_to_productservicename.productservicename_id = tbl.productservicename_id
        	WHERE 
        		tbl.id = @Id
        		AND
        		informationtype_productservicetype_to_productservicename.id = @@IDENTITY
        		
        INSERT INTO informationtype_productservicetype_productservicename_location_to_contact (informationtype_productservicetype_productservicename_location_id, contact_id, label)
        	SELECT @@IDENTITY, contact_id, tbl.facility
        	FROM @tbl as tbl
        	INNER JOIN
        		informationtype_productservicetype_productservicename_to_location
        	ON
        		informationtype_productservicetype_productservicename_to_location.location_id = tbl.location_id
        	INNER JOIN
        		informationtype_productservicetype_to_productservicename
        	ON
        		informationtype_productservicetype_to_productservicename.id = informationtype_productservicetype_productservicename_to_location.informationtype_productservicetype_productservicename_id
        		AND
        		informationtype_productservicetype_to_productservicename.informationtype_productservicetype_id = tbl.informationtype_productservicetype_id
        		AND
        		informationtype_productservicetype_to_productservicename.productservicename_id = tbl.productservicename_id
        	WHERE 
        		tbl.id = @Id
        		AND
        		informationtype_productservicetype_productservicename_to_location.id = @@IDENTITY   
        		
        -- PSLINE
        INSERT INTO informationtype_productserviceline_to_productservicename (informationtype_productserviceline_id, productservicename_id) 
        	SELECT informationtype_productserviceline_id, productservicename_id
        	FROM @tbl 
        	WHERE id = @Id
        	GROUP BY informationtype_productserviceline_id, productservicename_id
        
        INSERT INTO informationtype_productserviceline_productservicename_to_location (informationtype_productserviceline_productservicename_id, location_id)
        	SELECT @@IDENTITY, location_id
        	FROM @tbl as tbl
        	INNER JOIN
        		informationtype_productserviceline_to_productservicename
        	ON
        		informationtype_productserviceline_to_productservicename.informationtype_productserviceline_id = tbl.informationtype_productserviceline_id
        		AND
        		informationtype_productserviceline_to_productservicename.productservicename_id = tbl.productservicename_id
        	WHERE 
        		tbl.id = @Id
        		AND
        		informationtype_productserviceline_to_productservicename.id = @@IDENTITY
        		
        INSERT INTO informationtype_productserviceline_productservicename_location_to_contact (informationtype_productserviceline_productservicename_location_id, contact_id, label)
        	SELECT @@IDENTITY, contact_id, Null
        	FROM @tbl as tbl
        	INNER JOIN
        		informationtype_productserviceline_productservicename_to_location
        	ON
        		informationtype_productserviceline_productservicename_to_location.location_id = tbl.location_id
        	INNER JOIN
        		informationtype_productserviceline_to_productservicename
        	ON
        		informationtype_productserviceline_to_productservicename.id = informationtype_productserviceline_productservicename_to_location.informationtype_productserviceline_productservicename_id
        		AND
        		informationtype_productserviceline_to_productservicename.informationtype_productserviceline_id = tbl.informationtype_productserviceline_id
        		AND
        		informationtype_productserviceline_to_productservicename.productservicename_id = tbl.productservicename_id
        	WHERE 
        		tbl.id = @Id
        		AND
        		informationtype_productserviceline_productservicename_to_location.id = @@IDENTITY           		     	
        	        
        UPDATE @tbl SET processed = 1 WHERE id = @Id
END;
