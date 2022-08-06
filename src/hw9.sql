-- 1. Выведите в одном репорте информацию о суммах з/п групп,
-- объединённых по id менеджера, по job_id, по id департамента.
-- Репорт должен содержать 4 столбца: id менеджера, job_id, id департамента, суммированная з/п.

SELECT MANAGER_ID,
       TO_CHAR(NULL)   AS JOB_ID,
       TO_NUMBER(NULL) AS DEPARTMENT_ID,
       SUM(SALARY)
FROM EMPLOYEES
GROUP BY MANAGER_ID
UNION
SELECT TO_NUMBER(NULL),
       JOB_ID,
       TO_NUMBER(NULL),
       SUM(SALARY)
FROM EMPLOYEES
GROUP BY JOB_ID
UNION
SELECT TO_NUMBER(NULL),
       TO_CHAR(NULL),
       DEPARTMENT_ID,
       SUM(SALARY)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID;

-- 2. Выведите id тех департаментов, где работает менеджер № 100 и не работают менеджеры № 145, 201.

SELECT DEPARTMENT_ID
FROM EMPLOYEES
WHERE MANAGER_ID = 100
MINUS
SELECT DEPARTMENT_ID
FROM EMPLOYEES
WHERE MANAGER_ID = 145
MINUS
SELECT DEPARTMENT_ID
FROM EMPLOYEES
WHERE MANAGER_ID = 201;

-- 3. Используя SET операторы и не используя логические операторы,
-- выведите уникальную информацию о именах, фамилиях и з/п сотрудников,
-- второй символ в именах которых буква «а», и фамилия содержит букву «s» вне зависимости от регистра.
-- Отсортируйте результат по з/п по убыванию.

SELECT FIRST_NAME,
       LAST_NAME,
       SALARY
FROM EMPLOYEES
WHERE FIRST_NAME LIKE '_a%'
INTERSECT
SELECT FIRST_NAME,
       LAST_NAME,
       SALARY
FROM EMPLOYEES
WHERE UPPER(LAST_NAME) LIKE '%S%'
ORDER BY SALARY DESC;

-- 4. Используя SET операторы и не используя логические операторы,
-- выведите информацию о id локаций, почтовом коде и городе для локаций,
-- которые находятся в Италии или Германии.
-- А также для локаций, почтовый код которых содержит цифру «9».

SELECT LOCATION_ID,
       POSTAL_CODE,
       CITY
FROM LOCATIONS
WHERE COUNTRY_ID IN
      (SELECT COUNTRY_ID
       FROM COUNTRIES
       WHERE COUNTRY_NAME IN ('Italy', 'Germany'))
UNION ALL
SELECT LOCATION_ID,
       POSTAL_CODE,
       CITY
FROM LOCATIONS
WHERE POSTAL_CODE LIKE '%9%';

-- 5. Используя SET операторы и не используя логические операторы,
-- выведите всю уникальную информацию для стран, длина имён которых больше 8 символов.
-- А также для стран, которые находятся не в европейском регионе.
-- Столбцы аутпута должны называться id, country, region. Аутпут отсортируйте по названию стран по убывающей.

SELECT COUNTRY_ID   AS id,
       COUNTRY_NAME AS country,
       REGION_ID    AS region
FROM COUNTRIES
WHERE LENGTH(COUNTRY_NAME) > 8
UNION
SELECT COUNTRY_ID,
       COUNTRY_NAME,
       REGION_ID
FROM COUNTRIES
WHERE REGION_ID !=
      (SELECT REGION_ID
       FROM REGIONS
       WHERE REGION_NAME = 'Europe')
ORDER BY country DESC;
