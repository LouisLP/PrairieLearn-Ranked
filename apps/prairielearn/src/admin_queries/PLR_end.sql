-- Stop the live session and return the updated rows
UPDATE
  PLR_live_session
SET
  is_live = FALSE
WHERE
  is_live = TRUE 
RETURNING *;