package Servlets;

import com.mycompany.mundo.Metodos;
import java.io.IOException;
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
@WebServlet(name = "SvLogin", urlPatterns = {"/SvLogin"})
public class SvLogin extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false); // Obtener la sesión actual sin crear una nueva si no existe

        if (session != null) {
            session.invalidate(); // Invalidar la sesión actual
        } else {
            System.out.println("Error");
        }

        // Redirigir a la página de inicio
        response.sendRedirect("login.jsp");
    }

    Metodos metodos = new Metodos();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        // Obtener los datos del formulario de inicio de sesión
        String cedula = request.getParameter("cedula");
        String contrasena = request.getParameter("contrasena");
        String toastr = "usuarioInexistente";

        // Verificar las credenciales del usuario y obtener el id, rol y nombre
        String[] datosUsuario = metodos.iniciarSesion(cedula, contrasena);

        if (datosUsuario != null) {
            // Si las credenciales son válidas, almacenar el id, rol y nombre en la sesión
            session.setAttribute("idUsuario", datosUsuario[0]); // El id está en la posición 0
            session.setAttribute("rol", datosUsuario[1]); // El rol está en la posición 1
            session.setAttribute("nombre", datosUsuario[2]); // El nombre está en la posición 2

            // Redirigir a la página correspondiente según el rol del usuario
            String rol = datosUsuario[1];
            if (rol.equals("Usuario")) {
                response.sendRedirect("solicitudesUsuario.jsp");
            } else if (rol.equals("Administrador")) {
                response.sendRedirect("solicitudesAdministrador.jsp");
            }
        } else {
            // Si las credenciales no son válidas, redirigir de vuelta al formulario de inicio de sesión con un mensaje de error
            System.out.println("No existe el usuario");
            session.setAttribute("toastr", toastr);
            response.sendRedirect("login.jsp");
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
