WITH
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
  ),
  yegorIsTheFastest AS (
    UPDATE plr_live_session_credentials
    SET
      duration = '00:02:00'
    WHERE
      user_id = 6
  )
SELECT
  *
FROM
  plr_live_session_credentials;
