-- Use the commands below to select the correct database.
-- All data sets/tables have been stored to this database.

CREATE DATABASE IF NOT EXISTS proj;
USE proj;

-- Run the commands below only if the data sets have been corrupt.
-- Otherwise ignore.

SET FOREIGN_KEY_CHECKS = FALSE;
DROP  TABLE IF EXISTS `CovidStatus` ;
DROP  TABLE IF EXISTS `Location`	;
DROP  TABLE IF EXISTS `People`	    ;
DROP  TABLE IF EXISTS `WorkStatus`  ;
DROP  TABLE IF EXISTS `Risk`		;
SET FOREIGN_KEY_CHECKS = TRUE;
FLUSH TABLES 		  `CovidStatus`, `Location`, `People`, `WorkStatus`, `Risk`;

-- The code below creates the 5 main tables in our database.
-- ***
-- PLEASE NOTE :
-- The foreign keys are not included in the code below, they will 
-- be added later, for some reason mySQL cannot add a foreign key
-- before the actual table is created.
-- ***
-- The table names are 
-- 						"People"
-- 						"Risk"
-- 						"CovidStatus"
-- 						"WorkStatus"
-- 						"Location"

CREATE TABLE People (
	people_id INT NOT NULL AUTO_INCREMENT   					,
    risk_id	  INT NOT NULL 										,
    status_id INT NOT NULL 										,
	first_name VARCHAR (31)										,
	last_name VARCHAR (31)										,
	age INT NOT NULL											,
	gender VARCHAR (255)                    					,
	email VARCHAR (255)											,
	PRIMARY KEY (people_id)										
);

CREATE TABLE PeopleWorkStatus (
	people_id INT NOT NULL,
    work_id   INT NOT NULL,
    PRIMARY KEY (people_id, work_id),
    FOREIGN KEY (people_id) REFERENCES People (people_id),
    FOREIGN KEY (work_id)   REFERENCES WorkStatus (work_id)
);

CREATE TABLE Risk (
	risk_id INT NOT NULL AUTO_INCREMENT							,
	risk_level INT NOT NULL										,
	im_comp BOOLEAN												,
	PRIMARY KEY (risk_id)
);
 
CREATE TABLE CovidStatus (
	status_id INT NOT NULL		AUTO_INCREMENT					,
	has_covid BOOLEAN											,
	prev_test INT												,
	test_negative BOOLEAN 										,
	test_inconcls BOOLEAN 										,
	PRIMARY KEY (status_id)
);

CREATE TABLE WorkStatus (
	work_id INT NOT NULL AUTO_INCREMENT							,
    location_id INT NOT NULL									,
	work_type VARCHAR(255)										,
	high_inter BOOLEAN       									,
	hrs_inter INT NOT NULL									    ,
	PRIMARY KEY (work_id)
);

CREATE TABLE Location (
	location_id INT NOT NULL AUTO_INCREMENT						,
	country VARCHAR (255)										,
	state_province VARCHAR(255)									,
	city VARCHAR(255)											,
	PRIMARY KEY (location_ID)
);

-- The code segment below creates the relevant foreign keys for the tables created

ALTER TABLE			WorkStatus
ADD	  FOREIGN KEY	(location_id)
REFERENCES			Location (location_id);

ALTER TABLE 		People
ADD   FOREIGN KEY 	(risk_id) 
REFERENCES 			Risk (risk_id);

ALTER TABLE 		People
ADD   FOREIGN KEY 	(status_id) 
REFERENCES 			CovidStatus (status_id);

SHOW TABLES;	-- CHECK TO SEE IF CORRECT NUMBER OF TABLES HAVE BEEN CREATED!

-- After importing the data into the respective tables use the code below to look at the data.
-- Make sure everything adds up.

SELECT * FROM Location;
SELECT * FROM CovidStatus;
SELECT * FROM Risk;
SELECT * FROM WorkStatus;
SELECT * FROM People;
SELECT * FROM PeopleWorkStatus;

-- The two commands below represent the advanced SQL queris related to the project.

-- The command below finds the solution to the question, "How many people of each age group have COVID-19?". 

SELECT age, SUM(CovidStatus.has_covid) from People
INNER JOIN CovidStatus
ON People.status_id = CovidStatus.status_id
GROUP BY People.age;

-- The command below finds the solution to the question, "What is the average interaction hours by counrty?". 

SELECT country, AVG(WorkStatus.hrs_inter) from Location
INNER JOIN WorkStatus
ON Location.location_id = WorkStatus.location_id
GROUP BY Location.country;

CREATE INDEX index_name ON People (status_id);
DROP INDEX index_name ON Location;
CREATE INDEX index_name ON Location (country, city, state_province);
DROP INDEX index_name ON Location;
DROP INDEX index_name ON People;

CREATE INDEX index_name ON Location (state_province, city);


EXPLAIN ANALYZE SELECT age, SUM(CovidStatus.has_covid) from People
INNER JOIN CovidStatus
ON People.status_id = CovidStatus.status_id
GROUP BY People.age;

EXPLAIN ANALYZE SELECT country, AVG(WorkStatus.hrs_inter) from Location
INNER JOIN WorkStatus
ON Location.location_id = WorkStatus.location_id
GROUP BY Location.country;











