select salesrep from zipgplist where salesrep not in (
	select salesrep.person from salesrep
) 

select zipcode from zipgplist where zipcode not in (
	select zipcode.zipcode from zipcode
)

-- compare and update / insert

DECLARE @tbl Table (
	salesrep varchar(255),
	zipcode int
)

INSERT INTO @tbl
SELECT 
	salesrep.person,
	zipcode.zipcode
FROM
	salesrep_to_zipcode
INNER JOIN
	salesrep
ON
	salesrep.id = salesrep_to_zipcode.salesrep_id
INNER JOIN
	zipcode
ON
	zipcode.id = salesrep_to_zipcode.zipcode_id
WHERE
	salesrep_to_zipcode.salesrepgroup_id = 1
	

DECLARE @tbl2 Table (
	salesrep varchar(255),
	zipcode int,
	processed bit
)

INSERT INTO @tbl2 	
SELECT salesrep, zipcode, 0
FROM
(
  SELECT 'Table A' as TableName, t1.salesrep, t1.zipcode
  FROM @tbl AS t1
  UNION ALL
  SELECT 'Table B' as TableName, t2.salesrep, t2.zipcode
  FROM zipgplist as t2
) tmp
GROUP BY salesrep, zipcode
HAVING COUNT(*) = 1
ORDER BY salesrep, zipcode

-- Delete the zips so we can just insert (avoid duplication)
DELETE FROM
	salesrep_to_zipcode
WHERE
	salesrepgroup_id = 1
	AND
	zipcode_id in (
		SELECT 
			zipcode.id
		FROM
			@tbl2 as t
		INNER JOIN
			zipcode
		ON
			t.zipcode = zipcode.zipcode
	)

Declare @zipcode int
Declare @salesrep varchar(255)
Declare @zipcode_id int
Declare @salesrep_id int

Declare @has_match bit

-- start to loop through the unprocessed:
WHILE EXISTS ( SELECT * FROM @tbl2 WHERE processed = 0)
BEGIN   --Get the Id of the first row
       	SELECT Top 1 @zipcode = zipcode, @salesrep = salesrep FROM @tbl2 WHERE processed= 0
                 
        --do processing here
        
        -- Set zipcode_id
		SELECT
			@zipcode_id = id
		FROM
			zipcode
		WHERE
			zipcode.zipcode = @zipcode
	
		-- Set salesrep_id
		SELECT
			@salesrep_id = id
		FROM
			salesrep
		WHERE
			salesrep.person = @salesrep	
        
   	 	-- Insert
   	 	INSERT INTO 
   	 		salesrep_to_zipcode
   	 		(salesrepgroup_id, salesrep_id, zipcode_id)
   	 	VALUES
   	 		(1, @salesrep_id, @zipcode_id)
        	 		 
        
        UPDATE @tbl2 SET processed = 1 WHERE zipcode = @zipcode
        SET @has_match = NULL
END;
