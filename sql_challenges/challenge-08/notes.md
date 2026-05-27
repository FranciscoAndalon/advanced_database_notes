# Lesson 03 — Indexes Notes

## Exercise 1 — Query on `site_id`

### Question a) What scan type do you see? Why?
I see a full table scan, and it's that scan type because the column site_id only has a few possible values, so many rows can match site_id = 3. Because of that, reading a big part of the table can be cheaper than using an index.

### Question b) Is `site_id` high or low cardinality?
It's low cardinality because it only has values from 1 to 5.

### Question c) Would adding an index on `site_id` help?
Probably not a lot because each value appears in many rows, so the index is not very selective. It might add more cost for inserts and updates without helping SELECT queries that much.

### SQL reasoning
```sql
EXPLAIN PLAN FOR
SELECT *
FROM patient_visits
WHERE site_id = 3;
```
I use EXPLAIN PLAN to see how Oracle runs the query, which helps me decide if an index is useful or not.

---

## Exercise 2 — Index on `visit_date`

### Question a) Does Oracle use the index for the 30-day range?
Yes because 30 days is a smaller part of the range of the complete data.

### Question b) What happens with the last 7 days?
The index is used again because the range here is even smaller and more selective.

### Question c) What happens with the last 700 days?
Oracle prefers a full table scan because 700 days covers almost all the table.

### Question d) Why does range size matter?
A small range returns less rows so the index can save work. A big range returns a lot of rows, so using the index could be slower than just scanning the table.

### SQL reasoning
```sql
CREATE INDEX idx_pv_visit_date
ON patient_visits(visit_date);
```
I create an index on visit_date because the queries filter by date ranges, which can help Oracle find rows faster when the date range is small.

---

## Exercise 3 — Composite index

### Question a) Does the plan use the composite index?
Yes because the query filters by patient_id first and then by visit_date, this matches the order of the index.

### Question b) What happens if I query only on `visit_date`?
The composite doesn't really help because visit_date is the second column in the index. Oracle can't start from the middle of a normal composite index easily.

### Question c) What is the rule about column order?
The most important rule is that the leading column matters. A composite index on (patient_id, visit_date) is the best when the query uses patient_id or both patient_id and visit_date.

### SQL reasoning
```sql
CREATE INDEX idx_pv_patient_date
ON patient_visits(patient_id, visit_date);
```
I put patient_id first because it has high cardinality and the query searches for one patient. Then visit_date helps filter that patient's visits by date.

---

## Exercise 4 — Function on indexed column

### Question a) What scan type did the second query use?
A full table scan.

### Question b) Why does wrapping the column in a function break index use?
The index stores the original patient_id values, so when I write TO_CHAR(patient_id), Oracle has to transform the column first, so the normal index doesn't match the expression directly.

### Question c) How would I rewrite the query?
I would write it like:

```sql
SELECT *
FROM patient_visits
WHERE patient_id = 5432;
```

This keeps the column by itself and compares it to a number so that Oracle can use the normal index.

---

## Scenario A — Reporting table by date range

Yes, I'd add an index on the date column
for example:

```sql
CREATE INDEX idx_reporting_date
ON reporting_table(report_date);
```

This makes sense because the table is pretty big and analysts search by date range during the day. And because the table loads only one time at night, the cost to maintain the index is not as bad as in a table that has constant inserts.

---

## Scenario B — OLTP orders table

I'd add an index on customer_id like this:

```sql
CREATE INDEX idx_orders_customer_id
ON orders(customer_id);
```

This helps because support staff sometimes search by customer, but I would be careful with order_status because it only has 4 values, so it's low cardinality. I might avoid an index only on order_status unless testing proves it helps.

A possible composite index could be:

```sql
CREATE INDEX idx_orders_customer_status
ON orders(customer_id, order_status);
```

This could help if queries search frequently by both customer and status. The thing is that the table gets a lot of inserts per minute, so too many indexes can slow down writes.

---

## Scenario C — Patient email lookup

I would use a unique index on email:

```sql
CREATE UNIQUE INDEX idx_patient_email
ON patient(email);
```

I think this is a good option because email is unique and the app frequently searches by exact email. A unique index should make these lookups fast and also protect from duplicate emails.