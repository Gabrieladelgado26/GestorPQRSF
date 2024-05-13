package Servlets;

import com.mycompany.mundo.Metodos;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Gabriela Delgado
 */
@WebServlet(name = "SvEditarUsuario", urlPatterns = {"/SvEditarUsuario"})
public class SvEditarUsuario extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet SvEditarUsuario</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SvEditarUsuario at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();

        int idUser = Integer.parseInt(request.getParameter("idusuario"));
        System.out.println("es el " + idUser);
        String nombre = request.getParameter("nombre");
        String apellido = request.getParameter("apellido");
        String telefono = request.getParameter("telefono");
        String correo = request.getParameter("correo");
        String rol = request.getParameter("rol");
        System.out.println(rol);

        String toastr = "usuarioEditado";

        // Guardar el ID del usuario en la sesión
        session.setAttribute("idUsuario", idUser);

        // Obtener el ID del usuario autenticado de la sesión
        Integer idUsuarioAutenticado = (Integer) session.getAttribute("idUsuario");

        System.out.println("es el otro " + idUsuarioAutenticado);
        Metodos.editarUsuario(idUser, nombre, apellido, telefono, correo, rol);

        // Verificar si el usuario está cambiando su propio rol de administrador a usuario
        if ("Usuario".equals(rol) && idUsuarioAutenticado.equals(idUser)) {
            // Invalidar la sesión actual
            session.invalidate();
            // Establecer un mensaje en la sesión para mostrar después del inicio de sesión
            session = request.getSession(); // Crear una nueva sesión
            session.setAttribute("toastr", toastr);
            // Redirigir al usuario a la página de inicio de sesión
            response.sendRedirect("login.jsp");
        } else {
            // Redirigir al usuario a la página de administración de usuarios
            response.sendRedirect("administrarUsuarios.jsp");
            // Establecer un mensaje en la sesión para mostrar después de la redirección
            session.setAttribute("toastr", toastr);
        }

    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
