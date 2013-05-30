-- PRODUCT SERVICE TYPE VERSION


DECLARE @cu_contacts_tmp Table (
	tablename varchar(255),
	id int,
	informationtype varchar(255),
	productservicetype varchar(255),
	productservicename  varchar(255)
)

INSERT INTO @cu_contacts_tmp (tablename, id, informationtype, productservicetype,productservicename)
SELECT 
	 'cu_contacts' as tablename,
	 MIN(genpro03.dbo.cu_contacts.contact_id) as id,
	 genpro03.dbo.cu_informationtypes.dropdownname, 
	 genpro03.dbo.cu_contacts.productservicetype,
	 genpro03.dbo.cu_contacts.productservicename
FROM 
	genpro03.dbo.cu_contacts
INNER JOIN
	genpro03.dbo.cu_informationtypes
ON
	genpro03.dbo.cu_informationtypes.informationtype = genpro03.dbo.cu_contacts.informationtype
GROUP BY
	 genpro03.dbo.cu_informationtypes.dropdownname, 
	 genpro03.dbo.cu_contacts.productservicetype,
	 genpro03.dbo.cu_contacts.productservicename


DECLARE @new_contacts_tmp Table (
	tablename varchar(255),
	id int,
	informationtype varchar(255),
	productservicetype varchar(255),
	productservicename  varchar(255)
)

INSERT INTO @new_contacts_tmp (tablename, id, informationtype, productservicetype,productservicename)
SELECT
	'new_contacts',
	Null,
	informationtype.name as informationtype, 
	productservicetype.name as productservicetype, 
	productservicename.name as productservicename
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


SELECT MIN(tablename) as tablename, MIN(id), informationtype, productservicetype, productservicename
FROM
(
  SELECT tablename, id, informationtype, productservicetype, productservicename
  FROM @cu_contacts_tmp
  UNION ALL
  SELECT tablename, id, informationtype, productservicetype, productservicename
  FROM @new_contacts_tmp
) tmp
GROUP BY informationtype, productservicetype, productservicename
HAVING COUNT(*) = 1
ORDER BY productservicename
