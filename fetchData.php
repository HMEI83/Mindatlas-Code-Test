<?php
include 'db.php';

$sql = "SELECT users.firstname, users.surname, courses.description, enrolments.completionStatus, courses.courseID, users.userID 
        FROM enrolments
        JOIN users ON enrolments.userID = users.userID
        JOIN courses ON enrolments.courseID = courses.courseID";
$result = $conn->query($sql);

?>
