
package Servlets;

import com.mycompany.mundo.Metodos;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Gabriela Delgado
 */
@WebServlet(name = "SvEliminar", urlPatterns = {"/SvEliminar"})
public class SvEliminar extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
    }

    Metodos metodos = new Metodos();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        System.out.println("Corriendo metodo para eliminar usuario");
        int idUsuario = Integer.parseInt(request.getParameter("idUsuario"));
        
        metodos.eliminarUsuario(idUsuario);

        response.sendRedirect("administrarUsuarios.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("Corriendo metodo para eliminar");
        int idSolicitud = Integer.parseInt(request.getParameter("idSolicitud"));
        
        metodos.eliminarSolicitud(idSolicitud);

        response.sendRedirect("solicitudesUsuario.jsp");
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
