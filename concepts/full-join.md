# FULL JOIN

## My understanding
Full join returns everything from both tables while filling missing matches with NULLs.

## Why it matters
It's useful when you don't want to lose any data from either table.

## Example
SELECT *
FROM customers c
FULL JOIN orders o
  ON c.id = o.customer_id;