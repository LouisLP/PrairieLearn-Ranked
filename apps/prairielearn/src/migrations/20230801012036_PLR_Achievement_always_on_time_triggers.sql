-- This trigger removes the always on time achievement if a student misses a live session.
CREATE
OR REPLACE FUNCTION remove_aot_achievement () RETURNS TRIGGER AS $$
DECLARE
  missing_user_id INTEGER;
BEGIN
  -- Find user_id that exists in the join of plr_students and enrollments but not in the join of plr_live_session and plr_live_session_credentials
  SELECT INTO missing_user_id plr_students.user_id
  FROM plr_students
  JOIN enrollments ON plr_students.user_id = enrollments.user_id
  WHERE NOT EXISTS (
    SELECT 1
    FROM plr_live_session
    JOIN plr_live_session_credentials ON plr_live_session.id = plr_live_session_credentials.session_id
    WHERE plr_live_session_credentials.user_id = plr_students.user_id AND plr_live_session.id = NEW.id
  );

  -- If such a user_id was found, delete the corresponding row from the plr_has_achieved table
  IF FOUND AND EXISTS (
    SELECT 1 FROM plr_has_achieved WHERE user_id = missing_user_id AND achievement_id = 7
  ) THEN
    DELETE FROM plr_has_achieved
    WHERE user_id = missing_user_id AND achievement_id = 7;
  END IF;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- This trigger listens to the plr_live_session table
CREATE TRIGGER remove_aot_achievement_trigger
AFTER
UPDATE OF is_live ON plr_live_session FOR EACH ROW WHEN (NEW.is_live IS FALSE)
EXECUTE FUNCTION remove_aot_achievement ();

-- Insert the achievement into the plr_has_achieved table when a new student is created
CREATE
OR REPLACE FUNCTION insert_aot_achievement () RETURNS TRIGGER AS $$
BEGIN
  -- When a new student is inserted, insert a new row into plr_has_achieved
  INSERT INTO plr_has_achieved (user_id, achievement_id, amount)
  VALUES (NEW.user_id, 7, 1);

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- This trigger listens to the plr_students table
CREATE TRIGGER insert_aot_achievement_trigger
AFTER INSERT ON plr_students FOR EACH ROW
EXECUTE FUNCTION insert_aot_achievement ();
