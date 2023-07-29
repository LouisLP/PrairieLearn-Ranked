-- STUDENTS (connected to "users" with additional information for ranked profiles and live scores)
CREATE TABLE IF NOT EXISTS PLR_enrollment (
    user_id BIGINT ,
    course_instance_id VARCHAR(256) NOT NULL,
    PRIMARY KEY (user_id, course_instance_id)
);

-- This insert will grab every student in the DB when the table is made.
INSERT INTO PLR_enrollment (user_id, course_instance_id)
SELECT 
    user_id, course_instance_id
FROM
    enrollments;

CREATE OR REPLACE FUNCTION set_plr_enrollment()
RETURNS TRIGGER AS $$
BEGIN

        INSERT INTO PLR_enrollment (user_id, course_instance_id)
        VALUES (NEW.user_id, NEW.course_instance_id);

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER trigger_update_or_insert_enrollment
AFTER INSERT
   ON enrollments 
   FOR EACH ROW EXECUTE FUNCTION set_plr_enrollment();