### Reasonings

## Lesson 6

# Task 1
I use an INNER JOIN because the sales are in boxoffice, but the movie names are in movies. I connect them using the matching IDs so each row shows the movie title with its sales.

# Task 2
This is the same join as before, but now I filter with WHERE. I only keep movies where international_sales is bigger than domestic_sales, which means they made more money internationally.

# Task 3
Ratings are stored in boxoffice, but I still want the movie title from movies, so I join both tables. Then I sort by rating from highest to lowest using ORDER BY ... DESC.

## Lesson 7

# Task 1
I start from buildings so I don’t miss any building. The LEFT JOIN brings matching employees if they exist, then WHERE e.name IS NOT NULL deletes the empty ones, so I only keep buildings that actually have at least one employee. DISTINCT avoids repeating the same building a lot of times.

# Task 2
This info is already in the buildings table, so I don’t need a join, I just select the two columns.

# Task 3
I use LEFT JOIN because I still want buildings even if they have no employees. DISTINCT keeps each role only once per building, so I don’t get repeated roles for every employee. I sort by building name just to make it cleaner.

## Page With No Likes
## Facebook SQL Interview Question

I start from the pages table because I want to check all pages, even the ones that maybe don't have any likes.

I use a LEFT JOIN with page_likes so that pages with likes get matching rows and pages without likes get NULL values on the page_likes side

Then in the WHERE clause I filter for l.page_id IS NULL, which means the page never appeared in the page_likes table, so it has zero likes.

Finally, I use ORDER BY p.page_id ASC to sort the result from smallest to largest ID.
