
-- Big Clean-Up Script to fix duplicated paths

---- Find all paths that share an itype, pstype/psline, psname and location






	SELECT
		informationtype_productserviceline_productservicename_location_to_contact.id
	FROM
		contact
	INNER JOIN
		contact_to_facility
	ON
		contact_to_facility.contact_id = contact.id
	INNER JOIN
		facility
	ON
		contact_to_facility.facility_id = facility.id
	INNER JOIN
		informationtype_productserviceline_productservicename_location_to_contact
	ON
		informationtype_productserviceline_productservicename_location_to_contact.contact_id = contact.id
	WHERE
		facility.name IN
		(
			'Gen-Probe Technical Sales Representative (Canada – Alberta, British Columbia, Manitoba, Saskatchewan)'
		)
		AND
		informationtype_productserviceline_productservicename_location_to_contact.id NOT IN
		(
			SELECT
				min(informationtype_productserviceline_productservicename_location_to_contact.id)
			FROM
				contact
			INNER JOIN
				contact_to_facility
			ON
				contact_to_facility.contact_id = contact.id
			INNER JOIN
				facility
			ON
				contact_to_facility.facility_id = facility.id
			INNER JOIN
				informationtype_productserviceline_productservicename_location_to_contact
			ON
				informationtype_productserviceline_productservicename_location_to_contact.contact_id = contact.id
			WHERE
				facility.name IN
				(
					'Gen-Probe Technical Sales Representative (Canada – Alberta, British Columbia, Manitoba, Saskatchewan)'
				)
			GROUP BY
				informationtype_productserviceline_productservicename_location_to_contact.informationtype_productserviceline_productservicename_location_id
			HAVING 
				COUNT(*) > 1
		)
		
		
		
			SELECT
				min(informationtype_productserviceline_productservicename_location_to_contact.id)
			FROM
				contact
			INNER JOIN
				contact_to_facility
			ON
				contact_to_facility.contact_id = contact.id
			INNER JOIN
				facility
			ON
				contact_to_facility.facility_id = facility.id
			INNER JOIN
				informationtype_productserviceline_productservicename_location_to_contact
			ON
				informationtype_productserviceline_productservicename_location_to_contact.contact_id = contact.id
			WHERE
				facility.name IN
				(
					'Gen-Probe Technical Sales Representative (Canada – Alberta, British Columbia, Manitoba, Saskatchewan)'
				)
			GROUP BY
				informationtype_productserviceline_productservicename_location_to_contact.informationtype_productserviceline_productservicename_location_id
			HAVING 
				COUNT(*) > 1