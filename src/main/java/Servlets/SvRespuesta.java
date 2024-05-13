
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

/**
 *
 * @author Gabriela Delgado
 */
@WebServlet(name = "SvRespuesta", urlPatterns = {"/SvRespuesta"})
public class SvRespuesta extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet SvRespuesta</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SvRespuesta at " + request.getContextPath() + "</h1>");
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
        
        int idSolicitud = Integer.parseInt(request.getParameter("idSolicitud"));
        String respuesta = request.getParameter("respuesta");
        String tipoSolicitud = request.getParameter("tipoSolicitud");
        String nombre = request.getParameter("nombre");
        String apellido = request.getParameter("apellido");
        String correo = request.getParameter("correo");
        
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date fecha = null;
        try {
            fecha = new Date(sdf.parse(request.getParameter("fecha")).getTime());
        } catch (ParseException e) {
            e.printStackTrace(); // Manejar la excepción adecuadamente
        }
        String descripcion = request.getParameter("descripcion");
        String estado = "Solicitud respondida";

        // Llamar a la función para atender la solicitud
        Metodos.responderSolicitud(idSolicitud, respuesta, tipoSolicitud, nombre, apellido, correo, fecha, descripcion, estado);

        // Redirigir a una página de confirmación o a la página principal
        response.sendRedirect("solicitudesAdministrador.jsp");
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
