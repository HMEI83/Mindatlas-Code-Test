# MySQL Code Test

## SQL File

The SQL file containing the database schema and sample data can be found at the following path: Mindatlas-Code-Test/MySQL_Code_Test/MySQL Code Test.sql

## Tables

### User
- Description: Stores information about users.
- Columns:
  - `ID`: Primary key for the user.
  - `Username`: Username of the user.

### UserFieldName
- Description: Defines different fields that can be associated with users.
- Columns:
  - `ID`: Primary key for the field.
  - `Field`: Name of the field.

### UserData
- Description: Stores data associated with users for different fields.
- Columns:
  - `ID`: Primary key for the user data.
  - `FieldID`: Foreign key referencing the `UserFieldName` table.
  - `Data`: Data associated with the field.
  - `UserID`: Foreign key referencing the `User` table.

## EXPECTED RESULT QUERY

To retrieve user data, use the following SQL query:

```sql
SELECT 
    u.Username,
    phone.Data AS Phone,
    email.Data AS Email,
    position.Data AS Position
FROM 
    User u
LEFT JOIN 
    UserData phone ON u.ID = phone.UserID AND phone.FieldID = 1
LEFT JOIN 
    UserData email ON u.ID = email.UserID AND email.FieldID = 2
LEFT JOIN 
    UserData position ON u.ID = position.UserID AND position.FieldID = 3;
```


# PHP Code Test

This task involves setting up a User Data Management System using PHP and MySQL. Follow the steps below to configure and run the system:

## Prerequisites

- Make sure you have PHP version 8.0.30 installed on your system.
- Install XAMPP for a local server environment if you haven't already done so.

## Setup Instructions

1. **Database Setup**: 
   - Execute the `mindatlas.sql` script to generate sample data for the system. The data generated will be randomized and include over 100 enrolments.
   
2. **Database Configuration**:
   - Open the `db.php` file and update the server information as follows:
     ```php
     $servername = "localhost:3308";
     $username = "root";
     $password = "";
     $dbname = "mindatlasdb";
     ```

3. **Server Environment**:
   - It is recommended to run the system in a XAMPP environment to ensure compatibility and ease of setup.

## Running the System

Once you have completed the setup steps:

1. Start your XAMPP server.
2. Place the project files in the appropriate directory (e.g., `htdocs` folder in XAMPP).
3. Access the system through your web browser by navigating to `http://localhost/your_project_folder`.

## Features and Solutions

1. **Pagination Functionality:**
   - The system implements pagination to maintain fast page loading speeds, even with a significant amount of data. It limits the number of results displayed per page to 20 and provides navigation links for easy browsing.

2. **Search Capability:**
   - Users can search for information by user ID or course ID, with search results updating dynamically as users input their queries. This enhances flexibility and convenience for users seeking specific information.

3. **Efficient Data Handling:**
   - To handle large data sets efficiently, the system paginates results and retrieves data only when required. This approach improves system performance and ensures stability and scalability.

## Conclusion

With these features and solutions in place, the system effectively addresses the challenges posed by large data sets. The updated README file offers clear explanations and guidance, enabling users to navigate and utilize the system with ease.


## Additional Notes

- The `mindatlas.sql` script generates randomized sample data for the system, including over 100 enrolments. Make sure to execute this script before running the system.
- Ensure that your PHP version matches the requirement (PHP 8.0.30) to avoid compatibility issues.

Follow these instructions carefully to set up and run the system successfully.


