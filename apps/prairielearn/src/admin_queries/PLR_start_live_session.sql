-- Insert a new session
INSERT INTO PLR_live_session (assess_id, course_instance_id, is_live)
VALUES ($assess_id, $course_instance_id, TRUE);