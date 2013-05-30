DECLARE @tbl Table (
	salesrepgroup_id int, 
	zipcode_id int,
	processed bit
)

INSERT INTO @tbl
SELECT
	salesrepgroup_id, zipcode_id, 0
FROM 
	salesrep_to_zipcode
GROUP BY
	salesrepgroup_id, zipcode_id
HAVING COUNT(*)>1

Declare @zipcode_id int
Declare @zipcode nvarchar(5)

DECLARE @tbl2 Table (
	id int,
	salesrepgroup_id int,
	salesrep_id int, 
	zipcode_id int
)

-- start to loop through the unprocessed:
WHILE EXISTS ( SELECT * FROM @tbl WHERE processed = 0)
BEGIN   
       	SELECT Top 1 @zipcode_id = zipcode_id FROM @tbl WHERE processed = 0
                 
        --do processing here
        
        INSERT INTO @tbl2
        SELECT 
        	*
        FROM
        	salesrep_to_zipcode
        WHERE
        	salesrep_id not in 
        	(
	        SELECT 
	        	id
	        FROM
	        	salesrep
	        WHERE
	        	person = (
		        SELECT Top 1
		        	contactname
		        FROM
		        	genpro03.dbo.cu_salesreps
		        WHERE
		        	genpro03.dbo.cu_salesreps.zipcode = (SELECT Top 1 zipcode FROM zipcode WHERE id = @zipcode_id)
		        )
		   	)
		   	AND
		   	salesrepgroup_id = (SELECT TOP 1 salesrepgroup_id FROM @tbl WHERE zipcode_id = @zipcode_id)
		   	AND
		   	zipcode_id = @zipcode_id   	
	        	       
        UPDATE @tbl SET processed = 1 WHERE zipcode_id = @zipcode_id
END

SELECT * FROM @tbl2