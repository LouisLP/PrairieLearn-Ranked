-- SEASONAL_SESSION
CREATE TABLE IF NOT EXISTS PLR_seasonal_session (
    id SERIAL PRIMARY KEY,
    course_instance_id BIGINT NOT NULL UNIQUE
    -- FOREIGN KEY (course_instance_id) REFERENCES course_instances (id)
);

-- SEASONAL_SESSION_CREDENTIALS
CREATE TABLE IF NOT EXISTS PLR_seasonal_session_CREDENTIALS (
    id SERIAL PRIMARY KEY,
    user_id BIGINT NOT NULL,
    session_id INT NOT NULL,
    points DOUBLE PRECISION DEFAULT 0,
    duration INTERVAL NOT NULL,
    FOREIGN KEY (session_id) REFERENCES PLR_seasonal_session (id),
    FOREIGN KEY (user_id) REFERENCES PLR_students (user_id)
);