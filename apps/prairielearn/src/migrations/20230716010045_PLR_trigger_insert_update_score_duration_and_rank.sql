CREATE OR REPLACE FUNCTION update_score_and_rank()
RETURNS TRIGGER AS $$
BEGIN
  IF NEW.id IN (
    SELECT assessment_instance_id
    FROM PLR_live_session_credentials
  ) THEN
    UPDATE PLR_live_session_credentials 
    SET points = NEW.points * 3628, duration = NEW.duration
    WHERE
      PLR_live_session_credentials.assessment_instance_id = NEW.id;

  ELSIF NEW.assessment_id IN (
    SELECT assess_id
    FROM PLR_live_session
    WHERE is_live = TRUE
  ) THEN
    INSERT INTO PLR_live_session_credentials (points, session_id, duration, user_id, assessment_instance_id)
    SELECT
      NEW.points * 3628,
      PLR_live_session.id,
      NEW.duration,
      NEW.user_id,
      NEW.id
    FROM
      PLR_live_session
      INNER JOIN assessments ON PLR_live_session.course_instance_id = assessments.course_instance_id
    WHERE
      assessments.id = NEW.assessment_id;
  END IF;

  WITH RankedTable AS (
    SELECT
      id,
      session_id,
      user_id,
      RANK() OVER (PARTITION BY session_id ORDER BY points DESC, duration ASC) AS new_rank
    FROM
      PLR_live_session_credentials
  )
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
