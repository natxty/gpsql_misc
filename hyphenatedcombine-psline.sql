DECLARE @tbl Table (
	informationtype_productserviceline_productservicename_to_location_id int, 
	informationtype_productserviceline_productservicename_id int, 
	location_id int, 
	informationtype_productserviceline_productservicename_location_to_contact_id int, 
	informationtype_productserviceline_productservicename_location_id int, 
	contact_id int,
	processed bit
)

INSERT INTO @tbl
SELECT 
	informationtype_productserviceline_productservicename_to_location.id 
		as informationtype_productserviceline_productservicename_to_location_id,
	informationtype_productserviceline_productservicename_to_location.informationtype_productserviceline_productservicename_id,
	informationtype_productserviceline_productservicename_to_location.location_id,
	informationtype_productserviceline_productservicename_location_to_contact.id
		as informationtype_productserviceline_productservicename_location_to_contact_id,
	informationtype_productserviceline_productservicename_location_to_contact.informationtype_productserviceline_productservicename_location_id,
	informationtype_productserviceline_productservicename_location_to_contact.contact_id,
	0
FROM
	informationtype_productserviceline_productservicename_to_location
INNER JOIN
	informationtype_productserviceline_productservicename_location_to_contact
ON
	informationtype_productserviceline_productservicename_to_location.id = 
		informationtype_productserviceline_productservicename_location_to_contact.informationtype_productserviceline_productservicename_location_id
INNER JOIN
	location
ON
	location.id = informationtype_productserviceline_productservicename_to_location.location_id
WHERE
	location_id in 
		(select id from location where name like '%-%' and name not like '%Gen-Probe%' and name !='Benelux-France')
ORDER BY 
	informationtype_productserviceline_productservicename_to_location.informationtype_productserviceline_productservicename_id

DECLARE @tbl2 Table (
	contact_id int
)

Declare @id int
Declare @idt int

