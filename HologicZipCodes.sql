DECLARE @products TABLE (
    id int
    )

INSERT INTO @products
SELECT
	productservicename.id
FROM
	productservicename
INNER JOIN
	informationtype_productservicetype_to_productservicename
ON
	informationtype_productservicetype_to_productservicename.productservicename_id = productservicename.id
INNER JOIN
	informationtype_to_productservicetype	
ON
	informationtype_to_productservicetype.id = informationtype_productservicetype_to_productservicename.informationtype_productservicetype_id
INNER JOIN
    productservicetype
ON
    informationtype_to_productservicetype.productservicetype_id = productservicetype.id
WHERE
	informationtype_to_productservicetype.productservicetype_id IN (SELECT id FROM productservicetype WHERE name IN (
		'Instrument Systems',
		'Microbial Infectious Diseases',
		'Respiratory Infectious Diseases',
		'Virals'
	))
GROUP BY productservicename.name, productservicename.id

--- Delete any existing productservicenames associated 

DELETE FROM salesrepgroup_to_productservicename WHERE productservicename_id IN (
    SELECT id FROM @products
    ) AND salesrepgroup_id = 1

--- COLIN.... YOU MUST START HERE!!!
INSERT INTO salesrepgroup_to_productservicename (salesrepgroup_id, productservicename_id)
SELECT 4 as salesrepgroup_id, id as productservicename_id FROM @products

-- insert all the new people as sales reps, store in temp table

DECLARE @hreps TABLE (
    salesrep_id int,
    first varchar(255),
    last varchar(255)
    ) 

INSERT INTO @hreps
SELECT
    (SELECT id FROM salesrep WHERE (first + ' ' + last) = salesrep.person), 
    first, 
    last
FROM
    hologic_sales_reps 
GROUP BY first, last

DECLARE @first nvarchar(255)
DECLARE @last nvarchar(255)
DECLARE @salesrep_id int

WHILE EXISTS ( SELECT * FROM @hreps WHERE salesrep_id IS NULL)
BEGIN   --Get the Id of the first row
    SELECT Top 1 @first = first, @last = last FROM @hreps WHERE salesrep_id IS NULL
    INSERT INTO salesrep (person) VALUES (@first+' '+@last)
    
    SET @salesrep_id = @@IDENTITY
    UPDATE @hreps SET salesrep_id = @salesrep_id WHERE first = @first AND last = @last
END

-- find any missing zipcodes and add them

INSERT INTO zipcode (zipcode)
SELECT
    cast(h.zip as nvarchar(5))
FROM
    hologic_sales_reps as h
WHERE
    cast(h.zip as nvarchar(5)) NOT IN (
        SELECT zipcode.zipcode from zipcode
        )

-- create a mock table of our inserts

DECLARE @hinserts TABLE (
    salesrep_id int,
    salesrepgroup_id int,
    zipcode_id nvarchar(100)
    )

INSERT INTO @hinserts    
SELECT
    hreps.salesrep_id,
    4,
    zipcode.id
FROM
    hologic_sales_reps
INNER JOIN
    zipcode
ON
    cast(zipcode.zipcode as nvarchar(5)) = cast(hologic_sales_reps.zip as nvarchar(5))
INNER JOIN
    @hreps as hreps
ON
    hologic_sales_reps.first = hreps.first AND hologic_sales_reps.last = hreps.last

-- insert into the actual table

INSERT INTO salesrep_to_zipcode (salesrep_id, salesrepgroup_id, zipcode_id)
SELECT * FROM @hinserts

--- Add in missing Products


DECLARE @psnameids TABLE (
    id int
    )


INSERT INTO @psnameids
SELECT 
    id
FROM
    productservicename
WHERE
    name IN (
'APTIMA COMBO 2 Assay',
'APTIMA CT Assay',
'APTIMA GC Assay',
'APTIMA HPV Assay',
'APTIMA Specimen Transfer Kit for use with Liquid Pap Specimens',
'APTIMA Unisex Swab Specimen Collection Kit for Endovervical and Male Urethral Swab Specimens',
'APTIMA Urine Specimen Collection Kit for Male and Female Urine Specimens',
'APTIMA Vaginal Swab Specimen Collection Kit',
'Pace 2 CT',
'Pace 2 CT PCA',
'Pace 2 CT/GC',
'Pace 2 GC',
'Pace 2 GC PCA',
'APTIMA Trichomonas vaginalis',
'APTIMA COMBO 2 Assay',
'APTIMA CT Assay',
'APTIMA GC Assay',
'APTIMA Specimen Transfer Kit for use with Liquid Pap Specimens',
'APTIMA Unisex Swab Specimen Collection Kit for Endovervical and Male Urethral Swab Specimens',
'APTIMA Urine Specimen Collection Kit for Male and Female Urine Specimens',
'APTIMA Vaginal Swab Specimen Collection Kit',
'APTIMA Trichomonas vaginalis',
'APTIMA HPV Assay',
'Pace 2 CT',
'Pace 2 CT PCA',
'Pace 2 CT/GC',
'Pace 2 GC',
'Pace 2 GC PCA')
    
DELETE FROM salesrepgroup_to_productservicename WHERE productservicename_id IN (
    SELECT 
        id 
    FROM 
        @psnameids
    ) AND salesrepgroup_id = 1

SELECT
    *
FROM
    salesrepgroup_to_productservicename as stp
INNER JOIN
	productservicename
ON
	stp.productservicename_id = productservicename.id    
WHERE
    stp.salesrepgroup_id = 4
    AND
    stp.productservicename_id IN (SELECT id FROM @psnameids)
    
    INSERT INTO salesrepgroup_to_productservicename (salesrepgroup_id,productservicename_id)
    SELECT 4, id FROM @psnameids
    
    
-- Check if all zipcodes are added

DECLARE @zips TABLE (
    zipcode nvarchar(5)
    ) 

INSERT INTO @zips
SELECT 
    zip 
FROM
    hologic_sales_reps
    
    
SELECT 
    *
FROM
    @zips as z
WHERE
    z.zipcode NOT IN (
        SELECT 
            zipcode.zipcode
        FROM
            salesrep_to_zipcode
        INNER JOIN
            zipcode
        ON
            salesrep_to_zipcode.zipcode_id = zipcode.id
        )
   
   

DECLARE @zips TABLE (
    zipcode nvarchar(5)
    ) 

INSERT INTO @zips
SELECT 
    zip 
FROM
    hologic_sales_reps
   
DECLARE @newzips TABLE (
    zipcode nvarchar(5)
    )        
       
INSERT INTO @newzips
SELECT
    zipcode.zipcode
FROM
    zipcode
INNER JOIN
    salesrep_to_zipcode
ON
    salesrep_to_zipcode.zipcode_id = zipcode.id   
WHERE
     salesrep_to_zipcode.salesrepgroup_id = 4

SELECT 
    *
FROM
    @zips as z
WHERE
    z.zipcode NOT IN (SELECT nz.zipcode FROM @newzips as nz)