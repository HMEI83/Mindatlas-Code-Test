<?php
// Including the database connection file
include 'db.php';

// SQL query to fetch data from multiple tables
$sql = "SELECT users.firstname, users.surname, courses.description, enrolments.completionStatus, courses.courseID, users.userID 
        FROM enrolments
        JOIN users ON enrolments.userID = users.userID
        JOIN courses ON enrolments.courseID = courses.courseID";

// Executing the SQL query
$result = $conn->query($sql);
?>