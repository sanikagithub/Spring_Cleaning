(1) select title 
from Movie 
where director = 'Steven Spielberg';

(2) SELECT t1.year, t2.stars
FROM Movie AS t1 INNER JOIN Rating AS t2 
ON t1.mID = t2.mID
where stars >=4
ORDER BY year;

(3) SELECT t1.title, t2.stars
FROM Movie AS t1 
INNER JOIN 
Rating AS t2 
ON t1.mID = t2.mID
WHERE stars is NULL

(4) SELECT t1.name
FROM Reviewer AS t1 
INNER JOIN 
Rating AS t2 
ON t1.rID = t2.rID
WHERE ratingDate IS NULL;

(5) SELECT t3.name as Reviewer_Name, t1.title as Movie_Title, t2.stars as Rating, t2.ratingdate as Rating_Date 
FROM Movie as t1
INNER JOIN
Rating AS t2 
on t1.mID = t2.mID
INNER JOIN
Reviewer AS t3
on t2.rID = t3.rID
ORDER by t3.name, t1.title, t2.stars;

(6) 
SELECT name as Reviewer_Name, title as Movie_Title
FROM 
Movie as t1
INNER JOIN 
Rating as r1 
on 
t1.mid = r1.mID
INNER JOIN 
Rating as r2
ON
r1.rid = r2.rid
INNER JOIN 
Reviewer t2
ON
r2.rID = t2.rID
WHERE 
r1.mId = r2.mId 
AND r1.ratingDate < r2.ratingDate 
AND r1.stars < r2.stars;


(7)
SELECT title as Movie_Title, MAX(stars) as Highest_Rating
FROM 
Movie as t1
INNER JOIN 
Rating as t2 
on t1.mID = t2.mID
GROUP BY t2.mId
ORDER BY title;

(8)
SELECT title as Movie_Title, (MAX(stars)-MIN(stars)) as Rating_Spread
FROM 
Movie as t1
INNER JOIN 
Rating as t2 
on t1.mID = t2.mID
GROUP BY t2.mId
ORDER BY Rating_Spread desc, title;

(9)
SELECT AVG(Bef1980.avg) - AVG(Aft1980.avg)
FROM (
  SELECT AVG(stars) AS avg
  FROM Movie
  INNER JOIN Rating USING(mId)
  WHERE year < 1980
  GROUP BY mId
) AS Bef1980, (
  SELECT AVG(stars) AS avg
  FROM Movie
  INNER JOIN Rating USING(mId)
  WHERE year > 1980
  GROUP BY mId
) AS Aft1980;

(10)
SELECT distinct(t3.name) as Reviewer_Name
FROM Movie as t1
INNER JOIN
Rating AS t2 
on t1.mID = t2.mID
INNER JOIN
Reviewer AS t3
on t2.rID = t3.rID
WHERE t1.title = "Gone with the Wind";

(11)
SELECT t3.name as Reviewer_Name, t1.title as Movie_Title, t2.stars as Rating
FROM Movie as t1
INNER JOIN
Rating AS t2 
on t1.mID = t2.mID
INNER JOIN
Reviewer AS t3
on t2.rID = t3.rID
WHERE t1.director = t3.name;

(12)
SELECT title FROM Movie
UNION
SELECT name FROM Reviewer
ORDER BY name, title;

(13)
SELECT title
FROM Movie
WHERE mId NOT IN (
  SELECT mId
  FROM Rating
  INNER JOIN Reviewer USING(rId)
  WHERE name = "Chris Jackson"
);

(14)
SELECT DISTINCT Re1.name, Re2.name
FROM Rating R1, Rating R2, Reviewer Re1, Reviewer Re2
WHERE R1.mID = R2.mID
AND R1.rID = Re1.rID
AND R2.rID = Re2.rID
AND Re1.name < Re2.name
ORDER BY Re1.name, Re2.name;

(15)
SELECT name, title, stars
FROM Movie
INNER JOIN Rating USING(mId)
INNER JOIN Reviewer USING(rId)
WHERE stars = (SELECT MIN(stars) FROM Rating);



