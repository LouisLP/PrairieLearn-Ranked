-- Create a trigger function to handle the updates
CREATE
OR REPLACE FUNCTION gotta_go_fast () RETURNS TRIGGER AS $$
BEGIN
  IF OLD.is_live = true AND NEW.is_live = false THEN
    -- Find the row in plr_live_session_credentials with the matching session_id
    -- and the shortest duration
    WITH shortest_duration AS (
      SELECT user_id
      FROM plr_live_session_credentials
      WHERE session_id = OLD.id
      ORDER BY duration ASC
      LIMIT 1
    )
    -- Insert the user_id into plr_has_achieved and set achievement to 1
    INSERT INTO plr_has_achieved (user_id, achievement_id, amount)
    SELECT user_id, 5, 1
    FROM shortest_duration;
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create the trigger on the plr_live_session table
CREATE TRIGGER gotta_go_fast_trigger
AFTER
UPDATE ON plr_live_session FOR EACH ROW
EXECUTE FUNCTION gotta_go_fast ();
