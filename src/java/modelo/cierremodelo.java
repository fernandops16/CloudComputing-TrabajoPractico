package modelo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class cierremodelo {

    private String fecha, hora, monto, idapertura;

    public String getFecha() {
        return fecha;
    }

    public void setFecha(String fecha) {
        this.fecha = fecha;
    }

    public String getHora() {
        return hora;
    }

    public void setHora(String hora) {
        this.hora = hora;
    }

    public String getMonto() {
        return monto;
    }

    public void setMonto(String monto) {
        this.monto = monto;
    }

    public String getIdapertura() {
        return idapertura;
    }

    public void setIdapertura(String idapertura) {
        this.idapertura = idapertura;
    }

    // =========================
    // GUARDAR CIERRE DE CAJA
    // =========================
    public void cerrarcaja() {

        String sql = "INSERT INTO cierre (cie_fecha, cie_hora, cie_monto, idapertura) "
                   + "VALUES (?, ?, ?, ?)";

        try (
            Connection conn = utilidades.conexion.obtenerConexion();
            PreparedStatement ps = conn.prepareStatement(sql)
        ) {

            ps.setString(1, fecha);
            ps.setString(2, hora); // ya viene ajustada desde el controlador (+1)
            ps.setString(3, monto);
            ps.setString(4, idapertura);

            ps.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(cierremodelo.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    // =========================
    // ACTUALIZAR APERTURA
    // =========================
    public void actualizarapertura() {

        String sql = "UPDATE apertura SET ape_estado = 'CERRADA' WHERE idapertura = ?";

        try (
            Connection conn = utilidades.conexion.obtenerConexion();
            PreparedStatement ps = conn.prepareStatement(sql)
        ) {

            ps.setString(1, idapertura);
            ps.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(cierremodelo.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}