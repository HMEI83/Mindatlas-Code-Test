-- Create the users table to store user information
CREATE TABLE users (
    userID INT PRIMARY KEY, -- Primary key for the user
    firstname VARCHAR(255), -- User's first name
    surname VARCHAR(255) -- User's last name
);


-- Procedure to insert users with IDs from 1 to 100
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

CALL InsertUsersWithIDs(); -- Call the procedure to insert users


-- Create the courses table to store course information
CREATE TABLE courses (
    courseID INT PRIMARY KEY AUTO_INCREMENT, -- Primary key for the course, auto-incremented
    description VARCHAR(255) -- Description of the course
);

DELIMITER $$

-- Procedure to insert courses with descriptions
CREATE PROCEDURE InsertCourses()
BEGIN
    DECLARE i INT DEFAULT 1;
    WHILE i <= 50 DO
        INSERT INTO courses (description) VALUES (CONCAT('Course Description ', i));
        SET i = i + 1;
    END WHILE;
END$$

DELIMITER ;

CALL InsertCourses();  -- Call the procedure to insert courses

-- Create the enrolments table to store enrolment information
CREATE TABLE enrolments (
    enrolmentID INT AUTO_INCREMENT PRIMARY KEY, -- Primary key for the enrolment, auto-incremented
    userID INT, -- Foreign key referencing the users table
    courseID INT, -- Foreign key referencing the courses table
    completionStatus ENUM('not started', 'in progress', 'completed'), -- Status of completion
    FOREIGN KEY (userID) REFERENCES users(userID), -- Define foreign key constraint
    FOREIGN KEY (courseID) REFERENCES courses(courseID)  -- Define foreign key constraint
); 


-- Procedure to populate enrolments with random data
DELIMITER $$

CREATE PROCEDURE PopulateEnrolments()
BEGIN
    DECLARE userCount INT DEFAULT 1;
    DECLARE courseCount INT;
    DECLARE randStatus INT;
    DECLARE courseID INT;
    DECLARE status ENUM('not started', 'in progress', 'completed');

    WHILE userCount <= 100 DO -- Start a loop to iterate over each user (from 1 to 100)
        SET courseCount = 1; -- Initialize courseCount for the current user
	
        WHILE courseCount <= FLOOR(1 + (RAND() * 5)) DO -- Start a loop to randomly assign courses to the current user (1 to 5 courses)
            SET courseID = FLOOR(1 + (RAND() * 50)); -- Generate a random course ID (from 1 to 50)
            SET randStatus = FLOOR(1 + RAND() * 3); -- Generate a random completion status (1: not started, 2: in progress, 3: completed)
            CASE randStatus
                WHEN 1 THEN SET status = 'not started'; -- Assign status based on random value
                WHEN 2 THEN SET status = 'in progress';
                WHEN 3 THEN SET status = 'completed';
            END CASE;
            INSERT INTO enrolments (userID, courseID, completionStatus) VALUES (userCount, courseID, status);
            SET courseCount = courseCount + 1; -- Increment courseCount for the next iteration
        END WHILE;
        
        SET userCount = userCount + 1; -- Increment userCount for the next iteration
    END WHILE; -- End of user loop
END$$ -- End of procedure definition

DELIMITER ;

CALL PopulateEnrolments();  -- Call the procedure to populate enrolments

