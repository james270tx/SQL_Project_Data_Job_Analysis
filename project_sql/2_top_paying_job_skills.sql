/*

What skills are required for the top paying jobs?
--Use top 10 paying jobs from the first query
--Add specific skills for these jobs
--Why? It provides a look at which high paying jobs demand certain skills, helping job seekers to understand which skills to develop that align with top paying job opportunities

*/

WITH top_paying_jobs AS (
    SELECT
        job_id,
        company_dim.name AS company_name,
        job_title,
        salary_year_avg
    FROM
        job_postings_fact
    LEFT JOIN company_dim on job_postings_fact.company_id = company_dim.company_id
    WHERE
        job_title_short = 'Data Analyst' AND
        job_location = 'Anywhere' AND 
        salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
)

SELECT 
    top_paying_jobs.*,
    skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id --INNER JOIN works well here because it will disregard job postings with no skill_ID
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id --INNER JOIN here again to disregard job postings with NULL skill_id values
ORDER BY
    salary_year_avg DESC;