# Session – 2026-05-14

## Topics covered
- SQLAlchemy ORM
- ORM models
- Relationships
- One-to-many and many-to-one relationships
- Alembic migrations
- Migration generation
- Upgrade and downgrade operations
- CRUD operations
- Cascade delete
- Schema evolution

## What I understood
- ORM models represent database tables as Python classes.
- Relationships connect models together and make data easier to access.
- Alembic migrations track database schema changes.
- The upgrade function applies changes and downgrade reverses them.
- CRUD operations are the basic actions used in most applications.
- Cascade delete can automatically remove related records.

## What is still confusing
- How Alembic detects model changes automatically.
- How complex migrations are handled in production systems.
- When cascade delete should or should not be used.

## Questions
- How do teams handle migration conflicts?
- What happens if two developers generate migrations at the same time?
- Are there situations where raw SQL is better than ORM?

## Related concepts
- [ORM]
- [Relationships]
- [Alembic Migrations]
- [CRUD Operations]
- [Cascade Delete]

## Resources used
- See `resources/`