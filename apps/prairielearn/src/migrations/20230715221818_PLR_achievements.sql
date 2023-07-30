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
    'Gotta Go Fast',
    'rocket_launch',
    'Fastest to submit the quiz'
  ),
  (
    'Slowpoke',
    'elderly',
    'Slowest to submit the quiz'
  ),
  (
    'Enlightened',
    'self_improvement',
    'Best score in the semester (only 1 of these is cycled out per semester)'
  ),
  (
    'Heartbroken',
    'heart_broken',
    'Worst score in the semester (only 1 of these is cycled out per semester)'
  ),
  (
    'Bronze',
    'workspace_premium',
    'Get rank 3 (colored differently) in a live quiz'
  ),
  (
    'Silver',
    'workspace_premium',
    'Get rank 2 (colored differently) in a live quiz'
  ),
  (
    'Gold',
    'workspace_premium',
    'Get rank 1 (colored differently) in a live quiz'
  ),
  (
    'The Thinker',
    'psychology',
    'Highest score with the slowest submission'
  ),
  (
    'Hat Trick',
    'school',
    '3 first place scores in a row'
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
  (
    'Best of the Best',
    'hotel_class',
    'Given at the end of the semester to the top scorer'
  );
