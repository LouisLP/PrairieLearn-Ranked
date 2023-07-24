INSERT INTO
   PLR_students (
      user_id,
      display_name,
      color,
      course_instance_id,
      live_score
   )
VALUES
   (
      $user_id :: bigint,
      $display_name :: text,
      $color :: text,
      $course_instance_id :: bigint,
      $live_score :: int
   );