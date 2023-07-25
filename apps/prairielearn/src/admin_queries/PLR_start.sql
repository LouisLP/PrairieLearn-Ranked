WITH
users AS (
    -- Insert new users
    INSERT INTO users (uid, name, lti_course_instance_id)
    VALUES
        ('fazackernator@ubc.ca', 'Fazackernator', 1),
        ('big_ramon@ubc.ca', 'Big Ramon', 1),
        ('mouth_man@ubc.ca', 'Mouth of Sauron', 1)
    RETURNING user_id
),
session AS (
    -- Insert a new session
    INSERT INTO PLR_live_session (assess_id, course_instance_id, is_live)
    VALUES (1, 1, TRUE)
    RETURNING id AS session_id
),
user_sessions AS (
    SELECT user_id, session_id
    FROM users, session
),
credentials AS (
    -- Insert new credentials for each user in the new session
    INSERT INTO PLR_live_session_credentials (user_id, session_id, assessment_instance_id, duration, points)
    SELECT user_id, session_id, 1, '1 hour'::interval, ROUND(RANDOM() * 2000)
    FROM user_sessions
)
-- Select everything from the PLR_live_session_credentials table (it needs a return for the admin query)
SELECT * FROM PLR_live_session_credentials;
