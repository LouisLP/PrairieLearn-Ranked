-- Moved all the inserts here to ensure that they are run after the tables are created.

-- Insert our pre-made achievements into the achievements table
INSERT INTO
  PLR_achievements (
    achievement_name,
    icon_name,
    achievement_description
  )
VALUES
  ( -- ID 1
    'Gold',
    'counter_1',
    'Rank 1 in a live quiz'
  ),
  ( -- ID 2
    'Silver',
    'counter_2',
    'Rank 2 in a live quiz'
  ),
  ( -- ID 3
    'Bronze',
    'counter_3',
    'Rank 3 in a live quiz'
  ),
  ( -- ID 4
    'Hat Trick',
    'school',
    'Rank 1, 3 live quizzes in a row'
  ),
  ( -- ID 5
    'Gotta Go Fast',
    'rocket_launch',
    'Fastest to submit the quiz'
  ),
  ( -- ID 6
    'Speed Demon',
    'sprint',
    'Fastest time, 5 live quizzes in a row'
  ),
  ( -- ID 7
    'Always On Time',
    'emoji_people',
    'Attended every quiz'
  ),
  ( -- ID 8
    'Unstoppable',
    'person_celebrate',
    'Rank 1, 5 live quizzes in a row'
  );

-- This insert will grab every student in the DB when the table is made.
-- INSERT INTO PLR_students (user_id, display_name)
-- SELECT 
--     user_id, name
-- FROM
--     users
-- WHERE
--     user_id NOT IN (
--         SELECT
--             user_id
--         FROM
--             job_sequences
--     );

-- This insert will grab every student's enrollment in the DB when the table is made.
INSERT INTO PLR_enrollment (user_id, course_instance_id)
SELECT 
    user_id, course_instance_id
FROM
    enrollments;