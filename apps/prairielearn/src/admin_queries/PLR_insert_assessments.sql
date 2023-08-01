WITH
testsessment1 AS (
  INSERT INTO assessments (id, title, course_instance_id, assessment_set_id) VALUES (100, 'Testsessment1', 2, 15)
),
testsessment2 AS (
  INSERT INTO assessments (id, title, course_instance_id, assessment_set_id) VALUES (101, 'Testsessment2', 2, 15)
),
testsessment3 AS (
  INSERT INTO assessments (id, title, course_instance_id, assessment_set_id) VALUES (102, 'Testsessment3', 2, 15)
),
testsessment4 AS (
  INSERT INTO assessments (id, title, course_instance_id, assessment_set_id) VALUES (103, 'Testsessment4', 2, 15)
),
testsessment5 AS (
  INSERT INTO assessments (id, title, course_instance_id, assessment_set_id) VALUES (104, 'Testsessment5', 2, 15)
)
SELECT * FROM assessments;