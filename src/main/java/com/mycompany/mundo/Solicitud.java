
package com.mycompany.mundo;

/**
 *
 * @author Gabriela Delgado
 */
public class Solicitud {
    
    // Atributos de la clase
    private int idTutorial;
    private int idPersona;
    private String tipoSolicitud;
    private int fecha;
    private String descripcion;
    private String archivo;

    // Constructor vacio
    public Solicitud() {
    }

    // Constructor con parametros de la clase
    public Solicitud(int idTutorial, int idPersona, String tipoSolicitud, int fecha, String descripcion, String archivo) {
        this.idTutorial = idTutorial;
        this.idPersona = idPersona;
        this.tipoSolicitud = tipoSolicitud;
        this.fecha = fecha;
        this.descripcion = descripcion;
        this.archivo = archivo;
    }
    
    /**
     * Getters y Setters de los atributos de la clase Solicitud
     * @return 
     */
    public int getIdTutorial() {
        return idTutorial;
    }

    public void setIdTutorial(int idTutorial) {
        this.idTutorial = idTutorial;
    }

    public int getIdPersona() {
        return idPersona;
    }

    public void setIdPersona(int idPersona) {
        this.idPersona = idPersona;
    }

    public String getTipoSolicitud() {
        return tipoSolicitud;
    }

    public void setTipoSolicitud(String tipoSolicitud) {
        this.tipoSolicitud = tipoSolicitud;
    }

    public int getFecha() {
        return fecha;
    }

    public void setFecha(int fecha) {
        this.fecha = fecha;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public String getArchivo() {
        return archivo;
    }

    public void setArchivo(String archivo) {
        this.archivo = archivo;
    }    
}
