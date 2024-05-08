<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User & Course Information</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>

<h2>User & Course Information</h2>

<!-- Form to input user or course ID -->
<form method="GET" action="">
    <label for="search">Search by:</label>
    <select name="search_type" id="search_type">
        <option value="user">User ID</option>
        <option value="course">Course ID</option>
    </select>
    <input type="text" id="search" name="search">
    <input type="submit" value="Search">
</form>

<table border="1">
    <tr>
        <th>User ID</th>
        <th>First Name</th>
        <th>Last Name</th>
        <th>Course ID</th>
        <th>Course Description</th>
        <th>Completion Status</th>
    </tr>
    <?php
    include 'fetchData.php';

    // Pagination
    $results_per_page = 20;
    $page = isset($_GET['page']) ? $_GET['page'] : 1;
    $offset = ($page - 1) * $results_per_page;

    // Build SQL query
    $sql = "SELECT users.userID, users.firstname, users.surname, courses.courseID, courses.description, enrolments.completionStatus 
            FROM enrolments
            JOIN users ON enrolments.userID = users.userID
            JOIN courses ON enrolments.courseID = courses.courseID";

    // Check if search parameters are provided
    if (isset($_GET['search']) && isset($_GET['search_type'])) {
        $search = $_GET['search'];
        $search_type = $_GET['search_type'];
        if ($search_type === 'user') {
            $sql .= " WHERE users.userID = '$search'";
        } elseif ($search_type === 'course') {
            $sql .= " WHERE courses.courseID = '$search'";
        }
    }

    // Execute query
    $result = $conn->query($sql);

    // Check if query was successful
    if ($result !== null && $result->num_rows > 0) {
        // Loop through each row of the result set
        $total_results = $result->num_rows;
        $total_pages = ceil($total_results / $results_per_page);

        // Adjust page number if out of range
        if ($page < 1) {
            $page = 1;
        } elseif ($page > $total_pages) {
            $page = $total_pages;
        }

        // Adjust offset for pagination
        $offset = ($page - 1) * $results_per_page;
        $sql .= " LIMIT $offset, $results_per_page";

        // Execute paginated query
        $result = $conn->query($sql);

        // Output data for each row
        while($row = $result->fetch_assoc()) {
            echo "<tr>";
            echo "<td>" . $row["userID"] . "</td>";
            echo "<td>" . $row["firstname"] . "</td>";
            echo "<td>" . $row["surname"] . "</td>";
            echo "<td>" . $row["courseID"] . "</td>";
            echo "<td>" . $row["description"] . "</td>";
            echo "<td>" . $row["completionStatus"] . "</td>";
            echo "</tr>";
        }

        // Add pagination links
        echo "<tr><td colspan='6' class='pagination'>";
        if ($page > 1) {
            echo "<a href='{$_SERVER['PHP_SELF']}?page=".($page-1)."'>Previous</a> ";
        }
        for ($i=1; $i<=$total_pages; $i++) {
            echo "<a href='{$_SERVER['PHP_SELF']}?page=".$i."'>".$i."</a> ";
        }
        if ($page < $total_pages) {
            echo "<a href='{$_SERVER['PHP_SELF']}?page=".($page+1)."'>Next</a>";
        }
        echo "</td></tr>";

    } else {
        echo "<tr><td colspan='6'>No results found.</td></tr>";
    }
    ?>
</table>

</body>
</html>
