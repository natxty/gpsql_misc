DECLARE @tbl Table (
	informationtype_productservicetype_productservicename_location_id int
)

INSERT INTO @tbl (informationtype_productservicetype_productservicename_location_id)
SELECT
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
	informationtype.name = 'Sales and Distribution'
	AND
	productservicetype.name = 'Sexually Transmitted Diseases'
	AND
	location.name in ('United Kingdom')

INSERT INTO informationtype_productservicetype_productservicename_location_to_contact (informationtype_productservicetype_productservicename_location_id, contact_id)	
SELECT 
	* 
FROM 
	@tbl 
CROSS JOIN 
	(
	SELECT 1669 as id
	UNION ALL SELECT 1670
	UNION ALL SELECT 1671
	) t
	
	