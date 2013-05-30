DECLARE @tbl Table (
	location varchar(255),
	facility varchar(255)
)

INSERT INTO  @tbl (location, facility)
SELECT
	cu_locations.dropdownname as location,
	cu_locations.locationname as facility
FROM 
	genpro03.dbo.cu_contacts as cu_contacts
INNER JOIN
	genpro03.dbo.cu_locations as cu_locations
ON
	cu_contacts.location_id = cu_locations.location_id
WHERE 
	cu_contacts.productservicename like 'Diaclone DIAplex' 
	AND 
	cu_contacts.informationtype = 'distributers'
	
	
DECLARE @tbl2 Table (
	facility varchar(255)
)

INSERT INTO @tbl2 (facility)
SELECT 
	tbl.facility
FROM
	@tbl as tbl
WHERE
	tbl.facility NOT IN (
		SELECT 
			facility.name 
		FROM 
			contact
		INNER JOIN
			contact_to_facility
		ON
			contact.id = contact_to_facility.contact_id
		INNER JOIN
			facility
		ON
			facility.id = contact_to_facility.facility_id
		)
GROUP BY
	tbl.facility


DECLARE @tbl3 Table (
	facility varchar(255),
	person varchar(255),
	addressline1 varchar(255),
	addressline2 varchar(255),
	addressline3 varchar(255),
	phone1 varchar(255),
	phone2 varchar(255),
	phone3 varchar(255),
	fax1 varchar(255),
	email varchar(255),
	website varchar(255),
	processed bit
)

INSERT INTO @tbl3 (facility, person, addressline1, addressline2, addressline3, phone1, phone2, phone3, fax1, email, website, processed)
SELECT
	cu_locations.locationname,
	MIN(cu_locations.contactname),
	MIN(cu_locations.addressline1),
	MIN(cu_locations.addressline2),
	MIN(cu_locations.addressline3),
	MIN(cu_locations.phone1),
	MIN(cu_locations.phone2),
	MIN(cu_locations.phone3),
	MIN(cu_locations.fax1),
	MIN(cu_locations.email),
	MIN(cu_locations.website),
	0
FROM
	genpro03.dbo.cu_locations as cu_locations
INNER JOIN
	@tbl2 as tbl2
ON
	cu_locations.locationname = tbl2.facility
GROUP BY
	cu_locations.locationname

-- START THIS CRAZINESS!!!

DECLARE @insert_errors Table (
	contactId int, 
	facilityError int,
	personError int,
	address1Error int,
	address2Error int,
	address3Error int,
	phone1Error int,
	phone2Error int,
	phone3Error int,
	fax1Error int,
	fax2Error int,
	emailError int,
	websiteError int 
)


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

DECLARE @processed bit

