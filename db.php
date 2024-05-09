<?php
// Database connection information
$servername = "localhost:3308"; // MySQL server address and port
$username = "root"; // MySQL username
$password = ""; // MySQL password
$dbname = "mindatlasdb"; // Database name to connect to

// Create database connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check if the connection is successful
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
} else {
    echo "Connected successfully";
}
?>