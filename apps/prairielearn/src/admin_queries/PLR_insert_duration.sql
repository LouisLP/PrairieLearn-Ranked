UPDATE plr_live_session_credentials
    SET
      duration = $duration
    WHERE
      user_id = $user_id AND session_id = $session_id
RETURNING *;