-- start to loop through the unprocessed:
WHILE EXISTS ( SELECT * FROM @tbl3 WHERE processed = 0)
BEGIN   --Get the Facility of the first row
       	SELECT Top 1 @facility = facility FROM @tbl3 WHERE processed = 0
        
        
        -- Set the rest of our variables
        SET @contactLabel = @facility
        
        SET @contactId = Null
        
        SET @facilityId = Null
        SET @facilityError = Null
        
        SET @personId = Null
        SET @personError = Null
        
        SET @address1Id = Null
        SET @address1Error = Null
        
        SET @address2Id = Null
        SET @address2Error = Null
        
        SET @address3Id = Null
        SET @address3Error = Null
        
        SET @phone1Id = Null
        SET @phone1Error = Null
        
        SET @phone2Id = Null
        SET @phone2Error = Null
        
        SET @phone3Id = Null
        SET @phone3Error = Null
        
        SET @fax1id = Null
        SET @fax1Error = Null
        
        SET @emailId = Null
        SET @emailError = Null
        
        SET @websiteId = Null
        SET @websiteError = Null
        
        SELECT
        	@person = person,
        	@address1 = addressline1,
        	@address2 = addressline2,
        	@address3 = addressline3,
        	@phone1 = phone1,
        	@phone2 = phone2,
        	@phone3 = phone3,
        	@fax1 = fax1,
        	@email = email,
        	@website = website
        FROM
        	@tbl3
        WHERE
        	facility = @facility
        	
        --do processing here
        /*
        SELECT 
        	@person as person, 
        	@address1 as address1, 
        	@address2 as address2, 
        	@address3 as address3, 
        	@phone1 as phone1, 
        	@phone2 as phone2, 
        	@phone3 as phone3, 
        	@fax1 as fax1, 
        	@email as email, 
        	@website as website
        */
        
		IF (@contactId is NULL)
			BEGIN
			INSERT INTO contact (label) VALUES (@contactLabel)
			SET @contactId = @@IDENTITY
			END
		
		IF (@facilityId is NULL and @facility is not NULL)
			BEGIN
			INSERT INTO facility (name) VALUES (@facility)
			SET @facilityId = @@IDENTITY
			END
		IF (@facilityId is not NULL)
			BEGIN
			INSERT INTO contact_to_facility (contact_id, facility_id, item_order) VALUES (@contactId, @facilityId, 1)
			SET @facilityError = @@ERROR
			END
		
		
		IF (@personId is NULL and @person is not NULL)
			BEGIN
			INSERT INTO person (name) VALUES (@person)
			SET @personId = @@IDENTITY
			END
		IF (@personId is not NULL)
			BEGIN
			INSERT INTO contact_to_person (contact_id, person_id, item_order) VALUES (@contactId, @personId, 1)
			SET @personError = @@ERROR
			END
		
		IF (@address1Id is NULL and @address1 is not NULL)
			BEGIN
			INSERT INTO address (address) VALUES (@address1)
			SET @address1Id = @@IDENTITY
			END
		IF (@address1Id is not NULL)
			BEGIN
			INSERT INTO contact_to_address (contact_id, address_id, item_order) VALUES (@contactId, @address1Id, 1)
			SET @address1Error = @@ERROR
			END
		
		IF (@address2Id is NULL and @address2 is not NULL)
			BEGIN
			INSERT INTO address (address) VALUES (@address2)
			SET @address2Id = @@IDENTITY
			END
		IF (@address2Id is not NULL)
			BEGIN
			INSERT INTO contact_to_address (contact_id, address_id, item_order) VALUES (@contactId, @address2Id, 2)
			SET @address2Error = @@ERROR
			END
		
		IF (@address3Id is NULL and @address3 is not NULL)
			BEGIN
			INSERT INTO address (address) VALUES (@address3)
			SET @address3Id = @@IDENTITY
			END
		IF (@address3Id is not NULL)
			BEGIN
			INSERT INTO contact_to_address (contact_id, address_id, item_order) VALUES (@contactId, @address3Id, 3)
			SET @address3Error = @@ERROR
			END
		
		IF (@phone1Id is NULL and @phone1 is not NULL)
			BEGIN
			INSERT INTO phone (number) VALUES (@phone1)
			SET @phone1Id = @@IDENTITY
			END
		IF (@phone1Id is not NULL)
			BEGIN
			INSERT INTO contact_to_phone (contact_id, phone_id, item_order) VALUES (@contactId, @phone1Id, 1)
			SET @phone1Error = @@ERROR
			END
		
		IF (@phone2Id is NULL and @phone2 is not NULL)
			BEGIN
			INSERT INTO phone (number) VALUES (@phone2)
			SET @phone2Id = @@IDENTITY
			END
		IF (@phone2Id is not NULL)
			BEGIN
			INSERT INTO contact_to_phone (contact_id, phone_id, item_order) VALUES (@contactId, @phone2Id, 2)
			SET @phone2Error = @@ERROR
			END

		IF (@phone3Id is NULL and @phone3 is not NULL)
			BEGIN
			INSERT INTO phone (number) VALUES (@phone3)
			SET @phone3Id = @@IDENTITY
			END
		IF (@phone3Id is not NULL)
			BEGIN
			INSERT INTO contact_to_phone (contact_id, phone_id, item_order) VALUES (@contactId, @phone3Id, 3)
			SET @phone3Error = @@ERROR
			END
		
		IF (@fax1Id is NULL and @fax1 is not NULL)
			BEGIN
			INSERT INTO fax (number) VALUES (@fax1)
			SET @fax1Id = @@IDENTITY
			END
		IF (@fax1Id is not NULL)
			BEGIN
			INSERT INTO contact_to_fax (contact_id, fax_id, item_order) VALUES (@contactId, @fax1Id, 1)
			SET @fax1Error = @@ERROR
			END
		
		IF (@fax2Id is NULL and @fax2 is not NULL)
			BEGIN
			INSERT INTO fax (number) VALUES (@fax2)
			SET @fax2Id = @@IDENTITY
			END
		IF (@fax2Id is not NULL)
			BEGIN
			INSERT INTO contact_to_fax (contact_id, fax_id, item_order) VALUES (@contactId, @fax2Id, 2)
			SET @fax2Error = @@ERROR
			END
		
		IF (@emailId is NULL and @email is not NULL)
			BEGIN
			INSERT INTO email (email) VALUES (@email)
			SET @emailId = @@IDENTITY
			END
		IF (@emailId is not NULL)
			BEGIN
			INSERT INTO contact_to_email (contact_id, email_id, item_order) VALUES (@contactId, @emailId, 1)
			SET @emailError = @@ERROR
			END
		
		IF (@websiteId is NULL and @website is not NULL)
			BEGIN
			INSERT INTO website (url) VALUES (@website)
			SET @websiteId = @@IDENTITY
			END
		IF (@websiteId is not NULL)
			BEGIN
			INSERT INTO contact_to_website (contact_id, website_id, item_order) VALUES (@contactId, @websiteId, 1)
			SET @websiteError = @@ERROR
			END
			
		INSERT INTO @insert_errors (contactId, facilityError, personError, address1Error, address2Error, address3Error, phone1Error, phone2Error, phone3Error, fax1Error, fax2Error, emailError, websiteError)
		SELECT
			@contactId as contactId, 
			@facilityError as facilityError,
			@personError as personError,
			@address1Error as address1Error,
			@address2Error as address2Error,
			@address3Error as address3Error,
			@phone1Error as phone1Error,
			@phone2Error as phone2Error,
			@phone3Error as phone3Error,
			@fax1Error as fax1Error,
			@fax2Error as fax2Error,
			@emailError as emailError,
			@websiteError as websiteError        
        
        UPDATE @tbl3 SET processed = 1 WHERE facility = @facility
END

select * from @insert_errors