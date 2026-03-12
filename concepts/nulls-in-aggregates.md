# NULLs in Aggregates

## My understanding
The majority of aggregate functions ignore NULL values, but COUNT(*) is different because it counts rows, even if some values are NULL.
 
## Why it matters
If we ignore this concept we can get totals or averages that are look confusing or wrong.

## Example
SELECT COUNT(*), COUNT(weight), AVG(weight)
FROM bricks;