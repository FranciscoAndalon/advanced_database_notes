-- Lesson 6

-- Task 1
SELECT m.title, b.domestic_sales, b.international_sales
FROM movies AS m
INNER JOIN boxoffice AS b
  ON m.id = b.movie_id;

-- Task 2
SELECT m.title, b.domestic_sales, b.international_sales
FROM movies AS m
INNER JOIN boxoffice AS b
  ON m.id = b.movie_id
WHERE b.international_sales > b.domestic_sales;

-- Task 3
SELECT m.title, b.rating
FROM movies AS m
INNER JOIN boxoffice AS b
  ON m.id = b.movie_id
ORDER BY b.rating DESC;

-- Lesson 7

-- Task 1
SELECT DISTINCT b.building_name
FROM buildings AS b
LEFT JOIN employees AS e
  ON b.building_name = e.building
WHERE e.name IS NOT NULL;

-- Task 2
SELECT building_name, capacity
FROM buildings;

-- Task 3
SELECT DISTINCT b.building_name, e.role
FROM buildings AS b
LEFT JOIN employees AS e
  ON b.building_name = e.building
ORDER BY b.building_name;

-- "Page With No Likes" Interview Question
SELECT p.page_id
FROM pages AS p
LEFT JOIN page_likes AS l
  ON p.page_id = l.page_id
WHERE l.page_id IS NULL
ORDER BY p.page_id ASC;