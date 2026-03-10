# INNER JOIN

## My understanding
An inner join only returns the rows that have values that match in both tables.

## Why it matters
Helps to combine related data without including incomplete rows.

## Example
SELECT *
FROM employees e
INNER JOIN departments d
  ON e.dept_id = d.id;