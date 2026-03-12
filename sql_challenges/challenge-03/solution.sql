-- SQLBolt Lesson 10 --

-- 1) Longest time an employee has been at the studio
SELECT MAX(years_employed) AS longest_time
FROM employees;

-- 2) For each role, average years employed
SELECT role, AVG(years_employed) AS avg_years
FROM employees
GROUP BY role;

-- 3) Total employee years worked in each building
SELECT building, SUM(years_employed) AS total_years
FROM employees
GROUP BY building;

-- SQLBolt Lesson 11 -- 

-- 1) Number of Artists (without HAVING)
SELECT COUNT(*) AS num_artists
FROM employees
WHERE role = 'Artist';

-- 2) Number of employees of each role
SELECT role, COUNT(*) AS num_employees
FROM employees
GROUP BY role;

-- 3) Total years employed by all Engineers
SELECT SUM(years_employed) AS total_engineer_years
FROM employees
WHERE role = 'Engineer';

-- Aggregating Rows: Databases for Developers (freesql.com) --

-- TryIt #1 --
select COUNT(DISTINCT shape) number_of_shapes,
       STDDEV(DISTINCT weight) distinct_weight_stddev
from   bricks;

-- TryIt #2 --
select shape, SUM(weight) shape_weight
from   bricks
GROUP BY shape;

-- TryIt #3 --
select shape, sum(weight)
from   bricks
group  by shape
HAVING sum(weight) < 4;