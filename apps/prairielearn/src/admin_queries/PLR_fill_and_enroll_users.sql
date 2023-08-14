WITH
  users AS (
    -- Insert new users
    INSERT INTO
      users (user_id, uid, name)
    VALUES
      (15, 'fazackernator@ubc.ca', 'Fazackernator'),
      (14, 'big_ramon@ubc.ca', 'Big Ramon'),
      (13, 'mouth_man@ubc.ca', 'Mouth of Sauron'),
      (12, 'YesHoney@ubc.ca', 'Louis Dear'),
      (11, 'TheYoungGoat@ubc.ca', 'Sheel The Goat'),
      (10, 'ErenYegor@ubc.ca', 'Babayegor'),
      (9, 'IAmBecomePL@ubc.ca', 'PL God'),
      (8, 'LordAndSaviour@ubc.ca', 'The Almighty Nathan'),
      (7, 'TheReverseFlash@ubc.ca', 'Eobard Thawne'),
      (6, 'GottaGetThatMoney@ubc.ca', 'Eugene Krabs'),
      (5, 'CodeineGotMeTripping@ubc.ca', 'Don Spongiver'),
      (4, 'IAmKenough@ubc.ca', 'Ken'),
      (3, 'UncleBenis#Dead@ubc.ca', 'Miles Morales'),
      (2, 'LostMyMoney@ubc.ca', 'G@mb71ng @dd1<t')
  ),
  enrolls AS (
    INSERT INTO
      enrollments (user_id, course_instance_id)
    VALUES
      (2, $course_instance_id),
      (3, $course_instance_id),
      (4, $course_instance_id),
      (5, $course_instance_id),
      (6, $course_instance_id),
      (7, $course_instance_id),
      (8, $course_instance_id),
      (9, $course_instance_id),
      (10, $course_instance_id),
      (11, $course_instance_id),
      (12, $course_instance_id),
      (13, $course_instance_id),
      (14, $course_instance_id),
      (15, $course_instance_id)
  )
SELECT
  *
FROM
  PLR_students JOIN enrollments ON enrollments.user_id = PLR_students.user_id;