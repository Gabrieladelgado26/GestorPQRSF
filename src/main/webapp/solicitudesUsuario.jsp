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

        <%@include file= "templates/navbarUsuario.jsp" %>

        <!-- Page Header Start -->
        <div class="container-fluid bg-primary py-2">
            <div class="container py-3">
                <div class="row align-items-center py-4">
                    <div class="col-md-6 text-center text-md-left">
                        <h1 class="mb-4 mb-md-0 text-pri text-uppercase">Tus solicitudes</h1>
                    </div>
                    <div class="col-md-6 text-center text-md-right">
                        <div class="d-inline-flex align-items-center">
                            <a class="btn btn-pri" href="AgregarSolicitud.jsp">Agregar solicitud</a>
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
                    <%
                        Conexion tutorial = new Conexion();
                        Metodos metodos = new Metodos();
                        Connection conn = tutorial.establecerConexion();
                        List<Solicitud> solicitudes = new ArrayList<>();
                        // En caso de que se registre exitosamente

                        solicitudes = metodos.obtenerSolicitudes(conn);

                        String html = metodos.generarHTML(solicitudes);
                        // Imprimir el contenido HTML
                        out.println(html);
                    %>
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
        <a href="#" class="btn btn-lg btn-pri back-to-top"><i class="fa fa-angle-double-up"></i></a>


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

        <form action="SvEditar" method="POST">
            <div class="modal fade" id="editar" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="editarLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered custom-modal-size">
                    <div class="modal-content">
                        <div class="popup">
                            <div class="modal-header">
                                <h5 class="modal-title" id="exampleModalLabel">Editar solicitud</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="form">
                                <!-- Aquí se mostrará la información del tutorial -->
                                <div id="solicitud-edit"></div>
                                <hr>
                                <div class="row">
                                    <div class="col">
                                        <div class="form-element d-flex justify-content-center">
                                            <button type="submit" class="btn btn-secondary" style="margin-bottom: 10px">Editar</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </form>

        <div class="modal fade" id="eliminar" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="eliminarLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="popup">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLabel">Eliminar solicitud</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="form">
                            <p class="text-center">¿Estas seguro que quieres eliminar esta solicitud?</p>
                            <div class="form-element justify-content-center" style="display: flex; justify-content: space-between;">
                                <input type="hidden" id="idSolicitudEliminar" name="idSolicitudEliminar">
                                <button type="button" class="btn btn-secondary" style="margin-bottom: 15px" data-bs-dismiss="modal" style="margin-right: 10px;">Cancelar</button>
                                <a class="btn btn-lg btn-danger" style="margin-left: 10px; margin-bottom: 15px" onclick="eliminar()">Eliminar</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script>
            document.addEventListener("DOMContentLoaded", function () {
                var button = document.getElementById("sort-button");
                var idMostrado = 0;
                button.addEventListener("click", function () {
                    // Realizar una solicitud al servlet
                    $.ajax({
                        url: 'SvOrdenarTutoriales?id=' + idMostrado,
                        method: 'POST',
                        success: function (data) {
                            location.reload(); // Recargar la página después de la eliminación exitosa del usuario
                        },
                        error: function () {
                            console.log('Error al realizar la solicitud de visualización.');
                        }
                    });
                });
            });

            document.getElementById('closeBtn').addEventListener('click', function () {
                location.reload();
            });

            function redirectToUrl(url) {
                window.open(url, '_blank');
            }

            function eliminar() {
                $('#eliminar').modal('hide'); // Ocultar el modal de confirmación de eliminación
                var idEliminado = $('#idSolicitudEliminar').val(); // Obtener la ID de la solicitud desde el campo oculto
                $.ajax({
                    url: 'SvEliminar?id=' + idEliminado, // URL del servlet que maneja la solicitud de eliminación
                    method: 'POST', // Método HTTP utilizado (en este caso, POST)
                    success: function (data) {
                        location.reload(); // Recargar la página después de la eliminación exitosa de la solicitud
                    },
                    error: function () {
                        console.log('Error al realizar la solicitud de eliminación.'); // Registrar un mensaje de error en la consola en caso de error
                    }
                });
            }


            // Función para mostrar el modal de confirmación de eliminación y almacenar el nombre del usuario a eliminar
            var idEliminar;
            function modalEliminar(id) {
                $('#eliminar').modal('show'); // Mostrar el modal de confirmación de eliminación
                idEliminar = id; // Almacenar el nombre del usuario a eliminar
            }

            function eliminar() {
                $('#eliminar').modal('hide'); // Ocultar el modal de confirmación de eliminación
                var idEliminado = idEliminar; // Obtener el nombre del usuario a eliminar
                $.ajax({
                    url: 'SvEliminar?id=' + idEliminado, // URL del servlet que maneja la solicitud de eliminación
                    method: 'POST', // Método HTTP utilizado (en este caso, POST)
                    success: function (data) {
                        location.reload(); // Recargar la página después de la eliminación exitosa del usuario
                    },
                    error: function () {
                        console.log('Error al realizar la solicitud de eliminación.'); // Registrar un mensaje de error en la consola en caso de error
                    }
                });
            }    // Función para eliminar un usuario mediante una solicitud AJAX


            var idMostrar;

            function modalMostrar(id) {
                $('#mostrar').modal('show');
                idMostrar = id;
            }

            function mostrar() {
                $('#mostrar').modal('hide');
                var idMostrado = idMostrar;
                $.ajax({
                    url: 'SvMostrarTutorial?id=' + idMostrado,
                    method: 'POST',
                    success: function (data) {
                        $('#tutorialDetails').html(data);
                    },
                    error: function () {
                        console.log('Error al realizar la solicitud de visualización.');
                    }
                });
            }


            $(document).on('click', '#btnEditar', function () {
                var idMostrado = $(this).attr('data-nombre'); // Obtiene el valor del atributo data-nombre del botón
                $.ajax({
                    url: 'SvMostrarInfoEditarTutorial?idTutorial=' + idMostrado,
                    method: 'POST',
                    success: function (data) {
                        $('#tutorial-edit').html(data);
                        $('#editar').modal('show'); // Muestra el modal después de obtener los datos
                    },
                    error: function () {
                        console.log('Error al realizar la solicitud de visualización.');
                    }
                });
            });

            $(document).on('click', '#btnVisualizar', function () {
                var idMostrado = $(this).attr('data-nombre'); // Obtiene el valor del atributo data-nombre del botón
                $.ajax({
                    url: 'SvVisualizar?idSolicitud=' + idMostrado,
                    method: 'POST',
                    success: function (data) {
                        $('#visualizar').modal('show'); // Muestra el modal después de obtener los datos
                        $('#solicitudDetails').html(data);
                    },
                    error: function () {
                        console.log('Error al realizar la solicitud de visualización.');
                    }
                });
            });
        </script>

        <!-- Inclución de la plantilla footer -->
        <%@include file= "templates/footer.jsp" %>