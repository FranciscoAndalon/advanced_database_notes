# Row-level Triggers

## My understanding
A row-level trigger runs once for every row that is affected by the operation.

## Why it matters
It allows to control or check each row individually, like validating who created it.

## Example
CREATE OR REPLACE TRIGGER trg_row
BEFORE UPDATE ON employees
FOR EACH ROW
BEGIN
  IF :OLD.salary <> :NEW.salary THEN
    NULL;
  END IF;
END;