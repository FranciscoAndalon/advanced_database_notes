-- Lesson 03 — Indexes

-- Exercise 1: Check the plan for a low-cardinality column
EXPLAIN PLAN FOR
SELECT *
FROM patient_visits
WHERE site_id = 3;

SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);


-- Exercise 2: Create an index on visit_date and test date ranges
CREATE INDEX idx_pv_visit_date
ON patient_visits(visit_date);

BEGIN
  DBMS_STATS.GATHER_TABLE_STATS(USER, 'PATIENT_VISITS', cascade => TRUE);
END;
/

-- Last 30 days
EXPLAIN PLAN FOR
SELECT *
FROM patient_visits
WHERE visit_date BETWEEN SYSDATE - 30 AND SYSDATE;

SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

-- Last 7 days
EXPLAIN PLAN FOR
SELECT *
FROM patient_visits
WHERE visit_date BETWEEN SYSDATE - 7 AND SYSDATE;

SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

-- Last 700 days
EXPLAIN PLAN FOR
SELECT *
FROM patient_visits
WHERE visit_date BETWEEN SYSDATE - 700 AND SYSDATE;

SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);


-- Exercise 3: Create and test a composite index
CREATE INDEX idx_pv_patient_date
ON patient_visits(patient_id, visit_date);

BEGIN
  DBMS_STATS.GATHER_TABLE_STATS(USER, 'PATIENT_VISITS', cascade => TRUE);
END;
/

-- I use both columns in the same order as the composite index
EXPLAIN PLAN FOR
SELECT *
FROM patient_visits
WHERE patient_id = 1234
  AND visit_date > SYSDATE - 90;

SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

EXPLAIN PLAN FOR
SELECT *
FROM patient_visits
WHERE patient_id = 1234;

SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

EXPLAIN PLAN FOR
SELECT *
FROM patient_visits
WHERE visit_date > SYSDATE - 90;

SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);


-- Exercise 4: Function on an indexed column
EXPLAIN PLAN FOR
SELECT *
FROM patient_visits
WHERE patient_id = 5432;

SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

EXPLAIN PLAN FOR
SELECT *
FROM patient_visits
WHERE TO_CHAR(patient_id) = '5432';

SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

EXPLAIN PLAN FOR
SELECT *
FROM patient_visits
WHERE patient_id = 5432;

SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);


-- Scenario A: reporting table queried by date range
CREATE INDEX idx_reporting_date
ON reporting_table(report_date);

-- Scenario B: OLTP orders table lookups
CREATE INDEX idx_orders_customer_id
ON orders(customer_id);

CREATE INDEX idx_orders_customer_status
ON orders(customer_id, order_status);

-- Scenario C: unique email lookup
CREATE UNIQUE INDEX idx_patient_email
ON patient(email);


-- Cleanup for indexes created on patient_visits in this lesson
DROP INDEX idx_pv_patient_date;
DROP INDEX idx_pv_visit_date;