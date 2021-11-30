CREATE DATABASE IF NOT EXISTS fin;
USE fin;



SET FOREIGN_KEY_CHECKS = FALSE;
DROP  TABLE IF EXISTS `CovidStatus` ;
DROP  TABLE IF EXISTS `Location`	;
DROP  TABLE IF EXISTS `People`	    ;
DROP  TABLE IF EXISTS `WorkStatus`  ;
DROP  TABLE IF EXISTS `Risk`		;
SET FOREIGN_KEY_CHECKS = TRUE;
FLUSH TABLES 		  `CovidStatus`, `Location`, `People`, `WorkStatus`, `Risk`;

FLUSH TABLES `Risk`;

-- The table names are 
-- 						"People"			(**people_id**, risk_id, status_id, first_name, last_name, age, gender, email)
-- 						"Risk"				(**risk_id**, risk_level, im_comp) 											   UPDATED BY TRIGGER
-- 						"CovidStatus"		(**status_id**, has_covid, prev_test, test_negative, test_inconcls)
-- 						"WorkStatus"		(**work_id**, location_id, work_type, high_inter, hrs_inter)
-- 						"PeopleWorkStatus"	(**people_id**, **work_id**)
-- 						"Location"			(**location_id**, country, state_province, city)



-- CREATE TEMPORARY TABLE people_filtered
-- SELECT * FROM People NATURAL JOIN Risk
-- WHERE  age > 18 AND UPPER(gender) = UPPER("male")
-- UNION
-- SELECT * FROM People NATURAL JOIN Risk
-- WHERE age > 18 AND UPPER(gender) = UPPER("female")
-- UNION 
-- SELECT * FROM People NATURAL JOIN Risk
-- WHERE age > 18 AND UPPER(gender) = UPPER("non-binary");


FLUSH tables people_filtered;
DROP TABLES people_filtered;

SELECT * FROM people_filtered;



-- CREATE TEMPORARY TABLE risk_filtered
-- SELECT people_id, risk_id, risk_level
-- FROM   (SELECT people_id, risk_id, gender FROM People WHERE age > 18) AS s Natural Join Risk;

FLUSH tables risk_filtered;
DROP TABLES risk_filtered;

-- SELECT * FROM risk_filtered;



-- SELECT people_id, risk_level
-- FROM (SELECT people_id, risk_level FROM people_filtered WHERE age > 18) as pf 
-- UNION
-- SELECT people_id, risk_level
-- FROM risk_filtered;






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

ALTER TABLE         WorkStatus
ADD   FOREIGN KEY   (location_id)
REFERENCES          Location (location_id);

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




-- SELECT People, SUM(CovidStatus.has_covid) from People
-- INNER JOIN CovidStatus
-- ON People.status_id = CovidStatus.status_id
-- GROUP BY People.age;

-- -- The command below finds the solution to the question, "What is the average interaction hours by counrty?". 

-- SELECT country, AVG(WorkStatus.hrs_inter) from Location
-- INNER JOIN WorkStatus
-- ON Location.location_id = WorkStatus.location_id
-- GROUP BY Location.country;


-- CREATE TEMPORARY TABLE risk_filtered
-- SELECT people_id, risk_id, risk_level
-- FROM   (SELECT people_id, risk_id, gender FROM People WHERE age > 18) AS s Natural Join Risk;

-- FLUSH tables risk_filtered;
-- DROP TABLES risk_filtered;

-- SELECT * FROM risk_filtered;

-- CREATE TEMPORARY TABLE people_filtered
-- SELECT people_id, risk_id, high_inter
-- FROM (
-- 	SELECT people_id, risk_id, gender, age, risk_level
-- 	FROM   People Natural Join risk_filtered
-- ) as s NATURAL JOIN WorkStatus;

-- SELECT people_id, risk_id, gender, age, risk_level
-- FROM   People Natural Join Risk
-- WHERE  age > 18 AND risk_level > 2
-- group by risk_level;




delimiter $$
	DROP TRIGGER IF EXISTS RiskCalculation $$
	CREATE TRIGGER RiskCalculation BEFORE INSERT ON Risk FOR EACH ROW
	BEGIN
		IF NEW.im_comp  AND NEW.risk_level <= 4 THEN
			SET NEW.risk_level = NEW.risk_level  + 1;
		ELSEIF NEW.im_comp  AND NEW.risk_level > 4 THEN 
			SET @temp_risk_level = NEW.risk_level  + 2;
			IF @temp_risk_level > 9 THEN
				SET @temp_risk_level = 9;
			END IF;
			SET NEW.risk_level =  @temp_risk_level;
		ELSEIF NEW.risk_level > 4 THEN
			SET NEW.risk_level = NEW.risk_level  - 2;
		END IF;
	END $$
    
delimiter ;

INSERT INTO Risk (risk_id, risk_level, im_comp)
VALUES ( 666, 4 , TRUE);

INSERT INTO Risk (risk_level, im_comp)
VALUES ( 3 , TRUE);

INSERT INTO Risk (risk_level, im_comp)
VALUES ( 5 , TRUE);

INSERT INTO Risk (risk_level, im_comp)
VALUES ( 9 , TRUE);

INSERT INTO Risk (risk_level, im_comp)
VALUES ( 4 , FALSE);

INSERT INTO Risk (risk_level, im_comp)
VALUES ( 9 , FALSE);



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


















