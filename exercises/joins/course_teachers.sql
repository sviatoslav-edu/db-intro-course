-- Завдання:
--      Вивести список усіх активних курсів разом з іменами їхніх викладачів та їхніми ролями
--      Очікувані колонки результату:
--          - назва курсу (course_name)
--          - повне ім'я викладача (professor_name)
--          - роль викладача на курсі (role)
--      Включити тільки курси зі статусом 'активний'
--      Результат відсортувати за:
--          - назвою курсу, потім за роллю викладача

-- Рішення:

--      Очікувані колонки результату:
--          - назва курсу (course_name)
--          - повне ім'я викладача (professor_name)
--          - роль викладача на курсі (role)
SELECT 
    c.name AS course_name,
    CONCAT(p.first_name, ' ', p.last_name) AS professor_name,
    ct.professor_role AS role
FROM course c
JOIN course_teacher ct ON c.course_id = ct.course_id -- із course_teacher беремо нашого викладача
JOIN professor pr ON ct.professor_id = pr.professor_id -- шукаємо у professor - викладач
JOIN person p ON pr.person_id = p.person_id -- беремо особистні дані 
WHERE c.status = 'активний'--      Включити тільки курси зі статусом 'активний'
--      Результат відсортувати за:
--          - назвою курсу, потім за роллю викладача
ORDER BY 
    course_name ASC,  --
    role ASC;
