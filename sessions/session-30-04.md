# Session – 2026-04-30

## Topics covered
- Schema backup and restore
- Oracle data dictionary views
- user_objects, user_tables, and user_dependencies
- DBMS_METADATA.GET_DDL
- Cleaning DDL for portability
- Schema migration planning
- Dependency order
- Difference between DBMS_METADATA and expdp

## What I understood
- user_objects helps me see what exists in my schema.
- DBMS_METADATA.GET_DDL can generate SQL to recreate database objects.
- DDL should be cleaned before moving it to another schema.
- Schema names, storage settings, and tablespaces can cause problems during migration.
- Dependencies matter because some objects must be created before others.
- `expdp` is more complete than DBMS_METADATA, but it needs more permissions.

## What is still confusing
- How to restore table data if I only have SQL access.
- How to handle complex dependency problems in large schemas.
- When indexes should be created before or after constraints.

## Questions
- Can DBMS_METADATA export triggers automatically too?
- What is the safest order for restoring a very large schema?
- How do teams usually compare the old schema and new schema after migration?

## Related concepts
- [Schema Backup]
- [DBMS_METADATA]
- [DDL]
- [Dependencies]
- [Data Pump]

## Resources used
- See `resources/`