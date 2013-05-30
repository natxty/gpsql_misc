
DECLARE @informationtype varchar(255)
DECLARE @productservicetype varchar(255)
DECLARE @productservicename varchar(255)
DECLARE @location varchar(255)

DECLARE @informationtype_id int
DECLARE @productservicetype_id int
DECLARE @productservicename_id int
DECLARE @location_id int
DECLARE @contact_id int
DECLARE @contact_label varchar(255)

DECLARE @has_contact bit

DECLARE @informationtype_productservicetype_id int
DECLARE @informationtype_productservicetype_productservicename_id int
DECLARE @informationtype_productservicetype_productservicename_location_id int

DECLARE @informationtype_productservicetype_productservicename_us bit 
DECLARE @informationtype_productservicetype_productservicename_gl bit
DECLARE @informationtype_productservicetype_productservicename_both bit
DECLARE @informationtype_productservicetype_productservicename_location_us bit
DECLARE @informationtype_productservicetype_productservicename_location_gl bit
DECLARE @informationtype_productservicetype_productservicename_location_both bit

-- Manually set some stuff for now
SET @informationtype = 'Customer Service'
SET @productservicetype = 'Oncology'
SET @productservicename = 'PROGENSA PCA3'
SET @location = 'ROW'
SET @contact_id = 1

SET @informationtype_productservicetype_productservicename_us = 0 
SET @informationtype_productservicetype_productservicename_gl = 0
SET @informationtype_productservicetype_productservicename_both = 1
SET @informationtype_productservicetype_productservicename_location_us = 0
SET @informationtype_productservicetype_productservicename_location_gl = 0
SET @informationtype_productservicetype_productservicename_location_both = 1

IF (@informationtype IS NOT NULL)
	BEGIN
	SELECT @informationtype_id = id FROM informationtype WHERE name = @informationtype
	END

IF (@productservicetype IS NOT NULL)
	BEGIN
	SELECT @productservicetype_id = id FROM productservicetype WHERE name = @productservicetype
	END

IF (@productservicename IS NOT NULL)
	BEGIN
	SELECT @productservicename_id = id FROM productservicename WHERE name = @productservicename
	END

IF (@location IS NOT NULL)
	BEGIN
	SELECT @location_id = id FROM location WHERE name = @location
	END
	
IF (@productservicetype_id IS NULL AND @productservicetype IS NOT NULL)
	BEGIN
	INSERT INTO productservicetype (name) VALUES (@productservicetype);
	SET @productservicetype_id = @@IDENTITY
	END

IF (@productservicename_id IS NULL AND @productservicename IS NOT NULL)
	BEGIN
	INSERT INTO productservicename (name) VALUES (@productservicename);
	SET @productservicename_id = @@IDENTITY
	END

IF (@location_id IS NULL AND @location IS NOT NULL)
	BEGIN
	INSERT INTO location (name) VALUES (@location);
	SET @location_id = @@IDENTITY
	END
	
