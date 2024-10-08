<!-- Topbar Start -->
<div class="container-fluid bg-dark py-2">
    <div class="container">
        <div class="row">
            <div class="col-md-6 text-center text-lg-left mb-2 mb-lg-0">
            </div>
            <div class="col-md-6 text-center text-lg-right">
                <div class="d-inline-flex align-items-center">
                    <a class="text-white px-3" href="https://accounts.google.com/v3/signin/identifier?checkedDomains=youtube&continue=https%3A%2F%2Fmail.google.com%2Fmail%2F&ddm=0&dsh=S-468738091%3A1714509723452700&flowEntry=AccountChooser&flowName=GlifWebSignIn&hl=es&ifkv=AaSxoQy3jL3y88tb80cuv4vl7cGduTfC3FsQoRLCygx2Uda0Z2UtHmbaeFLAPGobVXTOWcY0peL8&pstMsg=1&theme=mn" target="_blank">
                        <i class="far fa-envelope"></i>
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Topbar End -->

<!-- Navbar Start -->
<div class="container-fluid position-relative nav-bar p-0">
    <div class="container position-relative" style="z-index: 9;">
        <nav class="navbar navbar-expand-lg bg-secondary navbar-dark py-3 py-lg-0 pl-3 pl-lg-5">
            <a href="" class="navbar-brand">
                <h1 class="m-0 display-5 text-white"><span class="text-primary">System</span>PQRSF</h1>
            </a>
            <button type="button" class="navbar-toggler" data-toggle="collapse" data-target="#navbarCollapse">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse justify-content-between px-3 align-items-center" id="navbarCollapse">
                <div class="navbar-nav ml-auto py-0">
                    <a href="inicio.jsp" class="nav-item nav-link">Inicio</a>
                    <%
                        String rolUsuario = (String) session.getAttribute("rol");
                        String urlDestino = "";
                        if (rolUsuario.equals("Usuario")) {
                            urlDestino = "solicitudesUsuario.jsp";
                        } else if (rolUsuario.equals("Administrador")) {
                            urlDestino = "solicitudesAdministrador.jsp";
                        }
                    %>
                    <a href="<%= urlDestino %>" class="nav-item nav-link active">Solicitudes</a>
                </div>
            </div>
            <!-- Nav Item - User Information -->
            <li class="dropdown ">
                <a data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    <%
                        String nombreU = (String) session.getAttribute("nombre");
                        if (nombreU != null) {
                    %>
                    <span class="d-lg-inline nav-item nav-link" style="color: white;"> <%= nombreU%> </span>
                    <%
                        }
                    %>
                    <img class="img-profile" style="width: 40px; height: 40px; margin-right: 20px" src="img/undraw_profile.svg">
                </a>
                <!-- Dropdown - User Information -->
                <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in"
                     aria-labelledby="userDropdown">
                    <div class="dropdown-divider"></div>
                    <a class="dropdown-item" href="SvLogin">
                        <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
                        Cerrar sesi�n
                    </a>
                </div>
            </li>
        </nav>
    </div>
</div>
<!-- Navbar End -->

<!-- Under Nav Start -->
<div class="container-fluid bg-white py-3">
    <div class="container">
        <div class="row">
            <div class="col-lg-4 text-left mb-3 mb-lg-0">
                <div class="d-inline-flex text-left">
                    <h1 class="flaticon-office font-weight-normal text-primary m-0 mr-3"></h1>
                    <div class="d-flex flex-column">
                        <h5>Nuestra oficina</h5>
                        <p class="m-0">Calle 19 # 43</p>
                    </div>
                </div>
            </div>
            <div class="col-lg-4 text-left text-lg-center mb-3 mb-lg-0">
                <div class="d-inline-flex text-left">
                    <h1 class="flaticon-email font-weight-normal text-primary m-0 mr-3"></h1>
                    <div class="d-flex flex-column">
                        <h5>Nuestro Email</h5>
                        <p class="m-0">iManager@gmail.com</p>
                    </div>
                </div>
            </div>
            <div class="col-lg-4 text-left text-lg-right mb-3 mb-lg-0">
                <div class="d-inline-flex text-left">
                    <h1 class="flaticon-telephone font-weight-normal text-primary m-0 mr-3"></h1>
                    <div class="d-flex flex-column">
                        <h5>Atenci�n al cliente</h5>
                        <p class="m-0">+012 345 6789</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Under Nav End -->