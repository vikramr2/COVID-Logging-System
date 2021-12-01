-- Use the commands below to select the correct database.
-- All data sets/tables have been stored to this database.

CREATE DATABASE IF NOT EXISTS proj;
USE proj;

-- Run the commands below only if the data sets have been corrupt.
-- Otherwise ignore.

SET FOREIGN_KEY_CHECKS = FALSE;
DROP  TABLE IF EXISTS `CovidStatus`     ;
DROP  TABLE IF EXISTS `Location`	    ;
DROP  TABLE IF EXISTS `People`	        ;
DROP  TABLE IF EXISTS `WorkStatus`      ;
DROP  TABLE IF EXISTS `Risk`		    ;
DROP  TABLE IF EXISTS `PeopleDetail`    ;
DROP  TABLE IF EXISTS `CountryCount`    ;
DROP  TABLE IF EXISTS `CityCount`       ;
DROP  TABLE IF EXISTS `ProvinceCount`   ;
DROP  TABLE IF EXISTS `PeopleWorkStatus`;
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
	location_id INT NOT NULL AUTO_INCREMENT	                    ,
	country VARCHAR (255)										,
	state_province VARCHAR(255)									,
	city VARCHAR(255)											,
	PRIMARY KEY (location_ID)
);

CREATE TABLE PeopleDetail (
	people_id INT NOT NULL AUTO_INCREMENT   					,
    first_name VARCHAR (31)										,
	last_name VARCHAR (31)										,
    has_covid BOOLEAN											,
	age INT NOT NULL											,
	gender VARCHAR (255)                    					,
	email VARCHAR (255)											,
    country VARCHAR (255)										,
	state_province VARCHAR(255)									,
	city VARCHAR(255)											,
    PRIMARY KEY (people_id)
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

-- After impoPeopleWorkStatusrting the data into the respective tables use the code below to look at the data.
-- Make sure everything adds up.

SELECT * FROM Location;
SELECT * FROM CovidStatus;
SELECT * FROM Risk;
SELECT * FROM WorkStatus;
SELECT * FROM People;
SELECT * FROM PeopleWorkStatus;

-- For API Purposes: Join tables to be parsed into readable format by client

INSERT INTO PeopleDetail
SELECT 
	pid,
    first_name,
    last_name,
    MAX(has_covid),
    age,
    gender,
    email,
    MAX(country),
    MAX(state_province),
    MAX(city)
FROM (
	SELECT DISTINCT 
		pid,
		first_name,
		last_name,
        has_covid,
		age,
		gender,
		email,
		country, 
		state_province, 
		city
	FROM (
		(SELECT 
			People.people_id pid,
			first_name,
			last_name,
            People.status_id sid,
			age,
			gender,
			email
		FROM People
		GROUP BY People.people_id) t
			JOIN PeopleWorkStatus ON PeopleWorkStatus.people_id = pid 
			JOIN WorkStatus ON WorkStatus.work_id = PeopleWorkStatus.work_id 
			JOIN Location ON WorkStatus.location_id = Location.location_id
            JOIN CovidStatus ON sid = CovidStatus.status_id
)) T
GROUP BY pid;

SELECT * FROM PeopleDetail; 

-- Get Cases for each country, province, and city

CREATE TABLE CountryCount (
	country VARCHAR (255)										,
    cases INT NOT NULL											
);

CREATE TABLE ProvinceCount (
	province VARCHAR (255)										,
    cases INT NOT NULL
);

CREATE TABLE CityCount (
	city VARCHAR (255)											,
    cases INT NOT NULL
);

INSERT INTO CountryCount
SELECT 
	country,
    SUM(has_covid)
FROM (
	SELECT DISTINCT 
		pid,
		first_name,
		last_name,
        has_covid,
		age,
		gender,
		email,
		country, 
		state_province, 
		city
	FROM (
		(SELECT 
			People.people_id pid,
			first_name,
			last_name,
            People.status_id sid,
			age,
			gender,
			email
		FROM People
		GROUP BY People.people_id) t
			JOIN PeopleWorkStatus ON PeopleWorkStatus.people_id = pid 
			JOIN WorkStatus ON WorkStatus.work_id = PeopleWorkStatus.work_id 
			JOIN Location ON WorkStatus.location_id = Location.location_id
            JOIN CovidStatus ON sid = CovidStatus.status_id
)) T
GROUP BY country;

INSERT INTO ProvinceCount
SELECT 
	state_province,
    SUM(has_covid)
FROM (
	SELECT DISTINCT 
		pid,
		first_name,
		last_name,
        has_covid,
		age,
		gender,
		email,
		country, 
		state_province, 
		city
	FROM (
		(SELECT 
			People.people_id pid,
			first_name,
			last_name,
            People.status_id sid,
			age,
			gender,
			email
		FROM People
		GROUP BY People.people_id) t
			JOIN PeopleWorkStatus ON PeopleWorkStatus.people_id = pid 
			JOIN WorkStatus ON WorkStatus.work_id = PeopleWorkStatus.work_id 
			JOIN Location ON WorkStatus.location_id = Location.location_id
            JOIN CovidStatus ON sid = CovidStatus.status_id
)) T
GROUP BY state_province;

INSERT INTO CityCount
SELECT 
	city,
    SUM(has_covid)
FROM (
	SELECT DISTINCT 
		pid,
		first_name,
		last_name,
        has_covid,
		age,
		gender,
		email,
		country, 
		state_province, 
		city
	FROM (
		(SELECT 
			People.people_id pid,
			first_name,
			last_name,
            People.status_id sid,
			age,
			gender,
			email
		FROM People
		GROUP BY People.people_id) t
			JOIN PeopleWorkStatus ON PeopleWorkStatus.people_id = pid 
			JOIN WorkStatus ON WorkStatus.work_id = PeopleWorkStatus.work_id 
			JOIN Location ON WorkStatus.location_id = Location.location_id
            JOIN CovidStatus ON sid = CovidStatus.status_id
)) T
GROUP BY city;

SELECT * FROM CountryCount;
SELECT * FROM ProvinceCount;
SELECT * FROM CityCount;


DELIMITER $$

DROP TRIGGER UpdateCounts$$
CREATE TRIGGER UpdateCounts
AFTER INSERT
ON PeopleDetail
FOR EACH ROW
BEGIN
	IF NEW.country != 'NorthKorea' THEN
		UPDATE CountryCount
		SET cases = cases + 1
		WHERE country = 'UnitedStates';
    END IF;
END $$
DELIMITER ;

DROP TABLE PeopleDetail2;

CREATE TABLE PeopleDetail2 (
	people_id INT NOT NULL AUTO_INCREMENT   					,
    first_name VARCHAR (31)										,
	last_name VARCHAR (31)										,
    has_covid BOOLEAN											,
	age INT NOT NULL											,
	gender VARCHAR (255)                    					,
	email VARCHAR (255)											,
    country VARCHAR (255)										,
	state_province VARCHAR(255)									,
	city VARCHAR(255)											,
    PRIMARY KEY (people_id)
);
DELIMITER $$

DROP TRIGGER UpdateCounts2$$
CREATE TRIGGER UpdateCounts2
AFTER DELETE
ON PeopleDetail
FOR EACH ROW
BEGIN
	UPDATE CountryCount
    SET cases = cases - 1
    WHERE country = 'Ukraine';
END $$
DELIMITER ;

SELECT * FROM PeopleDetail2;

DELIMITER $$
DELIMITER ;
CREATE TEMPORARY TABLE people_filtered
SELECT * FROM People NATURAL JOIN Risk
WHERE  age > 18 AND UPPER(gender) = UPPER("male")
UNION
SELECT * FROM People NATURAL JOIN Risk
WHERE age > 18 AND UPPER(gender) = UPPER("female")
UNION 
SELECT * FROM People NATURAL JOIN Risk
WHERE age > 18 AND UPPER(gender) = UPPER("non-binary");

CREATE TEMPORARY TABLE risk_filtered
SELECT people_id, risk_id, risk_level
FROM   (SELECT people_id, risk_id, gender FROM People WHERE age > 18) AS s Natural Join Risk;
DELIMITER $$

DROP PROCEDURE IF EXISTS PeopleRisk $$

CREATE PROCEDURE PeopleRisk()

BEGIN

DECLARE pid INT;
DECLARE pstatus VARCHAR(64);
DECLARE calculatedRisk INT;

DECLARE curs CURSOR FOR (SELECT people_id, risk_level
						 FROM (SELECT people_id, risk_level FROM people_filtered WHERE age > 18) as pf 
						 UNION
						 SELECT people_id, risk_level
						 FROM risk_filtered);
                        
   
DROP TABLE IF EXISTS CalculatedRiskTable;
CREATE TABLE CalculatedRiskTable(
	peopleID INT PRIMARY KEY,
	people_status VARCHAR(50),
	cal_risk INT
);

OPEN curs;
BEGIN
    DECLARE exit_flag BOOLEAN DEFAULT FALSE;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET exit_flag=TRUE;
    
    cloop: LOOP
    FETCH curs INTO pid, calculatedRisk;
        IF pid = NULL THEN
            LEAVE cloop;
        ELSEIF exit_flag THEN
            LEAVE cloop;
        END IF;
        
        IF calculatedRisk >= 7 THEN
            SET pstatus = "Quarantine for 14 days, please!";
        ELSEIF calculatedRisk > 3 AND calculatedRisk < 7 THEN
            SET pstatus = "Practice social distancing!";
        ELSE
            SET pstatus = "Lick door knobs!";
        END IF;
        
        INSERT IGNORE INTO CalculatedRiskTable VALUES (pid, pstatus, calculatedRisk);
    END LOOP cloop;
END;
CLOSE curs;

SELECT * FROM CalculatedRiskTable;

END $$

DELIMITER ;

CALL PeopleRisk;

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









