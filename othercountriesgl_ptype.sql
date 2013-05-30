DECLARE @tbl Table (
	informationtype_productservicetype_productservicename_id int,
	processed bit
)

INSERT INTO @tbl 
SELECT
	informationtype_productservicetype_to_productservicename.id,0
FROM
	informationtype_productservicetype_productservicename_to_location
INNER JOIN
	informationtype_productservicetype_to_productservicename
ON
	informationtype_productservicetype_to_productservicename.id = informationtype_productservicetype_productservicename_to_location.informationtype_productservicetype_productservicename_id
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
	informationtype_productservicetype_productservicename_location_to_contact
ON
	informationtype_productservicetype_productservicename_location_to_contact.informationtype_productservicetype_productservicename_location_id = informationtype_productservicetype_productservicename_to_location.id
INNER JOIN
	productservicename
ON
	informationtype_productservicetype_to_productservicename.productservicename_id = productservicename.id
WHERE
	informationtype_productservicetype_productservicename_to_location.us = 1
	AND
	informationtype.name in ('Customer Service', 'Technical Support')
	AND
	productservicetype.name in ('Sexually Transmitted Diseases', 'Respiratory Infectious Diseases', 'Genetic Disease Testing')
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
'Elucigene TRP (Thrombosis) Products')

INSERT INTO informationtype_productservicetype_productservicename_to_location (informationtype_productservicetype_productservicename_id, location_id, us, gl, both)
SELECT
	informationtype_productservicetype_productservicename_id, 4, 0, 1, 0
FROM 
	@tbl

SELECT * FROM  
	informationtype_productservicetype_productservicename_to_location
INNER JOIN
	@tbl as tbl
ON
	tbl.informationtype_productservicetype_productservicename_id = informationtype_productservicetype_productservicename_to_location.informationtype_productservicetype_productservicename_id
WHERE
	informationtype_productservicetype_productservicename_to_location.location_id = 4
	

INSERT INTO informationtype_productservicetype_productservicename_location_to_contact (informationtype_productservicetype_productservicename_location_id, contact_id)
SELECT 
	informationtype_productservicetype_productservicename_to_location.id,
	1661
FROM  
	informationtype_productservicetype_productservicename_to_location
INNER JOIN
	@tbl as tbl
ON
	tbl.informationtype_productservicetype_productservicename_id = informationtype_productservicetype_productservicename_to_location.informationtype_productservicetype_productservicename_id
WHERE
	informationtype_productservicetype_productservicename_to_location.location_id = 4
	
