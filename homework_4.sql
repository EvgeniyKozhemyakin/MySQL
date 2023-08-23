-- Подсчитать общее количество лайков, которые получили пользователи младше 12 лет.
select * 
FROM likes;
SELECT COUNT(l.id) AS total_likes
FROM likes l
JOIN profiles p ON l.user_id = p.user_id
WHERE TIMESTAMPDIFF(YEAR, p.birthday, CURDATE()) < 12;


-- Определить кто больше поставил лайков (всего): мужчины или женщины

SELECT p.gender, COUNT(l.id) AS total_likes
FROM likes l
JOIN profiles p ON l.user_id = p.user_id
GROUP BY p.gender
ORDER BY total_likes DESC
LIMIT 1;

-- Вывести всех пользователей, которые не отправляли сообщения.

SELECT u.id, u.firstname, u.lastname
FROM users u
LEFT JOIN messages m ON u.id = m.from_user_id
WHERE m.id IS NULL;


