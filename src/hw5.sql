-- 1. Используя функции, получите список всех сотрудников у которых в имени есть буква 'b' (без учета регистра).

SELECT *
FROM EMPLOYEES
WHERE INSTR(UPPER(FIRST_NAME), 'B') != 0;

-- 2. Используя функции, получите список всех сотрудников у которых в имени содержатся минимум 2 буквы 'a'.

SELECT *
FROM EMPLOYEES
WHERE INSTR(UPPER(FIRST_NAME), 'A', 1, 2) != 0;

-- 3. Получите первое слово из имени департамента, для тех департаментов,
-- у которых название состоит больше, чем из одного слова.

SELECT SUBSTR(DEPARTMENT_NAME, 1, INSTR(DEPARTMENT_NAME, ' ') - 1)
FROM DEPARTMENTS
WHERE INSTR(DEPARTMENT_NAME, ' ') != 0;

-- 4. Получите имена сотрудников без первой и последней буквы в имени.

SELECT
    FIRST_NAME,
    SUBSTR(FIRST_NAME, 2, LENGTH(FIRST_NAME) - 2)
FROM EMPLOYEES;

-- 5. Получите список всех сотрудников, у которых в значении job_id после знака '_' как минимум 3 символа,
-- но при этом это значение после '_' не равно 'CLERK'.

SELECT *
FROM EMPLOYEES
WHERE
    INSTR(JOB_ID, '_') + 3 <= LENGTH(JOB_ID) AND
    SUBSTR(JOB_ID, INSTR(JOB_ID, '_') + 1) != 'CLERK';

-- 6. Получите список всех сотрудников, которые пришли на работу в первый день любого месяца.

SELECT *
FROM EMPLOYEES
WHERE TO_CHAR(HIRE_DATE, 'DD') = '01';

-- 7. Получите список всех сотрудников, которые пришли на работу в 2008ом году.

SELECT *
FROM EMPLOYEES
WHERE TO_CHAR(HIRE_DATE, 'YYYY') = '2008';

-- 8. Покажите завтрашнюю дату в формате:
-- Tomorrow is Second day of January

SELECT TO_CHAR(SYSDATE + 1, 'fm"Tomorrow is" DdTHSP "day of" Month')
FROM DUAL;

-- 9. Выведите имя сотрудника и дату его прихода на работу в формате:
-- 21st of June, 2007

SELECT
    FIRST_NAME,
    TO_CHAR(HIRE_DATE, 'fmddTH "of" Month, YYYY')
FROM EMPLOYEES;

-- 10. Получите список работников с увеличенными зарплатами на 20%. Зарплату показать в формате: $28,800.00.

SELECT
    FIRST_NAME,
    TO_CHAR(SALARY * 1.2, '$999,999.99')
FROM EMPLOYEES;


-- 11. Выведите актуальную дату (нынешнюю), + секунда, + минута, + час, + день, + месяц, + год.
-- (Всё это по отдельности прибавляется к актуальной дате).

SELECT
    SYSDATE,
    SYSDATE + 1 / (24 * 60 * 60),
    SYSDATE + 1 / (24 * 60),
    SYSDATE + 1 / 24,
    SYSDATE + 1,
    ADD_MONTHS(SYSDATE, 1),
    ADD_MONTHS(SYSDATE, 12)
FROM DUAL;

-- 12. Выведите имя сотрудника, его з/п и новую з/п, которая равна старой плюс это значение текста «$12,345.55».

SELECT
    FIRST_NAME,
    SALARY,
    SALARY + TO_NUMBER('$12,345.55', '$99,999.99')
FROM EMPLOYEES;

-- 13. Выведите имя сотрудника, день его трудоустройства,
-- а также количество месяцев между днём его трудоустройства и датой,
-- которую необходимо получить из текста «SEP, 18:45:00 18 2009».

SELECT
    FIRST_NAME,
    HIRE_DATE,
    MONTHS_BETWEEN(TO_DATE('SEP, 18:45:00 18 2009', 'MON, HH24:MI:SS DD YYYY'), HIRE_DATE)
FROM EMPLOYEES;

-- 14. Выведите имя сотрудника, его з/п, а также полную з/п (salary + commission_pct(%)) в формате: $24,000.00.

SELECT
    FIRST_NAME,
    SALARY,
    TO_CHAR(SALARY * (1 + NVL(COMMISSION_PCT, 0)), '$999,999.99')
FROM EMPLOYEES;

-- 15. Выведите имя сотрудника, его фамилию,
-- а также выражение «different length», если длина имени не равна длине фамилии или выражение «same length»,
-- если длина имени равна длине фамилии. Не используйте conditional functions.

SELECT
    FIRST_NAME,
    LAST_NAME,
    NVL2(NULLIF(LENGTH(FIRST_NAME), LENGTH(LAST_NAME)), 'different length', 'same length')
FROM EMPLOYEES;

-- 16. Выведите имя сотрудника, его комиссионные,
-- а также информацию о наличии бонусов к зарплате – есть ли у него комиссионные (Yes/No).

SELECT
    FIRST_NAME,
    COMMISSION_PCT,
    NVL2(COMMISSION_PCT, 'Yes', 'No')
FROM EMPLOYEES;

-- 17. Выведите имя сотрудника и значение которое его будет характеризовать:
-- значение комиссионных, если присутствует, если нет, то id его менеджера, если и оно отсутствует, то его з/п.

SELECT
    FIRST_NAME,
    COALESCE(COMMISSION_PCT, MANAGER_ID, SALARY)
FROM EMPLOYEES;


-- 18. Выведите имя сотрудника, его з/п, а также уровень зарплаты каждого сотрудника:
-- Меньше 5000 считается Low level,
-- Больше или равно 5000 и меньше 10000 считается Normal level,
-- Больше или равно 10000 считается High level.

SELECT
    FIRST_NAME,
    SALARY,
    CASE
        WHEN SALARY < 5000 THEN 'Low level'
        WHEN SALARY >= 5000 AND SALARY < 10000 THEN 'Normal level'
        WHEN SALARY > 10000 THEN 'High level'
    END
FROM EMPLOYEES;

-- 19. Для каждой страны показать регион, в котором она находится: 1-Europe, 2-America, 3-Asia, 4-Africa.
-- Выполнить данное задание, не используя функционал JOIN. Используйте DECODE.

SELECT
    COUNTRY_NAME,
    DECODE(REGION_ID, 1, '1-Europe', 2, '2-America', 3, '3-Asia', 4, '4-Africa')
FROM COUNTRIES;

-- 20. Задачу №19 решите используя CASE.

SELECT
    COUNTRY_NAME,
    CASE REGION_ID
        WHEN 1 THEN '1-Europe'
        WHEN 2 THEN '2-America'
        WHEN 3 THEN '3-Asia'
        WHEN 4 THEN '4-Africa'
        END
FROM COUNTRIES;

-- 21. Выведите имя сотрудника, его з/п, а также уровень того, насколько у сотрудника хорошие условия:
-- - BAD: з/п меньше 10000 и отсутствие комиссионных;
-- - NORMAL: з/п между 10000 и 15000 или, если присутствуют комиссионные;
-- - GOOD: з/п больше или равна 15000.

SELECT
    FIRST_NAME,
    SALARY,
    CASE
        WHEN SALARY < 10000 AND COMMISSION_PCT IS NULL THEN 'BAD'
        WHEN (SALARY >= 10000 AND SALARY < 15000) OR COMMISSION_PCT IS NOT NULL THEN 'NORMAL'
        WHEN SALARY >= 15000 THEN 'GOOD'
    END
FROM EMPLOYEES;
