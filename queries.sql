-- write your queries here
 
-- PART 1 --

--1
SELECT * FROM owners FULL JOIN vehicles ON owners.id = vehicles.owner_id;


-- 2
SELECT o.first_name, o.last_name, COUNT(*) 
FROM owners o FULL JOIN vehicles v ON o.id = v.owner_id 
GROUP BY o.first_name, o.last_name ORDER BY first_name ASC;


-- 3
SELECT o.first_name, o.last_name, COUNT(owner_id), 
ROUND(AVG(price)) AS average_price FROM owners o 
JOIN vehicles v ON o.id = v.owner_id GROUP BY o.first_name, o.last_name 
HAVING ROUND(AVG(price)) > 10000 AND count(owner_id) > 1  ORDER BY first_name DESC;


-- PART 2 --
-- step 6 --
--1 
SELECT matchid, player FROM goal 
WHERE teamid = 'GER';

--2
SELECT id,stadium,team1,team2 FROM game 
JOIN goal ON goal.matchid = game.id 
WHERE goal.matchid = '1012' GROUP BY id, stadium, team1, team2;

--3
SELECT player, teamid, stadium, mdate 
FROM game JOIN goal ON (id=matchid) WHERE teamid = 'GER';

--4


--5
SELECT player, teamid, coach, gtime
  FROM goal JOIN eteam ON teamid = id
 WHERE gtime<=10 GROUP BY player, teamid, coach, gtime;

 --6
 SELECT mdate, teamname 
 FROM game JOIN eteam ON team1=eteam.id 
 WHERE coach = 'Fernando Santos' GROUP BY mdate, teamname;


--7
SELECT player FROM game JOIN goal ON matchid=id 
WHERE stadium = 'National Stadium, Warsaw';

--8
SELECT DISTINCT player FROM game JOIN goal ON matchid = id 
WHERE (team1='GER' OR team2='GER') AND teamid!='GER';

--9
SELECT teamname, COUNT(matchid)
  FROM eteam JOIN goal ON id=teamid
 GROUP BY teamname;

--10 
SELECT stadium, count(matchid) FROM game JOIN goal ON game.id = goal.matchid GROUP BY stadium;

--11
SELECT matchid, mdate, count(matchid)
  FROM game JOIN goal ON matchid = game.id 
 WHERE (team1 = 'POL' OR team2 = 'POL') GROUP BY matchid, mdate;

--12
 SELECT matchid, mdate, count(matchid) FROM game JOIN goal ON game.id = goal.matchid 
 WHERE teamid = 'GER' GROUP BY matchid, mdate;



-- step 7 --

--1 
SELECT id, title FROM movie WHERE yr=1962 GROUP BY id, title;

--2
SELECT yr FROM movie WHERE title = 'Citizen Kane' GROUP BY yr;

--3
SELECT id, title, yr FROM movie WHERE title LIKE'Star Trek%' GROUP BY id, title, yr ORDER BY yr DESC;


--4
SELECT id FROM actor WHERE name = 'Glenn Close' GROUP BY id;


--5
SELECT id FROM movie WHERE title = 'Casablanca';

--6
SELECT name FROM actor JOIN casting ON actor.id = casting.actorid WHERE movieid=27 GROUP BY name;


--7
SELECT name FROM casting JOIN movie ON movie.id = casting.movieid JOIN actor ON actor.id = casting.actorid 
WHERE title = 'Alien' GROUP BY name;

--8
SELECT title FROM casting JOIN movie ON movie.id = casting.movieid JOIN actor ON casting.actorid = actor.id 
WHERE name = 'Harrison Ford' GROUP BY title;

--9
SELECT title FROM casting JOIN movie ON movie.id = casting.movieid JOIN actor ON actor.id = casting.actorid 
WHERE ord !=1 AND name='Harrison Ford' GROUP BY title;

--10
SELECT title, name FROM movie JOIN casting ON movie.id = casting.movieid 
JOIN actor on actor.id = casting.actorid 
WHERE ord=1 AND yr=1962 GROUP BY title, name;

--11
SELECT yr,COUNT(title) FROM
  movie JOIN casting ON movie.id=movieid
        JOIN actor   ON actorid=actor.id
WHERE name='Rock Hudson'
GROUP BY yr
HAVING COUNT(title) > 1;


--12
SELECT title, name FROM casting JOIN movie ON casting.movieid = movie.id JOIN actor ON (actor.id = casting.actorid AND ord=1) WHERE movieid IN
(SELECT movieid FROM casting
WHERE actorid IN (
  SELECT id FROM actor
  WHERE name='Julie Andrews'));


--13
SELECT name FROM movie JOIN casting ON casting.movieid = movie.id JOIN actor ON actor.id = casting.actorid WHERE ord=1 GROUP BY name 
HAVING COUNT(actorid) >= 15 ORDER BY name ASC;


--14
SELECT title, COUNT(name) FROM movie JOIN casting ON movie.id = casting.movieid 
JOIN actor ON actor.id = casting.actorid 
WHERE title IN (SELECT title FROM movie WHERE yr = 1978) 
GROUP BY title ORDER BY count(name) DESC, title;
