# Session – YYYY-MM-DD

## Topics covered
- Why databases use multiple tables
- How JOINs connect related tables
- INNER JOIN vs LEFT JOIN
- RIGHT JOIN and FULL JOIN
- CROSS JOIN and why it can be dangerous
- SELF JOIN for working with hierarchies
- Basic JOIN syntax and ON conditions

## What I understood
- JOINs are used when data is divided in different tables.
- INNER JOIN only keeps rows that exist in both tables.
- LEFT JOIN keeps everything from the left table, even if there is no match.
- Missing matches in JOINs are shown as NULL.
- The ON condition is what tells SQL how tables are related.

## What is still confusing
- Knowing fast which JOIN type to use in a real problem.
- Visualizing FULL JOIN results without needing to draw them.
- Remembering that CROSS JOIN doesn't have an ON condition.

## Questions
- When should I use a LEFT JOIN instead of filtering later with WHERE?
- Are RIGHT JOINs actually used in practice, or can they always be rewritten?
- How do JOINs affect performance when tables get bigger?

## Related concepts
- [INNER JOIN](../concepts/inner-join.md)
- [LEFT JOIN](../concepts/left-join.md)
- [FULL JOIN](../concepts/full-join.md)
- [CROSS JOIN](../concepts/cross-join.md)
- [SELF JOIN](../concepts/self-join.md)

## Resources used
- See `resources/`
