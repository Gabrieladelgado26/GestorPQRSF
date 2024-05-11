<!doctype html>
<html lang="en">
    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://kit.fontawesome.com/424ce1386e.js" crossorigin="anonymous"></script>
        <link href="https://fonts.googleapis.com/css?family=Roboto:300,400&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="recursos/login/css/owl.carousel.min.css">
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="recursos/login/css/bootstrap.min.css">
        <!-- Style -->
        <link rel="stylesheet" href="recursos/login/css/style.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
        <title>Registro usuario</title>
    </head>

    <body>
        <%
            String toastr = (String) session.getAttribute("toastr");
            if (toastr != null && toastr.equals("cedulaDuplicada")) {
        %>
        <!-- Llama a un método de JavaScript para mostrar una modal de registro exitoso -->
        <script>
            $(document).ready(function () {
                cedulaDuplicada();
            });
        </script>
        <% } session.removeAttribute("toastr");%>

        <div class="content">
            <div class="container" style="margin-top: 1px">
                <div class="row">
                    <div class="col-md-7 contents">
                        <div class="row justify-content-center">
                            <div class="col-md-8">
                                <div class="mb-4">
                                    <h3>Registrate!</h3>
                                    <p class="mb-4" style="margin-top: 8px">Has tu registro para realizar todas las solicitudes que necesites.</p>
                                </div>
                                <a type="button" class="ml-auto forgot-pass" style="margin-bottom: 10px; padding-left: 320px" href="login.jsp">Iniciar sesión</a>
                                <br><form action="SvRegistro" method="POST">
                                    <div class="form-group first">
                                        <label for="nombreRegistro">Nombre</label>
                                        <input type="text" class="form-control" id="nombre" name="nombre" required="required" data-validation-required-message="Porfavor ingrese su nombre" >
                                    </div>
                                    <div class="form-group first">
                                        <label for="apellidoRegistro">Apellido</label>
                                        <input type="text" class="form-control" id="apellido" name="apellido" required="required" data-validation-required-message="Porfavor ingrese su apellido" >
                                    </div>
                                    <div class="form-group first">
                                        <label for="cedulaRegistro">Cedula</label>
                                        <input type="text" class="form-control" id="cedula" name="cedula" required="required" data-validation-required-message="Porfavor ingrese su cedula" >
                                    </div>
                                    <div class="form-group first">
                                        <label for="telefonoRegistro">Telefono</label>
                                        <input type="text" class="form-control" id="telefono" name="telefono" required="required" data-validation-required-message="Porfavor ingrese su telefono" >
                                    </div>
                                    <div class="form-group first">
                                        <label for="telefonoRegistro">Correo</label>
                                        <input type="email" class="form-control" id="correo" name="correo" required="required" data-validation-required-message="Porfavor ingrese su correo" >
                                    </div>
                                    <div class="form-group first">
                                        <label for="contraseñaRegistro">Contraseña</label>
                                        <input type="password" class="form-control" id="contresena" name="contrasena" required="required" data-validation-required-message="Porfavor ingrese su contraseña" >
                                    </div>
                                    <br><input type="submit" value="Registrar" class="btn btn-block btn-primary">
                                </form>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-5">
                        <img src="img/undraw_remotely_2j6y.jpg" alt="Image" class="img-fluid">
                        <div class="social-login" style="margin-top: 20px">
                            <a href="#" class="facebook">
                                <span></span> 
                            </a>
                            <a href="#" class="twitter">
                                <span class="icon-twitter mr-3"></span> 
                            </a>
                            <a href="#" class="google">
                                <span class="icon-google mr-3"></span> 
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script src="recursos/login/js/jquery-3.3.1.min.js"></script>
        <script src="recursos/login/js/popper.min.js"></script>
        <script src="recursos/login/js/bootstrap.min.js"></script>
        <script src="recursos/login/js/main.js"></script>

        <script>
            function cedulaDuplicada() {
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
                    "hideMethod": "fadeOut",
                    "toastClass": "toast toast-error"
                };

                // Mostrar una notificación Toastr de error
                toastr.error('La cedula que intenta registrar ya existe en el sistema', 'Error');
            }
        </script>

    </body>
</html>