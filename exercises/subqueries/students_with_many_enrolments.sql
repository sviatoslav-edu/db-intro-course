-- Завдання:
--      Знайти всіх студентів, які записані на більше курсів ніж в середньому
--      Очікувані колонки результату:
--          - ідентифікатор студента (student_id)
--          - повне ім'я студента (full_name)
--          - кількість курсів студента (course_number)
--          - середня кількість курсів серед усіх студентів (avg_number) - округлити результат до 2 знаків після коми
--      Результат відсортувати за:
--          - кількістю курсів студента (спадання), потім за іменем студента, потім за ідентифікатор студента

-- Рішення:
WITH student_course_count AS (
    SELECT
        student_id,
        COUNT(course_id) AS course_number
    FROM enrolment
    GROUP BY student_id
),
global_avg AS (
    SELECT
        AVG(course_number) AS avg_number
    FROM student_course_count
)
SELECT
    sc.student_id,
    CONCAT(p.first_name, ' ', p.last_name) AS full_name,
    sc.course_number,
    ROUND(ga.avg_number, 2)::float AS avg_number
FROM student_course_count sc
CROSS JOIN global_avg ga
JOIN student s ON sc.student_id = s.student_id
JOIN person p ON s.person_id = p.person_id
WHERE sc.course_number > ga.avg_number
-- сортування за ід не треба??
ORDER BY
    sc.course_number DESC,
    full_name ASC;
