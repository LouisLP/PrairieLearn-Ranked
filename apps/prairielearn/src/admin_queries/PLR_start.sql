-- Insert a new session
INSERT INTO PLR_live_session (assess_id, course_instance_id, is_live)
-- This is set to 42 so it connects to our live assessment. This assessment belongs to course ID 2.
VALUES (42, 2, TRUE)
-- Select everything from the PLR_live_session_credentials table (it needs a return for the admin query)
SELECT * FROM PLR_live_session_credentials;
