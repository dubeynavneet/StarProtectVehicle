package com.db;
import java.io.File;


import java.sql.*;

public class DBConnection {
//    private static final String URL = "jdbc:sqlite:Test.db"; // or an absolute path
//    private static final String URL = "jdbc:sqlite:C:/sqlite/Test.db";
//	private static final String URL = "jdbc:sqlite:C:/Users/hp5cd/OneDrive/Desktop/Test.db";
	private static final String URL = "jdbc:sqlite:C:/Users/hp5cd/MySQLiteDB/Test.db";


    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("org.sqlite.JDBC"); // Load SQLite driver
//            System.out.println("Connecting to DB: " + new File("Test.db").getAbsolutePath());
           
        } catch (ClassNotFoundException e) {
//        	System.out.print("Inside catch");
            e.printStackTrace();
        }
        return DriverManager.getConnection(URL);
    }
}


//package com.db;
//
//import java.sql.*;
//
//public class DBConnection {
//    private static final String URL = "jdbc:mysql://localhost:3306/StarProtect";
//    private static final String USER = "root"; // change if needed
//    private static final String PASSWORD = "yourpassword"; // change if needed
//
//    public static Connection getConnection() throws SQLException {
//        try {
//            Class.forName("com.mysql.cj.jdbc.Driver");
//        } catch (ClassNotFoundException e) {
//            e.printStackTrace();
//        }
//        return DriverManager.getConnection(URL, USER, PASSWORD);
//    }
//}
