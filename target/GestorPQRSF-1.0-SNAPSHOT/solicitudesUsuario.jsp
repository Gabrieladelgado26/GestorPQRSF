<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
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
        <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-K2y4n6Oz6LIC7eD5KBUf+RmJsHi3q4E0YIy9/f3Xf0s=" crossorigin="anonymous"></script>

    </head>

    <body>

        <%@include file= "templates/navbarUsuario.jsp" %>

        <!-- Page Header Start -->
        <div class="container-fluid bg-primary py-2">
            <div class="container py-3">
                <div class="row align-items-center py-4">
                    <div class="col-md-6 text-center text-md-left">
                        <h1 class="mb-4 mb-md-0 text-primary text-uppercase">Tus solicitudes</h1>
                    </div>
                    <div class="col-md-6 text-center text-md-right">
                        <div class="d-inline-flex align-items-center">
                            <a class="btn btn-agr" href="AgregarSolicitud.jsp">Agregar solicitud</a>
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
                        <h6 class="text-primary font-weight-normal text-uppercase mb-3">Revisa las solicitudes que has realizado hasta el momento</h6>
                        <h1 class="mb-4">Solicitudes</h1>
                    </div>
                </div>
                <div class="row pb-3 justify-content-center">
                    <%                        String idUsuarioStr = (String) session.getAttribute("idUsuario");
                        int idUsuario = (idUsuarioStr != null) ? Integer.parseInt(idUsuarioStr) : 0;
                        Conexion conexion = new Conexion();
                        Connection conn = conexion.establecerConexion();
                        PreparedStatement pstmt = null;
                        ResultSet rs = null;
                        String sqlu = "SELECT COUNT(*) AS numSolicitudes FROM solicitud WHERE idUsuario = ?";
                        pstmt = conn.prepareStatement(sqlu);
                        pstmt.setInt(1, idUsuario);
                        rs = pstmt.executeQuery();
                        rs.next();
                        int numSolicitudes = rs.getInt("numSolicitudes");

                        if (numSolicitudes == 0) { %>
                    <br>
                    <div class="no-tutorials d-flex justify-content-center">Aún no has registrado ninguna solicitud</div>
                    <br>


                    <% } else {
                        try {
                            String sql = "SELECT idSolicitud, tipoSolicitud, fecha, descripcion, archivo, respuesta, estado "
                                    + "FROM solicitud "
                                    + "INNER JOIN tipoSolicitud ON solicitud.idTipoSolicitud = tipoSolicitud.idTipoSolicitud "
                                    + "WHERE idUsuario = ? ORDER BY fecha DESC";

                            pstmt = conn.prepareStatement(sql);
                            pstmt.setInt(1, idUsuario);
                            rs = pstmt.executeQuery();

                            // Iterate through the result set and display each inquiry in the table
                            while (rs.next()) {
                                String idSolicitud = rs.getString("idSolicitud");
                                String tipoSolicitud = rs.getString("tipoSolicitud");
                                String fecha = rs.getString("fecha");
                                String descripcion = rs.getString("descripcion");
                                String archivo = rs.getString("archivo");
                                String respuesta = rs.getString("respuesta");
                                String estado = rs.getString("estado");
                    %>
                    <div class="col-md-4 mb-4">
                        <div class="card border-0 mb-2">
                            <div class="card-body bg-white p-4">
                                <div class="d-flex align-items-center mb-3">
                                    <a class="btn btn-pri" href=""><i class="fa fa-link"></i></a>
                                    <h4 class="m-0 ml-3 text-truncate"><%= tipoSolicitud%></h4>
                                </div>
                                <p><%= descripcion%></p>
                                <div class="">
                                    <div class="mr-6" style="margin-bottom: 10px"><i class="fa fa-folder text-primary"></i>  Archivo: <%= archivo%></div>
                                    <div class="mr-6"><i class="fa fa-comments text-primary" style="margin-bottom: 10px"></i>  Fecha: <%= fecha%></div>
                                    <div class="mr-6"><i class="fa fa-check-circle text-primary"></i>  Estado: <%= estado%></div>
                                    <div class="mr-6"><i class="fa fa-reply text-primary"></i>  Respuesta: <%= respuesta%></div>
                                </div>
                                <div class="d-flex justify-content-center">
                                    <a href="#" id="btnVisualizar" style="margin-top: 20px; margin-right: 5px;" class="btn btn-sm btn-outline-primary" data-bs-toggle="modal" data-bs-target="#visualizar" data-nombre=" <%= idSolicitud%>"><i class="fas fa-eye"></i></a>
                                    <a href="#" style="margin-top: 20px; margin-right: 5px;" class="btn btn-sm btn-outline-success" data-bs-toggle="modal" data-bs-target="#editar" title="Editar"
                                       data-idsolicitud="<%= idSolicitud%>"
                                       data-tipoSolicitud="<%= tipoSolicitud%>"
                                       data-descripcion="<%= descripcion%>"
                                       data-rutaarchivo="<%= archivo%>">
                                        <i class="fas fa-edit"></i> 
                                    </a>
                                    <a href="#" style="margin-top: 20px;" class="btn btn-sm btn-outline-danger" data-bs-toggle="modal" data-bs-target="#eliminar" onclick="setearIdSolicitud(<%= idSolicitud%>);"><i class="fas fa-trash"></i></a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%
                                }
                            } catch (SQLException e) {
                                e.printStackTrace();
                            } finally {
                                // Close the connection and resources
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
                        }%>
                </div>
                <div class="col-md-12 mb-4">
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


        <div class="modal fade" id="editar" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="editarLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered custom-modal-size">
                <div class="modal-content">
                    <div class="popup">
                        <div class="modal-header">
                            <h4 class="modal-title" id="editarLabel">Editar solicitud</h4>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <form action="SvEditar" method="POST" id="editForm" enctype="multipart/form-data">
                                <div class="mb-3" hidden>
                                    <label for="idSolicitud" class="col-form-label">ID Solicitud:</label>
                                    <input type="text" class="form-control" id="idSolicitud" name="idSolicitud" value="<%= request.getParameter("idSolicitud")%>" placeholder="ID de la solicitud" readonly required>
                                </div>
                                <div class="mb-3">
                                    <label for="tipoSolicitud" class="col-form-label">Tipo de Solicitud:</label>
                                    <select type="text" class="form-control" id="tipoSolicitud" name="tipoSolicitud" required="required" data-validation-required-message="Porfavor ingrese el tipo de solicitud a realizar">
                                        <option value="" selected disabled>Seleccione el tipo de solicitud</option>
                                        <%
                                            try {
                                                conn = conexion.establecerConexion();
                                                String sql = "SELECT idTipoSolicitud, tipoSolicitud FROM tipoSolicitud";
                                                pstmt = conn.prepareStatement(sql);
                                                rs = pstmt.executeQuery();

                                                while (rs.next()) {
                                                    int idTipoSolicitud = rs.getInt("idTipoSolicitud");
                                                    String nombre = rs.getString("tipoSolicitud");
                                        %>
                                        <option value="<%= idTipoSolicitud%>"><%= nombre%></option>
                                        <%
                                                }
                                            } catch (SQLException e) {
                                                e.printStackTrace();
                                            } finally {
                                                // Cierra la conexión y los recursos
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
                                        %>
                                    </select>
                                </div>
                                <div class="mb-3">
                                    <label for="descripcion" class="col-form-label">Descripcion: </label>
                                    <textarea class="form-control" id="descripcion" name="descripcion" rows="3" required></textarea>
                                </div>
                                <input type="hidden" class="form-control" id="rutaArchivoAnterior" name="rutaArchivoAnterior" value="<%= request.getParameter("rutaarchivo")%>" readonly required>
                                <div class="mb-3">
                                    <label for="archivo" class="col-form-label">Archivo:</label>
                                    <input type="text" class="form-control" id="archivo_nombre" readonly>
                                    <input type="file" class="form-control" id="archivo" name="archivo">
                                    <small class="text-muted">Si desea cambiar el archivo, seleccione uno nuevo.</small>
                                </div>
                                <hr>
                                <div class="row">
                                    <div class="col">
                                        <div class="form-element d-flex justify-content-center">
                                            <button type="submit" class="btn btn-primary" style="margin-bottom: 10px">Guardar cambios</button>
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
            $(document).ready(function () {
                $('#editar').on('show.bs.modal', function (event) {
                    var button = $(event.relatedTarget);
                    var idSolicitud = button.data('idsolicitud');
                    var tipoSolicitud = button.data('tiposolicitud');
                    var descripcion = button.data('descripcion');
                    var rutaArchivo = button.data('rutaarchivo');

                    var modal = $(this);
                    modal.find('.modal-body #idSolicitud').val(idSolicitud);
                    modal.find('.modal-body #tipoSolicitud').val(tipoSolicitud);
                    modal.find('.modal-body #descripcion').val(descripcion);
                    modal.find('.modal-body #archivo_nombre').val(rutaArchivo);
                    modal.find('#tipoSolicitud option').each(function () {
                        if ($(this).text() === tipoSolicitud) {
                            $(this).prop('selected', true);
                        }
                    });
                });
            });
        </script>

        <div class="modal fade" id="eliminar" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="eliminarLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="popup">
                        <div class="modal-header">
                            <h4 class="modal-title" id="exampleModalLabel">Eliminar solicitud</h4>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="form">
                            <br><p class="text-center">¿Estas seguro que quieres eliminar esta solicitud?</p>
                            <div class="form-element justify-content-center" style="display: flex; justify-content: space-between;">
                                <form id="eliminarSolicitudForm" action="SvEliminar" method="POST">
                                    <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal" style="margin-right: 6px; margin-bottom: 15px">Cancelar</button>
                                    <input type="hidden" id="idSolicitudEliminar" name="idSolicitud">
                                    <button type="submit" class="btn btn-danger btn-sm" style="margin-bottom: 15px">Eliminar</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script>
            function setearIdSolicitud(idSolicitud) {
                document.getElementById("idSolicitudEliminar").value = idSolicitud;
            }
        </script>

        <script>

            $('#editar').on('show.bs.modal', function (event) {
                var button = $(event.relatedTarget);
                var idSolicitud = button.data('idsolicitud');
                var tipoSolicitud = button.data('idtiposolicitud');
                var descripcion = button.data('descripcion');
                var archivo = button.data('rutaarchivo');

                // Establecer valores en los campos del formulario
                var modal = $(this);
                modal.find('#idSolicitud').val(idSolicitud);
                modal.find('#descripcion').val(descripcion);
                modal.find('#archivo_nombre').val(archivo);
                modal.find('#idSolicitud').val(idSolicitud);

                // Establecer el tipo de solicitud actual como seleccionado
                modal.find('#tipoSolicitud option').each(function () {
                    if ($(this).text() === tipoSolicitud) {
                        $(this).prop('selected', true);
                    }
                });
            });
        </script>

        <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-K2y4n6Oz6LIC7eD5KBUf+RmJsHi3q4E0YIy9/f3Xf0s=" crossorigin="anonymous"></script>

        <!-- Inclución de la plantilla footer -->
        <%@include file= "templates/footer.jsp" %>