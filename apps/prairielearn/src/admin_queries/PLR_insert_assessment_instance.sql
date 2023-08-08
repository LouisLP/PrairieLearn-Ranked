INSERT INTO
      assessment_instances (user_id, points, assessment_id)
    VALUES
      ($user_id, $points, $assessment_id)
RETURNING *;
