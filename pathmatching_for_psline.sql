-- PRODUCT SERVICE TYPE VERSION


DECLARE @cu_contacts_tmp Table (
	tablename varchar(255),
	id int,
	informationtype varchar(255),
	productserviceline varchar(255),
	productservicename  varchar(255)
)

INSERT INTO @cu_contacts_tmp (tablename, id, informationtype, productserviceline,productservicename)
SELECT 
	 'cu_contacts' as tablename,
	 MIN(genpro03.dbo.cu_contacts.contact_id) as id,
	 genpro03.dbo.cu_informationtypes.dropdownname, 
	 genpro03.dbo.cu_contacts.productserviceline,
	 genpro03.dbo.cu_contacts.productservicename
FROM 
	genpro03.dbo.cu_contacts
INNER JOIN
	genpro03.dbo.cu_informationtypes
ON
	genpro03.dbo.cu_informationtypes.informationtype = genpro03.dbo.cu_contacts.informationtype
GROUP BY
	 genpro03.dbo.cu_informationtypes.dropdownname, 
	 genpro03.dbo.cu_contacts.productserviceline,
	 genpro03.dbo.cu_contacts.productservicename


DECLARE @new_contacts_tmp Table (
	tablename varchar(255),
	id int,
	informationtype varchar(255),
	productserviceline varchar(255),
	productservicename  varchar(255)
)

INSERT INTO @new_contacts_tmp (tablename, id, informationtype, productserviceline,productservicename)
SELECT
	'new_contacts',
	Null,
	informationtype.name as informationtype, 
	productserviceline.name as productserviceline, 
	productservicename.name as productservicename
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


SELECT MIN(tablename) as tablename, MIN(id), informationtype, productserviceline, productservicename
FROM
(
  SELECT tablename, id, informationtype, productserviceline, productservicename
  FROM @cu_contacts_tmp
  UNION ALL
  SELECT tablename, id, informationtype, productserviceline, productservicename
  FROM @new_contacts_tmp
) tmp
GROUP BY informationtype, productserviceline, productservicename
HAVING COUNT(*) = 1
ORDER BY productservicename
