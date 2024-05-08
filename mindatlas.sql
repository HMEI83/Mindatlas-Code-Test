
CREATE TABLE users (
    userID INT PRIMARY KEY,
    firstname VARCHAR(255),
    surname VARCHAR(255)
);


DELIMITER $$

CREATE PROCEDURE InsertUsersWithIDs()
BEGIN
    DECLARE i INT DEFAULT 1;
    WHILE i <= 100 DO
        INSERT INTO users (userID, firstname, surname) VALUES (i, CONCAT('First', i), CONCAT('Last', i));
        SET i = i + 1;
    END WHILE;
END$$

DELIMITER ;

CALL InsertUsersWithIDs();

CREATE TABLE courses (
    courseID INT PRIMARY KEY AUTO_INCREMENT,
    description VARCHAR(255)
);

DELIMITER $$

CREATE PROCEDURE InsertCourses()
BEGIN
    DECLARE i INT DEFAULT 1;
    WHILE i <= 50 DO
        INSERT INTO courses (description) VALUES (CONCAT('Course Description ', i));
        SET i = i + 1;
    END WHILE;
END$$

DELIMITER ;

CALL InsertCourses();


CREATE TABLE enrolments (
    enrolmentID INT AUTO_INCREMENT PRIMARY KEY,
    userID INT,
    courseID INT,
    completionStatus ENUM('not started', 'in progress', 'completed'),
    FOREIGN KEY (userID) REFERENCES users(userID),
    FOREIGN KEY (courseID) REFERENCES courses(courseID)
);


DELIMITER $$

CREATE PROCEDURE PopulateEnrolments()
BEGIN
    DECLARE userCount INT DEFAULT 1;
    DECLARE courseCount INT;
    DECLARE randStatus INT;
    DECLARE courseID INT;
    DECLARE status ENUM('not started', 'in progress', 'completed');

    WHILE userCount <= 100 DO
        SET courseCount = 1;
	
        WHILE courseCount <= FLOOR(1 + (RAND() * 5)) DO
            SET courseID = FLOOR(1 + (RAND() * 50));
            SET randStatus = FLOOR(1 + RAND() * 3);
            CASE randStatus
                WHEN 1 THEN SET status = 'not started';
                WHEN 2 THEN SET status = 'in progress';
                WHEN 3 THEN SET status = 'completed';
            END CASE;
            INSERT INTO enrolments (userID, courseID, completionStatus) VALUES (userCount, courseID, status);
            SET courseCount = courseCount + 1;
        END WHILE;
        
        SET userCount = userCount + 1;
    END WHILE;
END$$

DELIMITER ;

CALL PopulateEnrolments();

