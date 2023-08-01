CREATE
OR REPLACE FUNCTION speed_demon_achievement () RETURNS TRIGGER AS $$
DECLARE
  shortest_duration_record RECORD;
  same_user_count INTEGER;
BEGIN
  -- 1. Find the plr_live_session_credential row with the shortest duration and matching session_id
  SELECT INTO shortest_duration_record *
  FROM plr_live_session_credentials
  WHERE session_id = NEW.id
  ORDER BY duration ASC
  LIMIT 1;

  -- 2. Check the previous 4 plr_live_sessions with matching course_instance_ids
  SELECT INTO same_user_count COUNT(*)
  FROM (
    SELECT id
    FROM plr_live_session
    WHERE course_instance_id = NEW.course_instance_id AND id < NEW.id
    ORDER BY created_at DESC
    LIMIT 4
  ) as previous_sessions
  JOIN plr_live_session_credentials ON previous_sessions.id = plr_live_session_credentials.session_id
  WHERE plr_live_session_credentials.user_id = shortest_duration_record.user_id;

  -- 3. If the same user_id had the shortest duration, insert a row into the plr_has_achieved table
  IF same_user_count = 4 THEN
    INSERT INTO plr_has_achieved (user_id, achievement_id, amount)
    SELECT shortest_duration_record.user_id, 6, 1
    WHERE NOT EXISTS (
      SELECT 1 FROM plr_has_achieved
      WHERE user_id = shortest_duration_record.user_id AND achievement_id = 6
    );
  END IF;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER speed_demon_achievement_trigger
AFTER
UPDATE OF is_live ON plr_live_session FOR EACH ROW WHEN (NEW.is_live IS FALSE)
EXECUTE FUNCTION speed_demon_achievement ();
