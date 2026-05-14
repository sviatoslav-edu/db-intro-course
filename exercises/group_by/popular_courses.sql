-- Завдання:
--      Знайти курси, на які записано більше ніж 100 студентів
--      Очікувані колонки результату:
--          - назва курсу (course_name)
--          - кількість студентів (student_count)
--          - середній бал (avg_grade) - середній бал серед студентів, які вже отримали оцінку - округлити результат до 2 знаків після коми
--      Результат відсортувати за:
--          - кількістю студентів (спадання), потім за назвою курсу

-- Рішення:

SELECT 
    c.name AS course_name,                                       -- назва курсу (course_name)
    COUNT(e.student_id) AS student_count,                        -- кількість студентів (student_count)
    ROUND(AVG(e.grade), 2) AS avg_grade                          -- середній бал, округлений до 2 знаків (avg_grade)
FROM course c
JOIN enrolment e ON c.course_id = e.course_id -- підключаємо записи на курс
GROUP BY c.course_id, c.name -- групуємо за ID та назвою курсу
HAVING COUNT(e.student_id) > 100 -- знайти курси, на які записано більше ніж 100 студентів
ORDER BY 
    student_count DESC,  -- Сортування з умови
    course_name ASC;
