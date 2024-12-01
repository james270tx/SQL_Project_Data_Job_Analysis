-- SQL_Project_Data_Job_Analysis by james270tx
-- Practice project to accompany 'SQL For Data Analytics' course at https://www.youtube.com/watch?v=7mz73uXD9DA
-- 
-- SELECT .. FROM .. LIMIT 100; A quick check that the databases have loaded the csv files 

SELECT *
FROM company_dim
LIMIT 100;

SELECT *
FROM job_postings_fact
LIMIT 100;

SELECT *
FROM skills_dim
LIMIT 100;

SELECT *
FROM skills_job_dim
LIMIT 100;