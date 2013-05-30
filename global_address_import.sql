DECLARE @c Table (
	id int NOT NULL IDENTITY(1,1), 
	facility_id int,
	phone_id int, 
	fax_id int,
	processed bit,
	contact_id int,
	PRIMARY KEY (id)
)

INSERT INTO @c (facility_id, phone_id, fax_id, processed, contact_id)
SELECT
	facility.id as facility_id, 
	phone.id as phone_id,
	fax.id as fax_id,
	0,
	NULL
FROM
	gl_locats_temp as tmp
INNER JOIN
	phone
ON
	tmp.phone = phone.number
INNER JOIN
	fax
ON
	tmp.fax = fax.number
INNER JOIN
	facility
ON
	facility.name = tmp.facility
	
Declare @Id int

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
WHILE EXISTS ( SELECT * FROM @c WHERE processed = 0)
BEGIN   --Get the Id of the first row
       	SELECT Top 1 @Id = id FROM @c WHERE processed = 0
                 
        SET @contactId = Null
        
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
        
		SELECT 
			@facilityId = facility_id,
			@phone1Id = phone_id,
			@fax1Id = fax_id
		FROM 
			@c
		WHERE
			id = @Id
			

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

        
        
        UPDATE @c SET processed = 1, contact_id = @contactId WHERE id = @Id
END	

SELECT * FROM @c