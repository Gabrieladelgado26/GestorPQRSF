<%@page import="com.mycompany.mundo.Metodos"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.mycompany.mundo.TipoSolicitud"%>
<%@page import="com.mycompany.mundo.Conexion"%>
<%@page import="java.sql.Connection"%>

<!-- Inclución de la plantilla header -->
<%@include file= "templates/header.jsp" %>

<body>

    <%@include file= "templates/navbarUsuario.jsp" %>

    <!-- Contact Start -->
    <div class="container-fluid bg-white">
        <div class="container">
            <div class="row">
                <div class="text-primary col-lg-5">
                    <div class="d-flex flex-column justify-content-center bg-primary h-100 p-5">
                        <div class="d-inline-flex border border-secondary p-4 mb-4">
                            <h1 class="flaticon-office font-weight-normal text-primary m-0 mr-3"></h1>
                            <div class="d-flex flex-column">
                                <h5 class="text-primary">Nuestra oficina</h5>
                                <p class="m-0 text-primary">Calle 19 # 43</p>
                            </div>
                        </div>
                        <div class="d-inline-flex border border-secondary p-4 mb-4">
                            <h1 class="flaticon-email font-weight-normal text-primary m-0 mr-3"></h1>
                            <div class="d-flex flex-column">
                                <h5 class="text-primary">Nuestro Email</h5>
                                <p class="m-0 text-primary">iManager@gmail.com</p>
                            </div>
                        </div>
                        <div class="d-inline-flex border border-secondary p-4">
                            <h1 class="flaticon-telephone font-weight-normal text-primary m-0 mr-3"></h1>
                            <div class="d-flex flex-column">
                                <h5 class="text-primary">Atención al cliente</h5>
                                <p class="m-0 text-primary">+012 345 6789</p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-7 mb-5 my-lg-5 py-5 pl-lg-5">
                    <div class="contact-form">
                        <div id="success"></div>
                        <form action="SvAgregarSolicitud" method="post">
                            <div class="control-group">
                                <select type="text" class="form-control" id="tipoSolicitud" name="tipoSolicitud" required="required" data-validation-required-message="Porfavor ingrese el tipo de solicitud a realizar">
                                    <option value="" disabled selected>Seleccione el tipo de solicitud</option>
                                    <%
                                        Metodos metodos = new Metodos();
                                        Conexion solicitud = new Conexion();
                                        Connection conn = solicitud.establecerConexion();
                                        List<TipoSolicitud> tipoSolicitud = new ArrayList<>();
                                        tipoSolicitud = metodos.obtenerTipoSolicitud(conn);
                                        String htmls = metodos.generarHTMLTipoSolicitud(tipoSolicitud);
                                        // Imprimir el contenido HTML
                                        out.println(htmls);
                                    %>
                                </select>
                                <p class="help-block text-danger"></p>
                            </div>
                            <div class="control-group">
                                <input type="date" class="form-control p-4" id="fecha" placeholder="Fecha" required="required" data-validation-required-message="Porfavor ingrese la fecha actual" />
                                <p class="help-block text-danger"></p>
                            </div>
                            <div class="control-group">
                                <textarea class="form-control p-4" rows="6" id="descripcion" placeholder="Message" data-validation-required-message="Please enter your message"></textarea>
                                <p class="help-block text-danger"></p>
                            </div>
                            <div class="control-group">
                                <input type="file" class="form-control p-4" id="archivo" accept="application/pdf" data-validation-required-message="Por favor seleccione un archivo PDF" />
                                <p class="help-block text-danger"></p>
                            </div>
                            <div>
                                <button class="btn btn-pri py-2 px-4" type="submit" id="sendMessageButton" style="margin-top: 10px">Enviar solicitud</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Contact End -->

    <!-- Footer Start -->
    <div class="container-fluid bg-dark text-white py-5 px-sm-3 px-md-5">
        <p class="m-0 text-center text-white">
            &copy; <a class="text-white font-weight-bold" href="#">Your Site Name</a>. All Rights Reserved. Designed by
            <a class="text-white font-weight-bold" href="https://htmlcodex.com">HTML Codex</a>
        </p>
    </div>
    <!-- Footer End -->

    <!-- Back to Top -->
    <a href="#" class="btn btn-lg btn-pri back-to-top"><i class="fa fa-angle-double-up"></i></a>

    <!-- JavaScript Libraries -->
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.bundle.min.js"></script>
    <script src="lib/easing/easing.min.js"></script>
    <script src="lib/owlcarousel/owl.carousel.min.js"></script>
    <script src="lib/isotope/isotope.pkgd.min.js"></script>
    <script src="lib/lightbox/js/lightbox.min.js"></script>

    <!-- Contact Javascript File -->
    <script src="mail/jqBootstrapValidation.min.js"></script>
    <script src="mail/contact.js"></script>

    <!-- Template Javascript -->
    <script src="js/main.js"></script>

    <script>
        // Obtener los elementos del DOM
        var mensajeTextarea = document.getElementById('message');
        var archivoInput = document.getElementById('archivo');
        var enviarButton = document.getElementById('sendMessageButton');

        // Función para verificar si un campo está lleno o vacío
        function campoLleno(campo) {
            return campo.value.trim() !== '';
        }

        // Función para validar campos
        function validarCampos() {
            // Si el mensaje está lleno, deshabilitar la validación requerida para el archivo
            if (campoLleno(mensajeTextarea)) {
                archivoInput.removeAttribute('required');
            } else {
                archivoInput.setAttribute('required', 'required');
            }
            // Si el archivo está lleno, deshabilitar la validación requerida para el mensaje
            if (campoLleno(archivoInput)) {
                mensajeTextarea.removeAttribute('required');
            } else {
                mensajeTextarea.setAttribute('required', 'required');
            }
        }

        // Llamar a la función validarCampos() cuando haya cambios en los campos
        mensajeTextarea.addEventListener('input', validarCampos);
        archivoInput.addEventListener('change', validarCampos);
    </script>

    <!-- Inclución de la plantilla footer -->
    <%@include file= "templates/footer.jsp" %>