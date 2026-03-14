-- TryIt 1 -- 

-- 1) List all colours from both tables, each appearing only once
select colour from my_brick_collection
UNION
select colour from your_brick_collection
order by colour;

-- 2) List all shapes from both tables, keeping every row
select shape from my_brick_collection
UNION ALL
select shape from your_brick_collection
order by shape;

-- TryIt 2 --

-- 3) Shapes in my collection but not in yours   
select shape from my_brick_collection
MINUS
select shape from your_brick_collection;

-- 4) Colours that exist in both tables
select colour from my_brick_collection
INTERSECT
select colour from your_brick_collection
order by colour;