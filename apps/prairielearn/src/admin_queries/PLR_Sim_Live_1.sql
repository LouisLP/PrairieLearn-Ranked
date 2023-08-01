With
createLive AS (
-- Insert rows with points incrementing from 2 to 28 in increments of 2 and set max_points to 28 for user_id 1 to 14
INSERT INTO plr_live_session (assess_id, course_instance_id, is_live)
VALUES ($assessment_id, 2, TRUE)
),
insertScores AS(
INSERT INTO assessment_instances (user_id, points, assessment_id, max_points)
VALUES 
  (2, 2, $assessment_id, 28), 
  (3, 4, $assessment_id, 28), 
  (4, 6, $assessment_id, 28),
  (5, 8, $assessment_id, 28), 
  (6, 10, $assessment_id, 28), 
  (7, 12, $assessment_id, 28),
  (8, 14, $assessment_id, 28), 
  (9, 16, $assessment_id, 28), 
  (10, 18, $assessment_id, 28),
  (11, 20, $assessment_id, 28), 
  (12, 22, $assessment_id, 28), 
  (13, 24, $assessment_id, 28),
  (14, 26, $assessment_id, 28), 
  (15, 28, $assessment_id, 28)
),
updateDurations AS(
-- Update duration to random times ranging from 3 minutes to 15 minutes
UPDATE plr_live_session_credentials
SET duration = (random() * interval '12 minutes' + interval '3 minutes')
WHERE user_id BETWEEN 2 AND 15
AND session_id IN (
    SELECT id
    FROM plr_live_session
    WHERE assess_id = $assessment_id
)
),
yegorIsTheFastest AS (
UPDATE plr_live_session_credentials
SET duration = '00:02:00'
WHERE user_id = 6
),
closeLive AS (
UPDATE plr_live_session
SET is_live = FALSE
WHERE assess_id = $assessment_id AND course_instance_id = 2
)
SELECT * FROM plr_live_session_credentials;