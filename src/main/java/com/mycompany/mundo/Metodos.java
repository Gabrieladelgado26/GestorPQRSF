
package com.mycompany.mundo;

import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletContext;

/**
 *
 * @author Gabriela Delgado
 */
public class Metodos {
    
    public static String verificarIngreso(int cedula, String contrasena, ServletContext context) throws IOException {
        
        Conexion conexion = new Conexion();
        Connection conn = conexion.establecerConexion();
        if (conn != null) {

        }
        return null;
    }
    
    public static int asignarId(Connection conn) throws SQLException {
        // Preparar la consulta SQL de conteo
        int totalTutoriales = 0;

        PreparedStatement stmt = conn.prepareStatement("SELECT COUNT(*) AS total FROM Tutorial");

        // Ejecutar la consulta y obtener el resultado
        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {
            // Obtener el número total de tutoriales
            totalTutoriales = rs.getInt("total");
            System.out.println("Número total de tutoriales: " + totalTutoriales);
        }
        return totalTutoriales;
    }
    
    public static int asignarIdTipoSolicitud(Connection conn, String solicitudSeleccionada) throws SQLException {
        
        // Lista para almacenar las categorías
        List<String> solicitudes = new ArrayList<>();

        // Preparar la consulta SQL para obtener todas las categorías
        PreparedStatement stmt = conn.prepareStatement("SELECT idCategoria, categoria FROM Categorias");

        // Ejecutar la consulta y obtener el resultado
        ResultSet rs = stmt.executeQuery();

        while (rs.next()) {
            // Agregar cada categoría al array
            solicitudes.add(rs.getString("solicitud"));

            // Comprobar si la categoría seleccionada coincide con alguna de las categorías
            if (rs.getString("solicitud").equals(solicitudes)) {
                // Retornar el idCategoria correspondiente
                return rs.getInt("idSolicitud");
            }
        }

        System.out.println("Lista de solicitudes: ");
        for (String solicitud : solicitudes) {
            System.out.println(solicitud);
        }
        return -1;
    }
}