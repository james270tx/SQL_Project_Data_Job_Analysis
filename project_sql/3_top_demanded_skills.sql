/*

What are the top in demand skills for data analysis?
--Join job postings to inner join table similar to part 2
--Identify the top 5 in demand skills for a data analyst
--Focus on all job postings
--Why? Retrieves the top 5 skills with the highest demand in the job market
----Provides insights into the most valuable skills for job seekers

*/

SELECT 
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS count
FROM 
    job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
GROUP BY
    skills_dim.skills
ORDER BY
    count DESC
LIMIT 5
