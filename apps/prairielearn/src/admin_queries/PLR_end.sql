-- Stop the live session
UPDATE
  PLR_live_session
SET
  is_live = FALSE
WHERE
  is_live = TRUE 
-- Return the updated rows
RETURNING *;