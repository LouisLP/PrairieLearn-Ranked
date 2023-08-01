CREATE
OR REPLACE FUNCTION trg_insert_plr_has_achieved_on_top_ranks () RETURNS TRIGGER AS $$
DECLARE
    top_rankers RECORD;
    prev_sessions_top_rankers RECORD;
BEGIN
  IF NEW.is_live = FALSE THEN
    FOR top_rankers IN (
      SELECT user_id 
      FROM plr_live_session_credentials 
      WHERE session_id = NEW.id AND rank IN (1, 2, 3)
    ) LOOP
      FOR prev_sessions_top_rankers IN (
        SELECT plr_live_session_credentials.user_id
        FROM plr_live_session
        JOIN plr_live_session_credentials ON plr_live_session.id = plr_live_session_credentials.session_id
        WHERE plr_live_session.course_instance_id = NEW.course_instance_id 
          AND plr_live_session.created_at < NEW.created_at
          AND plr_live_session_credentials.rank IN (1, 2, 3)
        ORDER BY plr_live_session.created_at DESC
        LIMIT 2
      ) LOOP
        IF top_rankers.user_id = prev_sessions_top_rankers.user_id THEN
          INSERT INTO plr_has_achieved (user_id, achievement_id, amount)
          SELECT top_rankers.user_id, 10, 1
          WHERE NOT EXISTS (
            SELECT 1 
            FROM plr_has_achieved 
            WHERE user_id = top_rankers.user_id AND achievement_id = 10
          );
          EXIT;  -- Exit the loop early since we found a match
        END IF;
      END LOOP;
    END LOOP;
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_after_update_plr_live_session_rank
AFTER
UPDATE OF is_live ON plr_live_session FOR EACH ROW
EXECUTE FUNCTION trg_insert_plr_has_achieved_on_top_ranks ();
