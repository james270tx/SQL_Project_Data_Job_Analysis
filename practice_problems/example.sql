-- SQL_Project_Data_Job_Analysis by james270tx
-- Practice for 'SQL For Data Analytics' course at https://www.youtube.com/watch?v=7mz73uXD9DA

/*
Memory trick... Silly Frogs Wear Green Hats on Lakes
SELECT column1, column2         -- Silly
FROM table_name                 -- Frogs
WHERE column1 = 'value'         -- Wear
GROUP BY column2                -- Green
HAVING COUNT(column2) > 1       -- Hats
ORDER BY column1                -- On
LIMIT 10;                       -- Lakes
*/


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