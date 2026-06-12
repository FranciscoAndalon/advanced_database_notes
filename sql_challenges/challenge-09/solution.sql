-- Lesson 04: Transactions and Stored Procedures

-- EXERCISE 1: Manual transaction
-- Transfer $50 from Charlie (3) to Alice (1)

SELECT account_id, owner_name, balance
FROM accounts
ORDER BY account_id;

BEGIN
    UPDATE accounts
    SET balance = balance - 50
    WHERE account_id = 3;

    UPDATE accounts
    SET balance = balance + 50
    WHERE account_id = 1;

    COMMIT;
END;
/

SELECT account_id, owner_name, balance
FROM accounts
ORDER BY account_id;


-- EXERCISE 2: Catch yourself with ROLLBACK
-- transfer $10,000 from Bob (2) to Charlie (3), then undo it

SELECT account_id, owner_name, balance
FROM accounts
ORDER BY account_id;

BEGIN
    UPDATE accounts
    SET balance = balance - 10000
    WHERE account_id = 2;

    UPDATE accounts
    SET balance = balance + 10000
    WHERE account_id = 3;
END;
/

SELECT account_id, owner_name, balance
FROM accounts
ORDER BY account_id;

ROLLBACK;

SELECT account_id, owner_name, balance
FROM accounts
ORDER BY account_id;


-- EXERCISE 3: SAVEPOINT checkpoint

SELECT account_id, owner_name, balance
FROM accounts
ORDER BY account_id;

BEGIN
    UPDATE accounts
    SET balance = balance + 25
    WHERE account_id = 1;

    SAVEPOINT after_alice_deposit;

    UPDATE accounts
    SET balance = balance - 25
    WHERE account_id = 3;

    ROLLBACK TO after_alice_deposit;

    UPDATE accounts
    SET balance = balance - 25
    WHERE account_id = 2;

    COMMIT;
END;
/

SELECT account_id, owner_name, balance
FROM accounts
ORDER BY account_id;


-- EXERCISE 4: Stored procedure
-- Create deposit_funds(p_account_id, p_amount)

CREATE OR REPLACE PROCEDURE deposit_funds (
    p_account_id IN NUMBER,
    p_amount     IN NUMBER
)
AS
BEGIN
    IF p_amount <= 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Deposit amount must be greater than 0');
    END IF;

    UPDATE accounts
    SET balance = balance + p_amount
    WHERE account_id = p_account_id;

    IF SQL%ROWCOUNT = 0 THEN
        RAISE_APPLICATION_ERROR(-20002, 'Account does not exist');
    END IF;

    COMMIT;

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END;
/

EXEC deposit_funds(3, 75);

SELECT account_id, owner_name, balance
FROM accounts
ORDER BY account_id;