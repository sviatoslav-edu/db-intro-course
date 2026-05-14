-- Завдання:
--      Сформувати єдиний список активностей університету, що поєднує:
--          - записи студентів на курси
--          - призначення викладачів на курси
--      Очікувані колонки результату:
--          - повне ім'я (full_name)
--          - назва курсу (course_name)
--          - тип активності (activity_type) - 'запис на курс' або 'викладання курсу'
--      Включити тільки активні курси (статус 'активний')
--      Результат відсортувати за:
--          - назвою курсу, потім за типом активності, потім за іменем

-- Рішення:
(
    SELECT 
        CONCAT(p_stud.first_name, ' ', p_stud.last_name) AS full_name, -- ім'я студента
        c.name AS course_name,                                         -- назва курсу
        'запис на курс' AS activity_type                               -- тип активності для студентів
    FROM enrolment e
    JOIN student s ON e.student_id = s.student_id                      -- підключаємо студента
    JOIN person p_stud ON s.person_id = p_stud.person_id               -- особисті дані студента
    JOIN course c ON e.course_id = c.course_id                         -- підключаємо курс
    WHERE c.status = 'активний'                                        -- тільки активні курси
)
UNION ALL
(
    SELECT 
        CONCAT(p_prof.first_name, ' ', p_prof.last_name) AS full_name, -- ім'я викладача
        c.name AS course_name,                                         -- назва курсу
        'викладання курсу' AS activity_type                            -- тип активності для викладачів
    FROM course_teacher ct
    JOIN professor pr ON ct.professor_id = pr.professor_id             -- підключаємо викладача
    JOIN person p_prof ON pr.person_id = p_prof.person_id              -- особисті дані викладача
    JOIN course c ON ct.course_id = c.course_id                        -- підключаємо курс
    WHERE c.status = 'активний'                                        -- тільки активні курси
)
-- результат відсортувати за: назвою курсу, потім за типом активності, потім за іменем
ORDER BY 
    course_name ASC, 
    activity_type ASC, 
    full_name ASC;
