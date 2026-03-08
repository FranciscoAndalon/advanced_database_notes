# CROSS JOIN

## My understanding
Cross join combines every row from one table with every row from another table.

## Why it matters
It can create very large sets of results, so it's better to use it carefully.

## Example
SELECT *
FROM colors
CROSS JOIN sizes;
