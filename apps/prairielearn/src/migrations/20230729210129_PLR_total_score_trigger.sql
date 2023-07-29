-- This trigger is used to store the total score of each student.
CREATE OR REPLACE FUNCTION update_total_score()
RETURNS TRIGGER AS $$
BEGIN

    UPDATE PLR_students
    SET total_score = total_score + NEW.points
    WHERE user_id = NEW.user_id;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- This trigger listens to the seasonal_session_credentials table and updates the total_score
CREATE TRIGGER seasonal_credential_update_trigger
AFTER INSERT OR UPDATE ON PLR_seasonal_session_CREDENTIALS
FOR EACH ROW
EXECUTE FUNCTION update_total_score();