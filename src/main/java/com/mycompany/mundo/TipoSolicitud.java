
package com.mycompany.mundo;

/**
 *
 * @author Gabriela Delgado
 */
public class TipoSolicitud {
    
    private int idTipoSolicitud;
    private String tipoSolicitud;

    public TipoSolicitud() {
    }

    public TipoSolicitud(int idTipoSolicitud, String tipoSolicitud) {
        this.idTipoSolicitud = idTipoSolicitud;
        this.tipoSolicitud = tipoSolicitud;
    }

    public int getIdTipoSolicitud() {
        return idTipoSolicitud;
    }

    public void setIdTipoSolicitud(int idTipoSolicitud) {
        this.idTipoSolicitud = idTipoSolicitud;
    }

    public String getTipoSolicitud() {
        return tipoSolicitud;
    }

    public void setTipoSolicitud(String tipoSolicitud) {
        this.tipoSolicitud = tipoSolicitud;
    }
}
