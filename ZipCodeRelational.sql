CREATE TABLE salesrep_to_zipcode (
	id int IDENTITY(1,1),
	salesrepgroup_id int NOT NULL, 
	salesrep_id int NOT NULL,
	zipcode_id int NOT NULL,
	PRIMARY KEY (id)
);

Declare @tbl Table (
	salesrepgroup_id int NOT NULL, 
	salesrep_id int NOT NULL,
	zipcode_id int NOT NULL
)

INSERT INTO @tbl (salesrepgroup_id, salesrep_id, zipcode_id) SELECT
	1, salesrep.id, zipcode.id
FROM 
	zipcode
INNER JOIN
	devpro03.dbo.cu_salesreps as cu_salesreps
ON
	zipcode.zipcode = cu_salesreps.zipcode
INNER JOIN
	salesrep
ON
	cu_salesreps.contactname = salesrep.person
	

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
	salesrepgroup.id = 1

	
SELECT
	MIN(TableName), person,  zipcode, phone, email
FROM
	(
		SELECT 'cu_salesreps' as TableName, contactname as person,  zipcode, phone1 as phone, email
		FROM devpro03.dbo.cu_salesreps
		UNION ALL
		SELECT 'tmp_salesreps' as TableName, person,  zipcode, phone, email
		FROM @tbl2
	)tmp
GROUP BY
	person,  zipcode, phone, email
HAVING COUNT(*) = 1
ORDER BY zipcode


-- Insert for salesrepgroup_to_productservicename
DECLARE @tbl Table(
	productservicename varchar(255)
)

INSERT INTO @tbl (productservicename)
SELECT 
	contacts.productservicename 
FROM
	devpro03.dbo.cu_locations as locations
INNER JOIN
	devpro03.dbo.cu_contacts as contacts
ON
	locations.location_id = contacts.location_id
WHERE
	locations.dropdownname = 'United States'
	AND
	contacts.informationtype = 'distributers'
	AND
	locations.addressline1 = 'zipcode'
	AND
	contacts.productservicename != 'Gen-Probe Fluoroanalyzer'
	AND
	contacts.productservicename in (select name from productservicename)
GROUP BY
	contacts.productservicename

INSERT INTO salesrepgroup_to_productservicename (salesrepgroup_id, productservicename_id)	
SELECT 
	1, psname.id 
FROM 
	@tbl as tbl
INNER JOIN
	productservicename as psname
ON
	psname.name = tbl.productservicename

-- Insert for salesrepgroup 2 (Waukesha)
INSERT INTO salesrepgroup_to_productservicename (salesrepgroup_id, productservicename_id)
SELECT 
	2, id
FROM
	productservicename
WHERE
	name in 
	(
	'LIFECODES Coagulation',
	'LIFECODES Platelet Antibody Detection Products',
	'LIFECODES HPA Genotyping',
	'LIFECODES Red Cell Genotyping',
	'Gen-Probe Fluroanalyzer',
	'LIFECODES Ancillary Products',
	'LIFECODES Donor Screening'
	)


-- SELECT for us id and productservicename_ids (TEST)
DECLARE @Ids VARCHAR(8000) 
SELECT @Ids = COALESCE(@Ids + ' ', '') + cast(productservicename_id as varchar(255)) FROM salesrepgroup_to_productservicename
SELECT 
	(SELECT id FROM location WHERE name = 'United States') as unitedstates_id,
	@Ids as productservicename_ids


-- SELECT for us id and productservicename_ids (REAL)
CREATE PROCEDURE ZipCode_Settings
AS
BEGIN
	DECLARE @Ids VARCHAR(8000) 
	SELECT @Ids = COALESCE(@Ids + ' ', '') + cast(productservicename_id as varchar(255)) FROM salesrepgroup_to_productservicename
	SELECT 
		(SELECT id FROM location WHERE name = 'United States') as unitedstates_id,
		@Ids as productservicename_ids
END


-- STORED PRODCEDURE for getting our actual zipcodes (TEST)
DECLARE @productservicename_id int
DECLARE @zipcode int

-- Give these some values for testing
SET @productservicename_id = (SELECT id FROM productservicename WHERE name = 'LIFECODES Ancillary Products')
SET @zipcode = 91107

SELECT
	salesrep.person,
	salesrep.email,
	salesrep.phone,
	salesrep.email
FROM
	salesrepgroup_to_productservicename
INNER JOIN
	salesrep_to_zipcode
ON
	salesrepgroup_to_productservicename.salesrepgroup_id = salesrep_to_zipcode.salesrepgroup_id
INNER JOIN
	zipcode
ON
	zipcode.id = salesrep_to_zipcode.zipcode_id
INNER JOIN
	salesrep
ON
	salesrep.id = salesrep_to_zipcode.salesrep_id
WHERE
	salesrepgroup_to_productservicename.productservicename_id = @productservicename_id
	AND
	zipcode.zipcode = @zipcode
	
	
-- STORED PRODCEDURE for getting our actual zipcodes (REAL)	
	
CREATE PROCEDURE ProductServiceName_and_ZipCode_to_SalesRep
	-- Add the parameters for the stored procedure here
	@productservicename_id int,
	@zipcode int 
AS
BEGIN	
	SELECT
		salesrep.person,
		salesrep.email,
		salesrep.phone,
		salesrep.email
	FROM
		salesrepgroup_to_productservicename
	INNER JOIN
		salesrep_to_zipcode
	ON
		salesrepgroup_to_productservicename.salesrepgroup_id = salesrep_to_zipcode.salesrepgroup_id
	INNER JOIN
		zipcode
	ON
		zipcode.id = salesrep_to_zipcode.zipcode_id
	INNER JOIN
		salesrep
	ON
		salesrep.id = salesrep_to_zipcode.salesrep_id
	WHERE
		salesrepgroup_to_productservicename.productservicename_id = @productservicename_id
		AND
		zipcode.zipcode = @zipcode	
END
