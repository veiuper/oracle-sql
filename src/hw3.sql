-- 1. Получите список всех сотрудников с именем David.

SELECT *
FROM employees
WHERE first_name = 'David';

-- 2. Получите список всех сотрудников, у которых job_id равен FI_ACCOUNT.

SELECT *
FROM employees
WHERE job_id = 'FI_ACCOUNT';

-- 3. Выведите информацию о имени, фамилии, з/п и номере департамента для сотрудников из 50го департамента с зарплатой,
-- большей 4000.

SELECT first_name,
       last_name,
       salary,
       department_id
FROM employees
WHERE department_id = 50
  AND salary > 4000;

-- 4. Получите список всех сотрудников, которые работают или в 20м, или в 30м департаменте.

SELECT *
FROM employees
WHERE department_id = 20
   OR department_id = 30;

-- 5. Получите список всех сотрудников, у которых вторая и последняя буква в имени равна 'a'.

SELECT *
FROM employees
WHERE first_name LIKE '_a%a';

-- 6. Получите список всех сотрудников из 50го и из 80го департамента, у которых есть бонус(комиссионные).
-- Отсортируйте строки по email (возрастающий порядок), используя его порядковый номер.

SELECT *
FROM employees
WHERE department_id in (50, 80)
  AND commission_pct IS NOT NULL
ORDER BY email;

-- 7. Получите список всех сотрудников, у которых в имени содержатся минимум 2 буквы 'n'.

SELECT *
FROM employees
WHERE first_name LIKE '%n%n%';

-- 8. Получить список всех сотрудников, у которых длина имени больше 4 букв.
-- Отсортируйте строки по номеру департамента (убывающий порядок) так, чтобы значения “null” были в самом конце.

SELECT *
FROM employees
WHERE first_name LIKE '_____%'
ORDER BY department_id DESC NULLS LAST;

-- 9. Получите список всех сотрудников, у которых зарплата находится в промежутке от 3000 до 7000 (включительно),
-- нет бонуса (комиссионных) и job_id среди следующих вариантов: PU_CLERK, ST_MAN, ST_CLERK.

SELECT *
FROM employees
WHERE salary BETWEEN 3000 AND 7000
  AND commission_pct IS NULL
  AND job_id IN ('PU_CLERK', 'ST_MAN', 'ST_CLERK');

-- 10. Получите список всех сотрудников у которых в имени содержится символ '%'.

SELECT *
FROM employees
WHERE first_name LIKE '%\%%' ESCAPE '\';

-- 11. Выведите информацию о job_id, имене и з/п для работников,
-- рабочий id которых больше или равен 120 и job_id не равен IT_PROG.
-- Отсортируйте строки по job_id (возрастающий порядок) и именам (убывающий порядок).

SELECT EMPLOYEE_ID,
       job_id,
       first_name,
       salary
FROM employees
WHERE employee_id >= 120
  AND job_id != 'IT_PROG'
ORDER BY job_id, first_name DESC;
