
package com.fitlife.dao;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {

    private static final String HOST =
            System.getenv("FITLIFE_DB_HOST");

    private static final String PORT =
            System.getenv("FITLIFE_DB_PORT");

    private static final String DATABASE =
            System.getenv("FITLIFE_DB_NAME");

    private static final String USER =
            System.getenv("FITLIFE_DB_USER");

    private static final String PASSWORD =
            System.getenv("FITLIFE_DB_PASSWORD");

    public static Connection getConnection() {

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            if (HOST == null || PORT == null || DATABASE == null
                    || USER == null || PASSWORD == null) {
                throw new RuntimeException(
                    "Database environment variables are missing."
                );
            }

            String url = "jdbc:mysql://" + HOST + ":" + PORT
                    + "/" + DATABASE
                    + "?sslMode=REQUIRED";

            Connection con = DriverManager.getConnection(
                    url, USER, PASSWORD
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
