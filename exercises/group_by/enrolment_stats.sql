-- Завдання:
--      Порахувати статистику записів на курси для кожного року навчання
--      Очікувані колонки результату:
--          - рік навчання (student_year)
--          - кількість курсів (number_of_courses)
--          - кількість записів (number_of_enrolments)
--          - кількість студентів, що вже отримали бали (number_of_students_with_grade)
--      Результат відсортувати за:
--          - роком навчання (зростання)

-- Рішення:
SELECT 
    e.start_year AS student_year,                                    -- рік навчання (student_year)
    COUNT(DISTINCT e.course_id) AS number_of_courses,                -- кількість унікальних курсів у цьому році
    COUNT(e.student_id) AS number_of_enrolments,                     -- загальна кількість записів (усі рядки)
    COUNT(CASE WHEN e.grade IS NOT NULL THEN 1 END) AS number_of_students_with_grade -- кількість студентівб з оцінками
FROM enrolment e
GROUP BY e.start_year -- групуємо за роком навчання
ORDER BY 
    student_year ASC;
