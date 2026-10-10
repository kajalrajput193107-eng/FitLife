package com.fitlife.dao;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {

    private static final String URL =
            "jdbc:mysql://localhost:3306/fitness_db";

    private static final String USER =
            System.getenv("FITLIFE_DB_USER");

    private static final String PASSWORD =
            System.getenv("FITLIFE_DB_PASSWORD");

    public static Connection getConnection() {

        try {

            Class.forName("com.mysql.cj.jdbc.Driver");

            if (USER == null || PASSWORD == null) {
                throw new RuntimeException(
                    "Database environment variables are not configured."
                );
            }

            Connection con = DriverManager.getConnection(
                    URL,
                    USER,
                    PASSWORD
            );

            System.out.println("Database Connected Successfully!");

            return con;

        } catch (Exception e) {

            System.out.println("Database Connection Failed!");
            e.printStackTrace();

            throw new RuntimeException(e);
        }
    }
}