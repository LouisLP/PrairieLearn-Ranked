-- This trigger updates the seasonal table with the latest data from the live table when a live table is closed.
CREATE OR REPLACE FUNCTION move_to_seasonal_session()
RETURNS TRIGGER AS
$$
DECLARE
    cred PLR_live_session_credentials%ROWTYPE;
BEGIN
    -- Insert or update data in PLR_seasonal_session table
    IF NEW.is_live = FALSE THEN
        INSERT INTO PLR_seasonal_session (course_instance_id, course_id)
        SELECT NEW.course_instance_id, course_id
        FROM course_instances
        WHERE course_instances.id = NEW.course_instance_id
        ON CONFLICT (course_instance_id) DO NOTHING;


        -- Loop over live session credentials and insert or update data in PLR_seasonal_session_credentials table
        FOR cred IN SELECT * FROM PLR_live_session_credentials WHERE session_id = NEW.id
        LOOP
            -- Check if the user_id already exists in PLR_seasonal_session_credentials for this session_id
            IF EXISTS (
                SELECT 1 FROM PLR_seasonal_session_credentials
                WHERE live_id = NEW.id AND user_id = cred.user_id
            ) THEN
                -- If the user_id exists, update points and duration
                UPDATE PLR_seasonal_session_credentials
                SET points = points + cred.points,
                    duration = duration + cred.duration
                WHERE session_id = NEW.id AND user_id = cred.user_id;
            ELSE
                -- If the user_id doesn't exist, insert a new row
                INSERT INTO PLR_seasonal_session_credentials (session_id, user_id, points, duration)
                SELECT id, cred.user_id, cred.points, cred.duration
                FROM PLR_seasonal_session
                WHERE course_instance_id = NEW.course_instance_id;
            END IF;
        END LOOP;

        RETURN NEW;
    END IF;
    RETURN NULL;
END;
$$
LANGUAGE plpgsql;


-- This trigger listens for updates on assessment instances
CREATE TRIGGER trg_move_to_seasonal_session
AFTER UPDATE OF is_live ON PLR_live_session
FOR EACH ROW
EXECUTE FUNCTION move_to_seasonal_session();