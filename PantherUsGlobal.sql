-- Both the to_productservicename and to_location have us / global / both settings...

UPDATE 
	informationtype_productservicetype_to_productservicename 
SET
	informationtype_productservicetype_to_productservicename.both = 1,
	informationtype_productservicetype_to_productservicename.gl = 0
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
	productservicename.name like '%Panther%'
	
	
UPDATE
	informationtype_productservicetype_productservicename_to_location
SET
	informationtype_productservicetype_productservicename_to_location.both = 1,
	informationtype_productservicetype_productservicename_to_location.gl = 0
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
	productservicename.name like '%Panther%'