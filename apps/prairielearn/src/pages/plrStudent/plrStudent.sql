-- BLOCK get_user_display_name
SELECT
   display_name
FROM
   PLR_students
WHERE
   user_id = $1;
-- ENDBLOCK

-- BLOCK update_display_name
UPDATE
   PLR_students
SET
   display_name = $2
WHERE
   user_id = $1;
-- ENDBLOCK