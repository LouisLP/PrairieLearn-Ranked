-- BLOCK get_seasonal_results
SELECT
   display_name,
   points,
   (
      SELECT ARRAY_AGG(PLR_achievements.icon_name)
      FROM PLR_achievements
      JOIN PLR_has_achieved ON PLR_achievements.id = PLR_has_achieved.achievement_id
      WHERE PLR_has_achieved.user_id = PLR_students.user_id
   ) AS achievements,
   PLR_students.user_id AS user_id
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
   points,
   created_at,
   (
      SELECT ARRAY_AGG(PLR_achievements.icon_name)
      FROM PLR_achievements
      JOIN PLR_has_achieved ON PLR_achievements.id = PLR_has_achieved.achievement_id
      WHERE PLR_has_achieved.user_id = PLR_students.user_id
   ) AS achievements
FROM
   PLR_seasonal_session_CREDENTIALS
   JOIN PLR_students USING (user_id)
   JOIN PLR_seasonal_session on session_id = PLR_seasonal_session.id
WHERE
   course_id = $1
ORDER BY
   points DESC;
-- ENDBLOCK

-- BLOCK get_live_results
SELECT
   display_name,
   points,
   rank,
   duration,
   PLR_live_session_credentials.id AS identifier,
   (
      SELECT ARRAY_AGG(PLR_achievements.icon_name)
      FROM PLR_achievements
      JOIN PLR_has_achieved ON PLR_achievements.id = PLR_has_achieved.achievement_id
      WHERE PLR_has_achieved.user_id = PLR_students.user_id
   ) AS achievements
FROM
   PLR_live_session_CREDENTIALS
   JOIN PLR_students USING (user_id)
   JOIN PLR_live_session on session_id = PLR_live_session.id
WHERE
   is_live = TRUE
ORDER BY
   points DESC, duration ASC;
-- ENDBLOCK
