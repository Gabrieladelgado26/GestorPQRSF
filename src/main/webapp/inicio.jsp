<!-- Inclución de la plantilla header -->
<%@include file= "templates/header.jsp" %>

<body>

    <%@include file= "templates/navbarUsuario.jsp" %>

    <!-- Carousel Start -->
    <div class="container-fluid p-0">
        <div id="header-carousel" class="carousel slide" data-ride="carousel">
            <div class="carousel-inner">
                <div class="carousel-item active">
                    <img class="w-100" src="img/carousel-2.jpg" alt=imagen>
                    <div class="carousel-caption d-flex flex-column align-items-center justify-content-center">
                        <div class="p-3" style="max-width: 800px;">
                            <h4 class="text-primary text-uppercase font-weight-normal mb-md-3">Sistema de Peticiones, Quejas, Reclamos, Sugerencias y Felicitaciones</h4>
                            <h3 class="display-3 text-white mb-md-4">Sistema gestor de PQRSF</h3>
                            <a href="" class="btn btn-pri py-md-3 px-md-5 mt-2 mt-md-4">Leer Mas</a>
                        </div>
                    </div>
                </div>
                <div class="carousel-item">
                    <img class="w-100" src="img/carousel-1.jpg" alt="imagen">
                    <div class="carousel-caption d-flex flex-column align-items-center justify-content-center">
                        <div class="p-3" style="max-width: 800px;">
                            <h4 class="text-primary text-uppercase font-weight-normal mb-md-3">Sistema de Peticiones, Quejas, Reclamos, Sugerencias y Felicitaciones</h4>
                            <h3 class="display-3 text-white mb-md-4">Al servicio de tus necesidades</h3>
                            <a href="" class="btn btn-pri py-md-3 px-md-5 mt-2 mt-md-4">Leer Mas</a>
                        </div>
                    </div>
                </div>
            </div>
            <a class="carousel-control-prev" href="#header-carousel" data-slide="prev">
                <div class="btn text-pri" style="width: 45px; height: 45px;">
                    <span class="carousel-control-prev-icon mb-n2"></span>
                </div>
            </a>
            <a class="carousel-control-next" href="#header-carousel" data-slide="next">
                <div class="btn btn-pri" style="width: 45px; height: 45px;">
                    <span class="carousel-control-next-icon mb-n2"></span>
                </div>
            </a>
        </div>
    </div>
    <!-- Carousel End -->

    <!-- About Start -->
    <div class="container-fluid bg-light">
        <div class="container">
            <div class="row">
                <div class="col-lg-5">
                    <div class="d-flex flex-column align-items-center justify-content-center bg-primary h-100 py-5 px-3">
                        <i class="flaticon-brickwall display-1 font-weight-normal text-pri mb-3"></i>
                        <h4 class="text-pri text-uppercase display-3 mb-3">25+</h4>
                        <h1 class="text-pri m-0">Años de experiencia</h1>
                    </div>
                </div>
                <div class="col-lg-7 m-0 my-lg-5 pt-5 pb-5 pb-lg-2 pl-lg-5">
                    <h6 class="text-pri font-weight-normal text-uppercase mb-3">Conoce sobre nosotros</h6>
                    <h1 class="mb-4 section-title">Resolver tus inquietudes es nuestra prioridad</h1>
                    <p>Tu participación en esta platofarma nos permite conocer tus inquietudes y manifestaciones para que tengamos la oportunidad de fortalecer nuestro servicio y seguir en el camino hacia la excelencia operativa.</p>
                    <div class="row py-2">
                        <div class="col-sm-6">
                            <div class="d-flex align-items-center mb-4">
                                <h1 class="flaticon font-weight-normal text-pri m-0 mr-3"></h1>
                                <h5 class="text-truncate m-0">Quejas</h5>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="d-flex align-items-center mb-4">
                                <h1 class="flaticon font-weight-normal text-pri m-0 mr-3"></h1>
                                <h5 class="text-truncate m-0">Peticiones</h5>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="d-flex align-items-center mb-4">
                                <h1 class="flaticon font-weight-normal text-pri m-0 mr-3"></h1>
                                <h5 class="text-truncate m-0">Reclamos</h5>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="d-flex align-items-center mb-4">
                                <h1 class="flaticon font-weight-normal text-pri m-0 mr-3"></h1>
                                <h5 class="text-truncate m-0">Sugerencias</h5>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- About End -->

    <!-- Services Start -->
    <div class="container-fluid py-5">
        <div class="container py-5">
            <div class="row">
                <div class="col-lg-6 pr-lg-5">
                    <h6 class="text-primary font-weight-normal text-uppercase mb-3">Conoce tus derechos</h6>
                    <h1 class="mb-4 section-title">Conoce el tipo de solicitud que deseas presentar</h1>
                    <p>Es importante que tengas en cuenta las definiciones de peticiones, quejas, reclamos y sugerencias para que puedas realizar tu solicitud sin problemas y conoscas los términos de respuesta.</p>
                    <a href="AgregarSolicitud.jsp" class="btn btn-pri mt-3 py-2 px-4">Realizar una solicitud</a>
                </div>
                <div class="col-lg-6 p-0 pt-5 pt-lg-0">
                    <div class="owl-carousel service-carousel position-relative">
                        <div class="d-flex flex-column text-center bg-light mx-3 p-4">
                            <h3 class="flaticon display-3 font-weight-normal text-pri mb-3"></h3>
                            <h5 class="mb-3">Peticiones</h5>
                            <p class="m-0">Petición, por motivos de interés general o particular, mediante el cual una persona solicita el reconocimiento de un derecho, la prestación de un servicio, etc.</p>
                        </div>
                        <div class="d-flex flex-column text-center bg-light mx-3 p-4">
                            <h3 class="flaticon display-3 font-weight-normal text-pri mb-3"></h3>
                            <h5 class="mb-3">Quejas</h5>
                            <p class="m-0">Manifestación del usuario para expresar inconformidad con el actuar del funcionario, ya sea porque incumplió un deber o violó el régimen de inhabilidades.</p>
                        </div>
                        <div class="d-flex flex-column text-center bg-light mx-3 p-4">
                            <h3 class="flaticon display-3 font-weight-normal text-pri mb-3"></h3>
                            <h5 class="mb-3">Reclamos</h5>
                            <p class="m-0">Es la oposición o contrariedad presentada por el usuario, para revisar y evaluar una actuación relacionada con la prestación del servicio en términos económicos.</p>
                        </div>
                        <div class="d-flex flex-column text-center bg-light mx-3 p-4">
                            <h3 class="flaticon display-3 font-weight-normal text-pri mb-3"></h3>
                            <h5 class="mb-3">Sugerencia</h5>
                            <p class="m-0">Es una propuesta presentada del usuario para incidir en la mejora de un proceso cuyo objeto está relacionado con la prestación del servicio.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Services End -->

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

    <!-- Inclución de la plantilla footer -->
    <%@include file= "templates/footer.jsp" %>