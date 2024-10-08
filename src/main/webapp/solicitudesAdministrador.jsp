<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.mycompany.mundo.Solicitud"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.mycompany.mundo.Metodos"%>
<%@page import="com.mycompany.mundo.Conexion"%>

<!-- Template o plantilla Header que contiene las etiquetas iniciales de las clases jsp -->

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <title>Sistema PQRSF</title>
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <meta content="Free HTML Templates" name="keywords">
        <meta content="Free HTML Templates" name="description">

        <!-- Google Web Fonts -->
        <link href="https://fonts.googleapis.com/css2?family=Montserrat&family=Oswald:wght@400;500;600&display=swap" rel="stylesheet"> 

        <!-- Font Awesome -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">

        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

        <!-- Bootstrap JS and dependencies -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>

        <!-- jQuery -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

        <!-- Flaticon Font -->
        <link href="lib/flaticon/font/flaticon.css" rel="stylesheet">

        <!-- Libraries Stylesheet -->
        <link href="lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
        <link href="lib/lightbox/css/lightbox.min.css" rel="stylesheet">

        <!-- Customized Bootstrap Stylesheet -->
        <link href="css/style.css" rel="stylesheet">

        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    </head>

    <body>

        <%@include file= "templates/navbarAdministrador.jsp" %>

        <!-- Page Header Start -->
        <div class="container-fluid bg-primary py-2">
            <div class="container py-3">
                <div class="row align-items-center py-4">
                    <div class="col-md-6 text-center text-md-left">
                        <h1 class="mb-4 mb-md-0 text-primary text-uppercase">Todas las solicitudes</h1>
                    </div>
                    <div class="col-md-6 text-center text-md-right">
                        <div class="d-inline-flex align-items-center">
                            <a class="btn btn-agr" href="administrarUsuarios.jsp">Administrar usuarios</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Page Header Start -->

        <!-- Blog Start -->
        <div class="container-fluid bg-light pt-5">
            <div class="container py-4">
                <div class="row justify-content-center">
                    <div class="col-lg-6 col-md-8 col text-center mb-4">
                        <h6 class="text-primary font-weight-normal text-uppercase mb-3">Revisa todas las solicitudes que se han realizado hasta el momento</h6>
                        <h1 class="mb-4">Solicitudes</h1>
                    </div>
                </div>
                <div class="row pb-3 justify-content-center">
                    <%                        Conexion conexion = new Conexion();
                        Metodos metodos = new Metodos();
                        Connection conn = conexion.establecerConexion();
                        PreparedStatement pstmt = null;
                        ResultSet rs = null;
                        List<Solicitud> solicitudes = new ArrayList<>();
                        solicitudes = metodos.obtenerSolicitudes(conn);

                        if (solicitudes.isEmpty()) {
                    %>
                    <br><div class="no-tutorials d-flex justify-content-center">No hay solicitudes registradas</div></br>
                    <%
                    } else {
                    %>
                    <table class="table" style="margin-bottom: 50px">
                        <center>
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Fecha</th>
                                    <th>Nombre usuario</th>
                                    <th>Tipo de Solicitud</th>
                                    <th>Descripci�n</th>
                                    <th>Archivo</th>
                                    <th>Respuesta</th>
                                    <th>Estado</th>
                                    <th>Acciones</th>
                                </tr>
                            </thead>
                        </center>
                        <tbody>
                            <%
                                try {

                                    String sql = "SELECT s.idSolicitud, u.nombre, u.apellido, u.correo, ts.tipoSolicitud, s.fecha, s.descripcion, s.archivo, s.respuesta, s.estado "
                                            + "FROM solicitud s INNER JOIN usuarios u ON s.idUsuario = u.idUsuario INNER JOIN tipoSolicitud ts ON s.idTipoSolicitud = ts.idTipoSolicitud";

                                    pstmt = conn.prepareStatement(sql);
                                    rs = pstmt.executeQuery();

                                    while (rs.next()) {
                                        String idSolicitud = rs.getString("idSolicitud");
                                        String nombre = rs.getString("nombre");
                                        String apellido = rs.getString("apellido");
                                        String correo = rs.getString("correo");
                                        String tipoSolicitud = rs.getString("tipoSolicitud");
                                        String fecha = rs.getString("fecha");
                                        String descripcion = rs.getString("descripcion");
                                        String archivo = rs.getString("archivo");
                                        String respuesta = rs.getString("respuesta");
                                        String estado = rs.getString("estado");
                            %>
                            <tr>
                                <td><%= idSolicitud%></td>
                                <td><%= fecha%></td>
                                <td><%= nombre%></td>
                                <td><%= tipoSolicitud%></td>
                                <td><%= descripcion%></td>
                                <td><% if (archivo != null) {%>
                                    <a href="archivos/<%= archivo%>" target="_blank" class="btn btn-primary">
                                        <i class="fas fa-file-download"></i>Abrir
                                    </a>
                                    <% } else { %>
                                    <!-- Bot�n deshabilitado si archivo es null -->
                                    <button class="btn btn-primary" disabled>
                                        <i class="fas fa-file-download"></i>Sin PDF
                                    </button>
                                    <% }%>
                                </td>
                                <td><%= respuesta%></td>
                                <td><%= estado%></td>
                                <td>
                                    <!-- Acci�n con icono de bootstrap -->
                                    <div class="acciones text-center justify-content-centered">
                                        <a href="#" id="btnVisualizar" class="btn btn-sm btn-outline-primary" data-bs-toggle="modal" data-bs-target="#visualizar" data-nombre=" <%= idSolicitud%>"><i class="fas fa-eye"></i></a>
                                        <a href="#" class="btn btn-sm btn-outline-success" data-bs-toggle="modal" data-bs-target="#responder" 
                                           data-idsolicitud="<%= idSolicitud%>"
                                           data-tipoSolicitud="<%= tipoSolicitud%>"
                                           data-nombre="<%= nombre%>"
                                           data-apellido="<%= apellido%>"
                                           data-correo="<%= correo%>"
                                           data-fecha="<%= fecha%>"
                                           data-descripcion="<%= descripcion%>">
                                            <i class="fas fa-reply fa-sm"></i></a>
                                    </div>
                                </td>
                            </tr>
                            <%
                                        }
                                    } catch (SQLException e) {
                                        e.printStackTrace();
                                    } finally {
                                        try {
                                            if (rs != null) {
                                                rs.close();
                                            }
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
                            %>
                        </tbody>
                    </table>
                    <br><div class="col-md-12 mb-4">
                        <nav aria-label="Page navigation">
                            <ul class="pagination justify-content-center mb-0">
                                <li class="page-item disabled">
                                    <a class="page-link" href="#" aria-label="Previous">
                                        <span aria-hidden="true">&laquo;</span>
                                        <span class="sr-only">Previous</span>
                                    </a>
                                </li>
                                <li class="page-item active"><a class="page-link" href="#">1</a></li>
                                <li class="page-item"><a class="page-link" href="#">2</a></li>
                                <li class="page-item"><a class="page-link" href="#">3</a></li>
                                <li class="page-item">
                                    <a class="page-link" href="#" aria-label="Next">
                                        <span aria-hidden="true">&raquo;</span>
                                        <span class="sr-only">Next</span>
                                    </a>
                                </li>
                            </ul>
                        </nav>
                    </div>
                </div>
            </div>
        </div>
        <!-- Blog End -->

        <!-- Footer Start -->
        <div class="container-fluid bg-dark text-white py-4 px-sm-3 px-md-5">
            <p class="m-0 text-center text-white">
                &copy; <a class="text-white font-weight-bold" href="#">Your Site Name</a>. All Rights Reserved. Designed by
                <a class="text-white font-weight-bold" href="https://htmlcodex.com">HTML Codex</a>
            </p>
        </div>
        <!-- Footer End -->

        <!-- Back to Top -->
        <a href="#" class="btn btn-lg btn-primary back-to-top"><i class="fa fa-angle-double-up"></i></a>


        <!-------------------------------------------- Ventanas modales ---------------------------------------------->


        <div class="modal fade" id="visualizar" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Detalles de la solicitud</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div id="solicitudDetails"></div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                    </div>
                </div>
            </div>
        </div>


        <div class="modal fade" id="responder" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="editarLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered custom-modal-size">
                <div class="modal-content">
                    <div class="popup">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLabel">Responder solicitud</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <form action="SvRespuesta" method="POST">
                                <div class="mb-3">
                                    <label for="respuesta" class="form-label">Responde a la solicitud:</label>
                                    <textarea class="form-control" id="respuesta" name="respuesta" rows="3" required></textarea>
                                </div>
                                <input type="hidden" id="idSolicitud" name="idSolicitud">
                                <input type="hidden" id="tipoSolicitud" name="tipoSolicitud">
                                <input type="hidden" id="nombre" name="nombre">
                                <input type="hidden" id="apellido" name="apellido">
                                <input type="hidden" id="correo" name="correo">
                                <input type="hidden" id="fecha" name="fecha">
                                <input type="hidden" id="descripcion" name="descripcion">
                                <div class="row">
                                    <div class="col">
                                        <div class="form-element d-flex justify-content-center">
                                            <button type="submit" class="btn btn-secondary" style="margin-bottom: 10px">Enviar respuesta</button>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script>
            $('.acciones .btn-outline-success').click(function () {
                // Obtener los datos de la solicitud seleccionada
                var idSolicitud = $(this).data('idsolicitud');
                var tipoSolicitud = $(this).data('tiposolicitud');
                var nombre = $(this).data('nombre');
                var apellido = $(this).data('apellido');
                var correo = $(this).data('correo');
                var fecha = $(this).data('fecha');
                var descripcion = $(this).data('descripcion');

                $('#idSolicitud').val(idSolicitud);
                $('#tipoSolicitud').val(tipoSolicitud);
                $('#nombre').val(nombre);
                $('#apellido').val(apellido);
                $('#correo').val(correo);
                $('#fecha').val(fecha);
                $('#descripcion').val(descripcion);
                
                $('#responder').modal('show');
            });
        </script>

        <!-- Incluci�n de la plantilla footer -->
        <%@include file= "templates/footer.jsp" %>