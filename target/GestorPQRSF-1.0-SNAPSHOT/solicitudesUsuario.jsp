<%@page import="com.mycompany.mundo.Solicitud"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.mycompany.mundo.Metodos"%>
<%@page import="com.mycompany.mundo.Conexion"%>

<!-- Inclución de la plantilla header -->
<%@include file= "templates/header.jsp" %>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

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
    
    <script>
        $(document).on('click', '#btnVisualizar', function () {
            $.ajax({
                url: 'SvVisualizar?idSolicitud=',
                method: 'POST',
                success: function (data) {
                    $('#solicitudDetails').html(data);
                    $('#visualizar').modal('show'); // Muestra el modal después de obtener los datos
                },
                error: function () {
                    console.log('Error al realizar la solicitud de visualización.');
                }
            });
        });
    </script>
    
    <!-- Inclución de la plantilla footer -->
    <%@include file= "templates/footer.jsp" %>