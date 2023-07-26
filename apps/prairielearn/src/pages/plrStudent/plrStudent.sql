-- BLOCK get_seasonal_results
SELECT
   display_name,
   points
FROM
   PLR_seasonal_session_CREDENTIALS
   JOIN PLR_students USING (user_id)
WHERE
   course_instance_id = $course_instance_id
ORDER BY
   points DESC;
-- ENDBLOCK