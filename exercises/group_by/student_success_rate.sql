-- Завдання:
--      Порахувати успішність студентів залежно від року навчання
--      Очікувані колонки результату:
--          - рік навчання студентів (student_year)
--          - середній бал за рік (avg_year_grade) - округлити результат до 2 знаків після коми
--      Результат відсортувати за:
--          - роком навчання (зростання)

-- Рішення:
SELECT 
    e.start_year AS student_year,                                              -- рік навчання студентів (student_year)
    ROUND(AVG(e.grade), 2)::numeric(10,2)::float AS avg_year_grade             -- середній бал за рік (avg_year_grade)
FROM enrolment e
WHERE e.grade IS NOT NULL -- рахуємо тільки за наявними оцінками
GROUP BY e.start_year -- групуємо за роком навчання
-- Результат відсортувати за: роком навчання (зростання)
ORDER BY 
    student_year ASC;
