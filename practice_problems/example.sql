-- SQL_Project_Data_Job_Analysis by james270tx
-- Practice for 'SQL For Data Analytics' course at https://www.youtube.com/watch?v=7mz73uXD9DA

/*
Memory trick... Silly Frogs Wear Green Hats On Lakes
SELECT column1, column2         -- Silly
FROM table_name                 -- Frogs
WHERE column1 = 'value'         -- Wear
GROUP BY column2                -- Green
HAVING COUNT(column2) > 1       -- Hats
ORDER BY column1                -- On
LIMIT 10;                       -- Lakes
*/



--Aggregation example with GROUP BY

SELECT
    department,
    SUM(salary) AS department_salary
FROM
    employees
GROUP BY
    department;



--Aggregation example with HAVING
--HAVING allows to filter data with an aggregation

SELECT
    department,
    COUNT(employee_id)
FROM
    employees
GROUP BY
    department
HAVING
    COUNT(employee_id) > 10;



--Example with multiple aggrecations

SELECT 
    SUM(salary_year_avg) AS salary_sum,
    COUNT(*) AS count_rows
FROM
    job_postings_fact;



--Example with DISTINCT

SELECT
    COUNT(DISTINCT job_title_short) AS job_type_total
FROM
    job_postings_fact;



--Example with AVG, MIN, and MAX aggregations

SELECT
    AVG(salary_year_avg) AS salary_avg,
    MIN(salary_year_avg) AS salary_min,
    MAX(salary_year_avg) AS salary_max
FROM
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst';



--Example with GROUP BY

SELECT
    job_title_short AS jobs,
    AVG(salary_year_avg) AS salary_avg,
    MIN(salary_year_avg) AS salary_min,
    MAX(salary_year_avg) AS salary_max
FROM
    job_postings_fact
GROUP BY
    job_title_short
ORDER BY
    salary_avg DESC;



--Example with HAVING

SELECT
    job_title_short AS jobs,
    COUNT(job_title_short) AS job_count,
    AVG(salary_year_avg) AS salary_avg,
    MIN(salary_year_avg) AS salary_min,
    MAX(salary_year_avg) AS salary_max
FROM
    job_postings_fact
GROUP BY
    job_title_short
HAVING
    COUNT(job_title_short) > 100
ORDER BY
    salary_avg DESC;



--Example with COUNT, EXTRACT MONTH, WHERE, GROUP BY, and ORDER BY

SELECT 
    COUNT(job_id) AS job_posted_count,
    EXTRACT (MONTH FROM job_posted_date) AS month
FROM 
    job_postings_fact
WHERE 
    job_title_short = 'Data Analyst'
GROUP BY
    month
ORDER BY 
    job_posted_count DESC;



/*

Example: Calculate the current month's total earnings per project. Calculate a scenario where the average rate increase by $5. 

-Calculates the total earnings (hours_spent * hours_rate) per project
-Calculate a scenario where the hourly rate increase by $5

*/

SELECT 
    project_id,
    SUM(hours_spent * hours_rate) AS project_original_cost,
    SUM(hours_spent * (hours_rate + 5)) AS project_projected_cost
FROM
    invoices_fact
GROUP BY
    project_id



-- Example with NOT NULL

SELECT 
    job_title_short,
    job_location,
    job_via,
    salary_year_avg
FROM
    job_postings_fact
WHERE
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg;



-- Example with LEFT JOIN
-- Every job_posting on job_postings_fact attempts to JOIN the company_id

SELECT
    job_postings.job_id,
    job_postings.job_title_short AS title,
    companies.name AS company
FROM 
    job_postings_fact AS job_postings
LEFT JOIN
    company_dim AS companies
    ON job_postings.company_id = companies.company_id
ORDER BY
    job_id;



-- Example with RIGHT JOIN
-- Every company_id on company_dim attempts to JOIN a record on the job_postings_fact table
-- This might be useful if trying to verify data in the company_dim table

SELECT
    job_postings.job_id,
    job_postings.job_title_short AS title,
    companies.name AS company
FROM 
    job_postings_fact AS job_postings
RIGHT JOIN
    company_dim AS companies
    ON job_postings.company_id = companies.company_id
ORDER BY
    job_id;



-- INNER JOIN example
-- basically it shows records that match both left to right and right to left

SELECT
    job_postings.job_id,
    job_postings.job_title,
    skills_to_job.skill_id,
    skills.skills
FROM
    job_postings_fact AS job_postings
INNER JOIN skills_job_dim AS skills_to_job ON job_postings.job_id = skills_to_job.job_id
INNER JOIN skills_dim AS skills ON skills_to_job.skill_id = skills.skill_id;



/* 

Find the average salary and number of jobs postings for each skill for this.
HINT use LEFT JOIN to combine skills_dim and skills_job_dim, and job_postings_fact tables. 
Why? Understand the demand and pay for skill.

*/

