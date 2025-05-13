-- Create tasks table
CREATE TABLE IF NOT EXISTS tasks (
    task_id VARCHAR(36) PRIMARY KEY,
    subject_id VARCHAR(36) NOT NULL,
    teacher_id VARCHAR(36) NOT NULL,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    due_date DATETIME NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (subject_id) REFERENCES subjects(subject_id),
    FOREIGN KEY (teacher_id) REFERENCES teachers(user_id)
);

-- Create task submissions table
CREATE TABLE IF NOT EXISTS task_submissions (
    submission_id VARCHAR(36) PRIMARY KEY,
    task_id VARCHAR(36) NOT NULL,
    student_id VARCHAR(36) NOT NULL,
    submission_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    score DECIMAL(5,2) NULL,
    feedback TEXT,
    graded_at DATETIME NULL,
    FOREIGN KEY (task_id) REFERENCES tasks(task_id),
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);
