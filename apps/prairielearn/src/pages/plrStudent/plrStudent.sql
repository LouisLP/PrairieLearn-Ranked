-- BLOCK get_seasonal_results
SELECT
   user_id,
   points
FROM
   PLR_seasonal_session_CREDENTIALS
ORDER BY
   points DESC;
-- ENDBLOCK