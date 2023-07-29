-- Stop the live session
UPDATE
  PLR_live_session
SET
  is_live = FALSE
WHERE
  id = $id
-- Return the updated rows
RETURNING *;