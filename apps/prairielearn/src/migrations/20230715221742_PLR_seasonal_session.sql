-- This table represents semester.
CREATE TABLE IF NOT EXISTS PLR_seasonal_session (
    id SERIAL PRIMARY KEY,
    course_instance_id BIGINT NOT NULL UNIQUE,
    course_id BIGINT NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT NOW()
);

-- This table represents a students credentials for a semester.
CREATE TABLE IF NOT EXISTS PLR_seasonal_session_CREDENTIALS (
    id SERIAL PRIMARY KEY,
    user_id BIGINT NOT NULL,
    session_id INT NOT NULL,
    live_id INT NOT NULL,
    points DOUBLE PRECISION DEFAULT 0,
    duration INTERVAL NOT NULL,
    FOREIGN KEY (session_id) REFERENCES PLR_seasonal_session (id),
    FOREIGN KEY (user_id) REFERENCES PLR_students (user_id)
);