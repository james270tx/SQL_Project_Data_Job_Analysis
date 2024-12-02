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

*/


