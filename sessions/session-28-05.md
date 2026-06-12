# Session – 2026-05-28

## Topics covered
- ETL process
- OLTP tables
- Data warehouse tables
- Assignment history
- Triggers for logging changes
- Star schema
- Dimension tables
- Fact tables
- Surrogate keys
- Historical assignment tracking
- Basic pandas ETL logic

## What I understood
- OLTP tables are used for day-to-day application data.
- A data warehouse is better for reporting and analytics.
- Assignment history is needed when the current row is not enough.
- Triggers can automatically record changes when assignments are updated.
- Dimension tables describe entities like agents.
- Fact tables store numeric events, like tickets created or resolved.
- ETL means extracting data, transforming it, and loading it into another structure.

## What is still confusing
- How to handle late-arriving data in a real warehouse.
- How often the ETL process should run.
- How to update facts if source data changes after it was already loaded.
- How to manage slowly changing dimensions.

## Questions
- Should assignment history always be stored in OLTP, or only in the warehouse?
- What happens if a ticket is reassigned many times in one day?
- Is it better to calculate daily facts in SQL or pandas?
- How do real companies avoid duplicate facts during ETL?

## Related concepts
- [ETL]
- [OLTP]
- [Data Warehouse]
- [Star Schema]
- [Fact Table]
- [Dimension Table]

## Resources used
- See `resources/`