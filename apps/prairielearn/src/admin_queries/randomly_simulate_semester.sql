SELECT
  user_id,
  uid,
  name,
  c.id AS course_id,
  c.short_name AS course,
  ci.id AS course_instance_id,
  ci.short_name AS course_instance
FROM
  users_randomly_generate (
    $count::int,
    NULLIF($course_instance_id, '')::bigint
  )
  LEFT JOIN course_instances AS ci on (ci.id = NULLIF($course_instance_id, '')::bigint)
  LEFT JOIN pl_courses AS c ON (c.id = ci.course_id)
ORDER BY
  user_id;

-- Insert row with is_live = TRUE and then immediately update it to FALSE
INSERT INTO plr_live_session (assess_id, course_instance_id, is_live)
VALUES (42, 2, TRUE);

SELECT
  u.user_id,
  u.uid,
  u.name,
  c.id AS course_id,
  c.short_name AS course,
  ci.id AS course_instance_id,
  ci.short_name AS course_instance,
  a.id AS assessment_id,
  a.title AS assessment,
  aii.assessment_instance_id
FROM
  assessments AS a
  JOIN course_instances AS ci on (ci.id = a.course_instance_id)
  JOIN pl_courses AS c ON (c.id = ci.course_id)
  JOIN enrollments AS e ON (e.course_instance_id = ci.id)
  JOIN users AS u ON (u.user_id = e.user_id)
  JOIN assessment_instances_insert (a.id, u.user_id, a.group_work, u.user_id, 'Public') AS aii ON TRUE
WHERE
  a.id = 42
ORDER BY
  user_id;

UPDATE plr_live_session
SET is_live = FALSE
WHERE assess_id = 42 AND course_instance_id = 2;

-- Insert row with is_live = TRUE and then immediately update it to FALSE
INSERT INTO plr_live_session (assess_id, course_instance_id, is_live)
VALUES (43, 2, TRUE);

SELECT
  u.user_id,
  u.uid,
  u.name,
  c.id AS course_id,
  c.short_name AS course,
  ci.id AS course_instance_id,
  ci.short_name AS course_instance,
  a.id AS assessment_id,
  a.title AS assessment,
  aii.assessment_instance_id
FROM
  assessments AS a
  JOIN course_instances AS ci on (ci.id = a.course_instance_id)
  JOIN pl_courses AS c ON (c.id = ci.course_id)
  JOIN enrollments AS e ON (e.course_instance_id = ci.id)
  JOIN users AS u ON (u.user_id = e.user_id)
  JOIN assessment_instances_insert (a.id, u.user_id, a.group_work, u.user_id, 'Public') AS aii ON TRUE
WHERE
  a.id = 43
ORDER BY
  user_id;

UPDATE plr_live_session
SET is_live = FALSE
WHERE assess_id = 43 AND course_instance_id = 2;

-- Insert row with is_live = TRUE and then immediately update it to FALSE
INSERT INTO plr_live_session (assess_id, course_instance_id, is_live)
VALUES (44, 2, TRUE);

SELECT
  u.user_id,
  u.uid,
  u.name,
  c.id AS course_id,
  c.short_name AS course,
  ci.id AS course_instance_id,
  ci.short_name AS course_instance,
  a.id AS assessment_id,
  a.title AS assessment,
  aii.assessment_instance_id
FROM
  assessments AS a
  JOIN course_instances AS ci on (ci.id = a.course_instance_id)
  JOIN pl_courses AS c ON (c.id = ci.course_id)
  JOIN enrollments AS e ON (e.course_instance_id = ci.id)
  JOIN users AS u ON (u.user_id = e.user_id)
  JOIN assessment_instances_insert (a.id, u.user_id, a.group_work, u.user_id, 'Public') AS aii ON TRUE
WHERE
  a.id = 44
ORDER BY
  user_id;

UPDATE plr_live_session
SET is_live = FALSE
WHERE assess_id = 44 AND course_instance_id = 2;

-- Insert row with is_live = TRUE and then immediately update it to FALSE
INSERT INTO plr_live_session (assess_id, course_instance_id, is_live)
VALUES (45, 2, TRUE);

SELECT
  u.user_id,
  u.uid,
  u.name,
  c.id AS course_id,
  c.short_name AS course,
  ci.id AS course_instance_id,
  ci.short_name AS course_instance,
  a.id AS assessment_id,
  a.title AS assessment,
  aii.assessment_instance_id
FROM
  assessments AS a
  JOIN course_instances AS ci on (ci.id = a.course_instance_id)
  JOIN pl_courses AS c ON (c.id = ci.course_id)
  JOIN enrollments AS e ON (e.course_instance_id = ci.id)
  JOIN users AS u ON (u.user_id = e.user_id)
  JOIN assessment_instances_insert (a.id, u.user_id, a.group_work, u.user_id, 'Public') AS aii ON TRUE
WHERE
  a.id = 45
ORDER BY
  user_id;

UPDATE plr_live_session
SET is_live = FALSE
WHERE assess_id = 45 AND course_instance_id = 2;

-- Insert row with is_live = TRUE and then immediately update it to FALSE
INSERT INTO plr_live_session (assess_id, course_instance_id, is_live)
VALUES (46, 2, TRUE);

SELECT
  u.user_id,
  u.uid,
  u.name,
  c.id AS course_id,
  c.short_name AS course,
  ci.id AS course_instance_id,
  ci.short_name AS course_instance,
  a.id AS assessment_id,
  a.title AS assessment,
  aii.assessment_instance_id
FROM
  assessments AS a
  JOIN course_instances AS ci on (ci.id = a.course_instance_id)
  JOIN pl_courses AS c ON (c.id = ci.course_id)
  JOIN enrollments AS e ON (e.course_instance_id = ci.id)
  JOIN users AS u ON (u.user_id = e.user_id)
  JOIN assessment_instances_insert (a.id, u.user_id, a.group_work, u.user_id, 'Public') AS aii ON TRUE
WHERE
  a.id = 46
ORDER BY
  user_id;

UPDATE plr_live_session
SET is_live = FALSE
WHERE assess_id = 46 AND course_instance_id = 2;

-- Insert row with is_live = TRUE and then immediately update it to FALSE
INSERT INTO plr_live_session (assess_id, course_instance_id, is_live)
VALUES (47, 2, TRUE);

SELECT
  u.user_id,
  u.uid,
  u.name,
  c.id AS course_id,
  c.short_name AS course,
  ci.id AS course_instance_id,
  ci.short_name AS course_instance,
  a.id AS assessment_id,
  a.title AS assessment,
  aii.assessment_instance_id
FROM
  assessments AS a
  JOIN course_instances AS ci on (ci.id = a.course_instance_id)
  JOIN pl_courses AS c ON (c.id = ci.course_id)
  JOIN enrollments AS e ON (e.course_instance_id = ci.id)
  JOIN users AS u ON (u.user_id = e.user_id)
  JOIN assessment_instances_insert (a.id, u.user_id, a.group_work, u.user_id, 'Public') AS aii ON TRUE
WHERE
  a.id = 47
ORDER BY
  user_id;

UPDATE plr_live_session
SET is_live = FALSE
WHERE assess_id = 47 AND course_instance_id = 2;
