-- Make our addresses

DECLARE @ukw_rsd_id int
DECLARE @uks_dk_id int
DECLARE @uke_jf_id int
DECLARE @ukc_rg_id int
DECLARE @ukwi_rg_id int
DECLARE @ukn_hp_id int

SET @ukw_rsd_id = 1693
SET @uks_dk_id = 1692
SET @uke_jf_id = 1691
SET @ukc_rg_id = 1690
SET @ukwi_rg_id = 1689
SET @ukn_hp_id = 1688

EXECUTE CreateAddress
	-- Contact Label
		NULL,
	-- Facility
		NULL,
	-- Person
		NULL,
	-- Address 1
		Null,
	-- Address 2
		Null,
	-- Address 3
		Null,
	-- Phone 1
		NULL,
	-- Phone 2
		Null,
	-- Fax 1
		Null,
	-- Fax 2
		Null,
	-- Email
		'helen.petrakis@hologic.com',
	-- Website
		NULL,
	-- Contact Id
		@ukn_hp_id,
	-- Facility Id
		NULL,
	-- Person Id
		NULL,
	-- Address 1 Id
		NULL,
	-- Address 2 Id
		NULL,
	-- Address 3 Id
		NULL,
	-- Phone 1 Id
		NULL,
	-- Phone 2 Id
		NULL,
	-- Fax 1 Id
		NULL,
	-- Fax 2 Id
		NULL,
	-- Email Id
		NULL,
	-- Website Id
		NULL,
	-- OUTPUT
		@ukn_hp_id OUTPUT


EXECUTE CreateAddress
	-- Contact Label
		NULL,
	-- Facility
		NULL,
	-- Person
		NULL,
	-- Address 1
		Null,
	-- Address 2
		Null,
	-- Address 3
		Null,
	-- Phone 1
		NULL,
	-- Phone 2
		Null,
	-- Fax 1
		Null,
	-- Fax 2
		Null,
	-- Email
		'rachel.gratland@hologic.com',
	-- Website
		NULL,
	-- Contact Id
		@ukwi_rg_id,
	-- Facility Id
		NULL,
	-- Person Id
		NULL,
	-- Address 1 Id
		NULL,
	-- Address 2 Id
		NULL,
	-- Address 3 Id
		NULL,
	-- Phone 1 Id
		NULL,
	-- Phone 2 Id
		NULL,
	-- Fax 1 Id
		NULL,
	-- Fax 2 Id
		NULL,
	-- Email Id
		NULL,
	-- Website Id
		NULL,
	-- OUTPUT
		@ukwi_rg_id OUTPUT


EXECUTE CreateAddress
	-- Contact Label
		NULL,
	-- Facility
		NULL,
	-- Person
		NULL,
	-- Address 1
		Null,
	-- Address 2
		Null,
	-- Address 3
		Null,
	-- Phone 1
		NULL,
	-- Phone 2
		Null,
	-- Fax 1
		Null,
	-- Fax 2
		Null,
	-- Email
		'rachel.gratland@hologic.com',
	-- Website
		NULL,
	-- Contact Id
		@ukc_rg_id,
	-- Facility Id
		NULL,
	-- Person Id
		NULL,
	-- Address 1 Id
		NULL,
	-- Address 2 Id
		NULL,
	-- Address 3 Id
		NULL,
	-- Phone 1 Id
		NULL,
	-- Phone 2 Id
		NULL,
	-- Fax 1 Id
		NULL,
	-- Fax 2 Id
		NULL,
	-- Email Id
		NULL,
	-- Website Id
		NULL,
	-- OUTPUT
		@ukc_rg_id OUTPUT

EXECUTE CreateAddress
	-- Contact Label
		NULL,
	-- Facility
		NULL,
	-- Person
		NULL,
	-- Address 1
		Null,
	-- Address 2
		Null,
	-- Address 3
		Null,
	-- Phone 1
		NULL,
	-- Phone 2
		Null,
	-- Fax 1
		Null,
	-- Fax 2
		Null,
	-- Email
		'jo.frost@hologic.com',
	-- Website
		NULL,
	-- Contact Id
		@uke_jf_id,
	-- Facility Id
		NULL,
	-- Person Id
		NULL,
	-- Address 1 Id
		NULL,
	-- Address 2 Id
		NULL,
	-- Address 3 Id
		NULL,
	-- Phone 1 Id
		NULL,
	-- Phone 2 Id
		NULL,
	-- Fax 1 Id
		NULL,
	-- Fax 2 Id
		NULL,
	-- Email Id
		NULL,
	-- Website Id
		NULL,
	-- OUTPUT
		@uke_jf_id OUTPUT

EXECUTE CreateAddress
	-- Contact Label
		NULL,
	-- Facility
		NULL,
	-- Person
		NULL,
	-- Address 1
		Null,
	-- Address 2
		Null,
	-- Address 3
		Null,
	-- Phone 1
		NULL,
	-- Phone 2
		Null,
	-- Fax 1
		Null,
	-- Fax 2
		Null,
	-- Email
		'doug.kirkwood@hologic.com',
	-- Website
		NULL,
	-- Contact Id
		@uks_dk_id,
	-- Facility Id
		NULL,
	-- Person Id
		NULL,
	-- Address 1 Id
		NULL,
	-- Address 2 Id
		NULL,
	-- Address 3 Id
		NULL,
	-- Phone 1 Id
		NULL,
	-- Phone 2 Id
		NULL,
	-- Fax 1 Id
		NULL,
	-- Fax 2 Id
		NULL,
	-- Email Id
		NULL,
	-- Website Id
		NULL,
	-- OUTPUT
		@uks_dk_id OUTPUT

EXECUTE CreateAddress
	-- Contact Label
		NULL,
	-- Facility
		NULL,
	-- Person
		NULL,
	-- Address 1
		Null,
	-- Address 2
		Null,
	-- Address 3
		Null,
	-- Phone 1
		NULL,
	-- Phone 2
		Null,
	-- Fax 1
		Null,
	-- Fax 2
		Null,
	-- Email
		'rebekah.selby-davis@hologic.com',
	-- Website
		NULL,
	-- Contact Id
		@ukw_rsd_id,
	-- Facility Id
		NULL,
	-- Person Id
		NULL,
	-- Address 1 Id
		NULL,
	-- Address 2 Id
		NULL,
	-- Address 3 Id
		NULL,
	-- Phone 1 Id
		NULL,
	-- Phone 2 Id
		NULL,
	-- Fax 1 Id
		NULL,
	-- Fax 2 Id
		NULL,
	-- Email Id
		NULL,
	-- Website Id
		NULL,
	-- OUTPUT
		@ukw_rsd_id OUTPUT