-- 1. Получить репорт по department_id с минимальной и максимальной зарплатой,
-- с самой ранней и самой поздней датой прихода на работу и с количеством сотрудников.
-- Сортировать по количеству сотрудников (по убыванию).

SELECT
    DEPARTMENT_ID,
    MIN(SALARY),
    MAX(SALARY),
    MIN(HIRE_DATE),
    MAX(HIRE_DATE),
    COUNT(*)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
ORDER BY COUNT(*) DESC;

-- 2. Выведите информацию о первой букве имени сотрудника и количество имён,
-- которые начинаются с этой буквы.
-- Выводить строки для букв, где количество имён, начинающихся с неё больше 1.
-- Сортировать по количеству.

SELECT
    SUBSTR(FIRST_NAME, 1, 1),
    COUNT(*)
FROM EMPLOYEES
GROUP BY SUBSTR(FIRST_NAME, 1, 1)
HAVING COUNT(*) > 1
ORDER BY COUNT(*);

-- 3. Выведите id департамента, з/п и количество сотрудников,
-- которые работают в одном и том же департаменте и получают одинаковую зарплату.

SELECT
    DEPARTMENT_ID,
    SALARY,
    COUNT(*)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID, SALARY;

-- 4. Выведите день недели и количество сотрудников, которых приняли на работу в этот день.

SELECT
    TO_CHAR(HIRE_DATE, 'Day'),
    COUNT(*)
FROM EMPLOYEES
GROUP BY TO_CHAR(HIRE_DATE, 'Day');

-- 5. Выведите id департаментов, в которых работает больше 30 сотрудников и сумма их з/п-т больше 300000.

SELECT DEPARTMENT_ID
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
HAVING
    COUNT(*) > 30 AND
    SUM(SALARY) > 300000;

-- 6. Из таблицы countries вывести все region_id, для которых сумма всех букв их стран больше 50ти.

SELECT REGION_ID
FROM COUNTRIES
GROUP BY REGION_ID
HAVING SUM(LENGTH(COUNTRY_NAME)) > 50;

-- 7. Выведите информацию о job_id и округленную среднюю зарплату работников для каждого job_id.

SELECT
    JOB_ID,
    ROUND(AVG(SALARY))
FROM EMPLOYEES
GROUP BY JOB_ID;

-- 8. Получить список id департаментов, в которых работают сотрудники нескольких (>1) job_id.

SELECT DEPARTMENT_ID
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
HAVING COUNT(DISTINCT JOB_ID) > 1;

-- 9. Выведите информацию о department, job_id,
-- максимальную и минимальную з/п для всех сочетаний department_id - job_id, где средняя з/п больше 10000.

SELECT
    DEPARTMENT_ID,
    JOB_ID,
    MAX(SALARY),
    MIN(SALARY)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID, JOB_ID
HAVING AVG(SALARY) > 10000;

-- 10. Получить список manager_id, у которых средняя зарплата всех его подчиненных, не имеющих комиссионные,
-- находится в промежутке от 6000 до 9000.

SELECT MANAGER_ID
FROM EMPLOYEES
WHERE COMMISSION_PCT IS NULL
GROUP BY MANAGER_ID
HAVING AVG(SALARY) BETWEEN 6000 AND 9000;

-- 11. Выведите округлённую до тысяч (не тысячных) максимальную зарплату среди всех средних зарплат по департаментам.

SELECT ROUND(MAX(AVG(SALARY)), -3)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID;
