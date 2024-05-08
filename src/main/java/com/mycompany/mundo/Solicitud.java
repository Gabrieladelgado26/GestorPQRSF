
package com.mycompany.mundo;

import java.sql.Date;

/**
 *
 * @author Gabriela Delgado
 */
public class Solicitud {
    
    // Atributos de la clase
    private int idSolicitud;
    private int idPersona;
    private String tipoSolicitud;
    private Date fecha;
    private String descripcion;
    private String archivo;
    private String estado;

    // Constructor vacio
    public Solicitud() {
    }

    public Solicitud(int idSolicitud, int idPersona, String tipoSolicitud, Date fecha, String descripcion, String archivo, String estado) {
        this.idSolicitud = idSolicitud;
        this.idPersona = idPersona;
        this.tipoSolicitud = tipoSolicitud;
        this.fecha = fecha;
        this.descripcion = descripcion;
        this.archivo = archivo;
        this.estado = estado;
    }

    public int getIdSolicitud() {
        return idSolicitud;
    }

    public void setIdSolicitud(int idSolicitud) {
        this.idSolicitud = idSolicitud;
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

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
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

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }
    
    
}