-- start to loop through the unprocessed:
WHILE EXISTS ( SELECT informationtype_productserviceline_productservicename_id FROM @tbl WHERE processed = 0 GROUP BY informationtype_productserviceline_productservicename_id)
BEGIN   --Get the Id of the first row
       	SELECT Top 1 @id = informationtype_productserviceline_productservicename_id FROM @tbl WHERE processed= 0 GROUP BY informationtype_productserviceline_productservicename_id                 


		-- autria
		INSERT INTO @tbl2
		select contact_id from @tbl where location_id in (11,12) and informationtype_productserviceline_productservicename_id = @id
		
		IF EXISTS(select * from @tbl2)
		BEGIN
		
			DELETE
			FROM 
				informationtype_productserviceline_productservicename_to_location 
			WHERE 
				id 
			IN (
				 SELECT 
				 	informationtype_productserviceline_productservicename_to_location_id 
				 FROM 
				 	@tbl 
				 WHERE 
				 	location_id IN (11,12) 
				 	AND 
				 	informationtype_productserviceline_productservicename_id = @id 
				 )
				 
			
			DELETE
			FROM 
				informationtype_productserviceline_productservicename_location_to_contact
			WHERE 
				id 
			IN (
				 SELECT 
				 	informationtype_productserviceline_productservicename_location_to_contact_id 
				 FROM 
				 	@tbl 
				 WHERE 
				 	location_id IN (11,12) 
				 	AND 
				 	informationtype_productserviceline_productservicename_id = @id 
				 )
				 
			INSERT INTO informationtype_productserviceline_productservicename_to_location (informationtype_productserviceline_productservicename_id, location_id)
			VALUES (@id, 10)
			
			SET @idt = @@IDENTITY
			
			INSERT INTO informationtype_productserviceline_productservicename_location_to_contact (informationtype_productserviceline_productservicename_location_id, contact_id)
			SELECT 
				@idt, contact_id
			FROM
				@tbl2
				
			DELETE FROM @tbl2
			
		END	
		
		
		-- canada
		INSERT INTO @tbl2
		select contact_id from @tbl where location_id in (26,27,28,29) and informationtype_productserviceline_productservicename_id = @id
		
		IF EXISTS(select * from @tbl2)
		BEGIN
		
			DELETE
			FROM 
				informationtype_productserviceline_productservicename_to_location 
			WHERE 
				id 
			IN (
				 SELECT 
				 	informationtype_productserviceline_productservicename_to_location_id 
				 FROM 
				 	@tbl 
				 WHERE 
				 	location_id IN (26,27,28,29) 
				 	AND 
				 	informationtype_productserviceline_productservicename_id = @id 
				 )
				 
			
			DELETE
			FROM 
				informationtype_productserviceline_productservicename_location_to_contact
			WHERE 
				id 
			IN (
				 SELECT 
				 	informationtype_productserviceline_productservicename_location_to_contact_id 
				 FROM 
				 	@tbl 
				 WHERE 
				 	location_id IN (26,27,28,29) 
				 	AND 
				 	informationtype_productserviceline_productservicename_id = @id 
				 )
				 
			INSERT INTO informationtype_productserviceline_productservicename_to_location (informationtype_productserviceline_productservicename_id, location_id)
			VALUES (@id, 25)
			
			SET @idt = @@IDENTITY
			
			INSERT INTO informationtype_productserviceline_productservicename_location_to_contact (informationtype_productserviceline_productservicename_location_id, contact_id)
			SELECT 
				@idt, contact_id
			FROM
				@tbl2
				
			DELETE FROM @tbl2
			
		END	
		
		-- estonia
		INSERT INTO @tbl2
		select contact_id from @tbl where location_id in (47,48) and informationtype_productserviceline_productservicename_id = @id

		IF EXISTS(select * from @tbl2)
		BEGIN
				
			DELETE
			FROM 
				informationtype_productserviceline_productservicename_to_location 
			WHERE 
				id 
			IN (
				 SELECT 
				 	informationtype_productserviceline_productservicename_to_location_id 
				 FROM 
				 	@tbl 
				 WHERE 
				 	location_id IN (47,48)
				 	AND 
				 	informationtype_productserviceline_productservicename_id = @id 
				 )
				 
			
			DELETE
			FROM 
				informationtype_productserviceline_productservicename_location_to_contact
			WHERE 
				id 
			IN (
				 SELECT 
				 	informationtype_productserviceline_productservicename_location_to_contact_id 
				 FROM 
				 	@tbl 
				 WHERE 
				 	location_id IN (47,48)
				 	AND 
				 	informationtype_productserviceline_productservicename_id = @id 
				 )
				 
			INSERT INTO informationtype_productserviceline_productservicename_to_location (informationtype_productserviceline_productservicename_id, location_id)
			VALUES (@id, 46)
			
			SET @idt = @@IDENTITY
			
			INSERT INTO informationtype_productserviceline_productservicename_location_to_contact (informationtype_productserviceline_productservicename_location_id, contact_id)
			SELECT 
				@@IDENTITY, contact_id
			FROM
				@tbl2
				
			DELETE FROM @tbl2	
				
		END
		
		-- finland
		INSERT INTO @tbl2
		select contact_id from @tbl where location_id in (53,54) and informationtype_productserviceline_productservicename_id = @id
		
		IF EXISTS(select * from @tbl2)
		BEGIN		
		
			DELETE
			FROM 
				informationtype_productserviceline_productservicename_to_location 
			WHERE 
				id 
			IN (
				 SELECT 
				 	informationtype_productserviceline_productservicename_to_location_id 
				 FROM 
				 	@tbl 
				 WHERE 
				 	location_id IN (53,54)
				 	AND 
				 	informationtype_productserviceline_productservicename_id = @id 
				 )
				 
			
			DELETE
			FROM 
				informationtype_productserviceline_productservicename_location_to_contact
			WHERE 
				id 
			IN (
				 SELECT 
				 	informationtype_productserviceline_productservicename_location_to_contact_id 
				 FROM 
				 	@tbl 
				 WHERE 
				 	location_id IN (53,54)
				 	AND 
				 	informationtype_productserviceline_productservicename_id = @id 
				 )
				 
			INSERT INTO informationtype_productserviceline_productservicename_to_location (informationtype_productserviceline_productservicename_id, location_id)
			VALUES (@id, 52)
			
			SET @idt = @@IDENTITY
			
			INSERT INTO informationtype_productserviceline_productservicename_location_to_contact (informationtype_productserviceline_productservicename_location_id, contact_id)
			SELECT 
				@idt, contact_id
			FROM
				@tbl2
				
			DELETE FROM @tbl2
					
		END
		
		-- turkey
		INSERT INTO @tbl2
		select contact_id from @tbl where location_id in (168,169) and informationtype_productserviceline_productservicename_id = @id

		IF EXISTS(select * from @tbl2)
		BEGIN		
		
			DELETE
			FROM 
				informationtype_productserviceline_productservicename_to_location 
			WHERE 
				id 
			IN (
				 SELECT 
				 	informationtype_productserviceline_productservicename_to_location_id 
				 FROM 
				 	@tbl 
				 WHERE 
				 	location_id IN (168,169)
				 	AND 
				 	informationtype_productserviceline_productservicename_id = @id 
				 )
				 
			
			DELETE
			FROM 
				informationtype_productserviceline_productservicename_location_to_contact
			WHERE 
				id 
			IN (
				 SELECT 
				 	informationtype_productserviceline_productservicename_location_to_contact_id 
				 FROM 
				 	@tbl 
				 WHERE 
				 	location_id IN (168,169)
				 	AND 
				 	informationtype_productserviceline_productservicename_id = @id 
				 )
				 
			INSERT INTO informationtype_productserviceline_productservicename_to_location (informationtype_productserviceline_productservicename_id, location_id)
			VALUES (@id, 167)
			
			SET @idt = @@IDENTITY
			
			INSERT INTO informationtype_productserviceline_productservicename_location_to_contact (informationtype_productserviceline_productservicename_location_id, contact_id)
			SELECT 
				@idt, contact_id
			FROM
				@tbl2
				
			DELETE FROM @tbl2	
					
		END
		
		-- united kingdom
		INSERT INTO @tbl2
		select contact_id from @tbl where location_id in  (186,187,188,189) and informationtype_productserviceline_productservicename_id = @id

		IF EXISTS(select * from @tbl2)
		BEGIN	
			
			DELETE
			FROM 
				informationtype_productserviceline_productservicename_to_location 
			WHERE 
				id 
			IN (
				 SELECT 
				 	informationtype_productserviceline_productservicename_to_location_id 
				 FROM 
				 	@tbl 
				 WHERE 
				 	location_id IN  (186,187,188,189)
				 	AND 
				 	informationtype_productserviceline_productservicename_id = @id 
				 )
				 
			
			DELETE
			FROM 
				informationtype_productserviceline_productservicename_location_to_contact
			WHERE 
				id 
			IN (
				 SELECT 
				 	informationtype_productserviceline_productservicename_location_to_contact_id 
				 FROM 
				 	@tbl 
				 WHERE 
				 	location_id IN  (186,187,188,189)
				 	AND 
				 	informationtype_productserviceline_productservicename_id = @id 
				 )
				 
			INSERT INTO informationtype_productserviceline_productservicename_to_location (informationtype_productserviceline_productservicename_id, location_id)
			VALUES (@id, 185)
			
			SET @idt = @@IDENTITY
			
			INSERT INTO informationtype_productserviceline_productservicename_location_to_contact (informationtype_productserviceline_productservicename_location_id, contact_id)
			SELECT 
				@idt, contact_id
			FROM
				@tbl2
				
			DELETE FROM @tbl2	
					
		END
		
		-- korea
		INSERT INTO @tbl2
		select contact_id from @tbl where location_id in  (94,95,96,98) and informationtype_productserviceline_productservicename_id = @id

		IF EXISTS(select * from @tbl2)
		BEGIN		
		
			DELETE
			FROM 
				informationtype_productserviceline_productservicename_to_location 
			WHERE 
				id 
			IN (
				 SELECT 
				 	informationtype_productserviceline_productservicename_to_location_id 
				 FROM 
				 	@tbl 
				 WHERE 
				 	location_id IN  (94,95,96,98)
				 	AND 
				 	informationtype_productserviceline_productservicename_id = @id 
				 )
				 
			
			DELETE
			FROM 
				informationtype_productserviceline_productservicename_location_to_contact
			WHERE 
				id 
			IN (
				 SELECT 
				 	informationtype_productserviceline_productservicename_location_to_contact_id 
				 FROM 
				 	@tbl 
				 WHERE 
				 	location_id IN  (94,95,96,98)
				 	AND 
				 	informationtype_productserviceline_productservicename_id = @id 
				 )
				 
			INSERT INTO informationtype_productserviceline_productservicename_to_location (informationtype_productserviceline_productservicename_id, location_id)
			VALUES (@id, 97)
			
			SET @idt = @@IDENTITY
			
			INSERT INTO informationtype_productserviceline_productservicename_location_to_contact (informationtype_productserviceline_productservicename_location_id, contact_id)
			SELECT 
				@idt, contact_id
			FROM
				@tbl2
				
			DELETE FROM @tbl2
						
		END
		
		-- italy
		INSERT INTO @tbl2
		select contact_id from @tbl where location_id in (85,86) and informationtype_productserviceline_productservicename_id = @id

		IF EXISTS(select * from @tbl2)
		BEGIN		
		
			DELETE
			FROM 
				informationtype_productserviceline_productservicename_to_location 
			WHERE 
				id 
			IN (
				 SELECT 
				 	informationtype_productserviceline_productservicename_to_location_id 
				 FROM 
				 	@tbl 
				 WHERE 
				 	location_id IN  (85,86)
				 	AND 
				 	informationtype_productserviceline_productservicename_id = @id 
				 )
				 
			
			DELETE
			FROM 
				informationtype_productserviceline_productservicename_location_to_contact
			WHERE 
				id 
			IN (
				 SELECT 
				 	informationtype_productserviceline_productservicename_location_to_contact_id 
				 FROM 
				 	@tbl 
				 WHERE 
				 	location_id IN  (85,86)
				 	AND 
				 	informationtype_productserviceline_productservicename_id = @id 
				 )
				 
			INSERT INTO informationtype_productserviceline_productservicename_to_location (informationtype_productserviceline_productservicename_id, location_id)
			VALUES (@id, 84)
			
			SET @idt = @@IDENTITY
			
			INSERT INTO informationtype_productserviceline_productservicename_location_to_contact (informationtype_productserviceline_productservicename_location_id, contact_id)
			SELECT 
				@idt, contact_id
			FROM
				@tbl2
				
			DELETE FROM @tbl2	
					
		END
		
		-- hong kong
		INSERT INTO @tbl2
		select contact_id from @tbl where location_id in (74,75) and informationtype_productserviceline_productservicename_id = @id

		IF EXISTS(select * from @tbl2)
		BEGIN		
		
			DELETE
			FROM 
				informationtype_productserviceline_productservicename_to_location 
			WHERE 
				id 
			IN (
				 SELECT 
				 	informationtype_productserviceline_productservicename_to_location_id 
				 FROM 
				 	@tbl 
				 WHERE 
				 	location_id IN  (74,75)
				 	AND 
				 	informationtype_productserviceline_productservicename_id = @id 
				 )
				 
			
			DELETE
			FROM 
				informationtype_productserviceline_productservicename_location_to_contact
			WHERE 
				id 
			IN (
				 SELECT 
				 	informationtype_productserviceline_productservicename_location_to_contact_id 
				 FROM 
				 	@tbl 
				 WHERE 
				 	location_id IN  (74,75)
				 	AND 
				 	informationtype_productserviceline_productservicename_id = @id 
				 )
				 
			INSERT INTO informationtype_productserviceline_productservicename_to_location (informationtype_productserviceline_productservicename_id, location_id)
			VALUES (@id, 73)
			
			SET @idt = @@IDENTITY
			
			INSERT INTO informationtype_productserviceline_productservicename_location_to_contact (informationtype_productserviceline_productservicename_location_id, contact_id)
			SELECT 
				@idt, contact_id
			FROM
				@tbl2
				
			DELETE FROM @tbl2	
				
		END
		
		-- germany
		INSERT INTO @tbl2
		select contact_id from @tbl where location_id in (203,67,68) and informationtype_productserviceline_productservicename_id = @id

		IF EXISTS(select * from @tbl2)
		BEGIN	
			
			DELETE
			FROM 
				informationtype_productserviceline_productservicename_to_location 
			WHERE 
				id 
			IN (
				 SELECT 
				 	informationtype_productserviceline_productservicename_to_location_id 
				 FROM 
				 	@tbl 
				 WHERE 
				 	location_id IN (203,67,68)
				 	AND 
				 	informationtype_productserviceline_productservicename_id = @id 
				 )
				 
			
			DELETE
			FROM 
				informationtype_productserviceline_productservicename_location_to_contact
			WHERE 
				id 
			IN (
				 SELECT 
				 	informationtype_productserviceline_productservicename_location_to_contact_id 
				 FROM 
				 	@tbl 
				 WHERE 
				 	location_id IN (203,67,68)
				 	AND 
				 	informationtype_productserviceline_productservicename_id = @id 
				 )
				 
			INSERT INTO informationtype_productserviceline_productservicename_to_location (informationtype_productserviceline_productservicename_id, location_id)
			VALUES (@id, 65)
			
			SET @idt = @@IDENTITY
			
			INSERT INTO informationtype_productserviceline_productservicename_location_to_contact (informationtype_productserviceline_productservicename_location_id, contact_id)
			SELECT 
				@idt, contact_id
			FROM
				@tbl2
				
			DELETE FROM @tbl2
					
		END
		
		-- czech republic
		INSERT INTO @tbl2
		select contact_id from @tbl where location_id in (39,40) and informationtype_productserviceline_productservicename_id = @id

		IF EXISTS(select * from @tbl2)
		BEGIN		
		
			DELETE
			FROM 
				informationtype_productserviceline_productservicename_to_location 
			WHERE 
				id 
			IN (
				 SELECT 
				 	informationtype_productserviceline_productservicename_to_location_id 
				 FROM 
				 	@tbl 
				 WHERE 
				 	location_id IN (39,40) 
				 	AND 
				 	informationtype_productserviceline_productservicename_id = @id 
				 )
				 
			
			DELETE
			FROM 
				informationtype_productserviceline_productservicename_location_to_contact
			WHERE 
				id 
			IN (
				 SELECT 
				 	informationtype_productserviceline_productservicename_location_to_contact_id 
				 FROM 
				 	@tbl 
				 WHERE 
				 	location_id IN (39,40) 
				 	AND 
				 	informationtype_productserviceline_productservicename_id = @id 
				 )
				 
			INSERT INTO informationtype_productserviceline_productservicename_to_location (informationtype_productserviceline_productservicename_id, location_id)
			VALUES (@id, 38)
			
			SET @idt = @@IDENTITY
			
			INSERT INTO informationtype_productserviceline_productservicename_location_to_contact (informationtype_productserviceline_productservicename_location_id, contact_id)
			SELECT 
				@idt, contact_id
			FROM
				@tbl2
				
			DELETE FROM @tbl2
						
		END
		
		-- china
		INSERT INTO @tbl2
		select contact_id from @tbl where location_id in (32,33) and informationtype_productserviceline_productservicename_id = @id

		IF EXISTS(select * from @tbl2)
		BEGIN		
		
			DELETE
			FROM 
				informationtype_productserviceline_productservicename_to_location 
			WHERE 
				id 
			IN (
				 SELECT 
				 	informationtype_productserviceline_productservicename_to_location_id 
				 FROM 
				 	@tbl 
				 WHERE 
				 	location_id IN (32,33)
				 	AND 
				 	informationtype_productserviceline_productservicename_id = @id 
				 )
				 
			
			DELETE
			FROM 
				informationtype_productserviceline_productservicename_location_to_contact
			WHERE 
				id 
			IN (
				 SELECT 
				 	informationtype_productserviceline_productservicename_location_to_contact_id 
				 FROM 
				 	@tbl 
				 WHERE 
				 	location_id IN (32,33)
				 	AND 
				 	informationtype_productserviceline_productservicename_id = @id 
				 )
				 
			INSERT INTO informationtype_productserviceline_productservicename_to_location (informationtype_productserviceline_productservicename_id, location_id)
			VALUES (@id, 31)
			
			SET @idt = @@IDENTITY
			
			INSERT INTO informationtype_productserviceline_productservicename_location_to_contact (informationtype_productserviceline_productservicename_location_id, contact_id)
			SELECT 
				@idt, contact_id
			FROM
				@tbl2
				
			DELETE FROM @tbl2		
				       
       END 
        
		-- japan
		INSERT INTO @tbl2
		select contact_id from @tbl where location_id in (89) and informationtype_productserviceline_productservicename_id = @id

		IF EXISTS(select * from @tbl2)
		BEGIN		
		
			DELETE
			FROM 
				informationtype_productserviceline_productservicename_to_location 
			WHERE 
				id 
			IN (
				 SELECT 
				 	informationtype_productserviceline_productservicename_to_location_id 
				 FROM 
				 	@tbl 
				 WHERE 
				 	location_id IN (89)
				 	AND 
				 	informationtype_productserviceline_productservicename_id = @id 
				 )
				 
			
			DELETE
			FROM 
				informationtype_productserviceline_productservicename_location_to_contact
			WHERE 
				id 
			IN (
				 SELECT 
				 	informationtype_productserviceline_productservicename_location_to_contact_id 
				 FROM 
				 	@tbl 
				 WHERE 
				 	location_id IN (89)
				 	AND 
				 	informationtype_productserviceline_productservicename_id = @id 
				 )
				 
			INSERT INTO informationtype_productserviceline_productservicename_to_location (informationtype_productserviceline_productservicename_id, location_id)
			VALUES (@id, 88)
			
			SET @idt = @@IDENTITY
			
			INSERT INTO informationtype_productserviceline_productservicename_location_to_contact (informationtype_productserviceline_productservicename_location_id, contact_id)
			SELECT 
				@idt, contact_id
			FROM
				@tbl2
				
			DELETE FROM @tbl2		
				       
       END         
        
        UPDATE @tbl SET processed = 1 WHERE informationtype_productserviceline_productservicename_id = @id
END


