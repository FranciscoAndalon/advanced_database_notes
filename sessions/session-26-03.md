# Session – 2026-03-26

## Topics covered
- Database triggers
- Types of triggers: BEFORE INSERT, BEFORE UPDATE, BEFORE DELETE
- Using :NEW and :OLD values in triggers
- Using pseudocolumns like USER and SYSDATE
- Controlling user actions with triggers
- Raising errors with RAISE_APPLICATION_ERROR

## What I understood
- Triggers run automatically when an event happens in a table.
- BEFORE INSERT can be used to fill values automatically like date and user.
- :NEW is used to set or read new values, and :OLD is used to read values that already exist.
- Actions like update or delete can be restricted using conditions inside triggers.
- RAISE_APPLICATION_ERROR stops an operation and shows a message.

## What is still confusing
- When to use the BEFORE and AFTER triggers.
- If triggers can make the database slower in real systems.
- How to debug triggers when something goes wrong.

## Questions
- Is it common to use triggers for security, or is this handled in another way?
- What happens if multiple triggers exist on the same table?
- Can triggers call other procedures or functions?

## Related concepts
- [Database Triggers](../concepts/database-triggers.md)
- [Row-level Triggers](../concepts/row-level-triggers.md)
- [Pseudocolumns](../concepts/pseudocolumns.md)
- [RAISE_APPLICATION_ERROR](../concepts/raise-application-error.md)

## Resources used
- See `resources/`
