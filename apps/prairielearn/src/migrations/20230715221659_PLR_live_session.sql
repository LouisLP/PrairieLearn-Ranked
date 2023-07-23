-- PLR_LIVE_SESSION (Created by professors when they start a live session for an assessment)
CREATE TABLE IF NOT EXISTS PLR_live_session (
    id SERIAL PRIMARY KEY,
    assess_id BIGINT NOT NULL,
    course_instance_id BIGINT NOT NULL,
    is_live BOOLEAN NOT NULL DEFAULT FALSE,
    created_at TIMESTAMP NOT NULL DEFAULT NOW()
);

-- LIVE_SESSION_CREDENTIALS
CREATE TABLE IF NOT EXISTS PLR_live_session_credentials (
    id SERIAL PRIMARY KEY,
    user_id BIGINT NULL,
    session_id BIGINT NOT NULL,
    assessment_instance_id BIGINT NOT NULL,
    duration INTERVAL NOT NULL,
    points DOUBLE PRECISION DEFAULT 0,
    rank BIGINT,
    FOREIGN KEY (user_id) REFERENCES PLR_students (user_id),
    FOREIGN KEY (session_id) REFERENCES PLR_live_session (id)
);
