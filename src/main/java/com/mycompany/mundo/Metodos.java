
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
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Gabriela Delgado
 */
public class Metodos {
    
    public static void SvAgregarUsuario(String nombre, String apellido, String cedula, String telefono, String correo, String rol, HttpSession session, HttpServletResponse response) throws IOException {
        Conexion conexion = new Conexion();
        Connection conn = conexion.establecerConexion();
        if (conn != null) {
            try {

                // Llamar al procedimiento almacenado
                CallableStatement stmt = conn.prepareCall("{call agregarUsuario(?, ?, ?, ?, ?, ?)}");

                // Establecer parámetros del procedimiento almacenado
                stmt.setString(1, nombre);
                stmt.setString(2, apellido);
                stmt.setString(3, cedula);
                stmt.setString(4, telefono);
                stmt.setString(5, correo);
                stmt.setString(6, rol);
                
                // Ejecutar el procedimiento almacenado
                stmt.execute();

                // Cerrar la conexión
                conn.close();

                // Redirigir a alguna página de éxito o mostrar un mensaje de éxito
                response.sendRedirect("login.jsp"); // Redirigir a una página de éxito

                System.out.println("Conexion exitosa");
                
            } catch (SQLException e) { // Manejar cualquier error de SQL
                response.getWriter().println("Error al agregar pruebe de nuevo"); // Esto mostrará un mensaje de error en la página
            }
        } else {
            // Manejar el caso en que no se pueda obtener una conexión a la base de datos
            response.getWriter().println("No se pudo establecer una conexión a la base de datos."); // Esto mostrará un mensaje de error en la página
        }
    }
    
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
    
    public List<TipoSolicitud> obtenerTipoSolicitud(Connection conn) throws SQLException {
        List<TipoSolicitud> tipoSolicitud = new ArrayList<>();

        PreparedStatement stmt = conn.prepareStatement("SELECT * FROM tipoSolicitud");
        ResultSet rs = stmt.executeQuery();

        while (rs.next()) {
            int idTipoSolicitud = rs.getInt("idTipoSolicitud");
            String nombre = rs.getString("tipoSolicitud");

            TipoSolicitud categoria = new TipoSolicitud(idTipoSolicitud, nombre);
            tipoSolicitud.add(categoria);
        }

        return tipoSolicitud;
    }

    public static String generarHTMLTipoSolicitud(List<TipoSolicitud> tipoSolicitud) {
        StringBuilder html = new StringBuilder();

            for (TipoSolicitud tipoSolicitudes : tipoSolicitud) {
                html.append("<option value=\"").append(tipoSolicitudes.getTipoSolicitud()).append("\">")
                        .append(tipoSolicitudes.getTipoSolicitud())
                        .append("</option>");
            
        }

        return html.toString();
    }
    
    public static int asignarIdTipoSolicitud(Connection conn, String tipoSolicitudSeleccionado) throws SQLException {
        // Lista para almacenar los tipos de solicitud
        List<String> tipoSolicitudes = new ArrayList<>();

        PreparedStatement stmt = conn.prepareStatement("SELECT idTipoSolicitud, tipoSolicitud FROM tipoSolicitud");

        ResultSet rs = stmt.executeQuery();

        while (rs.next()) {
            tipoSolicitudes.add(rs.getString("tipoSolicitud"));

            if (rs.getString("tipoSolicitud").equals(tipoSolicitudSeleccionado)) {
                return rs.getInt("idTipoSolicitud");
            }
        }

        System.out.println("Lista de tipos de solicitud:");
        for (String tipoSolicitud : tipoSolicitudes) {
            System.out.println(tipoSolicitud);
        }

        return -1;
    }
    
    public static void SvAgregarSolicitud(int idUsuario, String tipoSolicitud, String fecha, String descripcion, String archivo, String estado, HttpSession session, HttpServletResponse response) throws IOException {
        Conexion conexion = new Conexion();
        Connection conn = conexion.establecerConexion();
        if (conn != null) {
            try {

                // Llamar al procedimiento almacenado
                CallableStatement stmt = conn.prepareCall("{call agregarSolicitud(?, ?, ?, ?, ?, ?)}");
                
                int idTipoSolicidud = Metodos.asignarIdTipoSolicitud(conn, tipoSolicitud);

                System.out.println("El idSolicitud es: " + idTipoSolicidud);

                // Establecer parámetros del procedimiento almacenado
                stmt.setInt(1, idUsuario);
                stmt.setInt(2, idTipoSolicidud);
                stmt.setString(3, fecha);
                stmt.setString(4, descripcion);
                stmt.setString(5, archivo);
                stmt.setString(6, estado);
                
                // Ejecutar el procedimiento almacenado
                stmt.execute();

                // Cerrar la conexión
                conn.close();

                // Redirigir a alguna página de éxito o mostrar un mensaje de éxito
                response.sendRedirect("solicitudesUsuario.jsp"); // Redirigir a una página de éxito

                System.out.println("Conexion exitosa");
                
            } catch (SQLException e) { // Manejar cualquier error de SQL
                response.getWriter().println("Error al agregar pruebe de nuevo" + e.getMessage()); // Esto mostrará un mensaje de error en la página
            }
        } else {
            // Manejar el caso en que no se pueda obtener una conexión a la base de datos
            response.getWriter().println("No se pudo establecer una conexión a la base de datos."); // Esto mostrará un mensaje de error en la página
        }
    }
}