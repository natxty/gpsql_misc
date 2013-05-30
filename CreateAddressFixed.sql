CREATE PROCEDURE CreateAddress
	@contactLabel varchar(255),
	@facility varchar(255),
	@person varchar(255),
	@address1 varchar(255),
	@address2 varchar(255),
	@address3 varchar(255),
	@phone1 varchar(255),
	@phone2 varchar(255),
	@fax1 varchar(255),
	@fax2 varchar(255),
	@email varchar(255),
	@website varchar(255),

	@contactId int,
	@facilityId int,
	@personId int,
	@address1Id int,
	@address2Id int,
	@address3Id int,
	@phone1Id int,
	@phone2Id int,
	@fax1Id int,
	@fax2Id int,
	@emailId int,
	@websiteId int,

	@contact_id int OUTPUT
AS
BEGIN

	IF (@facility is not Null)
		BEGIN
		SET @facilityId = (SELECT TOP 1 id FROM facility WHERE facility.name = @facility)
		END

	IF (@person is not Null)
		BEGIN
		SET @personId 	= (SELECT TOP 1 id FROM person WHERE person.name = @person)
		END

	IF (@address1 is not Null)
		BEGIN
		SET @address1Id = (SELECT TOP 1 id FROM address WHERE address.address = @address1)
		END

	IF (@address2 is not Null)
		BEGIN
		SET @address2Id = (SELECT TOP 1 id FROM address WHERE address.address = @address2)
		END

	IF (@address3 is not Null)
		BEGIN
		SET @address3Id = (SELECT TOP 1 id FROM address WHERE address.address = @address3)
		END

	IF (@phone1 is not Null)
		BEGIN
		SET @phone1Id 	= (SELECT TOP 1 id FROM phone WHERE phone.number = @phone1)
		END

	IF (@phone2 is not Null)
		BEGIN
		SET @phone2Id 	= (SELECT TOP 1 id FROM phone WHERE phone.number = @phone2)
		END

	IF (@fax1 is not Null)
		BEGIN
		SET @fax1Id		= (SELECT TOP 1 id FROM fax WHERE fax.number = @fax1)
		END

	IF (@fax2 is not Null)
		BEGIN
		SET @fax2Id 	= (SELECT TOP 1 id FROM fax WHERE fax.number = @fax2)
		END

	IF (@email is not Null)
		BEGIN
		SET @emailId	= (SELECT TOP 1 id FROM email WHERE email.email = @email)
		END

	IF (@website is not Null)
		BEGIN
		SET @websiteId	= (SELECT TOP 1 id FROM website WHERE website.url = @website)
		END

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
		END


	IF (@personId is NULL and @person is not NULL)
		BEGIN
		INSERT INTO person (name) VALUES (@person)
		SET @personId = @@IDENTITY
		END
	IF (@personId is not NULL)
		BEGIN
		INSERT INTO contact_to_person (contact_id, person_id, item_order) VALUES (@contactId, @personId, 1)
		END

	IF (@address1Id is NULL and @address1 is not NULL)
		BEGIN
		INSERT INTO address (address) VALUES (@address1)
		SET @address1Id = @@IDENTITY
		END
	IF (@address1Id is not NULL)
		BEGIN
		INSERT INTO contact_to_address (contact_id, address_id, item_order) VALUES (@contactId, @address1Id, 1)
		END

	IF (@address2Id is NULL and @address2 is not NULL)
		BEGIN
		INSERT INTO address (address) VALUES (@address2)
		SET @address2Id = @@IDENTITY
		END
	IF (@address2Id is not NULL)
		BEGIN
		INSERT INTO contact_to_address (contact_id, address_id, item_order) VALUES (@contactId, @address2Id, 2)
		END

	IF (@address3Id is NULL and @address3 is not NULL)
		BEGIN
		INSERT INTO address (address) VALUES (@address3)
		SET @address3Id = @@IDENTITY
		END
	IF (@address3Id is not NULL)
		BEGIN
		INSERT INTO contact_to_address (contact_id, address_id, item_order) VALUES (@contactId, @address3Id, 3)
		END

	IF (@phone1Id is NULL and @phone1 is not NULL)
		BEGIN
		INSERT INTO phone (number) VALUES (@phone1)
		SET @phone1Id = @@IDENTITY
		END
	IF (@phone1Id is not NULL)
		BEGIN
		INSERT INTO contact_to_phone (contact_id, phone_id, item_order) VALUES (@contactId, @phone1Id, 1)
		END

	IF (@phone2Id is NULL and @phone2 is not NULL)
		BEGIN
		INSERT INTO phone (number) VALUES (@phone2)
		SET @phone2Id = @@IDENTITY
		END
	IF (@phone2Id is not NULL)
		BEGIN
		INSERT INTO contact_to_phone (contact_id, phone_id, item_order) VALUES (@contactId, @phone2Id, 2)
		END

	IF (@fax1Id is NULL and @fax1 is not NULL)
		BEGIN
		INSERT INTO fax (number) VALUES (@fax1)
		SET @fax1Id = @@IDENTITY
		END
	IF (@fax1Id is not NULL)
		BEGIN
		INSERT INTO contact_to_fax (contact_id, fax_id, item_order) VALUES (@contactId, @fax1Id, 1)
		END

	IF (@fax2Id is NULL and @fax2 is not NULL)
		BEGIN
		INSERT INTO fax (number) VALUES (@fax2)
		SET @fax2Id = @@IDENTITY
		END
	IF (@fax2Id is not NULL)
		BEGIN
		INSERT INTO contact_to_fax (contact_id, fax_id, item_order) VALUES (@contactId, @fax2Id, 2)
		END

	IF (@emailId is NULL and @email is not NULL)
		BEGIN
		INSERT INTO email (email) VALUES (@email)
		SET @emailId = @@IDENTITY
		END
	IF (@emailId is not NULL)
		BEGIN
		INSERT INTO contact_to_email (contact_id, email_id, item_order) VALUES (@contactId, @emailId, 1)
		END

	IF (@websiteId is NULL and @website is not NULL)
		BEGIN
		INSERT INTO website (url) VALUES (@website)
		SET @websiteId = @@IDENTITY
		END
	IF (@websiteId is not NULL)
		BEGIN
		INSERT INTO contact_to_website (contact_id, website_id, item_order) VALUES (@contactId, @websiteId, 1)
		END

	SELECT
		@contact_id = @contactId
END