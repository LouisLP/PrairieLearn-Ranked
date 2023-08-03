With
  createLive AS (
    -- Insert rows with points incrementing from 2 to 28 in increments of 2 and set max_points to 28 for user_id 1 to 14
    INSERT INTO
      plr_live_session (assess_id, course_instance_id, is_live)
    VALUES
      ($assessment_id, 2, TRUE)
  ),
  insertScores AS (
    INSERT INTO
      assessment_instances (user_id, points, assessment_id)
    VALUES
      (2, 2, $assessment_id),
      (3, 4, $assessment_id),
      (4, 6, $assessment_id),
      (5, 8, $assessment_id),
      (6, 10, $assessment_id),
      (7, 12, $assessment_id),
      (8, 14, $assessment_id),
      (9, 16, $assessment_id),
      (10, 18, $assessment_id),
      (11, 20, $assessment_id),
      (12, 22, $assessment_id),
      (13, 24, $assessment_id),
      (14, 26, $assessment_id),
      (15, 28, $assessment_id)
  )
SELECT
  *
FROM
  plr_live_session;
