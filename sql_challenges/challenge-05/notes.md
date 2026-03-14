# Reasonings 

## TryIt 1

### 1) List all colours from both tables, each appearing only once
I used UNION because it combines results from two queries and deletes duplicates automatically.
UNION is the correct operator because the question says each colour should appear only once.

### 2) List all shapes from both tables, keeping every row
Here we need every row from both tables, even if the shape appears multiple times.
UNION ALL keeps all rows and does not delete duplicates, so it matches the requirement.

## TryIt 2

### 3) Shapes in my collection but not in yours
MINUS returns the rows from the first query that don't exist in the second query.
So this gives shapes that appear in my collection but not in your collection.

### 4) Colours that exist in both tables
INTERSECT returns only the values that appear in both queries.
So it finds colours that exist in both collections.