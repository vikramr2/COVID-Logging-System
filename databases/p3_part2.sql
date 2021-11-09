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
    work_id	  INT NOT NULL 										,
	first_name VARCHAR (31)										,
	last_name VARCHAR (31)										,
	age INT NOT NULL											,
	gender ENUM("female", "male", "other") 						,
	email VARCHAR (255)											,
	PRIMARY KEY (people_id)										
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
	prev_test DATE												,
	test_negative BOOLEAN 										,
	test_inconcls BOOLEAN 										,
	PRIMARY KEY (status_id)
);

CREATE TABLE WorkStatus (
	work_id INT NOT NULL AUTO_INCREMENT							,
    location_id INT NOT NULL									,
	work_type VARCHAR(255)										,
	interaction INT NOT NULL									,
	daily_hours INT NOT NULL									,
	PRIMARY KEY (work_id)
);

CREATE TABLE Location (
	location_id INT NOT NULL AUTO_INCREMENT						,
	country VARCHAR (255)										,
	state_province VARCHAR(255)									,
	city VARCHAR(255)											,
	PRIMARY KEY (location_ID)
);

SELECT * from Location;

SHOW TABLES;	-- CHECK TO SEE IF CORRECT NUMBER OF TABLES HAVE BEEN CREATED!
 

 
-- The code segment below assigns the foreign keys among the tables created above.
-- The ALTER TABLE method is used and abused below.
-- If a faster or more efficient algorithm please yeet this code and use that lmao.
-- Structure of foreign keys:
-- ***	
--     1) Each `Person` has their own `Risk`			|
-- 		Every `Person` has only *1* `Risk` associated with him/her
--         
--     2) Each `Person` has their own `CovidStatus`	|
-- 		Every `Person` has only *1* `Risk` associated with him/her
--         
--     3) Each `Person` has their own `WorkStatus`		|
-- 		Every `Person` could be unemployed 		(i.e. *0*  jobs)
-- 					   could have only one job	(i.e. *1*  jobs)
--                        could have many jobs		(i.e. many jobs)
--                        
-- 	4) Each `WorkStatus` has its own location		|
-- 		Every `WorkStatus` could have one location	 (i.e. *1*  jobs)
--                            could have many locations (i.e. many jobs)
-- ***
-- In the above schema, only the tables `People` and `WorkStatus` have foreign keys.    
    


ALTER TABLE 		People
ADD   FOREIGN KEY 	(risk_id) 
REFERENCES 			Risk (risk_id);

ALTER TABLE 		People
ADD   FOREIGN KEY 	(status_id) 
REFERENCES 			CovidStatus (status_id);

ALTER TABLE 		People
ADD   FOREIGN KEY 	(work_id) 
REFERENCES 			WorkStatus (work_id);

ALTER TABLE			WorkStatus
ADD	  FOREIGN KEY	(location_id)
REFERENCES			Location (location_id);

-- Run the following commands to delete all tables created so far:

SET FOREIGN_KEY_CHECKS = FALSE;
DROP  TABLE IF EXISTS `CovidStatus` ;
DROP  TABLE IF EXISTS `Location`	;
DROP  TABLE IF EXISTS `People`	    ;
DROP  TABLE IF EXISTS `WorkStatus`  ;
DROP  TABLE IF EXISTS `Risk`		;
SET FOREIGN_KEY_CHECKS = TRUE;
FLUSH TABLES 		  `CovidStatus`, `Location`, `People`, `WorkStatus`, `Risk`;

SET GLOBAL read_only = 1;

-- LOAD DATA LOCAL INFILE '/Users/ivan/Documents/riwww/cs411/projdump/pseudo_data.csv'
-- 	INTO TABLE Risk
--     (risk_level, im_comp); 


CREATE DATABASE IF NOT EXISTS proj;
USE proj;

LOAD DATA LOCAL INFILE '/Users/ivan/Documents/riwww/cs411/projdump/pseudo_data.csv'
	INTO TABLE Risk
    (risk_level, im_comp);     
    
SHOW TABLES;

SELECT * FROM People;




































































