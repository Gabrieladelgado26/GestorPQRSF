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
                        <h1 class="mb-4 mb-md-0 text-primary text-uppercase">Todos los usuarios</h1>
                    </div>
                    <div class="col-md-6 text-center text-md-right">
                        <div class="d-inline-flex align-items-center">
                            <a class="btn btn-agr" href="solicitudesAdministrador.jsp">Regresar</a>
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
                        <h6 class="text-primary font-weight-normal text-uppercase mb-3">Administra todos los usuarios que se han registrado en el sistema hasta el momento</h6>
                        <h1 class="mb-4">Usuarios</h1>
                    </div>
                </div>
                <div class="row pb-3 justify-content-center">
                    <%                        Conexion conexion = new Conexion();
                        Connection conn = conexion.establecerConexion();
                        PreparedStatement pstmt = null;
                        ResultSet rs = null;
                    %>    
                    <table class="table" style="margin-bottom: 50px">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Nombre</th>
                                <th>Apellido</th>
                                <th>Cédula</th>
                                <th>Telefono</th>
                                <th>Correo</th>
                                <th>Rol</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                try {

                                    String sql = "SELECT u.idUsuario, u.nombre AS NombreUsuario, u.apellido, u.cedula, u.telefono, u.correo, u.rol "
                                            + "FROM usuarios u";

                                    pstmt = conn.prepareStatement(sql);
                                    rs = pstmt.executeQuery();

                                    while (rs.next()) {
                                        String idUsuario = rs.getString("idUsuario");
                                        String nombreUsuario = rs.getString("NombreUsuario");
                                        String apellido = rs.getString("apellido");
                                        String cedula = rs.getString("cedula");
                                        String telefono = rs.getString("telefono");
                                        String correo = rs.getString("correo");
                                        String rol = rs.getString("rol");
                            %>
                            <tr>
                                <td><%= idUsuario%></td>
                                <td><%= nombreUsuario%></td>
                                <td><%= apellido%></td>
                                <td><%= cedula%></td>
                                <td><%= telefono%></td>
                                <td><%= correo%></td>
                                <td><%= rol%></td>
                                <td>
                                    <div class="acciones  d-flex text-center justify-content-centered">
                                        <a href="#" style="margin-right: 5px;" class="btn btn-sm btn-outline-success" data-bs-toggle="modal" data-bs-target="#editar" title="Editar">
                                            <i class="fas fa-edit"></i> 
                                        </a>
                                        <%
                                            String rolUsuario = rol;
                                            boolean esUsuarioNormal = rolUsuario.equals("Usuario");
                                            if (esUsuarioNormal) {%>
                                        <!-- Mostrar el botón de eliminar solo si el usuario es un usuario normal -->
                                        <a href="#" class="btn btn-sm btn-outline-danger" data-bs-toggle="modal" data-bs-target="#eliminar" onclick="setearIdSolicitud(<%= idUsuario%>);"><i class="fas fa-trash"></i></a>
                                            <% } %>
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

        <div class="modal fade" id="eliminar" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="eliminarLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="popup">
                        <div class="modal-header">
                            <h4 class="modal-title" id="exampleModalLabel">Eliminar usuario</h4>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="form">
                            <br><p class="text-center">¿Estas seguro que quieres eliminar a este usuario?</p>
                            <div class="form-element justify-content-center" style="display: flex; justify-content: space-between;">
                                <form id="eliminarUsuarioForm" action="SvEliminar" method="GET">
                                    <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal" style="margin-right: 6px; margin-bottom: 15px">Cancelar</button>
                                    <input type="hidden" id="idUsuarioEliminar" name="idUsuario">
                                    <button type="submit" class="btn btn-danger btn-sm" style="margin-bottom: 15px">Eliminar</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script>
            function setearIdSolicitud(idUsuario) {
                document.getElementById("idUsuarioEliminar").value = idUsuario;
            }
        </script>

        <!-- Inclución de la plantilla footer -->
        <%@include file= "templates/footer.jsp" %>