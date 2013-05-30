
DECLARE @informationtype varchar(255)
DECLARE @productserviceline varchar(255)
DECLARE @productservicename varchar(255)
DECLARE @location varchar(255)

DECLARE @informationtype_id int
DECLARE @productserviceline_id int
DECLARE @productservicename_id int
DECLARE @location_id int
DECLARE @contact_id int
DECLARE @contact_label varchar(255)

DECLARE @has_contact bit

DECLARE @informationtype_productserviceline_id int
DECLARE @informationtype_productserviceline_productservicename_id int
DECLARE @informationtype_productserviceline_productservicename_location_id int

DECLARE @informationtype_productserviceline_productservicename_us bit 
DECLARE @informationtype_productserviceline_productservicename_gl bit
DECLARE @informationtype_productserviceline_productservicename_both bit
DECLARE @informationtype_productserviceline_productservicename_location_us bit
DECLARE @informationtype_productserviceline_productservicename_location_gl bit
DECLARE @informationtype_productserviceline_productservicename_location_both bit

-- Manually set some stuff for now
SET @informationtype = 'Customer Service'
SET @productserviceline = 'Oncology'
SET @productservicename = 'PROGENSA'
SET @location = 'US'
SET @contact_id = 1

SET @informationtype_productserviceline_productservicename_us = 0 
SET @informationtype_productserviceline_productservicename_gl = 0
SET @informationtype_productserviceline_productservicename_both = 1
SET @informationtype_productserviceline_productservicename_location_us = 0
SET @informationtype_productserviceline_productservicename_location_gl = 0
SET @informationtype_productserviceline_productservicename_location_both = 1

IF (@informationtype IS NOT NULL)
	BEGIN
	SELECT @informationtype_id = id FROM informationtype WHERE name = @informationtype
	END

IF (@productserviceline IS NOT NULL)
	BEGIN
	SELECT @productserviceline_id = id FROM productserviceline WHERE name = @productserviceline
	END

IF (@productservicename IS NOT NULL)
	BEGIN
	SELECT @productservicename_id = id FROM productservicename WHERE name = @productservicename
	END

IF (@location IS NOT NULL)
	BEGIN
	SELECT @location_id = id FROM location WHERE name = @location
	END
	
