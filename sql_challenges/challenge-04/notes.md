# Reasonings

## Window Functions - TryIt 1
I used partition by shape in both window functions because the calculations need to be done inside each shape group.
count(*) tells me how many bricks there are for that shape and median(weight) gives the middle weight value for that shape.

## Window Functions - TryIt 2
Here I used order by brick_id inside the window because the running average should go step by step in brick_id order.
SQL calculates again the average everytime a new row is added.

## Window Functions - TryIt 3
For the first part I used rows between 2 preceding and 1 preceding, because the exercise wants the minimum colour from the two rows before the current row, but not including the current one.
For the second part I used range between current row and 1 following, because it counts rows with the same weight as the current row and also the next weight value.

## Window Functions - TryIt 4
	•	partition by shape gives the total weight for each shape.
	•	order by brick_id gives the running total weight row by row.
	•	Then in the outer query I filter only the rows where both values are greater than 4.

## Top Three Salaries Exercise (DataLemur)
I used dense_rank() because the problem says ties should be handled correctly, so that means if two people have the same salary, they should get the same rank.