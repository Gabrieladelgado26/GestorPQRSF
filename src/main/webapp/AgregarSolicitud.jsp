<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
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
                        <div class="d-inline-flex border border-primary p-4 mb-4">
                            <h1 class="flaticon-office font-weight-normal text-primary m-0 mr-3"></h1>
                            <div class="d-flex flex-column">
                                <h5 class="text-primary">Nuestra oficina</h5>
                                <p class="m-0 text-primary">Calle 19 # 43</p>
                            </div>
                        </div>
                        <div class="d-inline-flex border border-primary p-4 mb-4">
                            <h1 class="flaticon-email font-weight-normal text-primary m-0 mr-3"></h1>
                            <div class="d-flex flex-column">
                                <h5 class="text-primary">Nuestro Email</h5>
                                <p class="m-0 text-primary">iManager@gmail.com</p>
                            </div>
                        </div>
                        <div class="d-inline-flex border border-primary p-4">
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
                        <form action="SvAgregarSolicitud" method="post" enctype="multipart/form-data">
                            <!-- Campo oculto para el ID del usuario obtenido de la sesión -->
                            <input type="hidden" name="idUsuario" value="<%= session.getAttribute("idUsuario")%>">
                            <div class="control-group">
                                <select type="text" class="form-control" id="tipoSolicitud" name="tipoSolicitud" required="required" data-validation-required-message="Porfavor ingrese el tipo de solicitud a realizar">
                                    <option value="" selected disabled>Seleccione el tipo de solicitud</option>
                                    <%
                                        Conexion conexion = new Conexion();
                                        Connection conn = conexion.establecerConexion();
                                        PreparedStatement pstmt = null;
                                        ResultSet rs = null;

                                        try {
                                            String sql = "SELECT idTipoSolicitud, tipoSolicitud FROM tipoSolicitud";
                                            pstmt = conn.prepareStatement(sql);
                                            rs = pstmt.executeQuery();

                                            while (rs.next()) {
                                                int idTipoSolicitud = rs.getInt("idTipoSolicitud");
                                                String nombre = rs.getString("tipoSolicitud");
                                    %>
                                    <option value="<%= idTipoSolicitud%>"><%= nombre %></option>
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
                                <p class="help-block text-danger"></p>
                            </div>
                            <div class="control-group">
                                <input type="date" class="form-control p-4" id="fecha" name="fecha" placeholder="Fecha" required="required" data-validation-required-message="Porfavor ingrese la fecha actual" />
                                <p class="help-block text-danger"></p>
                            </div>
                            <div class="control-group">
                                <textarea class="form-control p-4" rows="6" id="descripcion" name="descripcion" placeholder="Message" data-validation-required-message="Please enter your message"></textarea>
                                <p class="help-block text-danger"></p>
                            </div>
                            <div class="control-group" style="display: flex; align-items: center; justify-content: center;">
                                <input type="file" style="height: 50px; display: flex; align-items: center; justify-content: center;" class="form-control p-8" id="archivo" name="archivo" accept="application/pdf" data-validation-required-message="Por favor seleccione un archivo PDF" />
                                <p class="help-block text-danger"></p>
                            </div>

                            <div>
                                <button class="btn btn-primary py-2 px-4" type="submit" id="sendMessageButton" style="margin-top: 10px">Enviar solicitud</button>
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
    <a href="#" class="btn btn-lg btn-primary back-to-top"><i class="fa fa-angle-double-up"></i></a>

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


        // Obtener la fecha actual en formato "yyyy-mm-dd"
        var currentDate = new Date().toISOString().slice(0, 10);
        // Establecer el valor del campo de entrada de fecha
        document.getElementById('fecha').value = currentDate;
    </script>
</script>

<!-- Inclución de la plantilla footer -->
<%@include file= "templates/footer.jsp" %>