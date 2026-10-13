
package com.fitlife.dao;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {

    public static Connection getConnection() {

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            String host = System.getenv("FITLIFE_DB_HOST");
            String port = System.getenv("DB_PORT");
            String database = System.getenv("FITLIFE_DB_NAME");
            String user = System.getenv("FITLIFE_DB_USER");
            String password = System.getenv("FITLIFE_DB_PASSWORD");

            StringBuilder missing = new StringBuilder();

            if (host == null || host.isBlank())
                missing.append("FITLIFE_DB_HOST ");

            if (port == null || port.isBlank())
                missing.append("DB_PORT ");

            if (database == null || database.isBlank())
                missing.append("FITLIFE_DB_NAME ");

            if (user == null || user.isBlank())
                missing.append("FITLIFE_DB_USER ");

            if (password == null || password.isBlank())
                missing.append("FITLIFE_DB_PASSWORD ");

            if (missing.length() > 0) {
                throw new RuntimeException(
                    "Missing database variables: " + missing
                );
            }

            String url = "jdbc:mysql://" + host + ":" + port
                    + "/" + database
                    + "?sslMode=REQUIRED";

            Connection connection = DriverManager.getConnection(
                    url, user, password
            );

            System.out.println("Database Connected Successfully!");

            return connection;

        } catch (Exception e) {
            System.err.println("Database Connection Failed!");
            e.printStackTrace();
            throw new RuntimeException(e);
        }
    }
}
