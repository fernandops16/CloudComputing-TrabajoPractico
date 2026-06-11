package modelo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class clientesmodelo {
   private String codigo,nombre,apellido,ci,telefono;

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
  
    private String mensaje;

    public String getMensaje() {
        return mensaje;
    }

    public void setMensaje(String mensaje) {
        this.mensaje = mensaje;
    }
    
    // GUARDAR CLIENTE
    public void guardar() {
        String sql = "INSERT INTO clientes (id, nombre, apellido, ci, telefono) VALUES (?, ?, ?, ?, ?)";
        try (
            Connection conn = utilidades.conexion.obtenerConexion();
            PreparedStatement ps = conn.prepareStatement(sql)
        ) {
            ps.setString(1, codigo);
            ps.setString(2, nombre);
            ps.setString(3, apellido);
            ps.setString(4, ci);
            ps.setString(5, telefono);
            ps.executeUpdate();
            mensaje = "CLIENTE GUARDADO";
        } catch (SQLException ex) {
            Logger.getLogger(clientesmodelo.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    // LISTAR CLIENTES
    public List<clientesmodelo> Listar() {
        String sql = "SELECT * FROM clientes";
        List<clientesmodelo> lista = new ArrayList<>();

        try (
            Connection conn = utilidades.conexion.obtenerConexion();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery()
        ) {
            while (rs.next()) {
                clientesmodelo cliente = new clientesmodelo();
                cliente.setCodigo(rs.getString("id"));
                cliente.setNombre(rs.getString("nombre"));
                cliente.setApellido(rs.getString("apellido"));
                cliente.setCi(rs.getString("ci"));
                cliente.setTelefono(rs.getString("telefono"));
                lista.add(cliente);
            }
        } catch (SQLException ex) {
            Logger.getLogger(clientesmodelo.class.getName()).log(Level.SEVERE, null, ex);
        }
        return lista;
    }

    // ACTUALIZAR CLIENTE
    public void actualizar() {
        String sql = "UPDATE clientes SET nombre = ?, apellido = ?, ci = ?, telefono = ? WHERE id = ?";
        try (
            Connection conn = utilidades.conexion.obtenerConexion();
            PreparedStatement ps = conn.prepareStatement(sql)
        ) {
            ps.setString(1, nombre);
            ps.setString(2, apellido);
            ps.setString(3, ci);
            ps.setString(4, telefono);
            ps.setString(5, codigo);
            ps.executeUpdate();
            mensaje = "CLIENTE ACTUALIZADO";
        } catch (SQLException ex) {
            Logger.getLogger(clientesmodelo.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    // ELIMINAR CLIENTE
    public void eliminar(String codigoEliminar) {
        String sql = "DELETE FROM clientes WHERE id = ?";
        try (
            Connection conn = utilidades.conexion.obtenerConexion();
            PreparedStatement ps = conn.prepareStatement(sql)
        ) {
            ps.setString(1, codigoEliminar);
            ps.executeUpdate();
            mensaje = "CLIENTE ELIMINADO";
        } catch (SQLException ex) {
            Logger.getLogger(clientesmodelo.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
