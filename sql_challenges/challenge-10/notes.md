# Lesson 05 Notes — Schema Backup & Restore

## Exercise 1

I used user_objects to see what objects exist in my schema. Grouping by object_type helps me quickly know if I have tables, indexes, views, procedures, or other objects.

This is useful before backing up because I need to know what I actually have.

## Exercise 2

I used DBMS_METADATA.GET_DDL to extract the SQL code needed to recreate tables.

I also set transform parameters so the output is cleaner. For example, I removed storage and tablespace details because those may not work in another database.

## Exercise 3

I used EMIT_SCHEMA = false so the generated DDL does not include the original schema name.

This makes the script more portable because it can be run in another schema without manually changing every object name.

## Exercise 4

For migration, I would check the DDL and foreign keys to make sure there are no old schema references.

My basic migration checklist would be:
1. Export DDL with EMIT_SCHEMA = false
2. Review foreign keys
3. Remove or change old schema names
4. Run objects in the correct order
5. Verify object counts after migration

## Exercise 5

I used user_dependencies to see which objects depend on other objects.

This matters because when restoring a schema, tables usually need to exist before views, procedures, functions, and packages that depend on them.

## Exercise 6

If I only have SQL access and no expdp, I would use DBMS_METADATA to extract the schema structure.

This is how my restore order would be:
1. Tables
2. Sequences
3. Indexes
4. Constraints
5. Views
6. Procedures, functions, and packages
7. Triggers

## Discussion Questions

### Q1: What are the limitations of DBMS_METADATA vs expdp?

DBMS_METADATA mainly exports DDL, not the actual table data. It also requires more manual work, like copying or spooling the output.

expdp is stronger because it can export both structure and data, and it is better for large schemas. The problem is that it usually needs more privileges.

### Q2: How would you handle circular dependencies?

I would create the base objects first, then add constraints later. For PL/SQL, I would create package specifications first and package bodies after.

This helps avoid errors where one object depends on another that does not exist yet.

### Q3: Plan for read-only migration

First, I would document the old schema using user_objects, user_tables, and similar views. Then I would extract clean DDL with DBMS_METADATA.

After that, I would review schema names, dependencies, constraints, and object order. Finally, I would run the DDL in the new database and verify that the objects were created correctly.