package Servlets;

import com.mycompany.mundo.Metodos;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

/**
 *
 * @author Gabriela Delgado
 */
@WebServlet(name = "SvEditar", urlPatterns = {"/SvEditar"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50)   // 50MB

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
        int idTipoSolicitud = Integer.parseInt(request.getParameter("tipoSolicitud"));
        String descripcion = request.getParameter("descripcion");
        
        Part filePart = request.getPart("archivo");
        String rutaArchivo = null;
        if (filePart != null && filePart.getSize() > 0) {
            // Obtener el nombre del archivo
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString(); // MSIE fix.

            // Guardar el archivo en la carpeta "archivos"
            String uploadPath = getServletContext().getRealPath("") + File.separator + "archivos";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }
            String filePath = uploadPath + File.separator + fileName;
            try (InputStream fileContent = filePart.getInputStream()) {
                Files.copy(fileContent, Paths.get(filePath), StandardCopyOption.REPLACE_EXISTING);
            }

            // Ruta del archivo (ruta relativa)
            rutaArchivo = File.separator + fileName;
        } else {
            // Si no se ha adjuntado un nuevo archivo, utilizar la ruta del archivo anterior
            rutaArchivo = request.getParameter("rutaArchivoAnterior");
        }

        metodos.editarSolicitud(idSolicitud, idTipoSolicitud, descripcion, rutaArchivo);

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