CREATE
OR REPLACE FUNCTION perfect_score_achievement () RETURNS TRIGGER AS $$
BEGIN
  -- When is_live changes to false, check if any user has achieved half the max points
  WITH half_max_users AS (
    SELECT plr_live_session_credentials.user_id
    FROM plr_live_session 
    JOIN plr_live_session_credentials ON plr_live_session.id = plr_live_session_credentials.session_id
    JOIN assessments ON plr_live_session.assess_id = assessments.id
    WHERE plr_live_session.is_live = FALSE
      AND ROUND(plr_live_session_credentials.points / 3628) = ROUND(assessments.max_points)
  )
  INSERT INTO plr_has_achieved (user_id, achievement_id, amount)
  SELECT user_id, 9, 1
  FROM half_max_users
  WHERE NOT EXISTS (
    SELECT 1
    FROM plr_has_achieved
    WHERE plr_has_achieved.user_id = half_max_users.user_id
      AND plr_has_achieved.achievement_id = 9
  );

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER perfect_score_achievement_trigger
AFTER
UPDATE OF is_live ON plr_live_session FOR EACH ROW WHEN (NEW.is_live = FALSE)
EXECUTE FUNCTION perfect_score_achievement ();
