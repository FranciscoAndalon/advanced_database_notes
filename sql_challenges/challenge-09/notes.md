# Lesson 04 Notes — Transactions and Stored Procedures

## Exercise 1: Manual transaction

I transferred 50 dollars from Charlie to Alice by doing two UPDATE statements in one transaction. First I subtracted from Charlie, then I added to Alice, and then I used COMMIT.

This matters because a transfer should be complete. It would be bad if money was removed from one account but not added to the other one.

## Exercise 2: Catch with ROLLBACK

I tried to transfer 10,000 dollars from Bob to Charlie, but Bob does not have enough money. Before saving it permanently, I used ROLLBACK.

The rollback cancels the changes and returns the table to the previous committed state. This is useful when I notice a mistake before committing.

## Exercise 3: SAVEPOINT checkpoint

I added 25 dollars to Alice and created a savepoint. Then I accidentally removed 25 dollars from Charlie instead of Bob. I used ROLLBACK TO savepoint so only the wrong Charlie update was undone.

After that, I deducted the 25 dollars from Bob and committed.

Savepoints are useful because they let me undo part of a transaction without losing everything.

## Exercise 4: Stored procedure

The procedure deposit_funds receives an account ID and an amount. It checks that the amount is greater than 0, updates the balance, and commits if everything works.

I also added a check using SQL%ROWCOUNT so the procedure gives an error if the account does not exist.

If something goes wrong, the procedure uses ROLLBACK and raises the error again.

## Exercise 5: Discussion

### Q1: Patient appointment booking system

The time slot reservation and appointment record should be inside the transaction because they are database changes that must stay consistent.

The confirmation notification should usually be outside the transaction. If the notification fails, I do not necessarily want to undo the appointment. Also, sending notifications can be slower and is not really part of the database consistency.

### Q2: Procedure with COMMIT inside a larger transaction

If a procedure commits inside itself, it can accidentally save changes before the caller is ready. This is a problem because the developer loses control of the bigger transaction.

For example, if the larger process fails later, some changes may already be committed and cannot be rolled back.

### Q3: Function vs procedure in SELECT

A function like calculate_copay() can be used inside a SELECT statement if it returns a value.

A procedure like post_payment() normally cannot be used inside a SELECT because procedures are made to perform actions, not return a value directly in a query.

So functions are better for calculations, while procedures are better for doing steps like updating tables.