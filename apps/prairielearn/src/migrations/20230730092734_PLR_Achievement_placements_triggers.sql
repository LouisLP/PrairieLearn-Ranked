-- This trigger updates our achievements table with gold, silver, and bronze for the top 3 students in a live session
CREATE
OR REPLACE FUNCTION assign_medals () RETURNS TRIGGER AS $$
DECLARE    
    -- Here we select the top 3 students in a live session
    --winners CURSOR FOR 
    --SELECT user_id, rank 
    --FROM PLR_live_session_credentials 
    --WHERE session_id = NEW.id 
    --ORDER BY rank ASC 
    --LIMIT 3;

    winners CURSOR FOR 
    SELECT user_id, rank 
    FROM (
     SELECT
       id,
       session_id,
       user_id,
       RANK() OVER (PARTITION BY session_id ORDER BY points DESC, duration ASC) AS rank
     FROM
       PLR_live_session_credentials
     WHERE session_id = NEW.id 
    ) as rankedTable
    WHERE session_id = NEW.id 
    ORDER BY rank ASC 
    LIMIT 3;

    winner RECORD;
    medal BIGINT;
BEGIN
    -- We then iterate through the top 3 students and assign them gold, silver, and bronze medals
    IF OLD.is_live = TRUE AND NEW.is_live = FALSE THEN
        FOR winner IN winners LOOP
            CASE winner.rank
                WHEN 1 THEN medal := 1; -- Gold
                WHEN 2 THEN medal := 2; -- Silver
                WHEN 3 THEN medal := 3; -- Bronze
            END CASE;

            IF NOT EXISTS (
                SELECT 1 
                FROM PLR_has_achieved 
                WHERE user_id = winner.user_id AND achievement_id = medal
            ) THEN
                INSERT INTO PLR_has_achieved (user_id, achievement_id, amount) 
                VALUES (winner.user_id, medal, 1);
            END IF;
        END LOOP;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

--This trigger listens to PLR_live_session table for changes in is_live column
CREATE TRIGGER assign_medals_trigger
AFTER
UPDATE OF is_live ON PLR_live_session FOR EACH ROW
EXECUTE PROCEDURE assign_medals ();
