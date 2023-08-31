USE semimar_4;


CREATE TABLE users_old LIKE users;

DELIMITER //

CREATE PROCEDURE MoveUserToOld(IN userId INT)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION ROLLBACK;

    START TRANSACTION;
    
    INSERT INTO users_old SELECT * FROM users WHERE id = userId;
    DELETE FROM users WHERE id = userId;
    
    COMMIT;
END;
//

DELIMITER ;

CAll MoveUserToOld(3);

select * from users_old;

-- Создайте хранимую функцию hello(), которая будет возвращать приветсвие в зависимости от текущего времени суток. С 6:00 до 12:00 функция должна возвращать фразу " Доброе утро "? c 12:00 до 18:00 функция должна возвращать фразу "Добрый день", с 18:00 до 00:00 - " Добрый вечер ", с 00:00 до 06:00 - " Доброй ночи "
DELIMITER //

CREATE FUNCTION hello()
RETURNS VARCHAR(255)
NO SQL
BEGIN
    DECLARE current_hour INT;
    DECLARE greeting VARCHAR(255);
    
    SET current_hour = HOUR(NOW());
    
    IF current_hour >= 6 AND current_hour < 12 THEN
        SET greeting = 'Доброе утро';
    ELSEIF current_hour >= 12 AND current_hour < 18 THEN
        SET greeting = 'Добрый день';
    ELSEIF current_hour >= 18 AND current_hour < 24 THEN
        SET greeting = 'Добрый вечер';
    ELSE
        SET greeting = 'Доброй ночи';
    END IF;
    
    RETURN greeting;
END;
//

DELIMITER ;


SELECT hello();

