EXECUTE ContactPath
	NULL, 		--informationtype
	NULL, 		--productservicetype
	NULL,		--productserviceline
	NULL,		--productservicename
	NULL,		--location
	NULL,		--contact_label
	NULL,		--informationtype_id
	NULL,		--productservicetype_id
	NULL,		--productserviceline_id
	NULL,		--productservicename_id
	NULL,		--location_id
	NULL,		--contact_id
	NULL,		--informationtype_productservicetype_productservicename_us
	NULL,		--informationtype_productservicetype_productservicename_gl
	NULL,		--informationtype_productservicetype_productservicename_both
	NULL,		--informationtype_productservicetype_productservicename_location_us
	NULL,		--informationtype_productservicetype_productservicename_location_gl
	NULL,		--informationtype_productservicetype_productservicename_location_both
	NULL,		--informationtype_productserviceline_productservicename_us
	NULL,		--informationtype_productserviceline_productservicename_gl
	NULL,		--informationtype_productserviceline_productservicename_both
	NULL,		--informationtype_productserviceline_productservicename_location_us
	NULL,		--informationtype_productserviceline_productservicename_location_gl
	NULL		--informationtype_productserviceline_productservicename_location_both


DROP PROCEDURE dbo.ContactPath

CREATE PROCEDURE ContactPath
	@informationtype varchar(255),
	@productservicetype varchar(255),
	@productserviceline varchar(255),
	@productservicename varchar(255),
	@location varchar(255),
	@contact_label varchar(255),
	@informationtype_id int,
	@productservicetype_id int,
	@productserviceline_id int,
	@productservicename_id int,
	@location_id int,
	@contact_id int,
	
	@informationtype_productservicetype_productservicename_us bit,	
	@informationtype_productservicetype_productservicename_gl bit,	
	@informationtype_productservicetype_productservicename_both bit,	
	@informationtype_productservicetype_productservicename_location_us bit,	
	@informationtype_productservicetype_productservicename_location_gl bit,	
	@informationtype_productservicetype_productservicename_location_both bit,
	
	@informationtype_productserviceline_productservicename_us bit,
	@informationtype_productserviceline_productservicename_gl bit,	
	@informationtype_productserviceline_productservicename_both bit,	
	@informationtype_productserviceline_productservicename_location_us bit,	
	@informationtype_productserviceline_productservicename_location_gl bit,	
	@informationtype_productserviceline_productservicename_location_both bit
AS
BEGIN
	-- Our Variables
	DECLARE @has_contact bit
	
	DECLARE @ran_productservicetype bit
	DECLARE @ran_productserviceline bit
	
	SET @ran_productservicetype = 0
	SET @ran_productserviceline = 0
	
	-- Product Service Type
	DECLARE @informationtype_productservicetype_id int
	DECLARE @informationtype_productservicetype_productservicename_id int
	DECLARE @informationtype_productservicetype_productservicename_location_id int
	
	-- Product Service Line
	DECLARE @informationtype_productserviceline_id int
	DECLARE @informationtype_productserviceline_productservicename_id int
	DECLARE @informationtype_productserviceline_productservicename_location_id int
	
	-- Get our IDs if we just have names
	IF (@informationtype IS NOT NULL)
		BEGIN
		SELECT @informationtype_id = id FROM informationtype WHERE name = @informationtype
		END
	
	IF (@productservicetype IS NOT NULL)
		BEGIN
		SELECT @productservicetype_id = id FROM productservicetype WHERE name = @productservicetype
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
	
	-- Insert if not found	
	IF (@productservicetype_id IS NULL AND @productservicetype IS NOT NULL)
		BEGIN
		INSERT INTO productservicetype (name) VALUES (@productservicetype);
		SET @productservicetype_id = @@IDENTITY
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
	
	-- Do our Product Service Type section	
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
			WHERE
				informationtype_productservicetype_productservicename_location_id = @informationtype_productservicetype_productservicename_location_id
				AND
				contact_id = @contact_id
				AND
				( @contact_label IS NULL OR label = @contact_label )
				
		SET @ran_productservicetype = 1
		SET @has_contact = NULL
		
		END
	
	-- Do our Product Service Line section
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
			WHERE
				informationtype_productserviceline_productservicename_location_id = @informationtype_productserviceline_productservicename_location_id
				AND
				contact_id = @contact_id
				AND
				( @contact_label IS NULL OR label = @contact_label )				
				
		SET @ran_productserviceline = 1
		SET @has_contact = NULL
		END
	
	
	SELECT 
		@ran_productservicetype as ran_productservicetype, 
		@ran_productserviceline as ran_productserviceline
END
