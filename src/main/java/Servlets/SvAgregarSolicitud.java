package Servlets;

import com.mycompany.mundo.Metodos;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
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
@WebServlet(name = "SvAgregarSolicitud", urlPatterns = {"/SvAgregarSolicitud"})
public class SvAgregarSolicitud extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
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

        // Obtener los parámetros del formulario
        int idUsuario = 1;
        String tipoSolicitud = request.getParameter("tipoSolicitud");
        String fecha = request.getParameter("fecha");
        String descripcion = request.getParameter("descripcion");
        String archivo = request.getParameter("archivo");
        String estado = "Por revisar";

        Metodos.SvAgregarSolicitud(idUsuario, tipoSolicitud, fecha, descripcion, archivo, estado, session, response);
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
