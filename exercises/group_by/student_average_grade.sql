-- Завдання:
--      Для кожного студента знайти його середній бал у порівнянні з середнім балом по групі
--      Очікувані колонки результату:
--          - ідентифікатор студента (student_id)
--          - повне ім'я студента (full_name)
--          - середній бал студента (avg_student_grade) - округлити результат до 2 знаків після коми
--          - назва групи (group_name)
--          - середній бал по групі (avg_group_grade) - округлити результат до 2 знаків після коми
--      Результат відсортувати за:
--          - за назвою групи, потім за іменем студента

-- Рішення:
WITH student_avg AS (
    SELECT
        s.student_id,
        CONCAT(p.first_name, ' ', p.last_name) AS full_name,
        sg.name AS group_name,
        s.group_id,
        AVG(e.grade) AS avg_student_grade
    FROM student s
    JOIN person p ON p.person_id = s.person_id
    JOIN student_group sg ON sg.group_id = s.group_id
    JOIN enrolment e ON e.student_id = s.student_id
    GROUP BY s.student_id, full_name, sg.name, s.group_id
)
SELECT
    student_id, -- ідентифікатор студента (student_id)
    full_name, -- повне ім'я студента (full_name)
    ROUND(avg_student_grade, 2)::float AS avg_student_grade, -- середній бал студента (avg_student_grade) - округлити результат до 2 знаків після коми
    group_name, -- назва групи (group_name)
    ROUND(AVG(avg_student_grade) OVER (PARTITION BY group_id), 2)::float AS avg_group_grade -- середній бал по групі (avg_group_grade) - округлити результат до 2 знаків після коми
FROM student_avg
ORDER BY group_name, full_name, student_id;
