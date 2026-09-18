# Data Analyst Job Market Analysis (SQL)

## Overview

I created this project to better understand the data analyst job market. Using SQL, I analyzed 2,253 job listings to see where the most opportunities were, which technical skills employers requested, and how estimated salaries differed by location.

## Questions I explored

* Which cities had the most data analyst job listings?
* Which industries were hiring the most?
* Which technical skills appeared most often in job descriptions?
* What was the estimated average salary?
* How did salaries and employer ratings compare across locations and industries?
* Which job titles and experience levels appeared most often?

## What I did

* Imported the CSV into SQLite and checked the table structure.
* Used `COUNT`, `AVG`, `SUM`, `GROUP BY`, `HAVING`, and `ORDER BY` to summarize the data.
* Searched job descriptions for SQL, Excel, Python, Tableau, and Power BI.
* Used a CTE and text functions to turn salary ranges into numbers and estimate average salaries.
* Used `CASE` statements to group job titles by experience level.
* Filtered out missing values such as `-1` when needed.

## Key findings

* The dataset contained 2,253 job listings.
* New York had the most listings with 310, followed by Chicago with 130 and San Francisco with 119.
* IT Services and Staffing & Outsourcing had the most listings, with 325 and 323.
* SQL and Excel were the most frequently mentioned skills, appearing in 1,389 and 1,354 job descriptions.
* Python appeared in 637 listings, Tableau in 620, and Power BI in 180.
* The estimated average salary was about $72,100 per year.
* Among cities with at least 20 listings, San Jose had the highest estimated average salary at $108,900.
* Most titles did not clearly state an experience level. I found 404 senior, 101 leadership, and 84 junior or entry-level listings based on title keywords.
* `Data Analyst` was the most common exact title with 405 listings.

## A note about the data

* Salaries are estimates, not confirmed compensation.
* Skill counts are based on keyword mentions and do not show the level of experience required.
* Experience levels were identified only from words in the job title, so some roles may have been classified as “Not specified.”
* These results describe this dataset and not the entire current job market.

## Files

* `DataAnalyst.csv` — source data
* `data_analyst_job_market_analysis.sql` — queries used in the analysis
