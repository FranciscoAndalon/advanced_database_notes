# Session – 2026-03-05

## Topics covered
- Aggregate functions (SUM, AVG, COUNT, MAX)
- Grouping data with GROUP BY
- Filtering grouped results with HAVING
- Window functions using OVER
- Using PARTITION BY to calculate values per group
- Doing calculations with ORDER BY inside window functions
- Window frames like ROWS BETWEEN
- Ranking rows with functions like DENSE_RANK

## What I understood
- Aggregate functions summarize data from a lot of rows into one value.
- GROUP BY splits data into groups so aggregates can be calculated per group.
- HAVING filters results after grouping.
- Window functions calculate values across rows but still keep each row in the result.
- PARTITION BY divides data into groups inside a window function.
- Ranking functions help to find top values inside groups.

## What is still confusing
- The difference between ROWS and RANGE in window functions.
- Remembering when to use GROUP BY instead of a window function.
- Window frames still feel a little bit complicated to visualize.

## Questions
- When should I prefer window functions instead of GROUP BY?
- Are running calculations expensive for big datasets?
- Is DENSE_RANK always better than RANK when there are ties?

## Related concepts
- [Aggregate Functions](../concepts/aggregate-functions.md)
- [GROUP BY](../concepts/group-by.md)
- [HAVING Clause](../concepts/having-clause.md)

## Resources used
- See `resources/`
