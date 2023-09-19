--The average age of employees in each department and gender group. ( Rounding average age up to two decimal places)
SELECT ROUND(AVG(E.age),2) AS Avg_Age, E.department, E.gender
FROM employee E
GROUP BY E.department, E.gender

-- The top 3 departments with the highest average training scores. ( Rounding average scores up to two decimal places)
SELECT E.department, ROUND(AVG(E.avg_training_score),2) AS avg_score
FROM employee E
GROUP BY E.department
ORDER BY E.avg_training_score DESC
LIMIT 3

-- The percentage of employees who have won awards in each region. (Rounding percentages up to two decimal places)
SELECT E.region,
SUM(E.awards_won)*100/(SELECT SUM(awards_won) FROM employee) AS percent
FROM employee E
GROUP BY E.region
HAVING percent > 0.00

-- The number of employees who have met more than 80% of KPIs for each recruitment channel and education level.
SELECT SUM(E.KPIs_met_more_than_80) as employees, E.recruitment_channel, E.education
FROM employee E
GROUP BY E.recruitment_channel, E.education

-- The average length of service for employees in each department, considering only employees with previous year ratings greater than or equal to 4. ( Round average length up to two decimal places)
SELECT ROUND(AVG(E.length_of_service),2) as avg_service, E.department
FROM employee E
WHERE E.previous_year_rating >= 4
GROUP BY E.department

-- The top 5 regions with the highest average previous year ratings. ( Rounding average ratings up to two decimal places)
SELECT E.region, ROUND(AVG(E.previous_year_rating),2) AS avg_rating
FROM employee E
GROUP BY E.region
ORDER BY avg_rating DESC
LIMIT 5

-- The departments with more than 100 employees having a length of service greater than 5 years.
SELECT E.department, COUNT(E.department) AS employee_count
FROM employee E
WHERE E.length_of_service >5
GROUP BY E.department
HAVING (COUNT(E.department) > 100)

-- The average length of service for employees who have attended more than 3 trainings, grouped by department and gender. 
-- (Rounding average length up to two decimal places)
SELECT ROUND(AVG(E.length_of_service),2) as avg_service, E.department, E.gender
FROM employee E
WHERE E.no_of_trainings >3
GROUP BY E.department, E.gender

-- The percentage of female employees who have won awards, per department. Also show the number of female employees who won awards
-- and total female employees. ( Rounding percentage up to two decimal places)
SELECT ROUND(SUM(E.awards_won)*100/COUNT(E.gender),2) AS percent_won, E.department, SUM(E.awards_won) AS f_emp_won, COUNT(E.gender) AS tot_female
FROM employee E
WHERE (E.gender = 'f')
GROUP BY E.department

-- The percentage of employees per department who have a length of service between 5 and 10 years. ( Rounding percentage up to two decimal places)
SELECT E.department, ROUND( COUNT(E.length_of_service)*100/(SELECT COUNT(E1.department) FROM employee E1 WHERE E1.department=E.department),2) AS percent
FROM employee E
WHERE (E.length_of_service>=5) AND (E.length_of_service<=10)
GROUP BY E.department

-- The top 3 regions with the highest number of employees who have met more than 80% of their KPIs and received at least one award, grouped by department and region.
SELECT E.department, E.region, COUNT(E.employee_id) AS emp_count
FROM employee E
WHERE (E.KPIs_met_more_than_80) AND (E.awards_won)
GROUP BY E.region, E.department
ORDER BY emp_count DESC
LIMIT 3

-- The average length of service for employees per education level and gender, considering only those employees who have completed more than 2 trainings
--and have an average training score greater than 75 ( Rounding average length up to two decimal places)
SELECT E.education, E.gender, ROUND(AVG(E.length_of_service),2) AS avg_len_service
FROM employee E
WHERE (E.no_of_trainings>2) AND (E.avg_training_score>75)
GROUP BY E.education, E.gender

-- For each department and recruitment channel, The total number of employees who have met more than 80% of their KPIs, have a previous_year_rating of 5,
-- and have a length of service greater than 10 years.
SELECT E.department, E.recruitment_channel, COUNT(E.employee_id) AS emp_count
FROM employee E
WHERE (E.previous_year_rating=5) AND (E.length_of_service>10) AND(E.KPIs_met_more_than_80=1)
GROUP BY E.department, E.recruitment_channel

-- The percentage of employees in each department who have received awards, have a previous_year_rating of 4 or 5, and an average training score above 70,
-- grouped by department and gender ( Rounding percentage up to two decimal places )
SELECT E.department, E.gender, ROUND(SUM(E.awards_won)*100/(SELECT COUNT(E1.awards_won) 
                                                            FROM employee E1 WHERE (E1.department=E.department)AND(E1.gender=E.gender)),2) AS percent_emp
FROM employee E
WHERE (E.previous_year_rating = 4 OR E.previous_year_rating = 5) AND (E.avg_training_score>70) OR (E.awards_won = 0)
GROUP BY E.department, E.gender

-- The top 5 recruitment channels with the highest average length of service for employees who have met more than 80% of their KPIs,
-- have a previous_year_rating of 5, and an age between 25 and 45 years, grouped by department and recruitment channel. 
-- ( Rounding average length up to two decimal places)
SELECT E.department, E.recruitment_channel, ROUND(AVG(E.length_of_service),2) AS avg_len_service
FROM employee E
WHERE (E.KPIs_met_more_than_80) AND (E.previous_year_rating=5) AND (E.age BETWEEN 25 AND 45)
GROUP BY E.department, E.recruitment_channel
ORDER BY avg_len_service DESC
LIMIT 5