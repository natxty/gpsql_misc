Declare @tbl Table (
	salesrepgroup_id int NOT NULL, 
	salesrep_id int NOT NULL,
	zipcode_id int NOT NULL
)

INSERT INTO 
	@tbl (salesrepgroup_id, salesrep_id, zipcode_id)
SELECT 
	3, salesrep.id as salesrep_id, zipcode.id as zipcode_id 
FROM 
	salesrep_stamford_tmpimport as tmptble
INNER JOIN
	zipcode
ON
	cast(zipcode.zipcode as int) = cast(tmptble.zipcode as int)
INNER JOIN
	salesrep
ON
	salesrep.person = tmptble.person
GROUP BY
	salesrep.id, zipcode.id


Declare @tbl2 Table (
	zipcode nvarchar(5),
	person nvarchar(100),
	territory nvarchar(10),
	phone nvarchar(200),
	email nvarchar(200)
)

INSERT INTO @tbl2 (zipcode, person, territory, phone, email) SELECT 
	zipcode.zipcode,
	salesrep.person,
	salesrep.territory,
	salesrep.phone,
	salesrep.email
FROM
	@tbl as tbl
INNER JOIN
	salesrep
ON
	tbl.salesrep_id = salesrep.id
INNER JOIN
	zipcode
ON
	tbl.zipcode_id = zipcode.id
INNER JOIN
	salesrepgroup
ON
	tbl.salesrepgroup_id = salesrepgroup.id
WHERE
	salesrepgroup.id = 3


Declare @tbl3 Table (
	TableName nvarchar(200),
	zipcode nvarchar(5),
	person nvarchar(100),
	phone nvarchar(200),
	email nvarchar(200)
)

INSERT INTO @tbl3 (TableName, person, zipcode, phone, email)	
SELECT
	MIN(TableName), person,  zipcode, phone, email
FROM
	(
		SELECT 'cu_salesreps' as TableName, person,  zipcode, phone, email
		FROM salesrep_waukesha_tmpimport
		UNION ALL
		SELECT 'tmp_salesreps' as TableName, person,  zipcode, phone, email
		FROM @tbl2
	)tmp
GROUP BY
	person,  zipcode, phone, email
HAVING COUNT(*) = 1
ORDER BY zipcode

select * from @tbl3 as tbl3 where tbl3.zipcode not in (select zipcode.zipcode from zipcode)