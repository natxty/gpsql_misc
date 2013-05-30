DECLARE @target TABLE (
    informationtype_productservicetype_id int,
    informationtype_id int,
    productservicetype_id int
    )

INSERT INTO @target
SELECT 
	informationtype_to_productservicetype.id,
    informationtype_to_productservicetype.informationtype_id,
    informationtype_to_productservicetype.productservicetype_id
FROM 
	informationtype_to_productservicetype
INNER JOIN
	informationtype
ON
	informationtype.id = informationtype_to_productservicetype.informationtype_id
INNER JOIN
	productservicetype
ON 
	productservicetype.id = informationtype_to_productservicetype.productservicetype_id
WHERE
    productservicetype.name = 'Transfusion Medicine'

-- Select all existing paths and all target paths

UPDATE
    informationtype_productservicetype_to_productservicename
SET
    informationtype_productservicetype_to_productservicename.informationtype_productservicetype_id = t.informationtype_productservicetype_id
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
INNER JOIN 
    @target as t
ON
    t.informationtype_id = informationtype.id
WHERE
	productservicename.name = 'LIFECODES Donor Screening'
	AND
	productservicetype.name = 'Transplant Products'
	
	
---- PSLine

DECLARE @target TABLE (
    informationtype_productserviceline_id int,
    informationtype_id int,
    productserviceline_id int
    )

INSERT INTO @target
SELECT 
	informationtype_to_productserviceline.id,
    informationtype_to_productserviceline.informationtype_id,
    informationtype_to_productserviceline.productserviceline_id
FROM 
	informationtype_to_productserviceline
INNER JOIN
	informationtype
ON
	informationtype.id = informationtype_to_productserviceline.informationtype_id
INNER JOIN
	productserviceline
ON 
	productserviceline.id = informationtype_to_productserviceline.productserviceline_id
WHERE
    productserviceline.name = 'LIFECODES Transfusion Medicine'

-- Select all existing paths and all target paths

UPDATE
    informationtype_productserviceline_to_productservicename
SET
    informationtype_productserviceline_to_productservicename.informationtype_productserviceline_id = t.informationtype_productserviceline_id
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
INNER JOIN 
    @target as t
ON
    t.informationtype_id = informationtype.id
WHERE
	productservicename.name = 'LIFECODES Donor Screening'
	AND
	productserviceline.name = 'LIFECODES Transplant Products'
    