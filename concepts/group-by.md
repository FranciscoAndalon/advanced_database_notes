# GROUP BY

## My understanding
GROUP BY is used to put rows in groups that have the same value, like the same role, customer or year. 

## Why it matters
It helps turn data with a lot of details into summaries that are easier to understand.

## Example
SELECT role, COUNT(*)
FROM employees
GROUP BY role;