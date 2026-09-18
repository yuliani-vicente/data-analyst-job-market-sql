-- Data Analyst Job Market Analysis
-- Dataset: DataAnalyst.csv (2,253 job listings)
-- SQL dialect: SQLite

-- 1. Preview the data
SELECT *
FROM DataAnalyst
LIMIT 10;

-- 2. Count all job listings
SELECT COUNT(*) AS total_jobs
FROM DataAnalyst;

-- 3. Top locations by number of job listings
SELECT location, COUNT(*) AS job_count
FROM DataAnalyst
GROUP BY location
ORDER BY job_count DESC
LIMIT 10;

-- 4. Top industries by number of job listings
SELECT industry, COUNT(*) AS job_count
FROM DataAnalyst
WHERE industry IS NOT NULL
  AND industry <> '-1'
GROUP BY industry
ORDER BY job_count DESC
LIMIT 10;

-- 5. Technical skills mentioned in job descriptions
SELECT
  SUM(CASE WHEN LOWER(job_description) LIKE '%sql%' THEN 1 ELSE 0 END) AS sql_jobs,
  SUM(CASE WHEN LOWER(job_description) LIKE '%excel%' THEN 1 ELSE 0 END) AS excel_jobs,
  SUM(CASE WHEN LOWER(job_description) LIKE '%python%' THEN 1 ELSE 0 END) AS python_jobs,
  SUM(CASE WHEN LOWER(job_description) LIKE '%tableau%' THEN 1 ELSE 0 END) AS tableau_jobs,
  SUM(CASE WHEN LOWER(job_description) LIKE '%power bi%' THEN 1 ELSE 0 END) AS power_bi_jobs
FROM DataAnalyst;

-- 6. Industries with the highest employer ratings
-- A minimum of 20 rated listings reduces the effect of very small samples.
SELECT
  industry,
  ROUND(AVG(rating), 2) AS average_rating,
  COUNT(*) AS job_count
FROM DataAnalyst
WHERE industry IS NOT NULL
  AND industry <> '-1'
  AND rating > 0
GROUP BY industry
HAVING COUNT(*) >= 20
ORDER BY average_rating DESC
LIMIT 10;

-- 7. Inspect salary formats before cleaning
SELECT salary_estimate, COUNT(*) AS job_count
FROM DataAnalyst
GROUP BY salary_estimate
ORDER BY job_count DESC
LIMIT 15;

-- 8. Estimated average annual salary
-- Salary values are stored as text ranges such as $42K-$76K.
WITH cleaned_salaries AS (
  SELECT
    CAST(
      REPLACE(
        SUBSTR(salary_estimate, 1, INSTR(salary_estimate, '-') - 1),
        '$', ''
      ) AS REAL
    ) AS minimum_salary_k,
    CAST(
      REPLACE(
        SUBSTR(salary_estimate, INSTR(salary_estimate, '-') + 1),
        '$', ''
      ) AS REAL
    ) AS maximum_salary_k
  FROM DataAnalyst
  WHERE salary_estimate LIKE '$%K-$%K%'
)
SELECT
  ROUND(AVG((minimum_salary_k + maximum_salary_k) / 2), 1)
    AS average_salary_k
FROM cleaned_salaries;

-- 9. Highest-paying locations
-- Only locations with at least 20 listings are included.
WITH cleaned_salaries AS (
  SELECT
    location,
    CAST(
      REPLACE(
        SUBSTR(salary_estimate, 1, INSTR(salary_estimate, '-') - 1),
        '$', ''
      ) AS REAL
    ) AS minimum_salary_k,
    CAST(
      REPLACE(
        SUBSTR(salary_estimate, INSTR(salary_estimate, '-') + 1),
        '$', ''
      ) AS REAL
    ) AS maximum_salary_k
  FROM DataAnalyst
  WHERE salary_estimate LIKE '$%K-$%K%'
)
SELECT
  location,
  ROUND(AVG((minimum_salary_k + maximum_salary_k) / 2), 1)
    AS average_salary_k,
  COUNT(*) AS job_count
FROM cleaned_salaries
GROUP BY location
HAVING COUNT(*) >= 20
ORDER BY average_salary_k DESC
LIMIT 10;

-- 10. Job listings by experience level stated in the title
SELECT
  CASE
    WHEN LOWER(job_title) LIKE '%manager%'
      OR LOWER(job_title) LIKE '%director%'
      OR LOWER(job_title) LIKE '%lead%'
      OR LOWER(job_title) LIKE '%principal%'
      THEN 'Leadership'
    WHEN LOWER(job_title) LIKE '%senior%'
      OR LOWER(job_title) LIKE '%sr.%'
      OR LOWER(job_title) LIKE '%sr %'
      THEN 'Senior'
    WHEN LOWER(job_title) LIKE '%junior%'
      OR LOWER(job_title) LIKE '%jr.%'
      OR LOWER(job_title) LIKE '%jr %'
      OR LOWER(job_title) LIKE '%entry%'
      THEN 'Junior/Entry'
    ELSE 'Not specified'
  END AS experience_level,
  COUNT(*) AS job_count
FROM DataAnalyst
GROUP BY experience_level
ORDER BY job_count DESC;

-- 11. Most common job titles
SELECT job_title, COUNT(*) AS job_count
FROM DataAnalyst
GROUP BY job_title
ORDER BY job_count DESC
LIMIT 10;
