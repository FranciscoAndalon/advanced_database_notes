# HAVING Clause

## My understanding
HAVING is used to filter grouped results after GROUP BY.

## Why it matters
It allows to filter summaries, like only showing groups that have a total greater than some number.

## Example
SELECT shape, SUM(weight)
FROM bricks
GROUP BY shape
HAVING SUM(weight) < 4;