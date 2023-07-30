-- BLOCK get_quizzes
SELECT
   assessments.title,
   assessments.id,
   assessments.course_instance_id
FROM
   assessments
   JOIN assessment_sets ON assessments.assessment_set_id = assessment_sets.id
WHERE
   assessment_sets.abbreviation = 'LV'
   AND assessments.course_instance_id = $1;

-- ENDBLOCK

-- BLOCK set_live_flag

INSERT INTO PLR_live_session (assess_id, course_instance_id, is_live)
VALUES ($1, $2, TRUE);

-- ENDBLOCK