--Converting default when is 0 to no and when is 1 to yes
SELECT job, CASE WHEN [default] = 0 THEN 'no' ELSE 'yes' END as custom_default
FROM Bank_Marketing;



ALTER TABLE Bank_Marketing
ALTER COLUMN "default" VARCHAR(3); 


UPDATE Bank_Marketing
SET "default" = CASE WHEN "default" = 0 THEN 'no' ELSE 'yes' END;


--Converting housing when is 0 to no and 1 to yes
SELECT job, CASE WHEN [housing] = 0 THEN 'no' ELSE 'yes' END as custom_housing
FROM Bank_Marketing;



ALTER TABLE Bank_Marketing
ALTER COLUMN "housing" VARCHAR(3); 


UPDATE Bank_Marketing
SET "housing" = CASE WHEN "housing" = 0 THEN 'no' ELSE 'yes' END;



--Converting loan when is 0 to no and 1 to yes
SELECT job, CASE WHEN [loan] = 0 THEN 'no' ELSE 'yes' END as custom_loan
FROM Bank_Marketing;


ALTER TABLE Bank_Marketing
ALTER COLUMN "loan" VARCHAR(3); 


UPDATE Bank_Marketing
SET "loan" = CASE WHEN "loan" = 0 THEN 'no' ELSE 'yes' END;


--converting NULL values to unknown in contact culomn
SELECT 
  job, 
  marital, 
  contact,
  ISNULL(contact, 'unknown') as contact 
FROM 
  Bank_Marketing

UPDATE 
  Bank_Marketing
SET 
  contact = ISNULL(contact, 'unknown') 

--converting NULL values to unknown in poutcome culomn
SELECT 
  job, 
  marital, 
  poutcome,
  ISNULL(poutcome, 'unknown') as poutcome 
FROM 
  Bank_Marketing

UPDATE 
  Bank_Marketing
SET 
  poutcome = ISNULL(poutcome, 'unknown') 

