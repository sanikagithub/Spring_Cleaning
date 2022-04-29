/*Create a new database*/
CREATE DATABASE shirts_db

/*Select the database*/
use shirts_db

/*Create a new table*/
create table shirts (
 shirt_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
 article varchar(50),
 color varchar(50),
 shirt_size varchar(50),
 last_worn int
 )

/*(1) Get all that data in there with a single line*/
select * from shirts;

/*(2) Add a new shirt, purple polo shirt, size M last worn 50 days ago*/
INSERT INTO shirts (article, color, shirt_size, last_worn)
value ('polo shirt', 'purple', 'M' ,50);	

/*(3) SELECT all shirts but only print out article and color*/
SELECT article, color FROM shirts;

/*(4) SELECT all medium shirts and print out everything but shirt_id*/
SELECT article, color, shirt_size, last_worn FROM shirts
where shirt_size = 'M' ;

/*(5) Update all polo shirts Change their size to L*/
update shirts set shirt_size = 'L'
where article LIKE 'polo%';


/*(6) Update the shirt last worn 15 days ago change last_worn to zero ('0')*/
update shirts set last_worn = 0
where last_worn =15; 

/*(7) Update all white shirts and change size to 'XS' and color to 'off white'*/
update shirts set color = 'off white', shirt_size = 'XS' 
where color = 'white'; 

/*(8) Delete all old shirts that were last worn 200 days ago*/
delete from shirts where last_worn = 200;

/*(9) Delete all tank tops. Your tastes have changed...*/
delete from shirts where article = 'tank top';

/*(10) Delete all shirts. You are doing some major spring cleaning!*/
DELETE FROM shirts;

/*(11) Drop the entire shirts table. Scraping everything... you must be rich or something!*/
drop table shirts;






























