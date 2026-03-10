# Session – 2026-02-26

## Topics covered
- Why grouping helps to summarize data
- MAX, MIN, AVG, SUM, COUNT (aggregate functions)
- How GROUP BY works
- Difference between COUNT(*), COUNT(column), and COUNT(DISTINCT column)
- How NULL values affect aggregate functions
- Grouping by more than one column
- Grouping by expressions
- Difference between WHERE and HAVING
- Rollups and subtotals

## What I understood
- GROUP BY helps to compress a lot of rows into smaller summarized results.
- Aggregate functions are used to calculate totals, averages, counts, maximums, and minimums.
- COUNT(*) counts all rows, but COUNT(column) ignores NULLs.
- DISTINCT deletes duplicates before counting.
- WHERE filters rows before grouping. HAVING filters groups after grouping.

## What is still confusing
- When I should use HAVING instead of WHERE without overthinking it.
- Grouping by expressions still feels a little bit new to me.
- Rollups make sense in theory, but I still need more practice reading the NULL subtotal rows.

## Questions
- Is HAVING always slower than WHERE, or does it depend on the query?
- When should I use COUNT(DISTINCT ...) instead of grouping first?
- Are rollups common in real projects or generally just for reports?

## Related concepts
- GROUP BY￼
- Aggregate Functions￼
- COUNT and DISTINCT￼
- NULLs in Aggregates￼
- HAVING Clause￼

## Resources used
- See `resources/`