IF (
		(@informationtype_id IS NOT NULL)
		AND 
		(@productservicetype_id IS NOT NULL)
		AND 
		(@productservicename_id IS NOT NULL)
		AND 
		(@location_id IS NOT NULL)
		AND 
		(@contact_id IS NOT NULL)
		AND
		(@informationtype_productservicetype_productservicename_us IS NOT NULL)
		AND
		(@informationtype_productservicetype_productservicename_gl IS NOT NULL)
		AND
		(@informationtype_productservicetype_productservicename_both IS NOT NULL)
		AND
		(@informationtype_productservicetype_productservicename_location_us IS NOT NULL)
		AND
		(@informationtype_productservicetype_productservicename_location_gl IS NOT NULL)
		AND
		(@informationtype_productservicetype_productservicename_location_both IS NOT NULL)
	)
	BEGIN
	-- Find our informationtype_to_productservicetype id OR create it
	SELECT
		@informationtype_productservicetype_id = id
	FROM
		informationtype_to_productservicetype
	WHERE
		informationtype_id = @informationtype_id
		AND
		productservicetype_id = @productservicetype_id
	
	IF (@informationtype_productservicetype_id IS NULL)
		BEGIN
		INSERT INTO informationtype_to_productservicetype 
			(
				informationtype_id, 
				productservicetype_id
			)
		VALUES 
			(
				@informationtype_id, 
				@productservicetype_id
			)
		
		SET @informationtype_productservicetype_id = @@IDENTITY
		END
	
	-- Find our informationtype_productservicetype_to_productservicename id OR create it	
	SELECT 
		@informationtype_productservicetype_productservicename_id = id
	FROM
		informationtype_productservicetype_to_productservicename
	WHERE
		informationtype_productservicetype_id = @informationtype_productservicetype_id
		AND
		productservicename_id = @productservicename_id
		AND
		us = @informationtype_productservicetype_productservicename_us
		AND
		gl = @informationtype_productservicetype_productservicename_gl
		AND
		both = @informationtype_productservicetype_productservicename_both	
		
	IF (@informationtype_productservicetype_productservicename_id IS NULL)
		BEGIN
		INSERT INTO informationtype_productservicetype_to_productservicename 
			(
				informationtype_productservicetype_id, 
				productservicename_id, 
				us, 
				gl, 
				both
			)
		VALUES 
			(
				@informationtype_productservicetype_id, 
				@productservicename_id, 
				@informationtype_productservicetype_productservicename_us, 
				@informationtype_productservicetype_productservicename_gl, 
				@informationtype_productservicetype_productservicename_both
			)
		
		SET @informationtype_productservicetype_productservicename_id = @@IDENTITY
		END
		
	-- Find our informationtype_productservicetype_productservicename_to_location id OR create it	
	SELECT
		@informationtype_productservicetype_productservicename_location_id = id
	FROM
		informationtype_productservicetype_productservicename_to_location
	WHERE
		informationtype_productservicetype_productservicename_id = @informationtype_productservicetype_productservicename_id
		AND
		location_id = @location_id
		AND
		us = @informationtype_productservicetype_productservicename_location_us
		AND
		gl = @informationtype_productservicetype_productservicename_location_gl
		AND
		both = @informationtype_productservicetype_productservicename_location_both
		
	IF (@informationtype_productservicetype_productservicename_location_id IS NULL)
		BEGIN
		INSERT INTO informationtype_productservicetype_productservicename_to_location
			(
				informationtype_productservicetype_productservicename_id, 
				location_id,
				us,
				gl,
				both
			)
		VALUES
			(
				@informationtype_productservicetype_productservicename_id, 
				@location_id,
				@informationtype_productservicetype_productservicename_location_us,
				@informationtype_productservicetype_productservicename_location_gl,
				@informationtype_productservicetype_productservicename_location_both
			)
		
		SET @informationtype_productservicetype_productservicename_location_id = @@IDENTITY
		END
	
	-- See if the contact should be added or updated
	SELECT
		@has_contact = 1
	FROM
		informationtype_productservicetype_productservicename_location_to_contact
	WHERE
		informationtype_productservicetype_productservicename_location_id = @informationtype_productservicetype_productservicename_location_id
		AND
		contact_id = @contact_id
		AND
		( @contact_label IS NULL OR label = @contact_label )
	
	IF (@has_contact IS NULL)
		BEGIN
		-- INSERT
		INSERT INTO informationtype_productservicetype_productservicename_location_to_contact
			(informationtype_productservicetype_productservicename_location_id, contact_id, label)
		VALUES
			(@informationtype_productservicetype_productservicename_location_id, @contact_id, @contact_label)
		END
	ELSE
		-- UPDATE
		UPDATE 
			informationtype_productservicetype_productservicename_location_to_contact
		SET 
			contact_id = @contact_id, 
			label = @contact_label
	END
ELSE
	SELECT 
		@informationtype_id, 
		@productservicetype_id, 
		@productservicename_id, 
		@location_id, 
		@contact_id,
		@informationtype_productservicetype_productservicename_us,
		@informationtype_productservicetype_productservicename_gl,
		@informationtype_productservicetype_productservicename_both,
		@informationtype_productservicetype_productservicename_location_us,
		@informationtype_productservicetype_productservicename_location_gl,
		@informationtype_productservicetype_productservicename_location_both;


