
package com.mycompany.mundo;

import java.sql.Connection;
import java.sql.DriverManager;

/**
 *
 * @author Gabriela Delgado
 */
public class Conexion {
    
    public Connection establecerConexion(){
        String url = "jdbc:mysql://localhost:3306/gestor_pqrsf?serverTimeZone=utc";
        String user = "root";
        String password = "123456";
        Connection conn = null;
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(url,user,password);
            if (conn!=null) {
                System.out.println("Conexion exitosa");
            }
        } catch (Exception e) {
            System.out.println("Error de conexion " + e.getMessage());
        }
        return conn;
    }
}
