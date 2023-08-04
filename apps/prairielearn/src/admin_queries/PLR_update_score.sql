UPDATE assessment_instances
    SET
      points = $points
    WHERE
      user_id = $user_id AND assessment_id = $assessment_id