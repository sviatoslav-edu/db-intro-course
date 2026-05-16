-- Завдання:
--      Знайти студентів, чий середній бал перевищує середній бал їхньої групи
--      Використати два CTE: один для середнього балу студента, інший для середнього балу групи
--      Очікувані колонки результату:
--          - ідентифікатор студента (student_id)
--          - повне ім'я студента (full_name)
--          - назва групи (group_name)
--          - середній бал студента (avg_student_grade) - округлити результат до 2 знаків після коми
--          - середній бал групи (avg_group_grade) - округлити результат до 2 знаків після коми
--      Результат відсортувати за:
--          - назвою групи, потім за середнім балом студента (спадання), потім за іменем студента

-- Рішення:
WITH student_avg AS (
    SELECT
        student_id,
        AVG(grade) AS avg_student_grade
    FROM enrolment
    WHERE grade IS NOT NULL
    GROUP BY student_id
),
group_avg AS (
    SELECT
        s.group_id,
        AVG(e.grade) AS avg_group_grade
    FROM enrolment e
    JOIN student s ON s.student_id = e.student_id
    WHERE e.grade IS NOT NULL
    GROUP BY s.group_id
)
SELECT
    sa.student_id,
    CONCAT(p.first_name, ' ', p.last_name) AS full_name,
    sg.name AS group_name,
    sa.avg_student_grade::float AS avg_student_grade,
    ga.avg_group_grade::float AS avg_group_grade
FROM student_avg sa
JOIN student s  ON s.student_id = sa.student_id
JOIN person p  ON p.person_id = s.person_id
JOIN student_group sg ON sg.group_id = s.group_id
JOIN group_avg ga ON ga.group_id  = s.group_id
WHERE sa.avg_student_grade > ga.avg_group_grade
--TODO:FIX
ORDER BY
    group_name,
    avg_student_grade DESC,
    full_name
 

