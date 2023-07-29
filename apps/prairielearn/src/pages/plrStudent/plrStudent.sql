-- BLOCK get_seasonal_results
SELECT
   display_name,
   points
FROM
   PLR_live_session_CREDENTIALS
   JOIN PLR_students USING (user_id);
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
   JOIN PLR_students USING (user_id);
ORDER BY
   points DESC;

-- ENDBLOCK
