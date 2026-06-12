-- Lesson 07: KPI Dashboards

-- EXERCISE 1: Team Velocity

WITH team_stats AS (
  SELECT t.name AS team_name,
         COUNT(DISTINCT u.id) AS team_members,
         COUNT(CASE WHEN ts.status = 'completed' THEN 1 END) AS completed_tasks
  FROM teams t
  LEFT JOIN users u ON u.team_id = t.id
  LEFT JOIN tasks ts ON ts.assigned_to = u.id
  GROUP BY t.name
),
velocity AS (
  SELECT team_name,
         team_members,
         completed_tasks,
         ROUND(completed_tasks / NULLIF(team_members, 0), 2) AS velocity
  FROM team_stats
)
SELECT v.*,
       CASE
         WHEN velocity < AVG(velocity) OVER () THEN 'Below Average'
         ELSE 'OK'
       END AS velocity_flag
FROM velocity v
ORDER BY velocity DESC;

-- EXERCISE 2: On-Time Delivery Rate

SELECT priority,
       COUNT(*) AS completed_tasks,
       ROUND(
         100 * AVG(
           CASE
             WHEN completed_at < CAST(due_date + 1 AS TIMESTAMP) THEN 1
             ELSE 0
           END
         ), 2
       ) AS on_time_rate_pct,
       ROUND(AVG(
         CASE
           WHEN completed_at >= CAST(due_date + 1 AS TIMESTAMP)
           THEN EXTRACT(DAY FROM (completed_at - CAST(due_date AS TIMESTAMP))) * 24
              + EXTRACT(HOUR FROM (completed_at - CAST(due_date AS TIMESTAMP)))
           ELSE NULL
         END
       ), 2) AS avg_lateness_hours
FROM tasks
WHERE status = 'completed'
  AND completed_at IS NOT NULL
  AND due_date IS NOT NULL
GROUP BY priority
ORDER BY priority;

-- EXERCISE 3: Improved Tasks per Team

SELECT t.name AS team_name,
       COUNT(ts.id) AS total_tasks,
       COUNT(CASE WHEN ts.status IN ('open', 'in_progress', 'blocked') THEN 1 END) AS active_tasks,
       ROUND(
         100 * COUNT(CASE WHEN ts.status = 'completed' THEN 1 END)
         / NULLIF(COUNT(CASE WHEN ts.status <> 'cancelled' THEN 1 END), 0),
         2
       ) AS completion_rate_pct,
       CASE
         WHEN COUNT(CASE WHEN ts.status IN ('open', 'in_progress', 'blocked') THEN 1 END) > 10
           THEN 'Overloaded'
         WHEN COUNT(CASE WHEN ts.status IN ('open', 'in_progress', 'blocked') THEN 1 END) BETWEEN 5 AND 10
           THEN 'Healthy'
         ELSE 'Underutilized'
       END AS health_score
FROM teams t
LEFT JOIN users u ON u.team_id = t.id
LEFT JOIN tasks ts ON ts.assigned_to = u.id
GROUP BY t.id, t.name
ORDER BY active_tasks DESC;

-- EXERCISE 4: Improved Average Resolution Time

WITH completed AS (
  SELECT priority,
         EXTRACT(DAY FROM (completed_at - created_at)) * 24
       + EXTRACT(HOUR FROM (completed_at - created_at))
       + EXTRACT(MINUTE FROM (completed_at - created_at)) / 60 AS resolution_hours
  FROM tasks
  WHERE status = 'completed'
    AND completed_at IS NOT NULL
)
SELECT priority,
       COUNT(*) AS completed_task_count,
       ROUND(AVG(resolution_hours), 2) AS avg_resolution_hours,
       ROUND(PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY resolution_hours), 2) AS median_resolution_hours,
       ROUND(MIN(resolution_hours), 2) AS fastest_hours,
       ROUND(MAX(resolution_hours), 2) AS slowest_hours,
       CASE
         WHEN priority = 'critical' AND AVG(resolution_hours) <= 24 THEN 'Target Met'
         WHEN priority = 'high'     AND AVG(resolution_hours) <= 72 THEN 'Target Met'
         WHEN priority = 'medium'   AND AVG(resolution_hours) <= 168 THEN 'Target Met'
         WHEN priority = 'low'      AND AVG(resolution_hours) <= 336 THEN 'Target Met'
         ELSE 'Target Missed'
       END AS target_met
FROM completed
GROUP BY priority
ORDER BY priority;

-- EXERCISE 5: Improved Overdue Tasks Report

WITH overdue AS (
  SELECT ts.title,
         u.full_name AS assignee,
         t.name AS team_name,
         ts.priority,
         ts.due_date,
         TRUNC(SYSDATE) - ts.due_date AS days_overdue,
         CASE
           WHEN ts.priority = 'critical' AND TRUNC(SYSDATE) - ts.due_date > 0 THEN 'CRITICAL'
           WHEN ts.priority = 'high' AND TRUNC(SYSDATE) - ts.due_date > 2 THEN 'HIGH'
           WHEN ts.priority = 'medium' AND TRUNC(SYSDATE) - ts.due_date > 5 THEN 'MEDIUM'
           ELSE 'LOW'
         END AS severity
  FROM tasks ts
  LEFT JOIN users u ON ts.assigned_to = u.id
  LEFT JOIN teams t ON u.team_id = t.id
  WHERE ts.due_date < TRUNC(SYSDATE)
    AND ts.status NOT IN ('completed', 'cancelled')
    AND ts.due_date IS NOT NULL
)
SELECT title,
       assignee,
       team_name,
       priority,
       due_date,
       days_overdue,
       severity
