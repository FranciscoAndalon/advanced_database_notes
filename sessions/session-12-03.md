# Session – 2026-03-12

## Topics covered
- Combining results from multiple queries
- UNION to merge results without duplicates
- UNION ALL to merge results while keeping duplicates
- INTERSECT to find values that appear in both queries
- MINUS to find values that appear in one query but not another
- How sorting works after combining queries with ORDER BY

## What I understood
- SQL can combine results from different tables using set operations.
- UNION deletes duplicates automatically.
- UNION ALL keeps all rows from both queries.
- INTERSECT finds the common values between two queries.
- MINUS returns values that exist in the first query but not the second.
- ORDER BY is written at the end of the whole combined query.

## What is still confusing
- Remembering when duplicates are deleted automatically.
- The difference between MINUS and EXCEPT in different databases.
- Sometimes it’s hard to know if a problem should use JOIN or a set operation.

## Questions
- Are set operations slower than joins in big datasets?
- Is INTERSECT commonly used in real projects?
- Are UNION operations optimized internally by databases?

## Related concepts
- [UNION]
- [UNION ALL]
- [INTERSECT]
- [MINUS]

## Resources used
- See `resources/`