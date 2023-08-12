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
      (11, 'GottaGetThatMoney@ubc.ca', 'Eugene Krabs'),
      (12, 'CodeineGotMeTripping@ubc.ca', 'Don Spongiver'),
      (13, 'IAmKenough@ubc.ca', 'Ken'),
      (14, 'UncleBenis#Dead@ubc.ca', 'Miles Morales'),
      (15, 'LostMyMoney@ubc.ca', 'G@mb71ng @dd1<t')
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
  ),
  insertScores AS (
    INSERT INTO
      assessment_instances (user_id, points, assessment_id)
    VALUES
      (2, 2, $assessment_id),
      (3, 4, $assessment_id),
      (4, 6, $assessment_id),
      (5, 8, $assessment_id),
      (6, 10, $assessment_id),
      (7, 12, $assessment_id),
      (8, 14, $assessment_id),
      (9, 16, $assessment_id),
      (10, 18, $assessment_id),
      (11, 20, $assessment_id),
      (12, 22, $assessment_id),
      (13, 24, $assessment_id),
      (14, 26, $assessment_id),
      (15, 28, $assessment_id)
  ),
  updateDurations AS (
    -- Update duration to random times ranging from 3 minutes to 15 minutes
    UPDATE plr_live_session_credentials
    SET
      duration = (
        random() * interval '12 minutes' + interval '3 minutes'
      )
    WHERE
      user_id BETWEEN 2 AND 15
      AND session_id IN (
        SELECT
          id
        FROM
          plr_live_session
        WHERE
          assess_id = $assessment_id
      )
  )
SELECT
  *
FROM
  plr_live_session;

