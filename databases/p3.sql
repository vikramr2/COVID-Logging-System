
-- SET FOREIGN_KEY_CHECKS=0;
-- set FOREIGN_KEY_CHECKS=1;

DROP  TABLE  IF EXISTS `People`;
FLUSH TABLES	       `People`;

DROP  TABLE  IF EXISTS `Risk`; 
FLUSH TABLES	       `Risk`;

DROP  TABLE  IF EXISTS `CovidStatus`; 
FLUSH TABLES	       `CovidStatus`;

DROP  TABLE  IF EXISTS `WorkStatus`; 
FLUSH TABLES	       `WorkStatus`;

DROP  TABLE  IF EXISTS `Location`; 
FLUSH TABLES	       `Location`;

DROP  TABLE  IF EXISTS `getRisk`; 
FLUSH TABLES	       `getRisk`;

DROP  TABLE  IF EXISTS `getWorkStatus`; 
FLUSH TABLES	       `getWorkStatus`;

DROP  TABLE  IF EXISTS `getLocation`; 
FLUSH TABLES	       `getLocation`;

DROP  TABLE  IF EXISTS `getCovidStatus`; 
FLUSH TABLES	       `getCovidStatus`;


CREATE TABLE People (
	people_id INT NOT NULL										,
    risk_id	  INT NOT NULL										,
    status_id INT NOT NULL										,
    work_id	  INT NOT NULL  									,
	first_name VARCHAR (31)										,
	last_name VARCHAR (31)										,
	age INT NOT NULL											,
	gender ENUM("female", "male", "other") 						,
	Email VARCHAR (255)											,
	PRIMARY KEY (people_id)										
	-- FOREIGN KEY (risk_id) REFERENCES Risk (risk_id) 			,
-- 	FOREIGN KEY (status_id) REFERENCES CovidStatus (status_id)	,
-- 	FOREIGN KEY (work_id) REFERENCES WorkStatus (work_id) 		
);

CREATE TABLE Risk (
	risk_id INT NOT NULL										,
    people_id INT NOT NULL										,
	risk_level INT NOT NULL										,
	im_comp BOOLEAN												,
	PRIMARY KEY (risk_id)
-- 	FOREIGN KEY (people_id) REFERENCES People (people_id)
);
 
CREATE TABLE CovidStatus (
	status_id INT NOT NULL										,
    people_id INT NOT NULL										,
	has_covid BOOLEAN											,
	prev_test DATE												,
	age INT NOT NULL											,
	test_negative BOOLEAN 										,
	test_inconcls BOOLEAN 										,
	PRIMARY KEY (status_id)
-- 	FOREIGN KEY (people_id) REFERENCES People (people_id)
);
 
CREATE TABLE WorkStatus (
	work_id INT NOT NULL										,
	work_type VARCHAR(255)										,
	interaction INT NOT NULL									,
	daily_hours INT NOT NULL									,
	PRIMARY KEY (work_id)
-- 	FOREIGN KEY (people_id) REFERENCES People (people_id)
);

CREATE TABLE Location (
	location_id INT NOT NULL									,
	country VARCHAR (255)										,
	state_province VARCHAR(255)									,
	city VARCHAR(255)											,
	PRIMARY KEY (location_ID)
-- 	FOREIGN KEY (work_id) REFERENCES WorkStatus (work_id)
);
 
CREATE TABLE getRisk (
		risk_id INT NOT NULL,
		people_id INT NOT NULL,
		PRIMARY KEY (risk_id, people_id)
-- 		FOREIGN KEY (people_id) REFERENCES People (people_id)
-- 		FOREIGN KEY (risk_id) REFERENCES Risk (risk_id)
);
 
 CREATE TABLE getWorkStatus (
            work_id INT NOT NULL,
            people_id INT NOT NULL,
            PRIMARY KEY (work_id, people_id)
--             FOREIGN KEY (people_id) REFERENCES People (people_id),
--             FOREIGN KEY (work_id) REFERENCES Work (work_id)
);
 
CREATE TABLE getLocation (
            work_id INT NOT NULL,
            location_id INT NOT NULL,
            PRIMARY KEY (work_id, location_id)
--             FOREIGN KEY (location_id) REFERENCES Location (location_id)
--             FOREIGN KEY (work_id) REFERENCES Work (work_id)
);
 
CREATE TABLE getCovidStatus (
            status_id INT NOT NULL,
            people_id INT NOT NULL,
            PRIMARY KEY (status_id, people_id)
--             FOREIGN KEY (people_id) REFERENCES People (people_id),
--             FOREIGN KEY (status_id) REFERENCES CovidStatus (status_id)
);

SHOW TABLES;

ALTER TABLE 		People
ADD   FOREIGN KEY 	(risk_id) 
REFERENCES 			Risk (risk_id);

ALTER TABLE 		Risk
ADD   FOREIGN KEY 	(risk_id) 
REFERENCES 			People (risk_id);


ALTER TABLE 		CovidStatus
ADD   FOREIGN KEY 	(people_id) 
REFERENCES 			People (people_id);


