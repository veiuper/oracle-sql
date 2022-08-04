-- 1. Выведите всю информацию о сотрудниках, с самым длинным именем.

SELECT *
FROM EMPLOYEES
WHERE LENGTH(FIRST_NAME) =
      (SELECT MAX(LENGTH(FIRST_NAME))
       FROM EMPLOYEES);

-- 2. Выведите всю информацию о сотрудниках, с зарплатой большей средней зарплаты всех сотрудников.

SELECT *
FROM EMPLOYEES
WHERE SALARY >
      (SELECT AVG(SALARY)
       FROM EMPLOYEES);

-- 3. Получить город/города, где сотрудники в сумме зарабатывают меньше всего.

SELECT L.CITY
FROM LOCATIONS L
    JOIN DEPARTMENTS D ON L.LOCATION_ID = D.LOCATION_ID
    JOIN EMPLOYEES E ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
GROUP BY L.CITY
HAVING SUM(E.SALARY) =
       (SELECT MIN(SUM(E.SALARY))
        FROM LOCATIONS L
            JOIN DEPARTMENTS D ON L.LOCATION_ID = D.LOCATION_ID
            JOIN EMPLOYEES E ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
        GROUP BY L.CITY);

-- 4. Выведите всю информацию о сотрудниках, у которых менеджер получает зарплату больше 15000.

SELECT *
FROM EMPLOYEES
WHERE MANAGER_ID IN
      (SELECT DISTINCT MANAGER_ID
       FROM EMPLOYEES
       WHERE SALARY > 15000 AND
             MANAGER_ID IS NOT NULL);

-- 5. Выведите всю информацию о департаментах, в которых нет ни одного сотрудника.

SELECT *
FROM DEPARTMENTS
WHERE DEPARTMENT_ID NOT IN
      (SELECT DISTINCT DEPARTMENT_ID
       FROM EMPLOYEES
       WHERE DEPARTMENT_ID IS NOT NULL);

-- 6. Выведите всю информацию о сотрудниках, которые не являются менеджерами.

SELECT *
FROM EMPLOYEES
WHERE EMPLOYEE_ID NOT IN
      (SELECT DISTINCT MANAGER_ID
       FROM EMPLOYEES
       WHERE MANAGER_ID IS NOT NULL);


-- 7. Выведите всю информацию о менеджерах, которые имеют в подчинении больше 6ти сотрудников.

SELECT *
FROM EMPLOYEES
WHERE EMPLOYEE_ID IN
      (SELECT MANAGER_ID
       FROM EMPLOYEES
       WHERE MANAGER_ID IS NOT NULL
       GROUP BY MANAGER_ID
       HAVING COUNT(*) > 6);

SELECT *
FROM EMPLOYEES E1
WHERE
    (SELECT COUNT(*)
    FROM EMPLOYEES E2
    WHERE E2.MANAGER_ID = E1.EMPLOYEE_ID) > 6;

-- 8. Выведите всю информацию о сотрудниках, которые работают в департаменте с названием IT.

SELECT *
FROM EMPLOYEES
WHERE DEPARTMENT_ID =
      (SELECT DEPARTMENT_ID
       FROM DEPARTMENTS
       WHERE DEPARTMENT_NAME = 'IT');

-- 9. Выведите всю информацию о сотрудниках, менеджеры которых устроились на работу в 2005ом году,
-- но при это сами работники устроились на работу до 2005 года.

SELECT *
FROM EMPLOYEES
WHERE HIRE_DATE < TO_DATE('2005', 'YYYY') AND
      MANAGER_ID IN
      (SELECT DISTINCT EMPLOYEE_ID
       FROM EMPLOYEES
       WHERE TO_CHAR(HIRE_DATE, 'YYYY') = '2005');

-- 10. Выведите всю информацию о сотрудниках, менеджеры которых устроились на работу в январе любого года,
-- и длина job_title этих сотрудников больше 15ти символов.

SELECT *
FROM EMPLOYEES
WHERE MANAGER_ID IN
      (SELECT DISTINCT MANAGER_ID
       FROM EMPLOYEES
       WHERE TO_CHAR(HIRE_DATE, 'MM') = '01')
      AND JOB_ID IN
      (SELECT DISTINCT JOB_ID
       FROM JOBS
       WHERE LENGTH(JOB_TITLE) > 15);

SELECT *
FROM EMPLOYEES E
WHERE MANAGER_ID IN
      (SELECT DISTINCT MANAGER_ID
       FROM EMPLOYEES
       WHERE TO_CHAR(HIRE_DATE, 'MM') = '01')
  AND (SELECT LENGTH(JOB_TITLE)
       FROM JOBS J
       WHERE J.JOB_ID = E.JOB_ID) > 15;
