WITH
users AS (
    -- Insert new users
    INSERT INTO users (user_id, uid, name)
    VALUES
        (2, 'fazackernator@ubc.ca', 'Fazackernator'),
        (3, 'big_ramon@ubc.ca', 'Big Ramon'),
        (4, 'mouth_man@ubc.ca', 'Mouth of Sauron'),
        (5, 'YesHoney@ubc.ca', 'Louis Dear'),
        (6, 'TheYoungGoat@ubc.ca', 'Sheel The Goat'),
        (7, 'ErenYegor@ubc.ca', 'Babayegor'),
        (8, 'IAmBecomePL@ubc.ca', 'PL God'),
        (9, 'LordAndSaviour@ubc.ca', 'The Almighty Nathan'),
        (10, 'TheReverseFlash@ubc.ca', 'Eobard Thawne'),
        (11, 'GottaGetThatMoney@ubc.ca', 'Eugene Crabs'),
        (12, 'CodeineGotMeTripping@ubc.ca', 'Don Spongiver'),
        (13, 'IAmKenough@ubc.ca', 'Ken'),
        (14, 'UncleBenis#Dead@ubc.ca', 'Miles Morales'),
        (15, 'LostMyMoney@ubc.ca', 'G@mb71ng @dd1<t')
),
enrolls AS (
  INSERT INTO enrollments (user_id, course_instance_id)
  VALUES (2, 2), (3, 2), (4, 2), (5, 2), (6, 2), (7, 2), (8, 2), (9, 2), (10, 2), (11, 2), (12, 2), (13, 2), (14, 2), (15, 2)
),
testsessment1 AS (
  INSERT INTO assessments (id, title, course_instance_id, assessment_set_id) VALUES (100, 'Testsessment1', 2, 15)
),
testsessment2 AS (
  INSERT INTO assessments (id, title, course_instance_id, assessment_set_id) VALUES (101, 'Testsessment2', 2, 15)
),
testsessment3 AS (
  INSERT INTO assessments (id, title, course_instance_id, assessment_set_id) VALUES (102, 'Testsessment3', 2, 15)
),
testsessment4 AS (
  INSERT INTO assessments (id, title, course_instance_id, assessment_set_id) VALUES (103, 'Testsessment4', 2, 15)
),
testsessment5 AS (
  INSERT INTO assessments (id, title, course_instance_id, assessment_set_id) VALUES (104, 'Testsessment5', 2, 15)
),
createLive1 AS (
-- Insert rows with points incrementing from 2 to 28 in increments of 2 and set max_points to 28 for user_id 1 to 14
INSERT INTO plr_live_session (assess_id, course_instance_id, is_live)
VALUES (100, 2, TRUE)
),
insertScores1 AS(
INSERT INTO assessment_instances (user_id, points, assessment_id, max_points)
VALUES 
  (2, 2, 100, 28), 
  (3, 4, 100, 28), 
  (4, 6, 100, 28),
  (5, 8, 100, 28), 
  (6, 10, 100, 28), 
  (7, 12, 100, 28),
  (8, 14, 100, 28), 
  (9, 16, 100, 28), 
  (10, 18, 100, 28),
  (11, 20, 100, 28), 
  (12, 22, 100, 28), 
  (13, 24, 100, 28),
  (14, 26, 100, 28), 
  (15, 28, 100, 28)
),
updateDurations1 AS(
-- Update duration to random times ranging from 3 minutes to 15 minutes
UPDATE plr_live_session_credentials
SET duration = (random() * interval '12 minutes' + interval '3 minutes')
WHERE user_id BETWEEN 2 AND 15
AND session_id IN (
    SELECT id
    FROM plr_live_session
    WHERE assess_id = 100
)
),
yegorIsTheFastest1 AS (
UPDATE plr_live_session_credentials
SET duration = '00:02:00'
WHERE user_id = 6
),
closeLive1 AS (
UPDATE plr_live_session
SET is_live = FALSE
WHERE assess_id = 100 AND course_instance_id = 2
),
createLive2 AS (
-- Repeat the same process for testsessment2
INSERT INTO plr_live_session (assess_id, course_instance_id, is_live)
VALUES (101, 2, TRUE)
),
insertScores2 AS(
INSERT INTO assessment_instances (user_id, points, assessment_id, max_points)
VALUES 
  (2, 2, 101, 28), 
  (3, 4, 101, 28), 
  (4, 6, 101, 28),
  (5, 8, 101, 28), 
  (6, 10, 101, 28), 
  (7, 12, 101, 28),
  (8, 14, 101, 28), 
  (9, 16, 101, 28), 
  (10, 18, 101, 28),
  (11, 20, 101, 28), 
  (12, 22, 101, 28), 
  (13, 24, 101, 28),
  (14, 26, 101, 28), 
  (15, 28, 101, 28)
),
updateDurations2 AS(
UPDATE plr_live_session_credentials
SET duration = (random() * interval '12 minutes' + interval '3 minutes')
WHERE user_id BETWEEN 2 AND 15
AND session_id IN (
    SELECT id
    FROM plr_live_session
    WHERE assess_id = 101
)
),
yegorIsTheFastest2 AS (
UPDATE plr_live_session_credentials
SET duration = '00:02:00'
WHERE user_id = 6
),
closeLive2 AS (
UPDATE plr_live_session
SET is_live = FALSE
WHERE assess_id = 101 AND course_instance_id = 2
), 
createLive3 AS (
INSERT INTO plr_live_session (assess_id, course_instance_id, is_live)
VALUES (102, 2, TRUE)
),
insertScores3 AS(
INSERT INTO assessment_instances (user_id, points, assessment_id, max_points)
VALUES 
  (2, 2, 102, 28), 
  (3, 4, 102, 28), 
  (4, 6, 102, 28),
  (5, 8, 102, 28), 
  (6, 10, 102, 28), 
  (7, 12, 102, 28),
  (8, 14, 102, 28), 
  (9, 16, 102, 28), 
  (10, 18, 102, 28),
  (11, 20, 102, 28), 
  (12, 22, 102, 28), 
  (13, 24, 102, 28),
  (14, 26, 102, 28), 
  (15, 28, 102, 28)
),
updateDurations3 AS(
UPDATE plr_live_session_credentials
SET duration = (random() * interval '12 minutes' + interval '3 minutes')
WHERE user_id BETWEEN 2 AND 15
AND session_id IN (
    SELECT id
    FROM plr_live_session
    WHERE assess_id = 102
)
),
yegorIsTheFastest3 AS (
UPDATE plr_live_session_credentials
SET duration = '00:02:00'
WHERE user_id = 6
),
closeLive3 AS (
UPDATE plr_live_session
SET is_live = FALSE
WHERE assess_id = 102 AND course_instance_id = 2
),
-- Repeat these blocks for testsessment4
createLive4 AS (
INSERT INTO plr_live_session (assess_id, course_instance_id, is_live)
VALUES (103, 2, TRUE)
),
insertScores4 AS(
INSERT INTO assessment_instances (user_id, points, assessment_id, max_points)
VALUES 
  (2, 2, 103, 28), 
  (3, 4, 103, 28), 
  (4, 6, 103, 28),
  (5, 8, 103, 28), 
  (6, 10, 103, 28), 
  (7, 12, 103, 28),
  (8, 14, 103, 28), 
  (9, 16, 103, 28), 
  (10, 18, 103, 28),
  (11, 20, 103, 28), 
  (12, 22, 103, 28), 
  (13, 24, 103, 28),
  (14, 26, 103, 28), 
  (15, 28, 103, 28)
),
updateDurations4 AS(
UPDATE plr_live_session_credentials
SET duration = (random() * interval '12 minutes' + interval '3 minutes')
WHERE user_id BETWEEN 2 AND 15
AND session_id IN (
    SELECT id
    FROM plr_live_session
    WHERE assess_id = 103
)
),
yegorIsTheFastest4 AS (
UPDATE plr_live_session_credentials
SET duration = '00:02:00'
WHERE user_id = 6
),
closeLive4 AS (
UPDATE plr_live_session
SET is_live = FALSE
WHERE assess_id = 103 AND course_instance_id = 2
),
-- Repeat these blocks for testsessment5
createLive5 AS (
INSERT INTO plr_live_session (assess_id, course_instance_id, is_live)
VALUES (104, 2, TRUE)
),
insertScores5 AS(
INSERT INTO assessment_instances (user_id, points, assessment_id, max_points)
VALUES 
  (2, 2, 104, 28), 
  (3, 4, 104, 28), 
  (4, 6, 104, 28),
  (5, 8, 104, 28), 
  (6, 10, 104, 28), 
  (7, 12, 104, 28),
  (8, 14, 104, 28), 
  (9, 16, 104, 28), 
  (10, 18, 104, 28),
  (11, 20, 104, 28), 
  (12, 22, 104, 28), 
  (13, 24, 104, 28),
  (14, 26, 104, 28), 
  (15, 28, 104, 28)
),
updateDurations5 AS(
UPDATE plr_live_session_credentials
SET duration = (random() * interval '12 minutes' + interval '3 minutes')
WHERE user_id BETWEEN 2 AND 15
AND session_id IN (
    SELECT id
    FROM plr_live_session
    WHERE assess_id = 104
)
),
yegorIsTheFastest5 AS (
UPDATE plr_live_session_credentials
SET duration = '00:02:00'
WHERE user_id = 6
),
closeLive5 AS (
UPDATE plr_live_session
SET is_live = FALSE
WHERE assess_id = 104 AND course_instance_id = 2
)

SELECT * FROM plr_live_session_credentials;