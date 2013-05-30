DECLARE @tbl3 Table (
	id int,
	facility varchar(255),
	person varchar(255),
	addressline1 varchar(255),
	addressline2 varchar(255),
	addressline3 varchar(255),
	phone1 varchar(255),
	phone2 varchar(255),
	phone3 varchar(255),
	fax1 varchar(255),
	fax2 varchar(255),
	email varchar(255),
	website varchar(255),
	processed bit
)

INSERT INTO @tbl3 (id, facility, person, addressline1, addressline2, addressline3, phone1, phone2, phone3, fax1, fax2, email, website, processed)
SELECT
	MIN(cu_locations.location_id),
	MIN(cu_locations.locationname),
	MIN(cu_locations.contactname),
	MIN(cu_locations.addressline1),
	MIN(cu_locations.addressline2),
	MIN(cu_locations.addressline3),
	MIN(cu_locations.phone1),
	MIN(cu_locations.phone2),
	MIN(cu_locations.phone3),
	MIN(cu_locations.fax1),
	MIN(cu_locations.fax2),
	MIN(cu_locations.email),
	MIN(cu_locations.website),
	0
FROM
	genpro03.dbo.cu_locations as cu_locations
INNER JOIN
	contact
ON
	cu_locations.location_id = contact.ref_id
WHERE
	contact.id in (
		SELECT contact_id 
		FROM informationtype_productservicetype_productservicename_location_to_contact
		UNION ALL
		SELECT contact_id
		FROM informationtype_productserviceline_productservicename_location_to_contact
	)
GROUP BY
	cu_locations.location_id


DECLARE @tbl4 Table (
	id int,
	facility varchar(255),
	person varchar(255),
	addressline1 varchar(255),
	addressline2 varchar(255),
	addressline3 varchar(255),
	phone1 varchar(255),
	phone2 varchar(255),
	phone3 varchar(255),
	fax1 varchar(255),
	fax2 varchar(255),
	email varchar(255),
	website varchar(255),
	processed bit
)

INSERT INTO @tbl4 (id, facility, person, addressline1, addressline2, addressline3, phone1, phone2, phone3, fax1, fax2, email, website, processed)
SELECT
	contact.ref_id as id,
	-- Facility
	(
	SELECT 
		name 
	FROM 
		facility 
	INNER JOIN 
		contact_to_facility 
	ON
		facility.id = contact_to_facility.facility_id
	WHERE
		contact_to_facility.contact_id = contact.id
	) as facility,
	-- Person
	(
	SELECT 
		name 
	FROM 
		person 
	INNER JOIN 
		contact_to_person 
	ON
		person.id = contact_to_person.person_id
	WHERE
		contact_to_person.contact_id = contact.id
	) as person,
	-- Address 1
	(
	SELECT 
		address 
	FROM 
		address 
	INNER JOIN 
		contact_to_address 
	ON
		address.id = contact_to_address.address_id
	WHERE
		contact_to_address.contact_id = contact.id
		AND
		contact_to_address.item_order = 1
	) as addressline1,
	-- Address 2
	(
	SELECT 
		address 
	FROM 
		address 
	INNER JOIN 
		contact_to_address 
	ON
		address.id = contact_to_address.address_id
	WHERE
		contact_to_address.contact_id = contact.id
		AND
		contact_to_address.item_order = 2
	) as addressline2,
	-- Address 3
	(
	SELECT 
		address 
	FROM 
		address 
	INNER JOIN 
		contact_to_address 
	ON
		address.id = contact_to_address.address_id
	WHERE
		contact_to_address.contact_id = contact.id
		AND
		contact_to_address.item_order = 3
	) as addressline3,	
	-- Phone1
	(
	SELECT 
		number
	FROM 
		phone 
	INNER JOIN 
		contact_to_phone
	ON
		phone.id = contact_to_phone.phone_id
	WHERE
		contact_to_phone.contact_id = contact.id
		AND
		contact_to_phone.item_order = 1
	) as phone1,
	-- Phone2
	(
	SELECT 
		number
	FROM 
		phone 
	INNER JOIN 
		contact_to_phone
	ON
		phone.id = contact_to_phone.phone_id
	WHERE
		contact_to_phone.contact_id = contact.id
		AND
		contact_to_phone.item_order = 2
	) as phone2,
	-- Phone3
	(
	SELECT 
		number
	FROM 
		phone 
	INNER JOIN 
		contact_to_phone
	ON
		phone.id = contact_to_phone.phone_id
	WHERE
		contact_to_phone.contact_id = contact.id
		AND
		contact_to_phone.item_order = 3
	) as phone3,
	-- Fax1
	(
	SELECT 
		number
	FROM 
		fax 
	INNER JOIN 
		contact_to_fax
	ON
		fax.id = contact_to_fax.fax_id
	WHERE
		contact_to_fax.contact_id = contact.id
		AND
		contact_to_fax.item_order = 1
	) as fax1,
	-- Fax2
	(
	SELECT 
		number
	FROM 
		fax 
	INNER JOIN 
		contact_to_fax
	ON
		fax.id = contact_to_fax.fax_id
	WHERE
		contact_to_fax.contact_id = contact.id
		AND
		contact_to_fax.item_order = 2
	) as fax2,
	-- Email
	(
	SELECT 
		email
	FROM 
		email
	INNER JOIN 
		contact_to_email
	ON
		email.id = contact_to_email.email_id
	WHERE
		contact_to_email.contact_id = contact.id
	) as email,	
	-- Email
	(
	SELECT 
		url
	FROM 
		website
	INNER JOIN 
		contact_to_website
	ON
		website.id = contact_to_website.website_id
	WHERE
		contact_to_website.contact_id = contact.id
	) as website,
	-- Processed
	0		
