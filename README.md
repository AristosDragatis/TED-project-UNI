# Lost and Found Application

## Overview
The **Lost and Found Application** is a web-based platform that allows users to register and manage lost and found items. It provides an interface for adding lost items, viewing all reported items, and deleting records as necessary.

## Features
- **Home Page (index.jsp)**: Includes navigation links to insert a new lost item and view all lost items.
- **Insert Page (insert.jsp)**: Allows users to add a lost item with details such as description, finder, and location.
- **View All Page (view_all.jsp)**: Displays all lost items in a table format with the option to delete specific records.
- **Database Management**: Uses SQLite for storing lost item data.
- **Controller Servlet**: Handles item insertion and deletion with prepared statements to prevent SQL injection.

## Technologies Used
- Java (Servlets & JSP)
- Apache Tomcat
- SQLite Database
- HTML, CSS

## Installation & Setup
1. Clone the repository:
   ```sh
   git clone https://github.com/AristosDragatis/TED-project.git
   ```
2. Import the project into **Eclipse IDE**.
3. Ensure the necessary dependencies and Tomcat server are configured.
   -I used Apache Tomcat 10.1 version
5. Run the application on Tomcat.
6. Access the application via `http://localhost:8080/lostandfound/`.

## Database Schema
The SQLite database (`laf.db`) contains a table `LostAndFound` with the following structure:
```sql
CREATE TABLE IF NOT EXISTS LostAndFound (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    description VARCHAR(25) NOT NULL CHECK(description <> ''),
    finder VARCHAR(20) NOT NULL CHECK(finder <> ''),
    location CHAR(20) NOT NULL CHECK(location <> '')
);
```

## Usage
- Navigate to `index.jsp` to access the main page.
- Click **Insert Item** to add a lost item.
- Click **View All Items** to see the list of lost items.
- Use the **Delete** button to remove an entry.

## License
This project is licensed under the MIT License.

