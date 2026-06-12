# Lesson Notes — SQLAlchemy ORM and Alembic

## Exercise 1 — Model Design

### What relationships should Comment have?

The Comment model should belong to one Task and one User.

So it needs many-to-one relationship to Task and many-to-one relationship to User

### Should Task have a comments relationship?

Yes, a task can have many comments, so it makes sense to have a relationship from Task to Comment.

This makes it easier to access all comments for a task.

### What should happen when a task is deleted?

I would use cascade delete.

If a task is deleted, its comments are not useful anymore because they belong to that task.

Deleting them automatically keeps the database clean.

## Exercise 2 — Migration Creation

### What does upgrade() do?

The upgrade() function applies the migration.

For example, it creates new tables, columns, indexes, or constraints.

### What does downgrade() do?

The downgrade() function reverses the migration.

It removes whatever was added in upgrade().

### What happens if you downgrade this migration?

The comments table would be removed.

Any data stored in that table would also be lost.

### CHECK constraint

I added a CHECK constraint so comments cannot be empty.

This helps maintain data quality.

## Exercise 3 — CRUD Challenge

I created one team, one user and three tasks, then I counted the tasks, updated one task to closed and deleted the lowest priority task

The goal was to practice Create, Read, Update, and Delete operations.

## Exercise 4 — Migration Rollback

### What happens to the column?

If the migration is rolled back, the column is removed from the table.

### What happens to the data?

The data stored in that column is lost because the column no longer exists.

This is why rollbacks should be used carefully.

## Exercise 5 — Concept Check

### 1. Why use ORM instead of raw SQL?

ORM lets developers work with objects instead of writing SQL everywhere.

It usually makes code easier to read and maintain.

### 2. Why use migrations?

Migrations keep database changes organized and version controlled.

They make it easier for a team to stay synchronized.

### 3. When would you rollback?

When a migration causes problems or introduces an incorrect change.

### 4. Difference between add() and commit()?

add() places an object in the session.

commit() permanently saves the changes to the database.

### 5. Why are relationships useful?

Relationships allow related data to be accessed more easily.

For example, getting all tasks for a user or all comments for a task.