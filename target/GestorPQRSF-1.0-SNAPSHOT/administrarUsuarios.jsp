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
        <link href="https://fonts.googleapis.com/css2?family=Montserrat&family=Oswald:wght@400;500;600&display=swap" rel="stylesheet"> 
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <link href="lib/flaticon/font/flaticon.css" rel="stylesheet">
        <link href="lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
        <link href="lib/lightbox/css/lightbox.min.css" rel="stylesheet">
        <link href="css/style.css" rel="stylesheet">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
    </head>

    <body>

        <%@include file= "templates/navbarAdministrador.jsp" %>

        <%
            String toastr = (String) session.getAttribute("toastr");

            // En caso de que se registre exitosamente
            if (toastr != null && toastr.equals("usuarioEditado")) {
        %>
        <!-- Llama a un método de JavaScript para mostrar una modal de registro exitoso -->
        <script>
            $(document).ready(function () {
                usuarioEditado();
            });
        </script>
        <% } session.removeAttribute("toastr");%>
        
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

                                    String sql = "SELECT u.idUsuario, u.nombre, u.apellido, u.cedula, u.telefono, u.correo, u.rol "
                                            + "FROM usuarios u";

                                    pstmt = conn.prepareStatement(sql);
                                    rs = pstmt.executeQuery();

                                    while (rs.next()) {
                                        String idusuario = rs.getString("idUsuario");
                                        String nombre = rs.getString("nombre");
                                        String apellido = rs.getString("apellido");
                                        String cedula = rs.getString("cedula");
                                        String telefono = rs.getString("telefono");
                                        String correo = rs.getString("correo");
                                        String rol = rs.getString("rol");
                            %>
                            <tr>
                                <td><%= idusuario%></td>
                                <td><%= nombre%></td>
                                <td><%= apellido%></td>
                                <td><%= cedula%></td>
                                <td><%= telefono%></td>
                                <td><%= correo%></td>
                                <td><%= rol%></td>
                                <td>
                                    <div class="acciones  d-flex text-center justify-content-centered">
                                        <a href="#" style="margin-right: 5px;" class="btn btn-sm btn-outline-success" data-bs-toggle="modal" data-bs-target="#editar" title="Editar"
                                           data-idusuario="<%= idusuario%>"
                                           data-nombre="<%= nombre%>"
                                           data-apellido="<%= apellido%>"
                                           data-cedula="<%= cedula%>"
                                           data-telefono="<%= telefono%>"
                                           data-correo="<%= correo%>"
                                           data-rol="<%= rol%>">
                                            <i class="fas fa-edit"></i> 
                                        </a>
                                        <%
                                            String rolU = rol;
                                            boolean esUsuarioNormal = rolU.equals("Usuario");
                                            if (esUsuarioNormal) {%>
                                        <!-- Mostrar el botón de eliminar solo si el usuario es un usuario normal -->
                                        <a href="#" class="btn btn-sm btn-outline-danger" data-bs-toggle="modal" data-bs-target="#eliminar" onclick="setearIdUsuario(<%= idusuario%>);"><i class="fas fa-trash"></i></a>
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
            function setearIdUsuario(idUsuario) {
                document.getElementById("idUsuarioEliminar").value = idUsuario;
            }
        </script>

        <div class="modal fade" id="editar" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="editarLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered custom-modal-size">
                <div class="modal-content">
                    <div class="popup">
                        <div class="modal-header">
                            <h4 class="modal-title" id="editarLabel">Editar usuario</h4>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <form action="SvEditarUsuario" method="POST" id="editForm">
                                <div class="mb-3">
                                    <label for="idusuario" class="col-form-label">ID Usuario:</label>
                                    <input type="text" class="form-control" id="idusuario" name="idusuario" value="<%= request.getParameter("idUsuario")%>" placeholder="ID del usuario" readonly required>
                                </div>
                                <div class="mb-3">
                                    <label for="nombre" class="col-form-label">Nombre del usuario:</label>
                                    <input type="text" class="form-control" id="nombre" name="nombre" placeholder="Nombre del usuario" required>
                                </div>
                                <div class="mb-3">
                                    <label for="apellido" class="col-form-label">Apellido del usuario:</label>
                                    <input type="text" class="form-control" id="apellido" name="apellido" placeholder="Apellido del usuario" required>
                                </div>
                                <div class="mb-3">
                                    <label for="cedula" class="col-form-label">Cédula del usuario:</label>
                                    <input type="text" class="form-control" id="cedula" name="cedula" placeholder="Cédula del usuario" readonly required>
                                </div>
                                <div class="mb-3">
                                    <label for="telefono" class="col-form-label">Teléfono del usuario:</label>
                                    <input type="text" class="form-control" id="telefono" name="telefono" placeholder="Teléfono del usuario" required>
                                </div>
                                <div class="mb-3">
                                    <label for="correo" class="col-form-label">Correo del usuario:</label>
                                    <input type="email" class="form-control" id="correo" name="correo" placeholder="Correo del usuario" required>
                                </div>
                                <div class="mb-3">
                                    <label for="rol" class="col-form-label">Editar rol del usuario:</label>
                                    <select class="form-select" id="rol" name="rol" required>
                                        <option value="" disabled selected>Rol del usuario</option>
                                        <option value="Administrador">Administrador</option>
                                        <option value="Usuario">Usuario</option>
                                    </select>
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
            $('.acciones a.btn-outline-success').click(function () {
                var idUsuario = $(this).data('idusuario');
                var nombre = $(this).data('nombre');
                var apellido = $(this).data('apellido');
                var cedula = $(this).data('cedula');
                var telefono = $(this).data('telefono');
                var correo = $(this).data('correo');
                var rol = $(this).data('rol');

                $('#idusuario').val(idUsuario);
                $('#nombre').val(nombre);
                $('#apellido').val(apellido);
                $('#cedula').val(cedula);
                $('#telefono').val(telefono);
                $('#correo').val(correo);
                $('#rol').val(rol);

                $('#responder').modal('show');
            });
            
            function usuarioEditado() {
                // Configurar opciones Toastr
                toastr.options = {
                    "closeButton": false,
                    "debug": false,
                    "newestOnTop": false,
                    "progressBar": false,
                    "positionClass": "toast-top-center",
                    "preventDuplicates": false,
                    "onclick": null,
                    "showDuration": "300",
                    "hideDuration": "1000",
                    "timeOut": "5000",
                    "extendedTimeOut": "1000",
                    "showEasing": "swing",
                    "hideEasing": "linear",
                    "showMethod": "fadeIn",
                    "hideMethod": "fadeOut"
                };

                // Mostrar una notificación Toastr de éxito
                toastr.success('El usuario se ha editado exitosamente!', 'Editado');
            }
        </script>

        <!-- Inclución de la plantilla footer -->
        <%@include file= "templates/footer.jsp" %>