FROM
	@tbl3 as tbl3
INNER JOIN
	contact
ON
	contact.ref_id = tbl3.id
	

-- Vars
Declare @Id int
Declare @facilityVal varchar(255)
Declare @personVal varchar(255)
Declare @addressline1Val varchar(255)
Declare @addressline2Val varchar(255)
Declare @addressline3Val varchar(255)
Declare @phone1Val varchar(255)
Declare @phone2Val varchar(255)
Declare @phone3Val varchar(255)
Declare @fax1Val varchar(255)
Declare @fax2Val varchar(255)
Declare @emailVal varchar(255)
Declare @websiteVal varchar(255)

-- For our inserts
Declare @contactLabel varchar(255)
Declare @contactId int

Declare @facility varchar(255)
Declare @facilityId int
Declare @facilityError int

Declare @person varchar(255)
Declare @personId int
Declare @personError int

Declare @address1 varchar(255)
Declare @address1Id int
Declare @address1Error int

Declare @address2 varchar(255)
Declare @address2Id int
Declare @address2Error int

Declare @address3 varchar(255)
Declare @address3Id int
Declare @address3Error int

Declare @phone1 varchar(255)
Declare @phone1Id int
Declare @phone1Error int

Declare @phone2 varchar(255)
Declare @phone2Id int
Declare @phone2Error int

Declare @phone3 varchar(255)
Declare @phone3Id int
Declare @phone3Error int

Declare @fax1 varchar(255)
Declare @fax1Id int
Declare @fax1Error int

Declare @fax2 varchar(255)
Declare @fax2Id int
Declare @fax2Error int

Declare @email varchar(255)
Declare @emailId int
Declare @emailError int

Declare @website varchar(255)
Declare @websiteId int
Declare @websiteError int


