# Session – 2026-05-21

## Topics covered
- KPI dashboards
- KPI contracts
- Business definitions for metrics
- Team velocity
- On-time delivery rate
- Completion rate
- Average and median resolution time
- Overdue task reports
- Severity levels
- Bad KPI examples
- CTEs for dashboard queries

## What I understood
- A KPI needs a clear definition before writing the query.
- A number can be misleading if the filters and edge cases are not clear.
- Completed, cancelled, active, and overdue tasks should be treated differently.
- Metrics are better when they include context, like priority or team.
- CTEs help organize large dashboard queries.
- Bad KPIs can return numbers but still have no real business meaning.

## What is still confusing
- How to choose the best definition when a KPI is vague.
- How much normalization is enough for fair team comparisons.
- How dashboard queries are optimized when the dataset is very large.

## Questions
- Should cancelled tasks be excluded from most KPIs?
- When is median better than average?
- How often should KPI dashboards refresh in real systems?
- Should KPIs be calculated live or stored in summary tables?

## Related concepts
- [KPI Contract]
- [Dashboard Queries]
- [CTEs]
- [Completion Rate]
- [Resolution Time]

## Resources used
- See `resources/`