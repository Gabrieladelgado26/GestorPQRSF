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
        <title>Iniciar sesión</title>
    </head>

    <body>

        <%
            String toastr = (String) session.getAttribute("toastr");

            // En caso de que se registre exitosamente
            if (toastr != null && toastr.equals("usuarioAgregado")) {
        %>
        <!-- Llama a un método de JavaScript para mostrar una modal de registro exitoso -->
        <script>
            $(document).ready(function () {
                usuarioAgregado();
            });
        </script>
        <% } else if (toastr != null && toastr.equals("usuarioInexistente")) {
        %>
        <!-- Llama a un método de JavaScript para mostrar una modal de registro exitoso -->
        <script>
            $(document).ready(function () {
                usuarioInexistente();
            });
        </script>
        <% } session.removeAttribute("toastr");%>


        <div class="content">
            <div class="container" style="margin-top: 1px">
                <div class="row">
                    <div class="col-md-6">
                        <img src="img/undraw_remotely_2j6y.jpg" alt="Image" class="img-fluid">
                    </div>
                    <div class="col-md-6 contents">
                        <div class="row justify-content-center">
                            <div class="col-md-8">
                                <div class="mb-4">
                                    <h3>Iniciar sesión</h3>
                                    <p class="mb-4" style="margin-top: 8px">Inicia sesión para realizar todas las solicitudes que necesites.</p>
                                </div>
                                <a type="button" class="ml-auto forgot-pass" href="registro.jsp" style="margin-bottom: 10px; padding-left: 240px" data-bs-toggle="modal" data-bs-target="#modalAgregar">Registrate aqui!</a>
                                <br><form action="SvLogin" method="post">
                                    <div class="form-group first">
                                        <label for="usuario">Cedula de usuario</label>
                                        <input type="text" class="form-control" id="cedula" name="cedula" required="required" data-validation-required-message="Por favor ingrese su cédula" oninput="this.value = this.value.replace(/[^0-9]/g, '');" title="Ingrese solo números">
                                    </div>
                                    <div class="form-group last mb-4">
                                        <label for="contraseña">Contraseña</label>
                                        <input type="password" class="form-control" id="contrasena" name="contrasena" required="required" data-validation-required-message="Porfavor ingrese la contraseña" >
                                    </div>
                                    <div class="d-flex mb-5 align-items-center">
                                        <label class="control control--checkbox mb-0"><span class="caption">Recuérdame</span>
                                            <input type="checkbox" checked="checked"/>
                                            <div class="control__indicator"></div>
                                        </label>
                                    </div>
                                    <input type="submit" value="Iniciar sesión" class="btn btn-block btn-primary">
                                </form>
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
            </div>
        </div>

        <!-- Button trigger modal -->
        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal">
            Launch demo modal
        </button>

        <!-- Modal -->
        <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="exampleModalLabel">Modal title</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        ...
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        <button type="button" class="btn btn-primary">Save changes</button>
                    </div>
                </div>
            </div>
        </div>

        <script>
            // Función para mostrar una notificación Toastr de éxito cuando el registro fue exitoso
            function usuarioAgregado() {
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
                toastr.success('Se ha añadido exitosamente!', 'Registrado');
            }
        
            function usuarioInexistente() {
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
                    "toastClass": "toast toast-info"
                };

                // Mostrar una notificación Toastr de error
                toastr.info('Los datos ingresados son incorrectos', 'Verificar');
            }
        </script>

        <script src="recursos/login/js/jquery-3.3.1.min.js"></script>
        <script src="recursos/login/js/popper.min.js"></script>
        <script src="recursos/login/js/bootstrap.min.js"></script>
        <script src="recursos/login/js/main.js"></script>

    </body>
</html>