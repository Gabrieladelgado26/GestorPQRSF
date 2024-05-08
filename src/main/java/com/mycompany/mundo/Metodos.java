package com.mycompany.mundo;

import Servlets.SvVisualizar;
import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
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

    public static List<Solicitud> obtenerSolicitudes(Connection conn) throws SQLException {
        List<Solicitud> solicitudes = new ArrayList<>();

        PreparedStatement stmt = conn.prepareStatement("SELECT s.idSolicitud, s.idUsuario, t.tipoSolicitud, s.fecha, s.descripcion, s.archivo, s.estado FROM solicitud s LEFT JOIN tipoSolicitud t ON s.idTipoSolicitud = t.idTipoSolicitud");
        ResultSet rs = stmt.executeQuery();

        while (rs.next()) {
            int idSolicitud = rs.getInt("idSolicitud");
            int idPersona = rs.getInt("idSolicitud");
            String tipoSolicitud = rs.getString("tipoSolicitud");
            String fecha = rs.getString("fecha");
            String descripcion = rs.getString("descripcion");
            String archivo = rs.getString("archivo");
            String estado = rs.getString("estado");

            // Verificar si la categoría es null y manejarlo en consecuencia
            if (fecha == null) {
                fecha = "08/05/2024";
            }
            if (descripcion == null) {
                descripcion = "Diam amet eos at no eos sit, amet rebum ipsum clita stet, diam sea est diam eos, sit vero stet justo";
            }
            if (archivo == null) {
                archivo = "peticion.pdf";
            }

            Solicitud solicitud = new Solicitud(idSolicitud, idPersona, tipoSolicitud, fecha, descripcion, archivo, estado);
            solicitudes.add(solicitud);
        }

        return solicitudes;
    }

    public static String generarHTML(List<Solicitud> solicitudes) {
        StringBuilder html = new StringBuilder();

        if (solicitudes.isEmpty()) {
            html.append("<br><div class=\"no-tutorials\">No hay solicitudes registradas</div></br>");
        } else {
            for (Solicitud solicitud : solicitudes) {
                html.append("<div class=\"col-md-4 mb-4\">")
                        .append("<div class=\"card border-0 mb-2\">")
                        .append("<div class=\"card-body bg-white p-4\">")
                        .append("<div class=\"d-flex align-items-center mb-3\">")
                        .append("<a class=\"btn btn-pri\" href=\"\"><i class=\"fa fa-link\"></i></a>")
                        .append("<h5 class=\"m-0 ml-3 text-truncate\">").append(solicitud.getTipoSolicitud()).append("</h5>")
                        .append("</div>")
                        .append("<p>").append(solicitud.getDescripcion()).append("</p>")
                        .append("<div class=\"d-flex\">")
                        .append("<small class=\"mr-3\"><i class=\"fa fa-user text-primary\"></i>Id usuario: ").append(solicitud.getIdPersona()).append("</small>")
                        .append("<small class=\"mr-3\"><i class=\"fa fa-folder text-primary\"></i>Archivo: ").append(solicitud.getArchivo()).append("</small>")
                        .append("<small class=\"mr-3\"><i class=\"fa fa-comments text-primary\"></i>Fecha: ").append(solicitud.getFecha()).append("</small>")
                        .append("</div>")
                        .append("<div class=\"justify-content-center\">")
                        .append("<a href=\"#\" id=\"btnVisualizar\" style=\"margin-top: 20px; margin-right: 5px;\" class=\"btn btn-sm btn-outline-primary\" data-bs-toggle=\"modal\" data-bs-target=\"#visualizar\" data-nombre=\"" + solicitud.getIdSolicitud() + "\"><i class=\"fa-solid fa-eye fa-sm\"></i></a>")
                        .append("<a href=\"#\" id=\"btnEditar\" style=\"margin-top: 20px; margin-right: 5px;\" class=\"btn btn-sm btn-outline-success\" data-nombre=\"" + solicitud.getIdSolicitud() + "\" data-bs-toggle=\"modal\" data-bs-target=\"#editar\"><i class=\"fa-solid fa-pen-clip fa-sm\"></i></a>")
                        .append("<a href=\"#\" style=\"margin-top: 20px;\" class=\"btn btn-sm btn-outline-danger\" onclick=\"modalEliminar('" + solicitud.getIdSolicitud() + "')\" data-nombre=\"" + solicitud.getIdSolicitud() + "\"><i class=\"fa-solid fa-trash fa-sm\"></i></a>")
                        .append("</div>")
                        .append("</div>")
                        .append("</div>")
                        .append("</div>");
            }
        }
        return html.toString();
    }

    public Solicitud buscarSolicitudPorId(int id, Connection conn) {

        Solicitud solicitud = new Solicitud();

        try {
            // Consulta SQL con LEFT JOIN
            String sql = "SELECT s.idSolicitud, s.idUsuario, s.idTipoSolicitud, s.fecha, s.descripcion, s.archivo, s.estado \n"
                    + "FROM solicitud s \n"
                    + "LEFT JOIN tiposolicitud t ON s.idTipoSolicitud = t.idTipoSolicitud \n"
                    + "WHERE s.idSolicitud = ?";

            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                solicitud.setIdSolicitud(rs.getInt("idSolicitud"));
                solicitud.setIdPersona(rs.getInt("idUsuario"));
                solicitud.setTipoSolicitud(rs.getString("tipoSolicitud"));

                String fecha = rs.getString("fecha");
                String descripcion = rs.getString("descripcion");
                String archivo = rs.getString("archivo");
                // Verificar si la categoría es null y manejarlo en consecuencia
                if (fecha == null) {
                    fecha = "08/05/2024";
                }
                if (descripcion == null) {
                    descripcion = "Diam amet eos at no eos sit, amet rebum ipsum clita stet, diam sea est diam eos, sit vero stet justo";
                }
                if (archivo == null) {
                    archivo = "peticion.pdf";
                }
                solicitud.setFecha(fecha);
                solicitud.setDescripcion(descripcion);
                solicitud.setArchivo(archivo);

                solicitud.setEstado(rs.getString("estado"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return solicitud;
    }
    
    public String generarSolicitudHtml(Solicitud solicitud) {
        StringBuilder resultado = new StringBuilder();

        resultado.append("<h2>Información del tutorial</h2>");
        resultado.append("<hr>");
        resultado.append("<div class=\"row\">");
        resultado.append("<div class=\"col\">");
        resultado.append("<div class=\"form-element\">");
        resultado.append("<label class='titu' for=\"nombre\">Tipo de solicitud</label>");
        resultado.append("<p class='dato'>" + solicitud.getTipoSolicitud() + "</p>");
        resultado.append("<hr class='linea'>");
        resultado.append("</div>");
        resultado.append("</div>");
        resultado.append("<div class=\"col\">");
        resultado.append("<div class=\"form-element\">");
        resultado.append("<label class='titu' for=\"apellido\">Descripción</label>");
        resultado.append("<p class='dato'>" + solicitud.getDescripcion() + "</p>");
        resultado.append("<hr class='linea'>");
        resultado.append("</div>");
        resultado.append("</div>");
        resultado.append("</div>");
        resultado.append("<div class=\"row\">");
        resultado.append("<div class=\"col\">");
        resultado.append("<div class=\"form-element\">");
        resultado.append("<label class='titu' for=\"celular\">Prioridad</label>");
        resultado.append("<p class='dato'>" + solicitud.getFecha() + "</p>");
        resultado.append("<hr class='linea'>");
        resultado.append("</div>");
        resultado.append("</div>");
        resultado.append("<div class=\"col\">");
        resultado.append("<div class=\"form-element\">");
        resultado.append("<label class='titu' for=\"direccion\">Url</label>");
        resultado.append("<p class='dato link' onclick=\"redirectToUrl('" + solicitud.getArchivo() + "')\">Link</p>");
        resultado.append("<hr class='linea'>");
        resultado.append("</div>");
        resultado.append("</div>");
        resultado.append("</div>");
        resultado.append("<div class=\"row\">");
        resultado.append("<div class=\"col\">");
        resultado.append("</div>");
        resultado.append("</div>");
        resultado.append("</div>");

        return resultado.toString();
    }

    public static void visualizar(int idSolicitud, Metodos metodo, HttpServletResponse response) throws IOException {
        Solicitud solicitud = new Solicitud();
        Conexion conexion = new Conexion();
        Connection conn = conexion.establecerConexion();
        solicitud = metodo.buscarSolicitudPorId(idSolicitud, conn);

        String formularioHTML = metodo.generarSolicitudHtml(solicitud);

        String nuevoEstado = "Revisado";

        String sql = "CALL editarEstadoSolicitud(?, ?)";
        try (CallableStatement stmt = conn.prepareCall(sql)) {
            stmt.setInt(1, idSolicitud);
            stmt.setString(2, nuevoEstado);

            stmt.execute();
        } catch (SQLException ex) {
            Logger.getLogger(SvVisualizar.class.getName()).log(Level.SEVERE, null, ex);
        }

        // Se configura el tipo de contenido de la respuesta como "text/html"
        response.setContentType("text/html");
        // Se escribe la información del contacto en el cuerpo de la respuesta
        response.getWriter().write(formularioHTML);

    }
}
