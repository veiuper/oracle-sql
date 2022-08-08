-- 1. Перепишите и запустите данный statement для создания таблицы locations2,
-- которая будет содержать такие же столбцы, что и locations:
-- CREATE TABLE locations2 AS (SELECT * FROM locations WHERE 1=2);

CREATE TABLE LOCATIONS2 AS
    (SELECT *
     FROM LOCATIONS
     WHERE 1 = 2);

-- 2. Добавьте в таблицу locations2 2 строки с информацией о id локации, адресе, городе, id страны.
-- Пусть данные строки относятся к стране Италия.

INSERT INTO LOCATIONS2 (LOCATION_ID, STREET_ADDRESS, CITY, COUNTRY_ID)
VALUES (0, TO_CHAR(NULL), 'Some city 1', 'IT');
INSERT INTO LOCATIONS2 (LOCATION_ID, STREET_ADDRESS, CITY, COUNTRY_ID)
VALUES (1, TO_CHAR(NULL), 'Some city 2', 'IT');

-- 3. Совершите commit.

COMMIT;

-- 4. Добавьте в таблицу locations2 ещё 2 строки, не используя перечисления имён столбцов,
-- в которые заносится информация. Пусть данные строки относятся к стране Франция.
-- При написании значений, где возможно, используйте функции.

INSERT INTO LOCATIONS2
VALUES (2, TO_CHAR(NULL), TO_CHAR(NULL), 'Some city 3', TO_CHAR(NULL), 'FR');
INSERT INTO LOCATIONS2
VALUES (3, TO_CHAR(NULL), TO_CHAR(NULL), 'Some city 4', TO_CHAR(NULL), 'FR');

-- 5. Совершите commit.

COMMIT;

-- 6. Добавьте в таблицу locations2 строки из таблицы locations,
-- в которых длина значения столбца state_province больше 9.

INSERT INTO LOCATIONS2
    (SELECT *
     FROM LOCATIONS
     WHERE LENGTH(LOCATIONS.STATE_PROVINCE) > 9);

-- 7. Совершите commit.

COMMIT;

-- 8. Перепишите и запустите данный statement для создания таблицы locations4europe,
-- которая будет содержать такие же столбцы, что и locations:
-- CREATE TABLE locations4europe AS (SELECT * FROM locations WHERE 1=2);

CREATE TABLE LOCATIONS4EUROPE AS
    (SELECT *
     FROM LOCATIONS
     WHERE 1 = 2);

-- 9. Одним statement-ом добавьте в таблицу locations2 всю информацию для всех строк из таблицы locations,
-- а в таблицу locations4europe добавьте информацию о id локации, адресе, городе, id страны
-- только для тех строк из таблицы locations, где города находятся в Европе.

INSERT ALL
WHEN 1 = 1 THEN
INTO LOCATIONS2
VALUES (LOCATION_ID, STREET_ADDRESS, POSTAL_CODE, CITY, STATE_PROVINCE, COUNTRY_ID)
WHEN COUNTRY_ID IN (SELECT COUNTRY_ID FROM COUNTRIES WHERE REGION_ID = 1) THEN
INTO LOCATIONS4EUROPE (LOCATION_ID, STREET_ADDRESS, CITY, COUNTRY_ID)
VALUES (LOCATION_ID, STREET_ADDRESS, CITY, COUNTRY_ID)
SELECT *
FROM LOCATIONS;

-- 10. Совершите commit.

COMMIT;

-- 11. В таблице locations2 измените почтовый код на любое значение в тех строках,
-- где сейчас нет информации о почтовом коде.

UPDATE LOCATIONS2
SET POSTAL_CODE = '123456'
WHERE POSTAL_CODE IS NULL;

-- 12. Совершите rollback.

ROLLBACK;

-- 13. В таблице locations2 измените почтовый код в тех строках, где сейчас нет информации о почтовом коде.
-- Новое значение должно быть кодом из таблицы locations для строки с id 2600.

UPDATE LOCATIONS2
SET POSTAL_CODE = (SELECT POSTAL_CODE FROM LOCATIONS WHERE LOCATION_ID = 2600)
WHERE POSTAL_CODE IS NULL;

-- 14. Совершите commit.

COMMIT;

-- 15. Удалите строки из таблицы locations2, где id страны «IT».

DELETE
FROM LOCATIONS2
WHERE COUNTRY_ID = 'IT';

-- 16. Создайте первый savepoint.

SAVEPOINT S1;

-- 17. В таблице locations2 измените адрес в тех строках, где id локации больше 2500.
-- Новое значение должно быть «Sezam st. 18»

UPDATE LOCATIONS2
SET STREET_ADDRESS = 'Sezam st. 18'
WHERE LOCATION_ID > 2500;

-- 18. Создайте второй savepoint.

SAVEPOINT S2;

-- 19. Удалите строки из таблицы locations2, где адрес равен «Sezam st. 18».

DELETE
FROM LOCATIONS2
WHERE STREET_ADDRESS = 'Sezam st. 18';

-- 20. Откатите изменения до первого savepoint.

ROLLBACK TO SAVEPOINT S1;

-- 21. Совершите commit.

COMMIT;
