# Database Triggers

## My understanding
A trigger is a piece of code that runs automatically when something happens in a table, like an insert, update, or delete.

## Why it matters
It helps automate tasks and enforce rules without having the user to do it manually.

## Example
CREATE OR REPLACE TRIGGER trg_example
BEFORE INSERT ON my_table
FOR EACH ROW
BEGIN
  :NEW.created_date := SYSDATE;
END;