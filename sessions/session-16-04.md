# Session – 2026-04-16

## Topics covered
- Database indexes
- High and low cardinality
- Execution plans
- Full table scans and index scans
- Range queries
- Composite indexes
- Column order in indexes
- How functions can prevent using indexes
- Indexing strategies for OLTP and reporting systems

## What I understood
- Indexes help queries run faster by not doing full table scans.
- Whether using an index is worth it or not depends on the query.
- Columns with high cardinality generally are better candidates for indexes.
- Composite indexes depend on the order of the columns.
- Wrapping indexed columns in functions can make the optimizer not use the index.
- Execution plans help show what Oracle is actually doing internally.

## What is still confusing
- Exactly how Oracle decides between an index scan and a full table scan.
- Reading execution plans.
- When indexes become more expensive than useful because of inserts and updates.

## Questions
- How does Oracle calculate query cost internally?
- Are bitmap indexes still common today?
- How many indexes is too many for a table?

## Related concepts
- Indexes
- Cardinality
- Execution Plans
- Composite Indexes
- Range Scans

## Resources used
- See `resources/`