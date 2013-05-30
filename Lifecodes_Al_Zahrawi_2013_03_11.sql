-- Select to determine:

SELECT
	id
FROM
	informationtype_productservicetype_productservicename_to_location
INNER JOIN
	informationtype_productservicetype_to_productservicename
ON
	informationtype_productservicetype_productservicename_to_location.informationtype_productservicetype_productservicename_id = informationtype_productservicetype_to_productservicename.id
INNER JOIN
	informationtype_to_productservicetype
ON
	informationtype_productservicetype_to_productservicename.informationtype_productservicetype_id = informationtype_to_productservicetype.id
INNER JOIN
	informationtype
ON
	informationtype.id = informationtype_to_productservicetype.informationtype_id
INNER JOIN
	productservicetype
ON
	productservicetype.id = informationtype_to_productservicetype.productservicetype_id
INNER JOIN
	productservicename
ON
	productservicename.id = informationtype_productservicetype_to_productservicename.productservicename_id
INNER JOIN
	location
ON
	location.id = informationtype_productservicetype_productservicename_to_location.location_id
INNER JOIN
	informationtype_productservicetype_productservicename_location_to_contact
ON
	informationtype_productservicetype_productservicename_location_to_contact.informationtype_productservicetype_productservicename_location_id = informationtype_productservicetype_productservicename_to_location.id
INNER JOIN
	contact
ON
	informationtype_productservicetype_productservicename_location_to_contact.contact_id = contact.id
INNER JOIN
	contact_to_facility
ON
	contact.id = contact_to_facility.contact_id
INNER JOIN
	facility
ON
	contact_to_facility.facility_id = facility.id
WHERE
	informationtype.name = 'Sales and Distribution' 
	AND
	productservicetype.name = 'Transplant & Transfusion Medicine'
	AND
	facility.name LIKE '%Al-Zahr%'
ORDER BY
	location.name


--- exported/backup of the above data, as insert statements, as Lifecodes_Al_Zahrwahi_2013_03_11_inserts_for_deletions__backup.sql ( same dir. )

-- PSLINE:

DECLARE @tbl Table (
	productservicename_id int
)

INSERT INTO @tbl 
SELECT  
	productservicename.id
FROM 
	informationtype_productservicetype_to_productservicename
INNER JOIN
	informationtype_to_productservicetype
ON
	informationtype_productservicetype_to_productservicename.informationtype_productservicetype_id = informationtype_to_productservicetype.id
INNER JOIN
	informationtype
ON
	informationtype.id = informationtype_to_productservicetype.informationtype_id
INNER JOIN
	productservicetype
ON 
	productservicetype.id = informationtype_to_productservicetype.productservicetype_id
INNER JOIN
	productservicename
ON
	productservicename.id = informationtype_productservicetype_to_productservicename.productservicename_id
WHERE
	informationtype.name = 'Sales and Distribution'
	AND
	productservicetype.name = ('Transplant & Transfusion Medicine')
	AND
	productservicename.name IN ('LIFECODES Donor Specific Antibody', 'LIFECODES Fluoroanalyzer', 'LIFECODES HLA Genotyping', 'LIFECODES KIR Genotyping', 'LIFECODES LSA Single Antigen', 'LIFECODES LSA MIC', 'LIFECODES Red Cell Genotyping', 'LIFECODES Screen & Identification')
GROUP BY 
	productservicename.id


DECLARE @tbl2 Table (
	informationtype_productserviceline_productservicename_location_id int,
	informationtype_productserviceline_productservicename_location_contact_id int
)

INSERT INTO @tbl2 (informationtype_productserviceline_productservicename_location_id, informationtype_productserviceline_productservicename_location_contact_id)
SELECT 
	informationtype_productserviceline_productservicename_to_location.id,
	informationtype_productserviceline_productservicename_location_to_contact.id	
FROM 
	informationtype_productserviceline_productservicename_to_location
INNER JOIN
	informationtype_productserviceline_to_productservicename
ON
	informationtype_productserviceline_productservicename_to_location.informationtype_productserviceline_productservicename_id = informationtype_productserviceline_to_productservicename.id
INNER JOIN
	informationtype_to_productserviceline
ON
	informationtype_productserviceline_to_productservicename.informationtype_productserviceline_id = informationtype_to_productserviceline.id
INNER JOIN
	informationtype
ON
	informationtype.id = informationtype_to_productserviceline.informationtype_id
INNER JOIN
	productserviceline
ON 
	productserviceline.id = informationtype_to_productserviceline.productserviceline_id
INNER JOIN
	productservicename
ON
	productservicename.id = informationtype_productserviceline_to_productservicename.productservicename_id
LEFT JOIN
	location
ON
	location.id = informationtype_productserviceline_productservicename_to_location.location_id
LEFT JOIN
	informationtype_productserviceline_productservicename_location_to_contact
ON
	informationtype_productserviceline_productservicename_location_to_contact.informationtype_productserviceline_productservicename_location_id = informationtype_productserviceline_productservicename_to_location.id
LEFT JOIN
	contact
ON
	informationtype_productserviceline_productservicename_location_to_contact.contact_id = contact.id
LEFT JOIN 
	contact_to_facility
ON
	contact.id = contact_to_facility.contact_id
LEFT JOIN
	facility
