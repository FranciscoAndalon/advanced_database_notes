# LEFT JOIN

## My understanding
Left join keeps all rows from the left table and adds matching data from the right table when it exists.

## Why it matters
Allows to see missing relationships, like buildings with no employees.

## Example
SELECT *
FROM buildings b
LEFT JOIN employees e
  ON b.name = e.building;
  