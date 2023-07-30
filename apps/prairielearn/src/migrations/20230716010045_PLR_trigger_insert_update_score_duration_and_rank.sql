-- This trigger updates the score, duration, and rank for students in the live session.
CREATE OR REPLACE FUNCTION update_score_and_rank()
RETURNS TRIGGER AS $$
BEGIN
  -- First thing we do is check if the student has already started an assessment instance in the live session.
  IF NEW.id IN (
    SELECT assessment_instance_id
    FROM PLR_live_session_credentials
  ) THEN
    --If they have, we update their score and duration.
    UPDATE PLR_live_session_credentials
    SET
      points = NEW.points * 3628,
      duration = NOW() - PLR_live_session_credentials.assessment_start_time
    WHERE
      PLR_live_session_credentials.assessment_instance_id = NEW.id;


  -- Then we check if the assessment of our new row has a live session attached.
  ELSIF NEW.assessment_id IN (
    SELECT assess_id
    FROM PLR_live_session
    WHERE is_live = TRUE
  ) THEN
    -- If it does, we insert a new row into the live session credentials table.
    INSERT INTO PLR_live_session_credentials (points, session_id, assessment_start_time, user_id, assessment_instance_id)
    SELECT
      NEW.points * 3628,
      PLR_live_session.id,
      NOW(),
      NEW.user_id,
      NEW.id
    FROM
      PLR_live_session
      INNER JOIN assessments ON PLR_live_session.course_instance_id = assessments.course_instance_id
    WHERE
      assessments.id = NEW.assessment_id;
  END IF;

  -- This query updates the rank of each student in the live session.
  WITH RankedTable AS (
    SELECT
      id,
      session_id,
      user_id,
      RANK() OVER (PARTITION BY session_id ORDER BY points DESC, duration ASC) AS new_rank
    FROM
      PLR_live_session_credentials
  )
  -- This sets the rank of each student in the live session to the rank in the RankedTable.
  UPDATE PLR_live_session_credentials AS target
  SET rank = subquery.new_rank
  FROM RankedTable AS subquery
  WHERE target.id = subquery.id;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- This trigger listens for updates or inserts on assessment instances
CREATE TRIGGER trigger_update_assessment_instances
AFTER UPDATE OR INSERT ON assessment_instances
FOR EACH ROW
EXECUTE FUNCTION update_score_and_rank();