-- start to loop through the unprocessed:
WHILE EXISTS ( SELECT * FROM @tbl4 WHERE Processed = 0)
BEGIN   --Get the Id of the first row
       	SELECT Top 1 @Id = id FROM @tbl4 WHERE Processed = 0
                 
        -- Set and reset our variables
        SET @contactLabel = @facility
        
        SELECT @contactId = id FROM contact WHERE ref_id = @Id
        
        SET @facility = Null
        SET @facilityId = Null
        SET @facilityError = Null
        
        SET @person = Null
        SET @personId = Null
        SET @personError = Null
        
        SET @address1 = Null
        SET @address1Id = Null
        SET @address1Error = Null
        
        SET @address2 = Null
        SET @address2Id = Null
        SET @address2Error = Null
        
        SET @address3 = Null
        SET @address3Id = Null
        SET @address3Error = Null
        
        SET @phone1 = Null
        SET @phone1Id = Null
        SET @phone1Error = Null
        
        SET @phone2 = Null
        SET @phone2Id = Null
        SET @phone2Error = Null
        
        SET @phone3 = Null
        SET @phone3Id = Null
        SET @phone3Error = Null
        
        SET @fax1 = Null
        SET @fax1id = Null
        SET @fax1Error = Null

        SET @fax2 = Null
        SET @fax2id = Null
        SET @fax2Error = Null
        
        SET @email = Null
        SET @emailId = Null
        SET @emailError = Null
        
        SET @website = Null
        SET @websiteId = Null
        SET @websiteError = Null
        
        -- Conditional statements below
        
        -- Facility
        SELECT @facilityVal = facility FROM @tbl4 WHERE id = @Id
        IF(@facilityVal IS NULL )
        	BEGIN
        		SELECT
        			@facility = facility
        		FROM
        			@tbl3 as tbl3
        		WHERE
        			tbl3.id = @Id

        	END

		-- Person
        SELECT @personVal = person FROM @tbl4 WHERE id = @Id
        IF(@personVal IS NULL )
        	BEGIN
        		SELECT
        			@person = person
        		FROM
        			@tbl3 as tbl3
        		WHERE
        			tbl3.id = @Id
        	END
 
 		-- Addressline1
        SELECT @addressline1Val = addressline1 FROM @tbl4 WHERE id = @Id
        IF(@addressline1Val IS NULL )
        	BEGIN
        		SELECT
        			@address1 = addressline1
        		FROM
        			@tbl3 as tbl3
        		WHERE
        			tbl3.id = @Id
        	END
        	
 		-- Addressline2
        SELECT @addressline2Val = addressline2 FROM @tbl4 WHERE id = @Id
        IF(@addressline2Val IS NULL )
        	BEGIN
        		SELECT
        			@address2 = addressline2
        		FROM
        			@tbl3 as tbl3
        		WHERE
        			tbl3.id = @Id
        	END        	
 
  		-- Addressline3
        SELECT @addressline3Val = addressline3 FROM @tbl4 WHERE id = @Id
        IF(@addressline3Val IS NULL )
        	BEGIN
        		SELECT
        			@address3 = addressline3
        		FROM
        			@tbl3 as tbl3
        		WHERE
        			tbl3.id = @Id
        	END   
 
   		-- Phone1
        SELECT @phone1Val = phone1 FROM @tbl4 WHERE id = @Id
        IF(@phone1Val IS NULL )
        	BEGIN
        		SELECT
        			@phone1 = phone1
        		FROM
        			@tbl3 as tbl3
        		WHERE
        			tbl3.id = @Id
        	END 

   		-- Phone2
        SELECT @phone2Val = phone2 FROM @tbl4 WHERE id = @Id
        IF(@phone2Val IS NULL )
        	BEGIN
        		SELECT
        			@phone2 = phone2
        		FROM
        			@tbl3 as tbl3
        		WHERE
        			tbl3.id = @Id
        	END  
 
  		-- Fax1
        SELECT @fax1Val = fax1 FROM @tbl4 WHERE id = @Id
        IF(@fax1Val IS NULL )
        	BEGIN
        		SELECT
        			@fax1 = fax1
        		FROM
        			@tbl3 as tbl3
        		WHERE
        			tbl3.id = @Id
        	END 
        	
  		-- Fax2
        SELECT @fax2Val = fax2 FROM @tbl4 WHERE id = @Id
        IF(@fax2Val IS NULL)
        	BEGIN
        		SELECT
        			@fax2 = fax2
        		FROM
        			@tbl3 as tbl3
        		WHERE
        			tbl3.id = @Id
        	END         	
 
  		-- Email
        SELECT @emailVal = email FROM @tbl4 WHERE id = @Id
        IF(@emailVal IS NULL)
        	BEGIN
        	    SELECT
        			@email = email
        		FROM
        			@tbl3 as tbl3
        		WHERE
        			tbl3.id = @Id
        	END  
 
   		-- Website
        SELECT @websiteVal = website FROM @tbl4 WHERE id = @Id
        IF(@websiteVal IS NULL)
        	BEGIN
        		SELECT
        			@website = website
        		FROM
        			@tbl3 as tbl3
        		WHERE
        			tbl3.id = @Id
        	END 
 
 		-- Do our inserts here
 		
		IF (@contactId is NULL)
			BEGIN
			INSERT INTO contact (label) VALUES (@contactLabel)
			SET @contactId = @@IDENTITY
			END
		
		IF (@facilityId is NULL and @facility is not NULL and rtrim(@facility) != '' )
			BEGIN
			INSERT INTO facility (name) VALUES (@facility)
			SET @facilityId = @@IDENTITY
			END
		IF (@facilityId is not NULL)
			BEGIN
			INSERT INTO contact_to_facility (contact_id, facility_id, item_order) VALUES (@contactId, @facilityId, 1)
			SET @facilityError = @@ERROR
			END
		
		
		IF (@personId is NULL and @person is not NULL and rtrim(@person) != '')
			BEGIN
			INSERT INTO person (name) VALUES (@person)
			SET @personId = @@IDENTITY
			END
		IF (@personId is not NULL)
			BEGIN
			INSERT INTO contact_to_person (contact_id, person_id, item_order) VALUES (@contactId, @personId, 1)
			SET @personError = @@ERROR
			END
		
		IF (@address1Id is NULL and @address1 is not NULL and rtrim(@address1) != '')
			BEGIN
			INSERT INTO address (address) VALUES (@address1)
			SET @address1Id = @@IDENTITY
			END
		IF (@address1Id is not NULL)
			BEGIN
			INSERT INTO contact_to_address (contact_id, address_id, item_order) VALUES (@contactId, @address1Id, 1)
			SET @address1Error = @@ERROR
			END
		
		IF (@address2Id is NULL and @address2 is not NULL and rtrim(@address2) != '')
			BEGIN
			INSERT INTO address (address) VALUES (@address2)
			SET @address2Id = @@IDENTITY
			END
		IF (@address2Id is not NULL)
			BEGIN
			INSERT INTO contact_to_address (contact_id, address_id, item_order) VALUES (@contactId, @address2Id, 2)
			SET @address2Error = @@ERROR
			END
		
		IF (@address3Id is NULL and @address3 is not NULL and rtrim(@address3) != '')
			BEGIN
			INSERT INTO address (address) VALUES (@address3)
			SET @address3Id = @@IDENTITY
			END
		IF (@address3Id is not NULL)
			BEGIN
			INSERT INTO contact_to_address (contact_id, address_id, item_order) VALUES (@contactId, @address3Id, 3)
			SET @address3Error = @@ERROR
			END
		
		IF (@phone1Id is NULL and @phone1 is not NULL and rtrim(@phone1) != '')
			BEGIN
			INSERT INTO phone (number) VALUES (@phone1)
			SET @phone1Id = @@IDENTITY
			END
		IF (@phone1Id is not NULL)
			BEGIN
			INSERT INTO contact_to_phone (contact_id, phone_id, item_order) VALUES (@contactId, @phone1Id, 1)
			SET @phone1Error = @@ERROR
			END
		
		IF (@phone2Id is NULL and @phone2 is not NULL and rtrim(@phone2) != '')
			BEGIN
			INSERT INTO phone (number) VALUES (@phone2)
			SET @phone2Id = @@IDENTITY
			END
		IF (@phone2Id is not NULL)
			BEGIN
			INSERT INTO contact_to_phone (contact_id, phone_id, item_order) VALUES (@contactId, @phone2Id, 2)
			SET @phone2Error = @@ERROR
			END

		IF (@phone3Id is NULL and @phone3 is not NULL and rtrim(@phone3) != '')
			BEGIN
			INSERT INTO phone (number) VALUES (@phone3)
			SET @phone3Id = @@IDENTITY
			END
		IF (@phone3Id is not NULL)
			BEGIN
			INSERT INTO contact_to_phone (contact_id, phone_id, item_order) VALUES (@contactId, @phone3Id, 3)
			SET @phone3Error = @@ERROR
			END
		
		IF (@fax1Id is NULL and @fax1 is not NULL and rtrim(@fax1) != '')
			BEGIN
			INSERT INTO fax (number) VALUES (@fax1)
			SET @fax1Id = @@IDENTITY
			END
		IF (@fax1Id is not NULL)
			BEGIN
			INSERT INTO contact_to_fax (contact_id, fax_id, item_order) VALUES (@contactId, @fax1Id, 1)
			SET @fax1Error = @@ERROR
			END
		
		IF (@fax2Id is NULL and @fax2 is not NULL and rtrim(@fax2) != '')
			BEGIN
			INSERT INTO fax (number) VALUES (@fax2)
			SET @fax2Id = @@IDENTITY
			END
		IF (@fax2Id is not NULL)
			BEGIN
			INSERT INTO contact_to_fax (contact_id, fax_id, item_order) VALUES (@contactId, @fax2Id, 2)
			SET @fax2Error = @@ERROR
			END
		
		IF (@emailId is NULL and @email is not NULL and rtrim(@email) != '')
			BEGIN
			INSERT INTO email (email) VALUES (@email)
			SET @emailId = @@IDENTITY
			END
		IF (@emailId is not NULL)
			BEGIN
			INSERT INTO contact_to_email (contact_id, email_id, item_order) VALUES (@contactId, @emailId, 1)
			SET @emailError = @@ERROR
			END
		
		IF (@websiteId is NULL and @website is not NULL and rtrim(@website) != '')
			BEGIN
			INSERT INTO website (url) VALUES (@website)
			SET @websiteId = @@IDENTITY
			END
		IF (@websiteId is not NULL)
			BEGIN
			INSERT INTO contact_to_website (contact_id, website_id, item_order) VALUES (@contactId, @websiteId, 1)
			SET @websiteError = @@ERROR
			END 		

        
        UPDATE @tbl4 SET Processed = 1 WHERE id = @Id
END	

SELECT MIN(TableName) as TableName, id, facility, person, addressline1, addressline2, addressline3, phone1, phone2, phone3, fax1, fax2, email, website
FROM
(
  SELECT 'cu_locations' as TableName, id, facility, person, addressline1, addressline2, addressline3, phone1, phone2, phone3, fax1, fax2, email, website
  FROM @tbl3
  UNION ALL
  SELECT 'contactus' as TableName, id, facility, person, addressline1, addressline2, addressline3, phone1, phone2, phone3, fax1, fax2, email, website
  FROM @tbl4
) tmp
GROUP BY id, facility, person, addressline1, addressline2, addressline3, phone1, phone2, phone3, fax1, fax2, email, website
HAVING COUNT(*) = 1
ORDER BY ID