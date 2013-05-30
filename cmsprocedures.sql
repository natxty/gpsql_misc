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

-- Manually entered info for now...

SET @contactLabel = 'Tarom Applied Technologies Ltd. 94'
SET @facilityId = 171
SET @address1 = '94 Jabotinsky St. PetachTakva 49517, PO Box 39338'
SET @address2Id = 291
SET @phone1Id = 133
SET @fax1Id = 54
SET @emailId = 145

-- Begin our logic

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

SELECT
	@contactId as contactId, 
	@facilityError as facilityError,
	@personError as personError,
	@address1Error as address1Error,
	@address2Error as address2Error,
	@address3Error as address3Error,
	@phone1Error as phone1Error,
	@phone2Error as phone2Error,
	@fax1Error as fax1Error,
	@fax2Error as fax2Error,
	@emailError as emailError,
	@websiteError as websiteError
	
	
	
-- DELETE by Contact ID
DECLARE @contactId int
SET @contactId = 1597

delete from contact_to_facility where contact_to_facility.contact_id = @contactId
delete from contact_to_person where contact_to_person.contact_id = @contactId
delete from contact_to_address where contact_to_address.contact_id = @contactId
delete from contact_to_phone where contact_to_phone.contact_id = @contactId
delete from contact_to_fax where contact_to_fax.contact_id = @contactId
delete from contact_to_email where contact_to_email.contact_id = @contactId
delete from contact_to_website where contact_to_website.contact_id = @contactId
delete from contact where id = @contactId
