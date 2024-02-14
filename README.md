## HR Data Analysis Project

This project focuses on analyzing human resource data to derive valuable insights using SQL queries. The dataset contains employee information such as age, gender, job title, department, location, race, hire date, and termination date. The analysis aims to uncover trends, patterns, and metrics related to employee demographics, turnover rates, tenure distribution, departmental performance, and geographical distribution.

## Overview

The HR Data Analysis Project utilizes SQL queries to explore and analyze a dataset comprising 22,000 records spanning from 2000 to 2020. The analysis encompasses various aspects of HR management, including data loading, inspection, handling missing values, data cleaning, and analysis. The insights derived from the analysis are visualized and presented using Power BI dashboards.

## Data Loading & Inspection

- The dataset is loaded into SQL Server Management Studio (SSMS) using the `CREATE DATABASE` and `USE` commands.
- Basic SQL queries are used to inspect the dataset, including `SELECT * FROM hr_data` to view all records and `SELECT termdate FROM hr_data ORDER BY termdate DESC` to examine termination dates.

## Handling Missing Values

- The `termdate` column, imported as `nvarchar(50)`, contains termination dates and needs to be converted to date format.
- SQL queries are used to fix the `termdate` format, create a new column `new_termdate`, and populate it with converted time values.

## Data Cleaning & Analysis

- New columns such as `age` are created to facilitate analysis.
- SQL queries are used to calculate age distribution, gender breakdown, departmental turnover rates, tenure distribution, geographical distribution, and more.

## Power BI Visualization

- The insights derived from the SQL analysis are visualized and presented using Power BI dashboards.
- The Power BI report includes various interactive visualizations such as bar charts, pie charts, line charts, and tables, allowing users to explore HR metrics in-depth.

## Outcomes

- Age distribution analysis reveals the youngest and oldest employees in the company.
- Gender breakdown analysis provides insights into the gender distribution across departments and job titles.
- Race/ethnicity breakdown analysis highlights the diversity within the company.
- Average tenure analysis sheds light on employee retention.
- Departmental turnover rate analysis identifies departments with the highest turnover rates.
- Tenure distribution analysis provides insights into the tenure distribution across departments.
- Location analysis reveals the distribution of employees across different cities and states.
- Job title distribution analysis showcases the distribution of job titles across the company.
- Analysis of changes in employee count over time provides insights into hiring and termination trends.

## Conclusion

The HR Data Analysis Project offers a comprehensive exploration of human resource data using SQL queries and Power BI visualization. The insights derived from the analysis can inform strategic workforce planning, recruitment strategies, and organizational decision-making. By leveraging data-driven insights, organizations can optimize HR processes and enhance employee satisfaction and retention.

## Credits

- [Kahethu](https://www.youtube.com/watch?v=4yn7iUJnJtE) - Thanks for providing valuable guidance and inspiration through his tutorial videos!

