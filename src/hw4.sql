-- 1. Получите список всех сотрудников, у которых длина имени больше 10 букв.

SELECT *
FROM EMPLOYEES
WHERE LENGTH(FIRST_NAME) > 10;

-- 2. Получите список всех сотрудников, зарплата которых кратна 1000.

SELECT *
FROM EMPLOYEES
WHERE MOD(SALARY, 1000) = 0;

-- 3. Выведите телефонный номер и первое 3х значное число телефонного номера сотрудника,
-- если его номер представлен в формате ХХХ.ХХХ.ХХХХ.

SELECT PHONE_NUMBER, SUBSTR(PHONE_NUMBER, 1, 3)
FROM EMPLOYEES
WHERE PHONE_NUMBER LIKE '___.___.____';

-- 4. Получите список всех сотрудников, у которых последняя буква в имени равна 'm' и длина имени больше 5ти.

SELECT *
FROM EMPLOYEES
WHERE SUBSTR(FIRST_NAME, -1) = 'm'
  AND LENGTH(FIRST_NAME) > 5;

-- 5. Выведите дату следующей пятницы.

SELECT NEXT_DAY(SYSDATE, 'Пятница')
FROM DUAL;

-- 6. Получите список всех сотрудников, которые работают в компании больше 12 лет и 6ти месяцев (150 месяцев).

SELECT *
FROM EMPLOYEES
WHERE MONTHS_BETWEEN(SYSDATE, HIRE_DATE) > 12 * 12 + 6;

-- 7. Выведите телефонный номер, заменив в значении PHONE_NUMBER все '.' на '-'.

SELECT REPLACE(PHONE_NUMBER, '.', '-')
FROM EMPLOYEES;

-- 8. Выведите имя, email, job_id для всех работников в формате:
-- STEVEN sking Ad_Pres

SELECT UPPER(FIRST_NAME), LOWER(EMAIL), INITCAP(JOB_ID)
FROM EMPLOYEES;

-- 9. Выведите информацию о имени работника и его з/п, не используя символ || , в таком виде: Steven24000

SELECT CONCAT(FIRST_NAME, SALARY)
FROM EMPLOYEES;

-- 10. Выведите информацию о дате приёма сотрудника на работу,
-- округлённой дате приёма на работу до месяца и первом дне года приёма на работу.

SELECT HIRE_DATE, ROUND(HIRE_DATE, 'MM'), TRUNC(HIRE_DATE, 'YYYY')
FROM EMPLOYEES;

-- 11. Выведите информацию о имени и фамилии всех работников.
-- Имя должно состоять из 10 символов и если длина имени меньше 10, то дополняйте до 10 символов знаком $.
-- Фамилия должна состоять из 15 символов и если длина фамилии меньше 15,
-- то перед фамилией ставьте столько знаков ! сколько необходимо.

SELECT RPAD(FIRST_NAME, 10, '$'), LPAD(LAST_NAME, 15, '!')
FROM EMPLOYEES;

-- 12. Выведите имя сотрудника и позицию второй буквы ‘a’ в его имени.

SELECT FIRST_NAME, INSTR(FIRST_NAME, 'a', 1, 2)
FROM EMPLOYEES;

-- 13. Выведите на экран текст '!!!HELLO!! MY FRIEND!!!!!!!!' и тот же текст,
-- но без символа восклицательный знак в начале и конце текста.

SELECT '!!!HELLO!! MY FRIEND!!!!!!!!', TRIM('!' FROM '!!!HELLO!! MY FRIEND!!!!!!!!')
FROM DUAL;

-- 14. Выведите информацию о:
-- - з/п работника,
-- - з/п умноженной на коэффициент 3.1415 ,
-- - округлённый до целого значения вариант увеличенной з/п-ты,
-- - целое количество тысяч из увеличенной з/п.

SELECT SALARY, SALARY * 3.1415, ROUND(SALARY * 3.1415), TRUNC(SALARY * 3.1415, -3) / 1000
FROM EMPLOYEES;

-- 15. Выведите информацию о:
-- - дате приёма сотрудника на работу,
-- - дате, которая была через пол года, после принятия сотрудника на работу,
-- - дате последнего дня в месяце принятия сотрудника на работу.

SELECT HIRE_DATE, ADD_MONTHS(HIRE_DATE, 6), LAST_DAY(HIRE_DATE)
FROM EMPLOYEES;