ON
	contact_to_facility.facility_id = facility.id
WHERE
	informationtype.name = 'Sales and Distribution'
	AND
	productservicename.id 
	IN
		(
			SELECT 
				productservicename_id
			FROM
				@tbl
		)
	AND
	productservicename.name IN ('LIFECODES Donor Specific Antibody', 'LIFECODES Fluoroanalyzer', 'LIFECODES HLA Genotyping', 'LIFECODES KIR Genotyping', 'LIFECODES LSA Single Antigen', 'LIFECODES LSA MIC', 'LIFECODES Red Cell Genotyping', 'LIFECODES Screen & Identification')
	AND
	facility.name LIKE '%Al-Zahr%'


-- SELECT * FROM @tbl2

-- Begin Delete:
DELETE FROM informationtype_productserviceline_productservicename_location_to_contact WHERE id IN
(
	SELECT informationtype_productserviceline_productservicename_location_contact_id FROM @tbl2 
)



-- PSTYPE:

--- exported/backup of the above data, as insert statements, as Lifecodes_Al_Zahrwahi_2013_03_11_inserts_for_deletions__backup.sql ( same dir. )
DECLARE @tbl Table (
	productservicename_id int
)

INSERT INTO @tbl 
SELECT  
	productservicename.id
FROM 
	informationtype_productservicetype_to_productservicename
INNER JOIN
	informationtype_to_productservicetype
ON
	informationtype_productservicetype_to_productservicename.informationtype_productservicetype_id = informationtype_to_productservicetype.id
INNER JOIN
	informationtype
ON
	informationtype.id = informationtype_to_productservicetype.informationtype_id
INNER JOIN
	productservicetype
ON 
	productservicetype.id = informationtype_to_productservicetype.productservicetype_id
INNER JOIN
	productservicename
ON
	productservicename.id = informationtype_productservicetype_to_productservicename.productservicename_id
WHERE
	informationtype.name = 'Sales and Distribution'
	AND
	productservicetype.name = ('Transplant & Transfusion Medicine')
	AND
	productservicename.name IN ('LIFECODES Donor Specific Antibody', 'LIFECODES Fluoroanalyzer', 'LIFECODES HLA Genotyping', 'LIFECODES KIR Genotyping', 'LIFECODES LSA Single Antigen', 'LIFECODES LSA MIC', 'LIFECODES Red Cell Genotyping', 'LIFECODES Screen & Identification')
GROUP BY 
	productservicename.id


DECLARE @tbl2 Table (
	informationtype_productservicetype_productservicename_location_id int,
	informationtype_productservicetype_productservicename_location_contact_id int
)

INSERT INTO @tbl2 (informationtype_productservicetype_productservicename_location_id, informationtype_productservicetype_productservicename_location_contact_id)
SELECT 
	informationtype_productservicetype_productservicename_to_location.id,
	informationtype_productservicetype_productservicename_location_to_contact.id	
FROM 
	informationtype_productservicetype_productservicename_to_location
INNER JOIN
	informationtype_productservicetype_to_productservicename
ON
	informationtype_productservicetype_productservicename_to_location.informationtype_productservicetype_productservicename_id = informationtype_productservicetype_to_productservicename.id
INNER JOIN
	informationtype_to_productservicetype
ON
	informationtype_productservicetype_to_productservicename.informationtype_productservicetype_id = informationtype_to_productservicetype.id
INNER JOIN
	informationtype
ON
	informationtype.id = informationtype_to_productservicetype.informationtype_id
INNER JOIN
	productservicetype
ON 
	productservicetype.id = informationtype_to_productservicetype.productservicetype_id
INNER JOIN
	productservicename
ON
	productservicename.id = informationtype_productservicetype_to_productservicename.productservicename_id
LEFT JOIN
	location
ON
	location.id = informationtype_productservicetype_productservicename_to_location.location_id
LEFT JOIN
	informationtype_productservicetype_productservicename_location_to_contact
ON
	informationtype_productservicetype_productservicename_location_to_contact.informationtype_productservicetype_productservicename_location_id = informationtype_productservicetype_productservicename_to_location.id
LEFT JOIN
	contact
ON
	informationtype_productservicetype_productservicename_location_to_contact.contact_id = contact.id
LEFT JOIN 
	contact_to_facility
ON
	contact.id = contact_to_facility.contact_id
LEFT JOIN
	facility
ON
	contact_to_facility.facility_id = facility.id
WHERE
	informationtype.name = 'Sales and Distribution'
	AND
	productservicename.id 
	IN
		(
			SELECT 
				productservicename_id
			FROM
				@tbl
		)
	AND
	productservicename.name IN ('LIFECODES Donor Specific Antibody', 'LIFECODES Fluoroanalyzer', 'LIFECODES HLA Genotyping', 'LIFECODES KIR Genotyping', 'LIFECODES LSA Single Antigen', 'LIFECODES LSA MIC', 'LIFECODES Red Cell Genotyping', 'LIFECODES Screen & Identification')
	AND
	facility.name LIKE '%Al-Zahr%'


-- SELECT * FROM @tbl2

-- Begin Delete:
DELETE FROM informationtype_productservicetype_productservicename_location_to_contact WHERE id IN
(
	SELECT informationtype_productservicetype_productservicename_location_contact_id FROM @tbl2 
)
