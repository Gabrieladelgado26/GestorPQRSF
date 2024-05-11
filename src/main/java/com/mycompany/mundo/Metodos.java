package com.mycompany.mundo;

import Servlets.SvEditar;
import Servlets.SvVisualizar;
import java.io.IOException;
import java.net.Authenticator;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
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
import javax.mail.*;
import javax.mail.internet.*;
import java.util.Properties;

/**
 *
 * @author Gabriela Delgado
 */
public class Metodos {

    public boolean cedulaDuplicada(String cedula) {
        Conexion conexion = new Conexion();
        // Consulta SQL para verificar si la cédula ya existe en la base de datos
        String sql = "SELECT COUNT(*) AS count FROM usuarios WHERE Cedula = ?";

        try (Connection conn = conexion.establecerConexion(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, cedula);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                int count = rs.getInt("count");
                return count > 0; // Si count es mayor que 0, significa que la cédula ya está registrada
            }
            System.out.println("Entre al metodo");
        } catch (SQLException e) {
            System.out.println("Error al verificar la cédula duplicada: " + e.getMessage());
        }

        return false; // Si hay algún error o no se encuentra la cédula, se devuelve false por defecto
    }
    
    public static void agregarUsuario(String nombre, String apellido, String cedula, String telefono, String correo, String contrasena, String rol, HttpSession session, HttpServletResponse response) throws IOException {
        Conexion conexion = new Conexion();
        Connection conn = conexion.establecerConexion();
        if (conn != null) {
            try {

                // Llamar al procedimiento almacenado
                CallableStatement stmt = conn.prepareCall("{call agregarUsuario(?, ?, ?, ?, ?, ?, ?)}");

                // Establecer parámetros del procedimiento almacenado
                stmt.setString(1, nombre);
                stmt.setString(2, apellido);
                stmt.setString(3, cedula);
                stmt.setString(4, telefono);
                stmt.setString(5, correo);
                stmt.setString(6, contrasena);
                stmt.setString(7, rol);

                // Ejecutar el procedimiento almacenado
                stmt.execute();

                // Cerrar la conexión
                conn.close();

                String toastr = "usuarioAgregado";
                session.setAttribute("toastr", toastr);
                System.out.println("Redireccionando a login.jsp");
                enviarCorreoInsertarPQRS(nombre, apellido, cedula, telefono, correo);
                response.sendRedirect("login.jsp");

            } catch (SQLException e) {
                response.getWriter().println("Error al agregar, por favor, inténtelo de nuevo");
            }

        } else {
            // Manejar el caso en que no se pueda obtener una conexión a la base de datos
            response.getWriter().println("No se pudo establecer una conexión a la base de datos."); // Esto mostrará un mensaje de error en la página
        }
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

    public static void agregarSolicitud(int idUsuario, String tipoSolicitud, Date fecha, String descripcion, String archivo, String respuesta, String estado, HttpSession session, HttpServletResponse response) throws IOException {
        Conexion conexion = new Conexion();
        Connection conn = conexion.establecerConexion();
        if (conn != null) {
            try {

                // Llamar al procedimiento almacenado
                CallableStatement stmt = conn.prepareCall("{call agregarSolicitud(?, ?, ?, ?, ?, ?, ?)}");

                int idTipoSolicitud = Metodos.asignarIdTipoSolicitud(conn, tipoSolicitud);

                System.out.println("El idSolicitud es: " + idTipoSolicitud);

                // Establecer parámetros del procedimiento almacenado
                stmt.setInt(1, idUsuario);
                stmt.setInt(2, idTipoSolicitud);
                stmt.setDate(3, fecha);
                stmt.setString(4, descripcion);
                stmt.setString(5, archivo);
                stmt.setString(6, respuesta);
                stmt.setString(7, estado);

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

        PreparedStatement stmt = conn.prepareStatement("SELECT s.idSolicitud, s.idUsuario, t.tipoSolicitud, s.fecha, s.descripcion, s.archivo, s.respuesta, s.estado FROM solicitud s LEFT JOIN tipoSolicitud t ON s.idTipoSolicitud = t.idTipoSolicitud");
        ResultSet rs = stmt.executeQuery();

        while (rs.next()) {
            int idSolicitud = rs.getInt("idSolicitud");
            int idPersona = rs.getInt("idSolicitud");
            String tipoSolicitud = rs.getString("tipoSolicitud");
            Date fecha = rs.getDate("fecha");
            String descripcion = rs.getString("descripcion");
            String archivo = rs.getString("archivo");
            String respuesta = rs.getString("respuesta");
            String estado = rs.getString("estado");

            if (descripcion == null) {
                descripcion = "Diam amet eos at no eos sit, amet rebum ipsum clita stet, diam sea est diam eos, sit vero stet justo";
            }
            if (archivo == null) {
                archivo = "peticion.pdf";
            }

            Solicitud solicitud = new Solicitud(idSolicitud, idPersona, tipoSolicitud, fecha, descripcion, archivo, respuesta, estado);
            solicitudes.add(solicitud);
        }

        return solicitudes;
    }

    public static void editarSolicitud(int p_idSolicitud, int p_tipoSolicitud, String p_descripcion, String p_archivo) {
        PreparedStatement pstmt = null;
        Conexion conexion = new Conexion();
        Connection conn = conexion.establecerConexion();
        try {
            System.out.println("Entre a la edición");
            // Preparar la consulta SQL
            String sql = "UPDATE solicitud SET tipoSolicitud =?, descripcion =?, archivo =? WHERE idSolicitud =?";
            pstmt = conn.prepareStatement(sql);
            // Establecer los parámetros de la consulta
            pstmt.setInt(1, p_tipoSolicitud);
            pstmt.setString(2, p_descripcion);
            pstmt.setString(3, p_archivo);
            pstmt.setInt(4, p_idSolicitud);
            // Ejecutar la consulta
            pstmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // Cerrar la conexión y liberar los recursos
            try {
                if (pstmt != null) {
                    pstmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
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

                Date fecha = rs.getDate("fecha");
                String descripcion = rs.getString("descripcion");
                String archivo = rs.getString("archivo");
                // Verificar si la categoría es null y manejarlo en consecuencia
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

    public static void editarSolicitud(int idSolicitud, int idUsuario, String tipoSolicitud, String fecha, String descripcion, String archivo, String estado, HttpSession session, HttpServletResponse response, Metodos metodos) throws IOException {
        Conexion conexion = new Conexion();
        Connection conn = conexion.establecerConexion();

        int idTipoSolicitud = 0;
        try {
            idTipoSolicitud = metodos.asignarIdTipoSolicitud(conn, tipoSolicitud);
        } catch (SQLException ex) {
            Logger.getLogger(SvEditar.class.getName()).log(Level.SEVERE, null, ex);
        }

        String sql = "CALL editarTutorial(?, ?, ?, ?, ?, ?, ?)";
        try (CallableStatement stmt = conn.prepareCall(sql)) {
            stmt.setInt(1, idUsuario);
            stmt.setInt(1, idUsuario);
            stmt.setInt(2, idTipoSolicitud);
            stmt.setString(3, fecha);
            stmt.setString(4, descripcion);
            stmt.setString(5, archivo);
            stmt.setString(6, estado);

            stmt.execute();
        } catch (SQLException ex) {
            Logger.getLogger(SvEditar.class.getName()).log(Level.SEVERE, null, ex);
        }

        try {
            // Cerrar la conexión
            conn.close();
        } catch (SQLException ex) {
            Logger.getLogger(SvEditar.class.getName()).log(Level.SEVERE, null, ex);
        }

        // Redirigir a alguna página de éxito o mostrar un mensaje de éxito
        response.sendRedirect("solicitudesUsuario.jsp"); // Redirigir a una página de éxito

    }

    public static void eliminarSolicitud(int idSolicitud) throws IOException {
        Conexion conexion = new Conexion();
        Connection conn = conexion.establecerConexion();
        if (conn != null) {

            String sql = "{CALL eliminarSolicitud(?)}";
            try (CallableStatement stmt = conn.prepareCall(sql)) {
                stmt.setInt(1, idSolicitud);
                stmt.execute();
                System.out.println("Si llegue");
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public static void eliminarUsuario(int idUsuario) throws IOException {
        Conexion conexion = new Conexion();
        Connection conn = conexion.establecerConexion();
        if (conn != null) {

            String sql = "{CALL eliminarUsuario(?)}";
            try (CallableStatement stmt = conn.prepareCall(sql)) {
                stmt.setInt(1, idUsuario);
                stmt.execute();
                System.out.println("Si llegue");
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
    
    public String[] iniciarSesion(String cedula, String contrasena) {
        Conexion conexion = new Conexion();
        Connection conn = conexion.establecerConexion();
        String[] datosUsuario = null;

        try {
            String sql = "SELECT IdUsuario, rol, nombre FROM usuarios WHERE cedula = ? AND contrasena = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, cedula);
            pstmt.setString(2, contrasena);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                // Si las credenciales son válidas, obtener el id, rol y nombre del usuario
                int idUsuario = rs.getInt("idUsuario");
                System.out.println("ID del usuario en sesión: " + idUsuario);
                String rol = rs.getString("rol");
                String nombre = rs.getString("nombre");
                datosUsuario = new String[]{String.valueOf(idUsuario), rol, nombre};
            }
            rs.close();
            pstmt.close();
            conn.close();
        } catch (SQLException e) {
            System.out.println("Error al iniciar sesión: " + e.getMessage());
        }

        return datosUsuario;
    }

    public static void enviarCorreoInsertarPQRS(String nombre, String apellido, String cedula, String telefono, String correo) {
        // Configuración del servidor de correo
        String correoRemitente = "gestorpqrsf@gmail.com";
        String passwordRemitente = "z x g f y n n f i w v t a c d d";
        String host = "smtp.gmail.com";
        int puerto = 587;

        // Propiedades de la sesión
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", host);
        props.put("mail.smtp.port", puerto);

        // Autenticación
        Session session = Session.getInstance(props, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(correoRemitente, passwordRemitente);
            }
        });

        try {
            // Crear mensaje
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(correoRemitente));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(correo));
            message.setSubject("Registro Exitoso en el Sistema de PQRSF");

            // Construir el texto del mensaje con los datos del formulario
            String textoMensaje = "Estimado/a, " + nombre + "<br><br> Su registro se ha realizado correctamente en nuestro sistema.<br><br>";
            textoMensaje += "<h2>Detalles deL registro:</h2>\n";
            textoMensaje += "<p><strong>Nombre:</strong> " + nombre + "</p>\n";
            textoMensaje += "<p><strong>Apellido:</strong> " + apellido + "</p>\n";
            textoMensaje += "<p><strong>Cedula:</strong> " + cedula + "</p>\n";
            textoMensaje += "<p><strong>Teléfono:</strong> " + telefono + "</p>\n";
            textoMensaje += "<p><strong>Email:</strong> " + correo + "</p>\n";

            textoMensaje += "<br><p>Atentamente,<br>El equipo de soporte.</p>\n";
            message.setContent(textoMensaje, "text/html; charset=utf-8");

            // Enviar correo
            Transport.send(message);

            System.out.println("Correo de registro exitoso enviado a: " + correo);
        } catch (MessagingException e) {
            System.out.println("Error al enviar el correo de registro exitoso: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
