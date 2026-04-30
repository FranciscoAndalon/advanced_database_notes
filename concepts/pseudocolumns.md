# Pseudocolumns

## My understanding
Pseudocolumns are special values provided by the database, like the current user or current date.

## Why it matters
They make it easy to store useful information automatically without asking the user.

## Example
SELECT USER, SYSDATE
FROM dual;