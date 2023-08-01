WITH
  users AS (
    -- Insert new users
    INSERT INTO
      users (user_id, uid, name)
    VALUES
      (2, 'fazackernator@ubc.ca', 'Fazackernator'),
      (3, 'big_ramon@ubc.ca', 'Big Ramon'),
      (4, 'mouth_man@ubc.ca', 'Mouth of Sauron'),
      (5, 'YesHoney@ubc.ca', 'Louis Dear'),
      (6, 'TheYoungGoat@ubc.ca', 'Sheel The Goat'),
      (7, 'ErenYegor@ubc.ca', 'Babayegor'),
      (8, 'IAmBecomePL@ubc.ca', 'PL God'),
      (9, 'LordAndSaviour@ubc.ca', 'The Almighty Nathan'),
      (10, 'TheReverseFlash@ubc.ca', 'Eobard Thawne'),
      (11, 'GottaGetThatMoney@ubc.ca', 'Eugene Crabs'),
      (
        12,
        'CodeineGotMeTripping@ubc.ca',
        'Don Spongiver'
      ),
      (13, 'IAmKenough@ubc.ca', 'Ken'),
      (14, 'UncleBenis#Dead@ubc.ca', 'Miles Morales'),
      (15, 'LostMyMoney@ubc.ca', 'G@mb71ng @dd1<t')
  ),
  enrolls AS (
    INSERT INTO
      enrollments (user_id, course_instance_id)
    VALUES
      (2, 2),
      (3, 2),
      (4, 2),
      (5, 2),
      (6, 2),
      (7, 2),
      (8, 2),
      (9, 2),
      (10, 2),
      (11, 2),
      (12, 2),
      (13, 2),
      (14, 2),
      (15, 2)
  ),
  testsessment1 AS (
    INSERT INTO
      assessments (
        id,
        title,
        course_instance_id,
        assessment_set_id,
        max_points
      )
    VALUES
      (100, 'Testsessment1', 2, 15, 28)
  ),
  testsessment2 AS (
    INSERT INTO
      assessments (
        id,
        title,
        course_instance_id,
        assessment_set_id,
        max_points
      )
    VALUES
      (101, 'Testsessment2', 2, 15, 28)
  ),
  testsessment3 AS (
    INSERT INTO
      assessments (
        id,
        title,
        course_instance_id,
        assessment_set_id,
        max_points
      )
    VALUES
      (102, 'Testsessment3', 2, 15, 28)
  ),
  testsessment4 AS (
    INSERT INTO
      assessments (
        id,
        title,
        course_instance_id,
        assessment_set_id,
        max_points
      )
    VALUES
      (103, 'Testsessment4', 2, 15, 28)
  ),
  testsessment5 AS (
    INSERT INTO
      assessments (
        id,
        title,
        course_instance_id,
        assessment_set_id,
        max_points
      )
    VALUES
      (104, 'Testsessment5', 2, 15, 28)
  )
SELECT
  *
FROM
  assessments;
