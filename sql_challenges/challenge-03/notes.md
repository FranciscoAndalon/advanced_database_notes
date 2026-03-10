### Reasonings

## SQLBolt Lesson 10

# 1) Longest time an employee has been at the studio
MAX gives the biggest value in years_employed, so that's the longest time.

# 2) For each role, average years employed
AVG calculates the mean, and GROUP BY role makes it one average per role.

# 3) Total employee years worked in each building
SUM adds the years together, and GROUP BY building divides the totals by building.

## SQLBolt Lesson 11

# 1) Number of Artists (without HAVING)
I filter only Artists with WHERE to then count how many rows are left.

# 2) Number of employees of each role
COUNT(*) counts rows per group, and the group is each role.

# 3) Total years employed by all Engineers
First filter to Engineers and then add up their years_employed.

## Aggregating Rows: Databases for Developers (freesql.com)

# TryIt #1
COUNT(DISTINCT shape) counts how many different shapes there are, and STDDEV(DISTINCT weight) gets the standard deviation but using only unique weights.

# TryIt #2
I group rows by shape, then SUM(weight) gives the total weight per shape.

# TryIt #3
HAVING is for filtering after grouping, so I keep only shapes that give a total summed weight of less than 4.