package modelo;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.sql.Connection;
import java.sql.PreparedStatement;

public class aperturamodelo {
    private String codigo, fecha, hora, monto, idusuario, mensaje, idapertura;

    public String getCodigo() {
        return codigo;
    }

    public void setCodigo(String codigo) {
        this.codigo = codigo;
    }

    public String getIdapertura() {
        return idapertura;
    }

    public void setIdapertura(String idapertura) {
        this.idapertura = idapertura;
    }

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

    public String getIdusuario() {
        return idusuario;
    }

    public void setIdusuario(String idusuario) {
        this.idusuario = idusuario;
    }

    public String getMensaje() {
        return mensaje;
    }

    public void setMensaje(String mensaje) {
        this.mensaje = mensaje;
    }

    public void guardar() {
        String sql = "INSERT INTO apertura (ape_fecha, ape_hora, ape_monto, idusuarios, ape_estado) VALUES (?, ?, ?, ?, 'ABIERTA')";
        try (
            Connection conn = utilidades.conexion.obtenerConexion();
            PreparedStatement ps = conn.prepareStatement(sql)
        ) {
            ps.setString(1, fecha);
            ps.setString(2, hora);
            ps.setString(3, monto);
            ps.setString(4, idusuario);
            ps.executeUpdate();
            mensaje = "✅ CAJA ABIERTA CORRECTAMENTE";
        } catch (SQLException ex) {
            Logger.getLogger(aperturamodelo.class.getName()).log(Level.SEVERE, null, ex);
            mensaje = "❌ ERROR AL ABRIR CAJA";
        }
    }

    public String verificar() {
        String sql = "SELECT idapertura FROM apertura WHERE idusuarios = ? AND ape_estado = 'ABIERTA'";
        try (
            Connection conn = utilidades.conexion.obtenerConexion();
            PreparedStatement ps = conn.prepareStatement(sql)
        ) {
            ps.setString(1, idusuario);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    idapertura = rs.getString("idapertura");
                    return "cerrar"; // Ya hay una caja abierta
                } else {
                    return "abrir"; // Se puede abrir una nueva
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(aperturamodelo.class.getName()).log(Level.SEVERE, null, ex);
            return "error"; // Fallo en verificación
        }
    }
}
