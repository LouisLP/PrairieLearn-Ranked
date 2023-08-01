-- This table represents the achievements that a student can win.
CREATE TABLE IF NOT EXISTS
  PLR_achievements (
    id SERIAL PRIMARY KEY,
    achievement_name VARCHAR(50) NOT NULL,
    icon_name VARCHAR(50) NOT NULL,
    achievement_description VARCHAR(256)
  );

-- This table represents the achievements that a student has won.
CREATE TABLE IF NOT EXISTS
  PLR_has_achieved (
    user_id BIGINT,
    achievement_id BIGINT,
    amount INT,
    PRIMARY KEY (user_id, achievement_id),
    FOREIGN KEY (user_id) REFERENCES PLR_students (user_id),
    FOREIGN KEY (achievement_id) REFERENCES PLR_achievements (id)
  );

-- Insert our premade achievements into the achievements table
INSERT INTO
  PLR_achievements (
    achievement_name,
    icon_name,
    achievement_description
  )
VALUES
  (
    'Gold',
    'Rank 1 in a live quiz', -- Comma was missing here
    'workspace_premium'
  ),
  (
    'Silver',
    'workspace_premium',
    'Rank 2 in a live quiz'
  ),
  (
    'Bronze',
    'workspace_premium',
    'Rank 3 in a live quiz'
  ),
  (
    'Hat Trick',
    'school',
    'Rank 1, 3 live quizzes in a row'
  ),
  (
    'Gotta Go Fast',
    'rocket_launch',
    'Fastest to submit the quiz'
  ),
  (
    'Speed Demon',
    'no icon',
    'Fastest time 5 live quizzes in a row'
  ),
  (
    'Always On Time',
    'emoji_people',
    'Attended every quiz'
  ),
  (
    'Half-Baked',
    'cookie',
    'Exactly half the maximum score (pass)'
  ),
  ('Perfect Score', 'no icon', 'Perfect score'),
  (
    'Power Streak',
    'no icon',
    'Top 3 results, 5 quizzes in a row'
  ),
  (
    'Unstoppable',
    'no icon',
    'Rank 1, 5 or more live quizzes in a row'
  );
