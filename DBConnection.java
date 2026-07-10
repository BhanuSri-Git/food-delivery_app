package com.tap.utility;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * DBConnection - returns a fresh Connection on every call.
 * Callers are responsible for closing the connection (use try-with-resources).
 *
 * NOTE: For production, replace with a connection pool (HikariCP / c3p0).
 *       The DB password should be stored in a properties file, not source code.
 */
public class DBConnection {

    private static final String URL      = "jdbc:mysql://localhost:3306/FoodDelivery?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
    private static final String USERNAME = "root";
    private static final String PASSWORD = "Divya1991";

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("MySQL JDBC driver not found", e);
        }
    }

    /**
     * Returns a brand-new Connection every time.
     * Never stores a connection in a static field.
     *
     * Throws a RuntimeException (instead of returning null) if the connection
     * fails, so callers get a clear error immediately instead of a confusing
     * NullPointerException later when they try to use a null Connection.
     */
    public static Connection getConnection() {
        try {
            Connection connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
            System.out.println("DB connected");
            return connection;
        } catch (SQLException e) {
            // Log full details for debugging
            System.err.println("DB connection failed: " + e.getMessage());
            e.printStackTrace();
            // Fail loudly instead of returning null - callers should not have
            // to null-check every getConnection() result.
            throw new RuntimeException("Could not connect to database: " + e.getMessage(), e);
        }
    }
}
