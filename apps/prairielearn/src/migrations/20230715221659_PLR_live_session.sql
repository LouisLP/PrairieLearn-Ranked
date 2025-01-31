-- This table represents a live session and is connect to a specific assessment instance and course instance.
-- Is_live represents whether the session is still open or not.
-- Only one of these should be live per course instance.
CREATE TABLE IF NOT EXISTS PLR_live_session (
    id SERIAL PRIMARY KEY,
    assess_id BIGINT NOT NULL,
    course_instance_id BIGINT NOT NULL,
    is_live BOOLEAN NOT NULL DEFAULT FALSE,
    created_at TIMESTAMP NOT NULL DEFAULT NOW()
);

-- This table represents a student's live session credentials.
CREATE TABLE IF NOT EXISTS PLR_live_session_credentials (
    id SERIAL PRIMARY KEY,
    user_id BIGINT NULL,
    session_id BIGINT NOT NULL,
    assessment_instance_id BIGINT NOT NULL,
    assessment_start_time TIMESTAMP NOT NULL DEFAULT NOW(),
    duration INTERVAL NOT NULL DEFAULT '00:00:00',
    points DOUBLE PRECISION DEFAULT 0,
    rank BIGINT,
    FOREIGN KEY (user_id) REFERENCES PLR_students (user_id),
    FOREIGN KEY (session_id) REFERENCES PLR_live_session (id)
);


ALTER TABLE PLR_live_session ADD CONSTRAINT unique_assess_instance UNIQUE (assess_id, course_instance_id);