# Aggregate Functions

## My understanding
Aggregate functions do one calculation over many rows, like finding the toal, avergae, highest or lowest value.

## Why it matters
They help to answer questions that are related to businesses, such as totals and trends, instead of just showing raw rows.

## Example
SELECT MAX(years_employed), MIN(years_employed), AVG(years_employed)
FROM employees;