1	t-shirt	white	S	10
2	t-shirt	green	S	200
3	polo shirt	black	M	10
4	tank top	blue	S	50
5	t-shirt	pink	S	0
6	polo shirt	red	M	5
7	tank top	white	S	200
8	tank top	blue	M	

purple 
15

CREATE DATABASE shirts_db

use shirts_db

create table shirts (
 shirt_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
 article varchar(50),
 color varchar(50),
 shirt_size varchar(50),
 last_worn int
 )

(1) Get all that data in there with a single line
select * from shirts;

(2) Add a new shirt, purple polo shirt, size M last worn 50 days ago
INSERT INTO shirts (article, color, shirt_size, last_worn)
value ('polo shirt', 'purple', 'M' ,50);	

(3) SELECT all shirts but only print out article and color
SELECT article, color FROM shirts;

(4) SELECT all medium shirts and print out everything but shirt_id
SELECT article, color, shirt_size, last_worn FROM shirts
where shirt_size = 'M' ;

(5) Update all polo shirts Change their size to L
update shirts set shirt_size = 'L'
where article LIKE 'polo%';


(6) Update the shirt last worn 15 days ago change last_worn to zero ('0')
update shirts set last_worn = 0
where last_worn =15; 

(7) Update all white shirts and change size to 'XS' and color to 'off white'
update shirts set color = 'off white', shirt_size = 'XS' 
where color = 'white'; 

(8) Delete all old shirts that were last worn 200 days ago
delete from shirts where last_worn = 200;

(9) Delete all tank tops. Your tastes have changed...
delete from shirts where article = 'tank top';

(10) Delete all shirts. You are doing some major spring cleaning!
DELETE FROM shirts;

(11) Drop the entire shirts table. Scraping everything... you must be rich or something!
drop table shirts;


INSERT INTO rental_records VALUES(
NULL, 'GA5555E',
(
SELECT customer_id
FROM customers
WHERE name = 'Kumar'),
DATE_ADD(NOW(), INTERVAL 1 DAY),
DATE_ADD(DATE_ADD(NOW(), INTERVAL 1 DAY), INTERVAL 3 month),
NULL
);

/*List all rental records (start date, end date) with vehicle's registration number, brand, and 
--customer name, sorted by vehicle's categories followed by start date. */
select start_date, end_date, v.veh_reg_no, brand, name, category from 
rental_records as R,
vehicles as V,
customers As C
where 
r.veh_reg_no = v.veh_reg_no 
and
r.customer_id = c.customer_id
order by category, start_date
 ;

List all the expired rental records (end_date before CURDATE()).
/*List all the expired rental records (end_date before CURDATE()).*/
select * from 
rental_records 
where end_date < CURDATE();

/*List the vehicles rented out on '2012-01-10' (not available for rental), 
in columns of vehicle registration no, customer name, start date and end date. 
(Hint: the given date is in between the start_date and end_date.)*/

select R.veh_reg_no, C.name, R.start_date, R.end_date from
rental_records as R,
customers as C
where R.customer_id = C.customer_id 
and 
start_date <'2012-01-10'
and
end_date > '2012-01-10'

/*List all vehicles rented out today, in columns registration number, customer name, start date, end date.*/
select R.veh_reg_no, C.name, R.start_date, R.end_date from
rental_records as R,
customers as C
where R.customer_id = C.customer_id 
and 
start_date <= curdate()
and
end_date > curdate()

/*Similarly, list the vehicles rented out (not available for rental) for the period 
from '2012-01-03' to '2012-01-18'. (Hint: start_date is inside the range; or end_date is 
inside the range; or start_date is before the range and end_date is beyond the range.)*/
select R.veh_reg_no, V.category, V.brand, V.desc from
rental_records as R,
vehicles as V
where R.veh_reg_no = V.veh_reg_no
and 
start_date <= '2012-01-03'
and
end_date > '2012-01-18


/*List the vehicles (registration number, brand and description) available for 
rental (not rented out) on '2012-01-10' (Hint: You could use a subquery based on a earlier query).*/
select V.veh_reg_no, V.brand, V.desc from
vehicles as V
where veh_reg_no in 
( select veh_reg_no from rental_records where start_date > '2012-01-10' and end_date <= '2012-01-10');




























