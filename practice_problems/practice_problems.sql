-- SQL_Project_Data_Job_Analysis by james270tx
-- Practice for 'SQL For Data Analytics' course at https://www.youtube.com/watch?v=7mz73uXD9DA

/*

Get job details for both 'Data Analyst' or 'Business Analyst' positions. For 'Data Analyst' I want jobs only > '$100k'. For 'Business Analyst' I want jobs only > '$70k'. Only include jobs located in either 'Boston, MA' or 'Anywhere' IE remote.

*/

SELECT 
    job_title,
    job_title_short,
    salary_year_avg,
    job_location
FROM 
    job_postings_fact
WHERE 
    job_location IN ('Anywhere', 'Boston, MA') AND
    (
        (job_title_short = 'Data Analyst' AND salary_year_avg > 100000) OR
        (job_title_short = 'Business Analyst' AND salary_year_avg > 70000)
    )
ORDER BY salary_year_avg DESC;



/*

In the company_dim table find all companies that include 'tech' followed immediately followed by any single character. Return the name column.

*/

SELECT name 
FROM company_dim
WHERE name LIKE '%tech_';



/*

Find all job postings in the job_postings_fact table where job title is exactly 'Engineer' and any one character followed immediately after the term. Get job_id, job_title, and job_posted_date.

*/

SELECT 
    job_id,
    job_title,
    job_posted_date
FROM job_postings_fact
WHERE job_title LIKE 'Engineer_';



/*

From the job_postings_fact return the following columns job_id, job_title_short, job_location, job_via, job_posted_date, and salary_year_avg. Also rename the following job_via to job_posted_site and salary_year_avg to avg_yearly_salary

*/

SELECT
    job_id,
    job_title_short,
    job_location,
    job_via AS job_posted_site,
    job_posted_date,
    salary_year_avg AS avg_yearly_salary
FROM job_postings_fact
LIMIT 10;



/*

Write a query to find the average salary both yearly ( salary_year_avg ) and hourly ( salary_hour_avg ) for job postings that were posted after June 1, 2023. Group the results by job schedule type.

*/

SELECT 
    job_schedule_type,
    AVG(job_postings_fact.salary_year_avg) as average_salary,
    AVG(job_postings_fact.salary_hour_avg) as average_hourly
FROM job_postings_fact
WHERE job_posted_date > '2023_06_01'
GROUP BY job_schedule_type;



/*

Write a query to count the number of job postings for each month in 2023, adjusting the job_posted_date to be in America/New York time zone before extracting (hint) the month. Assume the job_posted_date is stored in UTC. Group and order by the month.

*/

SELECT 
    COUNT(job_id) AS job_posted_count,
    EXTRACT (MONTH FROM job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'America/New_York') AS month
FROM 
    job_postings_fact
GROUP BY month
ORDER BY month;



/* 

Write a query to find companies (include company name) that have posted jobs offering health insurance, where these postings were made in the 2nd quarter of 2023. Use date extraction to filter by quarter.

*/

SELECT 
    company_id,
    job_health_insurance,
    EXTRACT (QUARTER FROM job_posted_date) AS quarter,
    EXTRACT (YEAR FROM job_posted_date) AS year
FROM job_postings_fact
WHERE 
    job_health_insurance IS TRUE
    AND EXTRACT(QUARTER FROM job_posted_date) = '2'
    AND EXTRACT (YEAR FROM job_posted_date) = '2023';