IF (@productserviceline_id IS NULL AND @productserviceline IS NOT NULL)
	BEGIN
	INSERT INTO productserviceline (name) VALUES (@productserviceline);
	SET @productserviceline_id = @@IDENTITY
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
		(@productserviceline_id IS NOT NULL)
		AND 
		(@productservicename_id IS NOT NULL)
		AND 
		(@location_id IS NOT NULL)
		AND 
		(@contact_id IS NOT NULL)
		AND
		(@informationtype_productserviceline_productservicename_us IS NOT NULL)
		AND
		(@informationtype_productserviceline_productservicename_gl IS NOT NULL)
		AND
		(@informationtype_productserviceline_productservicename_both IS NOT NULL)
		AND
		(@informationtype_productserviceline_productservicename_location_us IS NOT NULL)
		AND
		(@informationtype_productserviceline_productservicename_location_gl IS NOT NULL)
		AND
		(@informationtype_productserviceline_productservicename_location_both IS NOT NULL)
	)
	BEGIN
	-- Find our informationtype_to_productserviceline id OR create it
	SELECT
		@informationtype_productserviceline_id = id
	FROM
		informationtype_to_productserviceline
	WHERE
		informationtype_id = @informationtype_id
		AND
		productserviceline_id = @productserviceline_id
	
	IF (@informationtype_productserviceline_id IS NULL)
		BEGIN
		INSERT INTO informationtype_to_productserviceline 
			(
				informationtype_id, 
				productserviceline_id
			)
		VALUES 
			(
				@informationtype_id, 
				@productserviceline_id
			)
		
		SET @informationtype_productserviceline_id = @@IDENTITY
		END
	
	-- Find our informationtype_productserviceline_to_productservicename id OR create it	
	SELECT 
		@informationtype_productserviceline_productservicename_id = id
	FROM
		informationtype_productserviceline_to_productservicename
	WHERE
		informationtype_productserviceline_id = @informationtype_productserviceline_id
		AND
		productservicename_id = @productservicename_id
		AND
		us = @informationtype_productserviceline_productservicename_us
		AND
		gl = @informationtype_productserviceline_productservicename_gl
		AND
		both = @informationtype_productserviceline_productservicename_both	
		
	IF (@informationtype_productserviceline_productservicename_id IS NULL)
		BEGIN
		INSERT INTO informationtype_productserviceline_to_productservicename 
			(
				informationtype_productserviceline_id, 
				productservicename_id, 
				us, 
				gl, 
				both
			)
		VALUES 
			(
				@informationtype_productserviceline_id, 
				@productservicename_id, 
				@informationtype_productserviceline_productservicename_us, 
				@informationtype_productserviceline_productservicename_gl, 
				@informationtype_productserviceline_productservicename_both
			)
		
		SET @informationtype_productserviceline_productservicename_id = @@IDENTITY
		END
		
	-- Find our informationtype_productserviceline_productservicename_to_location id OR create it	
	SELECT
		@informationtype_productserviceline_productservicename_location_id = id
	FROM
		informationtype_productserviceline_productservicename_to_location
	WHERE
		informationtype_productserviceline_productservicename_id = @informationtype_productserviceline_productservicename_id
		AND
		location_id = @location_id
		AND
		us = @informationtype_productserviceline_productservicename_location_us
		AND
		gl = @informationtype_productserviceline_productservicename_location_gl
		AND
		both = @informationtype_productserviceline_productservicename_location_both
		
	IF (@informationtype_productserviceline_productservicename_location_id IS NULL)
		BEGIN
		INSERT INTO informationtype_productserviceline_productservicename_to_location
			(
				informationtype_productserviceline_productservicename_id, 
				location_id,
				us,
				gl,
				both
			)
		VALUES
			(
				@informationtype_productserviceline_productservicename_id, 
				@location_id,
				@informationtype_productserviceline_productservicename_location_us,
				@informationtype_productserviceline_productservicename_location_gl,
				@informationtype_productserviceline_productservicename_location_both
			)
		
		SET @informationtype_productserviceline_productservicename_location_id = @@IDENTITY
		END
	
	-- See if the contact should be added or updated
	SELECT
		@has_contact = 1
	FROM
		informationtype_productserviceline_productservicename_location_to_contact
	WHERE
		informationtype_productserviceline_productservicename_location_id = @informationtype_productserviceline_productservicename_location_id
		AND
		contact_id = @contact_id
		AND
		( @contact_label IS NULL OR label = @contact_label )
	
	IF (@has_contact IS NULL)
		BEGIN
		-- INSERT
		INSERT INTO informationtype_productserviceline_productservicename_location_to_contact
			(informationtype_productserviceline_productservicename_location_id, contact_id, label)
		VALUES
			(@informationtype_productserviceline_productservicename_location_id, @contact_id, @contact_label)
		END
	ELSE
		-- UPDATE
		UPDATE 
			informationtype_productserviceline_productservicename_location_to_contact
		SET 
			contact_id = @contact_id, 
			label = @contact_label
	END
ELSE
	SELECT 
		@informationtype_id, 
		@productserviceline_id, 
		@productservicename_id, 
		@location_id, 
		@contact_id,
		@informationtype_productserviceline_productservicename_us,
		@informationtype_productserviceline_productservicename_gl,
		@informationtype_productserviceline_productservicename_both,
		@informationtype_productserviceline_productservicename_location_us,
		@informationtype_productserviceline_productservicename_location_gl,
		@informationtype_productserviceline_productservicename_location_both;


