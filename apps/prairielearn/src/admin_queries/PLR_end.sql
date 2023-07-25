-- Stop the live session
UPDATE
  PLR_live_session
SET
  is_live = FALSE
WHERE
  id = 1
-- Return the updated rows
RETURNING *;