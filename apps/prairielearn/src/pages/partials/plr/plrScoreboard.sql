-- BLOCK get_seasonal_results
SELECT
   display_name,
   points
FROM
   PLR_seasonal_session_CREDENTIALS
   JOIN PLR_students USING (user_id)
   JOIN PLR_seasonal_session on session_id = PLR_seasonal_session.id
WHERE
   course_instance_id = $1
ORDER BY
   points DESC;
-- ENDBLOCK

-- BLOCK get_alltime_results
SELECT
   display_name,
   points
FROM
   PLR_seasonal_session_CREDENTIALS
   JOIN PLR_students USING (user_id)
WHERE
   course_instance_id = $1
ORDER BY
   points DESC;
-- ENDBLOCK

-- BLOCK get_live_results
SELECT
   display_name,
   points,
   rank,
   duration
FROM
   PLR_live_session_CREDENTIALS
   JOIN PLR_students USING (user_id)
ORDER BY
   points DESC;
-- ENDBLOCK
