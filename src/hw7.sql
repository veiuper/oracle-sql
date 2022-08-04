-- 1. Выведите информацию о регионах и количестве сотрудников в каждом регионе.

SELECT
    R.REGION_NAME,
    COUNT(E.EMPLOYEE_ID)
FROM EMPLOYEES E
    JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
        JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID
            JOIN COUNTRIES C ON L.COUNTRY_ID = C.COUNTRY_ID
                RIGHT OUTER JOIN REGIONS R ON C.REGION_ID = R.REGION_ID
GROUP BY R.REGION_NAME;

-- 2. Выведите детальную информацию о каждом сотруднике:
-- имя, фамилия, название департамента, job_id, адрес, страна и регион.

SELECT
    E.FIRST_NAME,
    E.LAST_NAME,
    D.DEPARTMENT_NAME,
    E.JOB_ID,
    L.STREET_ADDRESS,
    C.COUNTRY_NAME,
    R.REGION_NAME
FROM EMPLOYEES E
    LEFT OUTER JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
        LEFT OUTER JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID
            LEFT OUTER JOIN COUNTRIES C ON L.COUNTRY_ID = C.COUNTRY_ID
                LEFT OUTER JOIN REGIONS R ON C.REGION_ID = R.REGION_ID;

-- 3. Выведите информацию о имени менеджеров, которые имеют в подчинении больше 6ти сотрудников,
-- а также выведите количество сотрудников, которые им подчиняются.

SELECT
    M.FIRST_NAME,
    COUNT(*)
FROM EMPLOYEES E JOIN EMPLOYEES M ON E.MANAGER_ID = M.EMPLOYEE_ID
GROUP BY M.FIRST_NAME
HAVING COUNT(*) > 6;

-- 4. Выведите информацию о названии всех департаментов и о количестве работников,
-- если в департаменте работают больше 30ти сотрудников.
-- Используйте технологию «USING» для объединения по id департамента.

SELECT
    D.DEPARTMENT_NAME,
    COUNT(*)
FROM DEPARTMENTS D JOIN EMPLOYEES E USING (DEPARTMENT_ID)
GROUP BY D.DEPARTMENT_NAME
HAVING COUNT(*) > 30;

-- 5. Выведите названия всех департаментов, в которых нет ни одного сотрудника.

SELECT
    D.DEPARTMENT_NAME
FROM DEPARTMENTS D LEFT OUTER JOIN EMPLOYEES E ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
WHERE E.EMPLOYEE_ID IS NULL;

-- 6. Выведите всю информацию о сотрудниках, менеджеры которых устроились на работу в 2005ом году,
-- но при это сами работники устроились на работу до 2005 года.

SELECT E.*
FROM EMPLOYEES E JOIN EMPLOYEES M ON E.MANAGER_ID = M.EMPLOYEE_ID
WHERE
    TO_CHAR(M.HIRE_DATE, 'YYYY') = '2005' AND
    E.HIRE_DATE < TO_DATE('2005-JAN-01', 'YYYY-MON-DD');

-- 7. Выведите название страны и название региона этой страны, используя natural join.

SELECT
    C.COUNTRY_NAME,
    R.REGION_NAME
FROM COUNTRIES C NATURAL JOIN REGIONS R;

-- 8. Выведите имена, фамилии и з/п сотрудников,
-- которые получают меньше, чем (минимальная з/п по их специальности + 1000).

SELECT
    E.FIRST_NAME,
    E.LAST_NAME,
    E.SALARY
FROM EMPLOYEES E JOIN JOBS J on E.JOB_ID = J.JOB_ID
WHERE E.SALARY < J.MIN_SALARY + 1000;

-- 9. Выведите уникальные имена и фамилии сотрудников, названия стран, в которых они работают.
-- Также выведите информацию о сотрудниках, о странах которых нет информации.
-- А также выведите все страны, в которых нет сотрудников компании.

SELECT DISTINCT
    E.FIRST_NAME,
    E.LAST_NAME,
    C.COUNTRY_NAME
FROM EMPLOYEES E
    FULL OUTER JOIN DEPARTMENTS D on E.DEPARTMENT_ID = D.DEPARTMENT_ID
        FULL OUTER JOIN LOCATIONS L on D.LOCATION_ID = L.LOCATION_ID
            FULL OUTER JOIN COUNTRIES C on L.COUNTRY_ID = C.COUNTRY_ID;

-- 10. Выведите имена и фамилии всех сотрудников, а также названия стран,
-- которые мы получаем при объединении работников со всеми странами без какой-либо логики.

SELECT
    E.FIRST_NAME,
    E.LAST_NAME,
    C.COUNTRY_NAME
FROM EMPLOYEES E CROSS JOIN COUNTRIES C;

-- 11. Решите задачу № 1, используя Oracle Join синтаксис.

SELECT
    R.REGION_NAME,
    COUNT(E.EMPLOYEE_ID)
FROM
    EMPLOYEES E,
    DEPARTMENTS D,
    LOCATIONS L,
    COUNTRIES C,
    REGIONS R
WHERE
    E.DEPARTMENT_ID (+) = D.DEPARTMENT_ID AND
    D.LOCATION_ID (+) = L.LOCATION_ID AND
    L.COUNTRY_ID (+) = C.COUNTRY_ID AND
    C.REGION_ID (+) = R.REGION_ID
GROUP BY R.REGION_NAME;

-- 12. Решите задачу № 5, используя Oracle Join синтаксис.

SELECT
    D.DEPARTMENT_NAME
FROM
    DEPARTMENTS D,
    EMPLOYEES E
WHERE
    D.DEPARTMENT_ID = E.DEPARTMENT_ID (+) AND
    E.EMPLOYEE_ID IS NULL;
