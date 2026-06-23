package modelo;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class proveedormodelo {
   private String codigo, nombre, ruc, telefono, correo, mensaje;

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

    public String getRuc() {
        return ruc;
    }

    public void setRuc(String ruc) {
        this.ruc = ruc;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public String getCorreo() {
        return correo;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }

    public String getMensaje() {
        return mensaje;
    }

    public void setMensaje(String mensaje) {
        this.mensaje = mensaje;
    }
    
    public void guardar() {
        String sql = "insert into proveedores (id, nombre, ruc, telefono, correo) values (?, ?, ?, ?, ?)";
        try (java.sql.Connection conn = utilidades.conexion.obtenerConexion();
             java.sql.PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, codigo);
            ps.setString(2, nombre);
            ps.setString(3, ruc);
            ps.setString(4, telefono);
            ps.setString(5, correo);
            ps.executeUpdate();
            mensaje = "guardado";
        } catch (SQLException ex) {
            mensaje = "Error al guardar: " + ex.getMessage();
            Logger.getLogger(proveedormodelo.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public List<proveedormodelo> Listar() {
        String sql = "select * from proveedores";
        List<proveedormodelo> lista = new ArrayList<>();
        try (Connection conn = utilidades.conexion.obtenerConexion();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                proveedormodelo p1 = new proveedormodelo();
                p1.setCodigo(rs.getString("id"));
                p1.setNombre(rs.getString("nombre"));
                p1.setRuc(rs.getString("ruc"));
                p1.setTelefono(rs.getString("telefono"));
                p1.setCorreo(rs.getString("correo"));
                lista.add(p1);
            }
        } catch (SQLException ex) {
            mensaje = "Error al listar: " + ex.getMessage();
            Logger.getLogger(proveedormodelo.class.getName()).log(Level.SEVERE, null, ex);
        }
        return lista;
    }

    public void actualizar() {
        String sql = "UPDATE proveedores SET nombre=?, ruc=?, telefono=?, correo=? WHERE id=?";
        try (java.sql.Connection conn = utilidades.conexion.obtenerConexion();
             java.sql.PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, nombre);
            ps.setString(2, ruc);
            ps.setString(3, telefono);
            ps.setString(4, correo);
            ps.setString(5, codigo);
            ps.executeUpdate();
            mensaje = "PROVEEDOR GUARDADO";
        } catch (SQLException ex) {
            mensaje = "Error al actualizar: " + ex.getMessage();
            Logger.getLogger(proveedormodelo.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void eliminar(String codigoEliminar) {
        String sql = "DELETE FROM proveedores WHERE id=?";
        try (java.sql.Connection conn = utilidades.conexion.obtenerConexion();
             java.sql.PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, codigoEliminar);
            ps.executeUpdate();
            mensaje = "PROVEEDOR ELIMINADO";
        } catch (SQLException ex) {
            mensaje = "Error al eliminar: " + ex.getMessage();
            Logger.getLogger(proveedormodelo.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}

