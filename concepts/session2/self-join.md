# SELF JOIN

## My understanding
Self join joins a table to itself using aliases.

## Why it matters
It's useful for hierarchies, like employees and their managers.

## Example
SELECT e.name, m.name AS manager
FROM employees e
LEFT JOIN employees m
  ON e.manager_id = m.id;