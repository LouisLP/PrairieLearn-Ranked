WITH
  newUser AS (
      INSERT INTO
          users (user_id, uid, name)
          VALUES
          ($user_id, $uid, $name)
  ),
  enrollUser AS (
      INSERT INTO
        enrollments (user_id, course_instance_id)
      VALUES
        ($user_id, $course_instance_id)
  )
SELECT * FROM users WHERE user_id = $user_id;