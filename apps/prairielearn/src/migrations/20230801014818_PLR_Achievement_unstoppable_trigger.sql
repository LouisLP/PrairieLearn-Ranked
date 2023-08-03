-- This trigger gives a student the unstoppable achievement if they are ranked first in 5 consecutive live sessions
CREATE
OR REPLACE FUNCTION unstoppable_achievement () RETURNS TRIGGER AS $$
DECLARE
    first_ranker RECORD;
    prev_sessions_first_ranker RECORD;
    rank_one_counter INTEGER := 0;
BEGIN
  IF NEW.is_live = FALSE THEN
    FOR first_ranker IN (
      SELECT user_id 
      FROM plr_live_session_credentials 
      WHERE session_id = NEW.id AND rank = 1
    ) LOOP
    -- Here we select the top student in the previous 4 live sessions
      FOR prev_sessions_first_ranker IN (
        SELECT plr_live_session_credentials.user_id
        FROM plr_live_session
        JOIN plr_live_session_credentials ON plr_live_session.id = plr_live_session_credentials.session_id
        WHERE plr_live_session.course_instance_id = NEW.course_instance_id 
          AND plr_live_session.created_at < NEW.created_at
          AND plr_live_session_credentials.rank = 1
        ORDER BY plr_live_session.created_at DESC
        LIMIT 4
      ) LOOP
      -- If the student is ranked first in the current live session and the previous 4 live sessions, then we increment the counter
        IF first_ranker.user_id = prev_sessions_first_ranker.user_id THEN
          rank_one_counter := rank_one_counter + 1;
        END IF;
      END LOOP;
      IF rank_one_counter >= 4 THEN
        INSERT INTO plr_has_achieved (user_id, achievement_id, amount)
        SELECT first_ranker.user_id, 8, 1
        WHERE NOT EXISTS (
          SELECT 1 
          FROM plr_has_achieved 
          WHERE user_id = first_ranker.user_id AND achievement_id = 8
        );
      END IF;
    END LOOP;
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- This trigger listens to the plr_live_session table
CREATE TRIGGER unstoppable_achievement_trigger
AFTER
UPDATE OF is_live ON plr_live_session FOR EACH ROW
EXECUTE FUNCTION unstoppable_achievement ();
