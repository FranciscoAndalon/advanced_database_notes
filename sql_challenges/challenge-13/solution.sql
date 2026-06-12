-- Lesson 08: ETL + Data Warehouse

-- STEP 1: Source Tables (OLTP)

BEGIN EXECUTE IMMEDIATE 'DROP TABLE ticket_assignments'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE tickets'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE agents'; EXCEPTION WHEN OTHERS THEN NULL; END;
/

CREATE TABLE agents (
    agent_id    NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    agent_name  VARCHAR2(100) NOT NULL,
    team        VARCHAR2(50) NOT NULL
);

CREATE TABLE tickets (
    ticket_id    NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    title        VARCHAR2(200) NOT NULL,
    status       VARCHAR2(20) DEFAULT 'open' NOT NULL,
    priority     VARCHAR2(10) DEFAULT 'medium' NOT NULL,
    created_at   TIMESTAMP DEFAULT SYSTIMESTAMP,
    resolved_at  TIMESTAMP,
    assigned_to  NUMBER REFERENCES agents(agent_id),

    CONSTRAINT chk_ticket_status
        CHECK (status IN ('open', 'in_progress', 'resolved', 'cancelled')),

    CONSTRAINT chk_ticket_priority
        CHECK (priority IN ('low', 'medium', 'high', 'critical'))
);

CREATE TABLE ticket_assignments (
    assignment_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    ticket_id     NUMBER NOT NULL REFERENCES tickets(ticket_id),
    assigned_to   NUMBER NOT NULL REFERENCES agents(agent_id),
    assigned_by   NUMBER REFERENCES agents(agent_id),
    valid_from    TIMESTAMP NOT NULL,
    valid_to      TIMESTAMP
);

-- STEP 2: Sample Data

INSERT INTO agents (agent_name, team) VALUES ('Alice Chen', 'Support');
INSERT INTO agents (agent_name, team) VALUES ('Bob Martinez', 'Support');
INSERT INTO agents (agent_name, team) VALUES ('Carol Smith', 'Escalations');
INSERT INTO agents (agent_name, team) VALUES ('Dave Kim', 'Billing');

COMMIT;

-- STEP 3: Trigger

CREATE OR REPLACE TRIGGER trg_ticket_assignment_log
AFTER INSERT OR UPDATE OF assigned_to ON tickets
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        INSERT INTO ticket_assignments (
            ticket_id,
            assigned_to,
            assigned_by,
            valid_from,
            valid_to
        )
        VALUES (
            :NEW.ticket_id,
            :NEW.assigned_to,
            NULL,
            :NEW.created_at,
            NULL
        );

    ELSIF UPDATING THEN
        UPDATE ticket_assignments
        SET valid_to = SYSTIMESTAMP
        WHERE ticket_id = :OLD.ticket_id
          AND valid_to IS NULL;

        INSERT INTO ticket_assignments (
            ticket_id,
            assigned_to,
            assigned_by,
            valid_from,
            valid_to
        )
        VALUES (
            :NEW.ticket_id,
            :NEW.assigned_to,
            NULL,
            SYSTIMESTAMP,
            NULL
        );
    END IF;
END;
/

-- Inserting tickets after trigger exists so assignment history is logged

INSERT INTO tickets (title, status, priority, created_at, resolved_at, assigned_to)
VALUES (
    'Cannot reset password',
    'resolved',
    'high',
    TIMESTAMP '2026-05-01 09:00:00',
    TIMESTAMP '2026-05-01 15:00:00',
    1
);

INSERT INTO tickets (title, status, priority, created_at, resolved_at, assigned_to)
VALUES (
    'Invoice not generated',
    'resolved',
    'medium',
    TIMESTAMP '2026-05-02 10:00:00',
    TIMESTAMP '2026-05-03 12:00:00',
    2
);

INSERT INTO tickets (title, status, priority, created_at, resolved_at, assigned_to)
VALUES (
    'Account locked',
    'in_progress',
    'critical',
    TIMESTAMP '2026-05-03 11:00:00',
    NULL,
    3
);

INSERT INTO tickets (title, status, priority, created_at, resolved_at, assigned_to)
VALUES (
    'Payment failed',
    'open',
    'high',
    TIMESTAMP '2026-05-04 08:30:00',
    NULL,
    4
);

INSERT INTO tickets (title, status, priority, created_at, resolved_at, assigned_to)
VALUES (
    'Update contact email',
    'resolved',
    'low',
    TIMESTAMP '2026-05-05 14:00:00',
    TIMESTAMP '2026-05-06 10:00:00',
    1
);

COMMIT;

-- Test reassignment. Ticket 1 moves from Alice to Carol

UPDATE tickets
SET assigned_to = 3,
    resolved_at = TIMESTAMP '2026-05-01 15:00:00'
WHERE ticket_id = 1;

COMMIT;

SELECT ta.ticket_id,
       t.title,
       a.agent_name AS assigned_to,
       ta.valid_from,
       ta.valid_to
FROM ticket_assignments ta
JOIN tickets t ON t.ticket_id = ta.ticket_id
JOIN agents a ON a.agent_id = ta.assigned_to
ORDER BY ta.ticket_id, ta.valid_from;

-- STEP 4: Data Warehouse Tables

BEGIN EXECUTE IMMEDIATE 'DROP TABLE fact_ticket_daily'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE dim_agent'; EXCEPTION WHEN OTHERS THEN NULL; END;
/

CREATE TABLE dim_agent (
    agent_key   NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    agent_id    NUMBER NOT NULL,
    agent_name  VARCHAR2(100) NOT NULL,
    team        VARCHAR2(50) NOT NULL,
    CONSTRAINT uq_dim_agent_source UNIQUE (agent_id)
);

CREATE TABLE fact_ticket_daily (
    fact_key          NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    date_key          NUMBER NOT NULL,
    agent_key         NUMBER NOT NULL REFERENCES dim_agent(agent_key),
    status            VARCHAR2(20) NOT NULL,
    priority          VARCHAR2(10) NOT NULL,
    tickets_created   NUMBER DEFAULT 0,
    tickets_resolved  NUMBER DEFAULT 0
);

-- STEP 5: Populate dim_agent

INSERT INTO dim_agent (agent_id, agent_name, team)
SELECT agent_id, agent_name, team
FROM agents;

COMMIT;

SELECT *
FROM dim_agent
ORDER BY agent_key;

-- Verify fact table

SELECT f.date_key,
       a.agent_name,
       a.team,
       f.status,
       f.priority,
       f.tickets_created,
       f.tickets_resolved
FROM fact_ticket_daily f
JOIN dim_agent a ON a.agent_key = f.agent_key
ORDER BY f.date_key, a.agent_name, f.priority;