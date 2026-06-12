# Lesson 07 Notes — KPI Dashboards

## Exercise 1: Team Velocity

I defined team velocity as completed tasks per team member.

I did this because the teams may not have the same number of people. If I only count completed tasks, a bigger team can look better just because it has more members.

The query counts completed tasks, divides by team size, and flags teams below the average.

## Exercise 2: On-Time Delivery Rate

I defined on-time as a task completed before the end of its due date.

Tasks without a due date are ignored because I cannot know if they were late or not.

I grouped the result by priority because urgent work and low-priority work should not always be judged the same way.

## Exercise 3: Improved Tasks per Team

The original query counted all tasks, including completed and cancelled ones. That can be misleading because old completed work does not mean the team is currently busy.

My improved query shows total tasks, active tasks, completion rate, and a simple health label.

## Exercise 4: Improved Average Resolution Time

The original query averaged all completed tasks together, which hides the difference between priorities.

I grouped by priority and added average, median, fastest, and slowest resolution time.

I also added these SLA targets
- critical = 24 hours
- high = 72 hours
- medium = 168 hours
- low = 336 hours

## Exercise 5: Improved Overdue Tasks

The original query only counted overdue tasks. That is useful, but it does not explain which tasks are most urgent.

My query lists the task, assignee, team, priority, due date, days overdue, and severity.

This makes the KPI more useful because managers can see what to fix first.

## Exercise 6: Fix Productivity Score

The bad query counted all assigned tasks as productivity.

That is not a good metric because having many tasks is not the same as completing work.

I rewrote it to count completed tasks and give more weight to higher-priority tasks.

## Exercise 7: Fix Team Efficiency

The bad query used AVG(task_id), which has no real meaning.

Task IDs are just identifiers, not measurements.

I rewrote the metric as completed tasks divided by total non-cancelled tasks.

## Exercise 8: Fix Urgency Index

The bad query tried to multiply a text value like priority.

That does not make sense because priority is not numeric.

I converted priority into a number and combined it with due date pressure to create a real urgency score.

## Bonus Dashboard Query

The bonus query uses CTEs to build a dashboard step by step.

I first created a base CTE with useful calculated columns, then created smaller metric CTEs.

This makes the query easier to read and closer to how real dashboard queries are built.