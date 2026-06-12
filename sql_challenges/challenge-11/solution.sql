-- Exercise 1 — Comment Model

CREATE TABLE comments (
    id          NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    task_id     NUMBER NOT NULL,
    user_id     NUMBER NOT NULL,
    content     VARCHAR2(1000) NOT NULL,
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_comments_task
        FOREIGN KEY (task_id)
        REFERENCES tasks(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_comments_user
        FOREIGN KEY (user_id)
        REFERENCES users(id),

    CONSTRAINT chk_comment_content
        CHECK (TRIM(content) IS NOT NULL)
);

-- CRUD Challenge

-- Create team
INSERT INTO teams (name, description)
VALUES ('DevOps', 'Infrastructure and deployment team');

-- Create user
INSERT INTO users (
    username,
    email,
    full_name,
    team_id
)
VALUES (
    'diana_ops',
    'diana@example.com',
    'Diana Ops',
    3
);

-- Create tasks

INSERT INTO tasks (
    title,
    description,
    status,
    assigned_to
)
VALUES (
    'Configure CI Pipeline',
    'Create GitHub Actions workflow',
    'open',
    4
);

INSERT INTO tasks (
    title,
    description,
    status,
    assigned_to
)
VALUES (
    'Deploy Monitoring',
    'Install monitoring tools',
    'open',
    4
);

INSERT INTO tasks (
    title,
    description,
    status,
    assigned_to
)
VALUES (
    'Clean Old Logs',
    'Remove unused log files',
    'open',
    4
);

COMMIT;

-- Print task count

SELECT COUNT(*) AS total_tasks
FROM tasks;

-- Close one task

UPDATE tasks
SET status = 'closed',
    updated_at = CURRENT_TIMESTAMP
WHERE title = 'Configure CI Pipeline';

-- Delete lowest priority task

DELETE FROM tasks
WHERE title = 'Clean Old Logs';

COMMIT;

-- Verify

SELECT *
FROM tasks
ORDER BY id;