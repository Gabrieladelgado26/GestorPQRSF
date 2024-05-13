package com.mycompany.mundo;

import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
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
                enviarCorreoRegistroExitoso(nombre, apellido, cedula, telefono, correo);
                response.sendRedirect("login.jsp");

            } catch (SQLException e) {
                response.getWriter().println("Error al agregar, por favor, inténtelo de nuevo");
            }

        } else {
            // Manejar el caso en que no se pueda obtener una conexión a la base de datos
            response.getWriter().println("No se pudo establecer una conexión a la base de datos."); // Esto mostrará un mensaje de error en la página
        }
    }

    public static void editarUsuario(int idUsuario, String nombre, String apellido, String telefono, String correo, String rol) {
        PreparedStatement pstmt = null;
        Conexion conexion = new Conexion();
        Connection conn = conexion.establecerConexion();
        try {
            System.out.println("Entre a la edición");
            String sql = "UPDATE usuarios SET nombre =?, apellido =?, telefono =?, correo =?, rol =? WHERE idUsuario =?";
            pstmt = conn.prepareStatement(sql);

            pstmt.setString(1, nombre);
            pstmt.setString(2, apellido);
            pstmt.setString(3, telefono);
            pstmt.setString(4, correo);
            pstmt.setString(5, rol);
            pstmt.setInt(6, idUsuario);

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

    public static void enviarCorreoRegistroExitoso(String nombre, String apellido, String cedula, String telefono, String correo) {
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

            String textoMensaje = "          Bienvenid@ a nuestro sistema          ";
            //textoMensaje += "<img src=\"img/correoR.png\" alt=\"Imagen\">";
            textoMensaje += "Estimado/a, " + nombre + "<br><br> Su registro se ha realizado correctamente en nuestro sistema.<br><br>";
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

    public static void agregarSolicitud(int idUsuario, int idTipoSolicitud, Date fecha, String descripcion, String archivo, String respuesta, String estado) {
        Conexion conexion = new Conexion();
        Connection conn = conexion.establecerConexion();
        PreparedStatement pstmt = null;
        try {

            String sql = "INSERT INTO solicitud(idUsuario, idTipoSolicitud, fecha, descripcion, archivo, respuesta, estado)"
                    + "VALUES (?, ?, ?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);

            // Establecer parámetros del procedimiento almacenado
            pstmt.setInt(1, idUsuario);
            pstmt.setInt(2, idTipoSolicitud);
            pstmt.setDate(3, fecha);
            pstmt.setString(4, descripcion);
            pstmt.setString(5, archivo);
            pstmt.setString(6, respuesta);
            pstmt.setString(7, estado);

            pstmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
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

    public static void editarSolicitud(int p_idSolicitud, int p_idTipoSolicitud, String p_descripcion, String p_archivo) {
        PreparedStatement pstmt = null;
        Conexion conexion = new Conexion();
        Connection conn = conexion.establecerConexion();
        try {
            System.out.println("Entre a la edición");
            String sql = "UPDATE solicitud SET idTipoSolicitud =?, descripcion =?, archivo =? WHERE idSolicitud =?";
            pstmt = conn.prepareStatement(sql);

            pstmt.setInt(1, p_idTipoSolicitud);
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

    public static void responderSolicitud(int idSolicitud, String respuesta, String tipoSolicitud, String nombre, String apellido, String correo, Date fecha, String descripcion, String estado) {
        Conexion conexion = new Conexion();
        Connection conn = conexion.establecerConexion();
        PreparedStatement pstmt = null;

        try {
            String sql = "UPDATE solicitud SET respuesta = ?, estado = ? WHERE idSolicitud = ?";
            pstmt = conn.prepareStatement(sql);

            pstmt.setString(1, respuesta);
            pstmt.setString(2, estado);
            pstmt.setInt(3, idSolicitud);

            pstmt.executeUpdate();

            enviarCorreoSolicitudRespondida(tipoSolicitud, nombre, apellido, correo, fecha, descripcion, respuesta, estado);

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if (pstmt != null) {
                try {
                    pstmt.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    public static void enviarCorreoSolicitudRespondida(String tipoSolicitud, String nombre, String apellido, String correo, Date fecha, String descripcion, String respuesta, String estado) {
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
            message.setSubject("Su " + tipoSolicitud + " ha sido respondida");

            // Construir el texto del mensaje con los datos del formulario
            String textoMensaje = "Estimado/a, " + nombre + "" + apellido + "<br><br> Su solicitud ha sido respondida por nuestro equipo de servicio al cliente, le agradecemos por tomarse el tiempo de escribirnos, esperamos que esta respesta resuelva du solcicitud.<br><br>";
            textoMensaje += "<h2>Detalles deL registro:</h2>\n";
            textoMensaje += "<p><strong>Nombre:</strong> " + nombre + "</p>\n";
            textoMensaje += "<p><strong>Apellido:</strong> " + apellido + "</p>\n";
            textoMensaje += "<p><strong>Fecha en la que se realizo la solicitud:</strong> " + fecha + "</p>\n";
            textoMensaje += "<p><strong>Descripción:</strong> " + descripcion + "</p>\n";
            textoMensaje += "<p><strong>Estado de la solicitud:</strong> " + estado + "</p>\n";

            textoMensaje += "<p><strong>Respuesta a la solicitud:</strong> " + respuesta + "</p>\n";

            textoMensaje += "<br><p>Atentamente, el equipo de atención al cliente.</p>\n";
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
