-- BLOCK get_seasonal_results
SELECT
   display_name,
   points
FROM
   PLR_seasonal_session_credentials
   INNER JOIN PLR_students ON PLR_seasonal_session_credentials.user_id = PLR_students.user_id
ORDER BY
   points DESC;
-- ENDBLOCK