DECLARE @copied TABLE (
    location_id int,
    contact_id int
    )

INSERT INTO @copied
SELECT 
	location.id as location_id,
	contact.id as contact_id
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
	informationtype.name = 'Customer Service'
	AND
	productservicetype.name = 'Sexually Transmitted Diseases'
	AND
	productservicename.name = 'APTIMA COMBO 2'
    AND
    informationtype_productservicetype_productservicename_to_location.gl = 1

DECLARE @copyPSTYPE TABLE (
    informationtype_id int,
    productservicetype_id int, 
    productservicename_id int,
    location_id int,
    contact_id int
    )

INSERT INTO @copyPSTYPE  
SELECT 
	informationtype.id as informationtype_id, 
	productservicetype.id as productservicetype_id, 
	productservicename.id as productservicename_id,
	ct.location_id as location_id,
	ct.contact_id as contact_id
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
CROSS JOIN
    @copied as ct
WHERE
	informationtype.name IN ('Customer Service', 'Technical Support')
    AND
    productservicetype.name IN ('Instrument Systems')


DECLARE @copyPSLINE TABLE (
    informationtype_id int,
    productserviceline_id int, 
    productservicename_id int,
    location_id int,
    contact_id int
    )
    

INSERT INTO @copyPSLINE  
SELECT 
	informationtype.id as informationtype_id, 
	productserviceline.id as productserviceline_id, 
	productservicename.id as productservicename_id,
	ct.location_id as location_id,
	ct.contact_id as contact_id
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
CROSS JOIN
    @copied as ct	
WHERE
    informationtype.name IN ('Customer Service', 'Technical Support')
    AND
	productserviceline.name IN ('DTS', 'LEADER', 'TIGRIS', 'PANTHER System')

DECLARE @SQL Varchar(max)
SET @SQL = ''

SELECT 
	@SQL = @SQL 
        +'EXECUTE ContactPath '
        +	'NULL, ' 	    --informationtype
        +	'NULL, ' 	    --productservicetype
        +	'NULL, '		--productserviceline
        +	'NULL, '		--productservicename
        +	'NULL, '		--location
        +	'NULL, '		--contact_label
        +	CAST(informationtype_id as varchar(max)) + ', '		    --informationtype_id
        +	CAST(productservicetype_id as varchar(max)) + ', '		--productservicetype_id
        +	'NULL, '		                                        --productserviceline_id
        +	CAST(productservicename_id as varchar(max)) + ', '		--productservicename_id
        +	CAST(location_id as varchar(max)) + ', '		        --location_id
        +	CAST(contact_id as varchar(max)) + ', '		            --contact_id
        +	'0, '		--informationtype_productservicetype_productservicename_us
        +	'0, '		--informationtype_productservicetype_productservicename_gl
        +	'0, '		--informationtype_productservicetype_productservicename_both
        +	'0, '		--informationtype_productservicetype_productservicename_location_us
        +	'1, '		--informationtype_productservicetype_productservicename_location_gl
        +	'0, '		--informationtype_productservicetype_productservicename_location_both
        +	'0, '		--informationtype_productserviceline_productservicename_us
        +	'0, '		--informationtype_productserviceline_productservicename_gl
        +	'1, '		--informationtype_productserviceline_productservicename_both
        +	'0, '		--informationtype_productserviceline_productservicename_location_us
        +	'0, '		--informationtype_productserviceline_productservicename_location_gl
        +	'1; '		--informationtype_productserviceline_productservicename_location_both	
FROM 
	@copyPSTYPE
	
SELECT 
	@SQL = @SQL 
        +'EXECUTE ContactPath '
        +	'NULL, ' 	    --informationtype
        +	'NULL, ' 	    --productservicetype
        +	'NULL, '		--productserviceline
        +	'NULL, '		--productservicename
        +	'NULL, '		--location
        +	'NULL, '		--contact_label
        +	CAST(informationtype_id as varchar(max)) + ', '		    --informationtype_id
        +	'NULL, '		                                        --productservicetype_id
        +	CAST(productserviceline_id as varchar(max)) + ', '		--productserviceline_id
        +	CAST(productservicename_id as varchar(max)) + ', '		--productservicename_id
        +	CAST(location_id as varchar(max)) + ', '		        --location_id
        +	CAST(contact_id as varchar(max)) + ', '		            --contact_id
        +	'0, '		--informationtype_productservicetype_productservicename_us
        +	'0, '		--informationtype_productservicetype_productservicename_gl
        +	'0, '		--informationtype_productservicetype_productservicename_both
        +	'0, '		--informationtype_productservicetype_productservicename_location_us
        +	'1, '		--informationtype_productservicetype_productservicename_location_gl
        +	'0, '		--informationtype_productservicetype_productservicename_location_both
        +	'0, '		--informationtype_productserviceline_productservicename_us
        +	'0, '		--informationtype_productserviceline_productservicename_gl
        +	'1, '		--informationtype_productserviceline_productservicename_both
        +	'0, '		--informationtype_productserviceline_productservicename_location_us
        +	'1, '		--informationtype_productserviceline_productservicename_location_gl
        +	'0; '		--informationtype_productserviceline_productservicename_location_both	
FROM 
	@copyPSLINE
	
EXEC (@SQL)


-- Cleanup

UPDATE
    informationtype_productservicetype_productservicename_to_location
SET
    informationtype_productservicetype_productservicename_to_location.both = 0,
    informationtype_productservicetype_productservicename_to_location.us = 1
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
    informationtype.name IN ('Customer Service', 'Technical Support')
    AND
    productservicetype.name IN ('Instrument Systems')
    AND
    informationtype_productservicetype_productservicename_to_location.both = 1

UPDATE
    informationtype_productserviceline_productservicename_to_location
SET
    informationtype_productserviceline_productservicename_to_location.both = 0,
    informationtype_productserviceline_productservicename_to_location.us = 1
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
    informationtype.name IN ('Customer Service', 'Technical Support')
    AND
    productserviceline.name IN ('DTS', 'LEADER', 'TIGRIS', 'PANTHER System')
    AND
    informationtype_productserviceline_productservicename_to_location.both = 1
    
    
    