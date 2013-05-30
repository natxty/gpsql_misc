delete from contact_to_phone where phone_id in 
	(select id from phone where rtrim(number) = '')
	
delete from contact_to_fax where fax_id in 
	(select id from fax where rtrim(number) = '')	

delete from contact_to_email where email_id in 
	(select id from email where rtrim(email) = '')
	
delete from contact_to_website where website_id in 
	(select id from website where rtrim(url) = '')
	
delete from contact_to_person where person_id in 
	(select id from person where rtrim(name) = '')




select 'phone',id from contact_to_phone where phone_id in 
	(select id from phone where rtrim(number) = '')
UNION ALL	
select 'fax',id from contact_to_fax where fax_id in 
	(select id from fax where rtrim(number) = '')	
UNION ALL
select 'email',id from contact_to_email where email_id in 
	(select id from email where rtrim(email) = '')
UNION ALL	
select 'website',id from contact_to_website where website_id in 
	(select id from website where rtrim(url) = '')
UNION ALL	
select 'person',id from contact_to_person where person_id in 
	(select id from person where rtrim(name) = '')