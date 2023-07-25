WITH
users AS (
    -- Insert new users
    INSERT INTO users (uid, name, lti_course_instance_id)
    VALUES
        ('fazackernator@ubc.ca', 'Fazackernator', 2),
        ('big_ramon@ubc.ca', 'Big Ramon', 2),
        ('mouth_man@ubc.ca', 'Mouth of Sauron', 2),
        ('YesHoney@ubc.ca', 'Louis Dear', 2),
        ('TheYoungGoat@ubc.ca', 'Sheel The Goat', 2),
        ('ErenYegor@ubc.ca', 'Babayegor', 2),
        ('IAmBecomePL@ubc.ca', 'PL God', 2),
        ('LordAndSaviour@ubc.ca', 'The Almighty Nathan', 2),
        ('TheReverseFlash@ubc.ca', 'Eobard Thawne', 2),
        ('GottaGetThatMoney@ubc.ca', 'Eugene Crabs', 2),
        ('CodeineGotMeTripping@ubc.ca', 'Don Spongiver', 2),
        ('IAmKenough@ubc.ca', 'Ken', 2),
        ('UncleBenis#Dead@ubc.ca', 'Miles Morales', 2),
        ('LostMyMoney@ubc.ca', 'G@mb71ng @dd1<t', 2)
    RETURNING user_id
),
session AS (
    -- Insert a new session
    INSERT INTO PLR_live_session (assess_id, course_instance_id, is_live)
    -- This is set to 42 so it connects to our live assessment. This assessment belongs to course ID 2.
    VALUES (42, 2, TRUE)
    RETURNING assess_id
),
user_sessions AS (
    SELECT user_id, assess_id
    FROM users, session
),
credentials AS (
    -- Insert new credentials for each user in the new session
    INSERT INTO assessment_instances (user_id, assessment_id, duration, points)
    SELECT user_id, assess_id, '00:00:00'::time + (random() * '01:00:00'::interval), ROUND(RANDOM() * 42069)
    FROM user_sessions
)
-- Select everything from the PLR_live_session_credentials table (it needs a return for the admin query)
SELECT * FROM PLR_live_session_credentials;
