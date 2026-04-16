# Reasonings

## 1) BEFORE INSERT trigger
I used a BEFORE INSERT trigger so it runs before the row is saved. SYSDATE gives the current date and time and USER gives the current database user, so I assign both to the new row using :NEW.
If something goes wrong, I catch it with WHEN OTHERS and show an error.

## 2) BEFORE UPDATE trigger
This trigger runs before updating a row. I compare the user who created the record with the current USER, and if they are different, I stop the update with an error.
This is so that users can only edit their own records.

## 3) BEFORE DELETE trigger
This trigger runs before deleting a row. I check if the current USER is 'JOEMANAGER', and if not, I stop the delete with an error, so that only the manager can delete records.