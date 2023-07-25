WITH
users1 AS (
    -- Insert new users
    INSERT INTO users (uid, name, lti_course_instance_id)
    VALUES
        ('fazackernator@ubc.ca', 'Fazackernator', 2),
        ('big_ramon@ubc.ca', 'Big Ramon', 2),
        ('mouth_man@ubc.ca', 'Mouth of Sauron', 2),
        ('YesHoney@ubc.ca', 'Louis Dear', 2),
        ('TheYoungGoat@ubc.ca', 'Sheel The Goat', 2),
        ('ErenYegor@ubc.ca', 'Babayegor', 2),
        ('IAmBecomePL@ubc.ca', 'PL God', 2)
    RETURNING user_id AS user_id1
),
users2 AS (
    -- Insert new users
    INSERT INTO users (uid, name, lti_course_instance_id)
    VALUES
        ('LordAndSaviour@ubc.ca', 'The Almighty Nathan', 2),
        ('TheReverseFlash@ubc.ca', 'Eobard Thawne', 2),
        ('GottaGetThatMoney@ubc.ca', 'Eugene Crabs', 2),
        ('CodeineGotMeTripping@ubc.ca', 'Don Spongiver', 2),
        ('IAmKenough@ubc.ca', 'Ken', 2),
        ('UncleBenis#Dead@ubc.ca', 'Miles Morales', 2),
        ('LostMyMoney@ubc.ca', 'G@mb71ng @dd1<t', 2)
    RETURNING user_id AS user_id2
),
session1 AS (
    -- Insert a new session
    INSERT INTO PLR_live_session (assess_id, course_instance_id, is_live)
    -- This is set to 42 so it connects to our live assessment. This assessment belongs to course ID 2.
    VALUES (42, 2, TRUE)
    RETURNING assess_id
),
session2 AS (
    -- Insert a new session
    INSERT INTO PLR_live_session (assess_id, course_instance_id, is_live)
    -- This is set to 42 so it connects to our live assessment. This assessment belongs to course ID 2.
    VALUES (43, 2, TRUE)
    RETURNING assess_id
),
user_sessions1 AS (
    SELECT user_id1, assess_id
    FROM users1, session1
),
user_sessions2 AS (
    SELECT user_id2, assess_id
    FROM users2, session2
),
credentials1 AS (
    -- Insert new credentials for each user in the new session
    INSERT INTO assessment_instances (user_id, assessment_id, duration, points)
    SELECT user_id, assess_id, '00:00:00'::time + (random() * '01:00:00'::interval), ROUND(RANDOM() * 42069)
    FROM user_sessions1
),
credentials2 AS (
    -- Insert new credentials for each user in the new session
    INSERT INTO assessment_instances (user_id, assessment_id, duration, points)
    SELECT user_id, assess_id, '00:00:00'::time + (random() * '01:00:00'::interval), ROUND(RANDOM() * 42069)
    FROM user_sessions2
)
-- Select everything from the PLR_live_session_credentials table (it needs a return for the admin query)
SELECT * FROM PLR_live_session_credentials;
