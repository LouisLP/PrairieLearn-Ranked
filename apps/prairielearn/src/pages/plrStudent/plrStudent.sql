-- BLOCK get_user_display_name
SELECT
   PLR_students.display_name
FROM
   PLR_students
WHERE
   PLR_students.user_id = $1;
-- ENDBLOCK