FROM overdue
ORDER BY
  CASE severity
    WHEN 'CRITICAL' THEN 1
    WHEN 'HIGH' THEN 2
    WHEN 'MEDIUM' THEN 3
    ELSE 4
  END,
  days_overdue DESC;

-- EXERCISE 6: Fix Productivity Score

SELECT u.full_name,
       COUNT(ts.id) AS completed_tasks,
       SUM(
         CASE ts.priority
           WHEN 'critical' THEN 4
           WHEN 'high' THEN 3
           WHEN 'medium' THEN 2
           WHEN 'low' THEN 1
           ELSE 0
         END
       ) AS weighted_completed_score
FROM users u
LEFT JOIN tasks ts
  ON ts.assigned_to = u.id
 AND ts.status = 'completed'
GROUP BY u.id, u.full_name
ORDER BY weighted_completed_score DESC;

-- EXERCISE 7: Fix Team Efficiency

SELECT t.name AS team_name,
       COUNT(CASE WHEN ts.status = 'completed' THEN 1 END) AS completed_tasks,
       COUNT(CASE WHEN ts.status <> 'cancelled' THEN 1 END) AS total_valid_tasks,
       ROUND(
         100 * COUNT(CASE WHEN ts.status = 'completed' THEN 1 END)
         / NULLIF(COUNT(CASE WHEN ts.status <> 'cancelled' THEN 1 END), 0),
         2
       ) AS efficiency_pct
FROM teams t
LEFT JOIN users u ON u.team_id = t.id
LEFT JOIN tasks ts ON ts.assigned_to = u.id
GROUP BY t.id, t.name
ORDER BY efficiency_pct DESC;

-- EXERCISE 8: Fix Urgency Index

SELECT title,
       priority,
       due_date,
       CASE priority
         WHEN 'critical' THEN 4
         WHEN 'high' THEN 3
         WHEN 'medium' THEN 2
         WHEN 'low' THEN 1
         ELSE 0
       END AS priority_weight,
       due_date - TRUNC(SYSDATE) AS days_until_due,
       (
         CASE priority
           WHEN 'critical' THEN 40
           WHEN 'high' THEN 30
           WHEN 'medium' THEN 20
           WHEN 'low' THEN 10
           ELSE 0
         END
         - (due_date - TRUNC(SYSDATE))
       ) AS urgency_score
FROM tasks
WHERE status NOT IN ('completed', 'cancelled')
  AND due_date IS NOT NULL
ORDER BY urgency_score DESC;

-- BONUS: Summary Dashboard Query

WITH base AS (
  SELECT ts.*,
         u.full_name,
         t.name AS team_name,
         CASE WHEN ts.status IN ('open', 'in_progress', 'blocked') THEN 1 ELSE 0 END AS is_active,
         CASE WHEN ts.status = 'completed' THEN 1 ELSE 0 END AS is_completed,
         CASE
           WHEN ts.due_date < TRUNC(SYSDATE)
            AND ts.status NOT IN ('completed', 'cancelled')
           THEN 1 ELSE 0
         END AS is_overdue,
         CASE
           WHEN ts.status = 'completed' AND ts.completed_at IS NOT NULL
           THEN EXTRACT(DAY FROM (ts.completed_at - ts.created_at)) * 24
              + EXTRACT(HOUR FROM (ts.completed_at - ts.created_at))
              + EXTRACT(MINUTE FROM (ts.completed_at - ts.created_at)) / 60
         END AS resolution_hours,
         CASE
           WHEN ts.due_date < TRUNC(SYSDATE)
            AND ts.status NOT IN ('completed', 'cancelled')
           THEN TRUNC(SYSDATE) - ts.due_date
         END AS days_overdue
  FROM tasks ts
  LEFT JOIN users u ON ts.assigned_to = u.id
  LEFT JOIN teams t ON u.team_id = t.id
),
main_metrics AS (
  SELECT COUNT(*) AS total_tasks,
         SUM(is_completed) AS completed_tasks,
         SUM(is_active) AS active_tasks,
         SUM(is_overdue) AS overdue_tasks,
         ROUND(100 * SUM(is_completed) / NULLIF(COUNT(*), 0), 2) AS completion_rate_pct,
         ROUND(AVG(resolution_hours), 2) AS avg_resolution_hours,
         ROUND(AVG(days_overdue), 2) AS avg_days_overdue
  FROM base
),
priority_rank AS (
  SELECT priority,
         COUNT(*) AS active_count,
         ROW_NUMBER() OVER (ORDER BY COUNT(*) DESC) AS rn
  FROM base
  WHERE is_active = 1
  GROUP BY priority
),
team_rank AS (
  SELECT team_name,
         COUNT(*) AS active_count,
         ROW_NUMBER() OVER (ORDER BY COUNT(*) DESC) AS rn
  FROM base
  WHERE is_active = 1
  GROUP BY team_name
)
SELECT m.total_tasks,
       m.completed_tasks,
       m.active_tasks,
       m.overdue_tasks,
       m.completion_rate_pct,
       m.avg_resolution_hours,
       m.avg_days_overdue,
       p.priority AS most_common_priority,
       tr.team_name AS busiest_team
FROM main_metrics m
LEFT JOIN priority_rank p ON p.rn = 1
LEFT JOIN team_rank tr ON tr.rn = 1;