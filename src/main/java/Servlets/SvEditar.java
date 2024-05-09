package Servlets;

import com.mycompany.mundo.Metodos;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
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
@WebServlet(name = "SvEditar", urlPatterns = {"/SvEditar"})
public class SvEditar extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    Metodos metodos = new Metodos();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("Corriendo metodo para editar");

        int idSolicitud = Integer.parseInt(request.getParameter("idSolicitud"));
        System.out.println("id solisitud" + idSolicitud);
        int tipoSolicitud = Integer.parseInt(request.getParameter("tipoSolicitud")); // Convertir a entero
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date fecha = null;
        try {
            fecha = new Date(sdf.parse(request.getParameter("fecha")).getTime());
        } catch (ParseException e) {
            e.printStackTrace(); // Manejar la excepción adecuadamente
        }
        String descripcion = request.getParameter("descripcion");
        String archivo = request.getParameter("archivo");

        metodos.editarSolicitud(idSolicitud, tipoSolicitud, fecha, descripcion, archivo);
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
