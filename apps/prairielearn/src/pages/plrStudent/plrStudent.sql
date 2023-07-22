-- BLOCK get_student_information
SELECT
   *
FROM
   PLR_students
WHERE
   user_id = $ 1;
-- ENDBLOCK

-- BLOCK get_seasonal_results
SELECT
   user_id,
   points
FROM
   PLR_seasonal_session_CREDENTIALS
ORDER BY
   points DESC;
-- ENDBLOCK