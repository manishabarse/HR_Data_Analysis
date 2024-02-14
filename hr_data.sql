CREATE DATABASE hr;
USE hr;

SELECT *
FROM hr_data;

SELECT termdate
FROM hr_data
ORDER BY termdate DESC;

-- fix termdate format
-- format the UTC datetime    values
-- update date/time to date format (yyyy-MM-dd)

UPDATE hr_data
SET termdate = FORMAT(CONVERT(DATETIME, LEFT(termdate,19), 120), 'yyyy-MM-dd');

-- create new column named new_termdate
-- update from nvachar to date
ALTER TABLE hr_data
ADD new_termdate DATE;

-- copy converted timevalues from termdate to new_termdate
UPDATE hr_data
SET new_termdate = CASE
	WHEN termdate IS NOT NULL AND ISDATE(termdate) = 1
		THEN CAST(termdate AS DATETIME)
		ELSE NULL
	END;

-- create new column age
ALTER TABLE hr_data
ADD age nvarchar(50);

-- populate new colum with age
UPDATE hr_data
SET age = DATEDIFF(YEAR, birthdate, GETDATE());

SELECT age
FROM hr_data;

-- QUESTIONS

-- 1. What is the age distribution of employees in the company?
-- age distribution
SELECT 
 MIN(age) AS youngest, 
 MAX(age) AS oldest
FROM hr_data;

-- age group distribution

SELECT
  age_group,
  COUNT(*) AS count
FROM (
  SELECT
    CASE
      WHEN age >= 21 AND age <= 30 THEN '21 to 30'
      WHEN age >= 31 AND age <= 40 THEN '31 to 40'
      WHEN age >= 41 AND age <= 50 THEN '41-50'
      ELSE '50+'
    END AS age_group
  FROM hr_data
  WHERE new_termdate IS NULL
) AS Subquery
GROUP BY age_group
ORDER BY age_group ASC;

-- age group by gender
SELECT
  age_group, gender,
  COUNT(*) AS count
FROM (
  SELECT
    CASE
      WHEN age >= 21 AND age <= 30 THEN '21 to 30'
      WHEN age >= 31 AND age <= 40 THEN '31 to 40'
      WHEN age >= 41 AND age <= 50 THEN '41-50'
      ELSE '50+'
    END AS age_group, gender
  FROM hr_data
  WHERE new_termdate IS NULL
) AS Subquery
GROUP BY age_group, gender
ORDER BY age_group, gender ASC;

-- 2. What is the gender breakdown of employees in the company?
SELECT gender,
COUNT(gender) AS count
FROM hr_data
WHERE new_termdate IS NULL
GROUP BY gender
ORDER BY gender ASC;


-- 3. How does the gender distribution vary across departments and job titles?
--gender department
SELECT department, gender,
COUNT(gender) AS count
FROM hr_data
WHERE new_termdate IS NULL
GROUP BY department, gender
ORDER BY department, gender ASC;

--job title
SELECT department, jobtitle, gender,
COUNT(gender) AS count
FROM hr_data
WHERE new_termdate IS NULL
GROUP BY department, jobtitle, gender
ORDER BY department, jobtitle, gender ASC;

-- 4. What is the race/ethnicity breakdown of employees in the company?
SELECT race,
COUNT(*) AS count
FROM hr_data
WHERE new_termdate IS NULL
GROUP BY race
ORDER BY count DESC;

-- 5. What is the average length of employment for employees who have been terminated?
SELECT 
AVG(DATEDIFF(year, hire_date, new_termdate)) AS tenure
FROM hr_data
WHERE new_termdate IS NOT NULL AND new_termdate <= GETDATE();

-- 6. Which department has the highest turnover rate?
-- get total count
-- get terminated count
-- terminated count/total count

SELECT
 department,
 total_count,
 terminated_count,
 (round(CAST(terminated_count AS FLOAT)/total_count, 2)*100) AS turnover_rate
FROM 
   (SELECT
   department,
   count(*) AS total_count,
   SUM(CASE
        WHEN new_termdate IS NOT NULL AND new_termdate <= getdate()
		THEN 1 ELSE 0
		END
   ) AS terminated_count
  FROM hr_data
  GROUP BY department
  ) AS Subquery
ORDER BY turnover_rate DESC;

-- 7. What is the tenure distribution for each department?
SELECT 
AVG(DATEDIFF(year, hire_date, new_termdate)) AS tenure
FROM hr_data
WHERE new_termdate IS NOT NULL AND new_termdate <= GETDATE()
GROUP BY department
ORDER BY tenure DESC;

-- 8. How many employees work at headquarters versus remote locations?
SELECT
 location,
 count(*) AS count
 FROM hr_data
 WHERE new_termdate IS NULL
 GROUP BY location;

-- 9. What is the distribution of employees across locations by city and state?
--city
SELECT
 location_city,
 count(*) AS count
 FROM hr_data
 WHERE new_termdate IS NULL
 GROUP BY location_city 
 ORDER BY count DESC;
 
 --state
SELECT
 location_state,
 count(*) AS count
 FROM hr_data
 WHERE new_termdate IS NULL
 GROUP BY location_state 
 ORDER BY count DESC;

-- 10. How is the distribution of job titles across the company?
SELECT
 jobtitle,
 count(*) AS count
 FROM hr_data
 WHERE new_termdate IS NULL
 GROUP BY jobtitle 
 ORDER BY count DESC;


-- 11. How has the company's employee count changed over time based on hire and term dates?
-- calculate hires
-- calculate terminations
-- ((hires-terminations)/hires)*100 percent hire change

SELECT
 hire_year,
 hires,
 terminations,
 hires - terminations AS net_change,
 (round(CAST(hires-terminations AS FLOAT)/hires, 2)) * 100 AS percent_hire_change
 FROM
	(SELECT 
	 YEAR(hire_date) AS hire_year,
	 count(*) AS hires,
	 SUM(CASE
			WHEN new_termdate is not null and new_termdate <= GETDATE() THEN 1 ELSE 0
			END
			) AS terminations
	FROM hr_data
	GROUP BY YEAR(hire_date)
	) AS subquery
ORDER BY percent_hire_change ASC, hire_year ASC;
