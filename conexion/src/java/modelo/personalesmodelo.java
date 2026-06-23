package modelo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.ArrayList;
import java.util.List;

public class personalesmodelo {
   private String codigo, nombre, apellido, ci, telefono, mensaje;

    public String getCodigo() {
        return codigo;
    }

    public void setCodigo(String codigo) {
        this.codigo = codigo;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getApellido() {
        return apellido;
    }

    public void setApellido(String apellido) {
        this.apellido = apellido;
    }

    public String getCi() {
        return ci;
    }

    public void setCi(String ci) {
        this.ci = ci;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public String getMensaje() {
        return mensaje;
    }

    public void setMensaje(String mensaje) {
        this.mensaje = mensaje;
    }

    public void guardar() {
        String sql = "INSERT INTO personales (id, nombre, apellido, ci, telefono) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = utilidades.conexion.obtenerConexion();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, codigo);
            ps.setString(2, nombre);
            ps.setString(3, apellido);
            ps.setString(4, ci);
            ps.setString(5, telefono);
            ps.executeUpdate();
            mensaje = "PERSONAL GUARDADO";
        } catch (SQLException ex) {
            Logger.getLogger(personalesmodelo.class.getName()).log(Level.SEVERE, null, ex);
            mensaje = "ERROR AL GUARDAR PERSONAL";
        }
    }

    public List<personalesmodelo> listar() {
        String sql = "SELECT * FROM personales";
        List<personalesmodelo> lista = new ArrayList<>();
        try (Connection conn = utilidades.conexion.obtenerConexion();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                personalesmodelo p1 = new personalesmodelo();
                p1.setCodigo(rs.getString("id"));
                p1.setNombre(rs.getString("nombre"));
                p1.setApellido(rs.getString("apellido"));
                p1.setCi(rs.getString("ci"));
                p1.setTelefono(rs.getString("telefono"));
                lista.add(p1);
            }
        } catch (SQLException ex) {
            Logger.getLogger(personalesmodelo.class.getName()).log(Level.SEVERE, null, ex);
        }
        return lista;
    }

    public void actualizar() {
        String sql = "UPDATE personales SET nombre=?, apellido=?, ci=?, telefono=? WHERE id=?";
        try (Connection conn = utilidades.conexion.obtenerConexion();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, nombre);
            ps.setString(2, apellido);
            ps.setString(3, ci);
            ps.setString(4, telefono);
            ps.setString(5, codigo);
            ps.executeUpdate();
            mensaje = "PERSONAL ACTUALIZADO";
        } catch (SQLException ex) {
            Logger.getLogger(personalesmodelo.class.getName()).log(Level.SEVERE, null, ex);
            mensaje = "ERROR AL ACTUALIZAR PERSONAL";
        }
    }

    public void eliminar(String codigoEliminar) {
        String sql = "DELETE FROM personales WHERE id=?";
        try (Connection conn = utilidades.conexion.obtenerConexion();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, codigoEliminar);
            ps.executeUpdate();
            mensaje = "PERSONAL ELIMINADO";
        } catch (SQLException ex) {
            Logger.getLogger(personalesmodelo.class.getName()).log(Level.SEVERE, null, ex);
            mensaje = "ERROR AL ELIMINAR PERSONAL";
        }
    }
}
