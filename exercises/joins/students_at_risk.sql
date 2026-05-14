-- Завдання:
--      Вивести список студентів, які мають низькі оцінки (менше 60) разом з інформацією про курс та викладача
--      Очікувані колонки результату:
--          - повне ім'я студента (student_name)
--          - назва групи (group_name)
--          - назва курсу (course_name)
--          - оцінка (grade)
--          - повне ім'я лектора курсу (lecturer_name)
--      Включити тільки записи, де оцінка вже виставлена
--      Включити тільки лекторів
--      Результат відсортувати за:
--          - оцінкою (зростання), потім за назвою групи, потім за іменем студента, потім за назвою курсу

-- Рішення:
SELECT 
    CONCAT(p_student.first_name, ' ', p_student.last_name) AS student_name, -- повне ім'я студента (student_name)
    sg.name AS group_name,                                                  -- назва групи (group_name)
    c.name AS course_name,                                                  -- назва курсу (course_name)
    e.grade,                                                                -- оцінка (grade)
    CONCAT(p_prof.first_name, ' ', p_prof.last_name) AS lecturer_name       -- повне ім'я лектора курсу (lecturer_name)
FROM enrolment e
JOIN student s ON e.student_id = s.student_id -- студент
JOIN person p_student ON s.person_id = p_student.person_id -- "персона" студента
JOIN student_group sg ON s.group_id = sg.group_id -- група студента
JOIN course c ON e.course_id = c.course_id -- курс беремо з enrolment
JOIN course_teacher ct ON c.course_id = ct.course_id AND ct.professor_role = 'лектор' -- беремо лектора
JOIN professor prof ON ct.professor_id = prof.professor_id -- шукаємо викладача
JOIN person p_prof ON prof.person_id = p_prof.person_id -- "персона" викладача
WHERE e.grade IS NOT NULL AND e.grade < 60
ORDER BY 
    e.grade ASC, -- ASCEND! Bye-bye
    group_name ASC, 
    student_name ASC, 
    course_name ASC;
