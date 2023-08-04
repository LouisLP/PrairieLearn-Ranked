INSERT INTO assessments (
    id,
    title,
    course_instance_id,
    assessment_set_id
    )
    VALUES
    ($assessment_id, $title, $course_instance_id, $assessment_set_id)
RETURNING *;