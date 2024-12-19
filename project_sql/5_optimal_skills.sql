/*

What are the most optimal skills to learn?
--aka high paying and high demand
--Identify skills in high demand and associated with high average salaries for Data Analyst roles
--Concentrate on remote positions with specified salaries
--Why? Targets skills that offer job security (high demand) and financial benefits (high salary) offering strategies insights for career development in Data Analysis

*/

WITH skills_demand AS (
    SELECT 
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT(skills_job_dim.job_id) AS count
    FROM 
        job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst'
        AND salary_year_avg IS NOT NULL
        AND job_work_from_home = TRUE
    GROUP BY
        skills_dim.skill_id
), avg_salary AS (
    SELECT 
        skills_job_dim.skill_id,
        ROUND(AVG(salary_year_avg), 0) AS avg_salary
    FROM 
        job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst'
        AND salary_year_avg IS NOT NULL
        AND job_work_from_home = TRUE
    GROUP BY
        skills_job_dim.skill_id
)

SELECT
    --skills_demand.skill_id,
    skills_demand.skills,
    count,
    avg_salary
FROM 
    skills_demand 
INNER JOIN avg_salary ON skills_demand.skill_id = avg_salary.skill_id
ORDER BY
    count DESC,
    avg_salary DESC
LIMIT 25;