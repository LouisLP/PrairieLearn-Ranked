-- Create a trigger function to handle the logic when is_live changes to false
CREATE
OR REPLACE FUNCTION check_hat_trick () RETURNS TRIGGER AS $$
DECLARE
    user_id_to_insert BIGINT;
BEGIN
    -- Check if the session is now closed (is_live changed to false)
    IF OLD.is_live = true AND NEW.is_live = false THEN
        -- Find the last three rank 1 records for the same course_instance_id
        SELECT user_id
        FROM PLR_live_session_credentials
        WHERE rank = 1 AND session_id 
        IN (
            SELECT id FROM PLR_live_session
            WHERE course_instance_id = NEW.course_instance_id
            ORDER BY created_at DESC
            LIMIT 3
        )
        GROUP BY user_id
        HAVING COUNT(*) = 3
        INTO user_id_to_insert;

        -- Check if the last three rank 1s belong to the same user and the user hasn't already achieved this achievement
        IF user_id_to_insert IS NOT NULL AND NOT EXISTS (
            SELECT 1
            FROM PLR_has_achieved
            WHERE user_id = user_id_to_insert AND achievement_id = 4
        ) THEN
            -- Insert into the has_achieved table
            INSERT INTO PLR_has_achieved (user_id, achievement_id, amount)
            VALUES (user_id_to_insert, 4, 1);
        END IF;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create the trigger on PLR_live_session to invoke the trigger function
CREATE TRIGGER check_hat_trick_trigger
AFTER
UPDATE ON PLR_live_session FOR EACH ROW
EXECUTE FUNCTION check_hat_trick ();
