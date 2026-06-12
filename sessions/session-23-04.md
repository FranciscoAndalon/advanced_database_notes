# Session – 2026-04-23

## Topics covered
- Transactions
- COMMIT and ROLLBACK
- Manual money transfers between accounts
- SAVEPOINT
- Stored procedures
- Error handling in PL/SQL
- RAISE_APPLICATION_ERROR
- Difference between functions and procedures
- Transaction design decisions

## What I understood
- A transaction groups multiple database actions together.
- COMMIT saves changes permanently.
- ROLLBACK cancels changes that have not been committed yet.
- SAVEPOINT lets me go back to a specific point inside a transaction.
- Stored procedures can organize database logic into reusable blocks.
- Error handling is important so bad changes do not stay in the database.
- Functions return values, while procedures are usually used to perform actions.

## What is still confusing
- When a procedure should include COMMIT and when it should let the caller commit.
- How nested transactions work in Oracle.
- How to decide what belongs inside a transaction in real applications.

## Questions
- Is it usually better to avoid COMMIT inside stored procedures?
- Can a notification system be safely connected to a database transaction?
- What is the best way to test rollback behavior?

## Related concepts
- [Transactions]
- [COMMIT and ROLLBACK]
- [SAVEPOINT]
- [Stored Procedures]
- [Error Handling]

## Resources used
- See `resources/`
