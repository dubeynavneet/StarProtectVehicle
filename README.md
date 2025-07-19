
# Star Protect Vehicle - Java Web Application

## Project Overview
**Star Protect Vehicle** is a Java EE-based Vehicle Insurance Management System built using Servlets, JSP, JDBC, and SQLite, and deployed using Apache Tomcat.

## Project Folder Structure
```
StarProtectVehicle/
├── src/main/java/com/dao/             # DAO classes
├── src/main/java/com/db/              # DB connection utility
├── src/main/java/com/servlet/         # Servlet classes (Controllers)
├── src/main/webapp/jsp/               # JSP views
├── src/main/webapp/css/               # CSS styles
├── WebContent/                        # Web resources
├── sqlite-jdbc-3.7.2.jar              # SQLite JDBC driver
├── .classpath, .project               # Eclipse project config files
```

## Folder and Package Structure Explained
- `com` is the **base Java package** containing all subpackages (`dao`, `db`, `servlet`) and is located under `src/main/java/`
- `com.dao` is a **Java package** for Data Access Object classes
- `com.db` is a **Java package** containing database connection helper class
- `com.servlet` is a **Java package** holding all Servlet classes (Controllers)
- `jsp/` is a **folder** under `src/main/webapp/` that contains all JSP (View) files
- `css/` is a **folder** under `src/main/webapp/` containing stylesheet files for design
- `WebContent/` includes static web resources and deployment descriptor `web.xml`

## How to Run
1. **Open Eclipse IDE**
2. **Import Project**: `File > Import > Existing Projects into Workspace`
3. **Add SQLite JDBC**:
   - Right-click project > `Build Path > Configure Build Path > Libraries > Add External JARs`
   - Add `sqlite-jdbc-3.7.2.jar`
4. **Start Apache Tomcat (v9)** and deploy the project
5. **Access the App**: `http://localhost:8080/StarProtectVehicle`

## How to Open Scrapbook in Eclipse
1. Go to `Window > Show View > Other > Java > Scrapbook`
2. Right-click inside and choose `Open Scrapbook Page`
3. Use it for quick code testing (make sure classes are compiled)

## How to Add SQLite in Data Source Explorer (DSE)
1. Go to `Window > Show View > Other > Data Management > Data Source Explorer`
2. In DSE, right-click on `Database Connections > New`
3. Select `SQLite` from the list (install DTP plugins if not available)
4. Click `Next` and:
   - Provide a name
   - Click `Edit Driver Definition`
   - Choose `SQLite JDBC Driver`
   - Add `sqlite-jdbc-3.7.2.jar` if not listed
   - Specify the path to your `.db` file (e.g., `C:/sqlite/starprotect.db`)
5. Test the connection and click `Finish`

---

## Servlet Details

### 1. `AdminLoginServlet.java`
Handles admin login validation. Reads username/password and checks credentials using database logic.

### 2. `AddUnderwriterServlet.java`
Adds new underwriter data into the system by accepting parameters and using `UnderwriterDAO`.

### 3. `DeleteUnderwriterServlet.java`
Deletes a specified underwriter based on their ID.

### 4. `UpdateUnderwriterServlet.java`
Updates underwriter data in the database.

### 5. `UnderwriterLoginServlet.java`
Handles login for underwriters.

### 6. `CreatePolicyServlet.java`
Creates a new insurance policy for a customer.

### 7. `UpdatePolicyServlet.java`
Updates an existing policy's details.

### 8. `RenewPolicyServlet.java`
Renews an existing insurance policy.

---

## JSP Pages

### 1. `index.jsp`
Main landing page for the application. Contains a brief overview and navigation.

### 2. `login.jsp`
Shared login page for Admin and Underwriter users.

---

## Supporting Classes

### DB Connection
- **File**: `com/db/DBConnection.java`
- Establishes connection with SQLite database using JDBC driver.

### DAO Class
- **File**: `com/dao/UnderwriterDAO.java`
- Contains all database operations related to underwriter data.

---

## Database: SQLite
- **Driver**: `sqlite-jdbc-3.7.2.jar`
- Lightweight and file-based.
- Ensure SQLite DB file is correctly referenced and connection string matches the file path.

---

## Deployment Tip
Ensure all JSP and Servlet mappings are declared in `web.xml` (located under `WebContent/WEB-INF/`).

---

## Authors & License
This project is developed for educational purposes. Modify and extend as needed.

---

## Notes
- Styling and layout are inside the `/css/` folder
- JSP pages link to servlets through `action` attributes or `form` submission logic
- Java classes follow MVC architecture: Servlet (Controller), DAO (Model), JSP (View)
