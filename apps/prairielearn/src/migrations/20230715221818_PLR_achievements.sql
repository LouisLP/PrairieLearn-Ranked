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