INSERT INTO plr_has_achieved
    (user_id, achievement_id, amount)
    VALUES
    ($user_id, $achievement_id, 1)
RETURNING *;