# COUNT and DISTINCT

## My understanding
COUNT(*) counts all rows and DISTINCT deletes values that are repeated before counting.

## Why it matters
This matter when we want to know how many total rows there are versus how many unique values there are.

## Example
SELECT COUNT(DISTINCT shape)
FROM bricks;