CREATE DATABASE ab_testing_project;
USE ab_testing_project;
SELECT * FROM ab_testing_dataset;
ALTER TABLE ab_testing_dataset
RENAME COLUMN `group` TO group_name;
DESCRIBE ab_testing_dataset;

-- count total users in each group
SELECT 
    group_name, COUNT(*) AS total_users
FROM
    ab_testing_dataset
GROUP BY group_name;

-- total conversion in each group
SELECT 
    group_name, SUM(converted) AS total_conversions
FROM
    ab_testing_dataset
GROUP BY group_name;

-- conversion rate by group
SELECT 
    group_name,
    COUNT(*) AS total_users,
    SUM(converted) AS total_conversions,
    ROUND(SUM(converted) * 100.0 / COUNT(*), 2) AS conversion_rate
FROM
    ab_testing_dataset
GROUP BY group_name;

-- average time spent by group
SELECT 
    group_name, ROUND(AVG(time_spent), 2) AS avg_time_spent
FROM
    ab_testing_dataset
GROUP BY group_name;

SELECT 
    group_name,
    COUNT(*) AS total_users,
    SUM(converted) AS total_conversions,
    ROUND(SUM(converted) * 100.0 / COUNT(*), 2) AS conversion_rate,
    ROUND(AVG(time_spent), 2) AS avg_time_spent
FROM
    ab_testing_dataset
GROUP BY group_name;

-- conversion rate difference between A and B 
WITH conversion_summery AS(
	SELECT
		group_name,
        ROUND(SUM(converted)*100.0/COUNT(*),2) AS conversion_rate
	FROM ab_testing_dataset
GROUP BY group_name
)
SELECT 
	MAX(CASE WHEN group_name = 'B' THEN conversion_rate END) -
	MAX(CASE WHEN group_name = 'A' THEN conversion_rate END) AS conversion_rate_difference
FROM conversion_summery;