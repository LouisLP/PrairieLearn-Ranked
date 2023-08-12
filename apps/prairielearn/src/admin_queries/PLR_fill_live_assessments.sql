WITH
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
    ),
    updateDurations AS (
    -- Update duration to random times ranging from 3 minutes to 15 minutes
    UPDATE plr_live_session_credentials
    SET
      duration = (
        random() * interval '12 minutes' + interval '3 minutes'
      )
    WHERE
      user_id BETWEEN 2 AND 15
      AND session_id IN (
        SELECT
          id
        FROM
          plr_live_session
        WHERE
          assess_id = $assessment_id
      )
  )
SELECT
  *
FROM
  PLR_live_session_credentials;