-- Завдання:
--      Знайти викладачів зі статусом 'викладає', які не є куратором жодної студентської групи
--      Очікувані колонки результату:
--          - повне ім'я викладача (professor_name)
--          - посада (job)
--      Результат відсортувати за:
--          - повним іменем викладача
-- Рішення:

-- Очікувані колонки результату:
--          - повне ім'я викладача (professor_name)
--          - посада (job)
SELECT 
    CONCAT(p.first_name, ' ', p.last_name) AS professor_name, -- повне ім'я викладача (professor_name)
    pr.job                                                    -- посада (job)
FROM professor pr
JOIN person p ON pr.person_id = p.person_id -- особисті дані викладача
WHERE pr.status = 'викладає' -- Викладачів зі статусом 'викладає'
  AND NOT EXISTS (
      SELECT 1 
      FROM student_group sg 
      WHERE sg.curator_id = pr.professor_id -- перевіряємо, чи є він куратором хоч якоїсь групи
  ) -- які не є куратором жодної студентської групи
-- Результат відсортувати за: повним іменем викладача
ORDER BY 
    professor_name ASC;
