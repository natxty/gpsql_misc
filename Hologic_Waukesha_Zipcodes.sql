IF ( (SELECT id FROM salesrep WHERE person = 'Rich Reed') IS NULL )
    BEGIN
    INSERT INTO salesrep (person, phone, email) VALUES ('Rich Reed', '(262) 327-5476', 'richard.reed@hologic.com')
    END

DECLARE @sreps TABLE (
    old_id int,
    new_id int
    )

INSERT INTO @sreps
SELECT
    (SELECT id FROM salesrep WHERE salesrep.person = c.old_rep) as old_id,
    (SELECT id FROM salesrep WHERE salesrep.person = c.new_rep) as new_id
FROM
    (
	SELECT 'Jack Frontczak' as old_rep, 'Lisa Tran' as new_rep
	UNION ALL SELECT 'Paul Graf', 'Lisa Tran'
	UNION ALL SELECT 'Louis Panagopoulos', 'Rich Reed'
	UNION ALL SELECT 'Brad Hemesath', 'Karl Stemke'
	) c
	
SELECT * FROM @sreps

UPDATE
    salesrep_to_zipcode
SET
    salesrep_to_zipcode.salesrep_id = t.new_id
FROM
    @sreps as t
WHERE
    salesrep_to_zipcode.salesrep_id = t.old_id
    AND
    salesrep_to_zipcode.salesrepgroup_id = 2

