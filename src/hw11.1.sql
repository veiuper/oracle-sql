-- 1. Создать таблицу friends с помощью sub-query так,
-- чтобы она после создания содержала значения следующих столбцов из таблицы employees:
-- employee_id, first_name, last_name для тех строк, где имеются комиссионные.
-- Столбцы в таблице friends должны называться id, name, surname.

CREATE TABLE FRIENDS AS
    (SELECT EMPLOYEE_ID AS ID, FIRST_NAME AS NAME, LAST_NAME AS SURNAME
     FROM EMPLOYEES
     WHERE COMMISSION_PCT IS NOT NULL);

-- 2. Добавить в таблицу friends новый столбец email.

ALTER TABLE FRIENDS
    ADD (EMAIL VARCHAR2(25));

-- 3. Изменить столбец email так, чтобы его значение по умолчанию было «no email».

ALTER TABLE FRIENDS
    MODIFY (EMAIL VARCHAR2(25) DEFAULT 'no email');

-- 4. Проверить добавлением новой строки, работает ли дефолтное значение столбца email.

INSERT INTO FRIENDS (ID, NAME, SURNAME)
VALUES (0, 'SOME NAME', 'SOME SURNAME');

-- 5. Изменить название столбца с id на friends_id.

ALTER TABLE FRIENDS RENAME COLUMN ID TO FRIENDS_ID;

-- 6. Удалить таблицу friends.

DROP TABLE FRIENDS;

-- 7. Создать таблицу friends со следующими столбцами:
-- id, name, surname, email, salary, city, birthday. У столбцов salary и birthday должны быть значения по умолчанию.

CREATE TABLE FRIENDS
(
    ID       INTEGER,
    NAME     VARCHAR2(25),
    SURNAME  VARCHAR2(25),
    EMAIL    VARCHAR2(25),
    SALARY   NUMBER(9, 2) DEFAULT 0,
    CITY     VARCHAR2(25),
    BIRTHDAY DATE         DEFAULT SYSDATE
);

-- 8. Добавить 1 строку в таблицу friends со всеми значениями.

INSERT INTO FRIENDS (ID, NAME, SURNAME, EMAIL, SALARY, CITY, BIRTHDAY)
VALUES (0, 'SOME NAME', 'SOME SURNAME', 'SOME@EMAIL', 1000.555, 'SOME CITY', TO_DATE('01.01.1990', 'DD.MM.YYYY'));

-- 9. Добавить 1 строку в таблицу friends со всеми значениями кроме salary и birthday.

INSERT INTO FRIENDS (ID, NAME, SURNAME, EMAIL, CITY)
VALUES (0, 'SOME NAME', 'SOME SURNAME', 'SOME@EMAIL', 'SOME CITY');

-- 10. Совершить commit.

COMMIT;

-- 11. Удалить столбец salary.

ALTER TABLE FRIENDS
    DROP COLUMN SALARY;

-- 12. Сделать столбец email неиспользуемым (unused).

ALTER TABLE FRIENDS
    SET UNUSED COLUMN EMAIL;

-- 13. Сделать столбец birthday неиспользуемым (unused).

ALTER TABLE FRIENDS
    SET UNUSED COLUMN BIRTHDAY;

-- 14. Удалить из таблицы friends неиспользуемые столбцы.

ALTER TABLE FRIENDS
    DROP UNUSED COLUMNS;

-- 15. Сделать таблицу friends пригодной только для чтения.

ALTER TABLE FRIENDS
    READ ONLY;

-- 16. Проверить предыдущее действие любой DML командой.

INSERT INTO FRIENDS (ID, NAME, SURNAME, EMAIL, CITY)
VALUES (0, 'SOME NAME', 'SOME SURNAME', 'SOME@EMAIL', 'SOME CITY');

-- 17. Опустошить таблицу friends.

TRUNCATE TABLE FRIENDS;

-- 18. Удалить таблицу friends.

DROP TABLE FRIENDS;
