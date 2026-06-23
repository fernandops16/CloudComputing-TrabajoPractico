package modelo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class productomodelo {
    private String codigo, nombre, precio, cantidad, iva, costo;
    private String mensaje;

    // Getters y Setters EXACTOS como los tenés
    public String getCosto() {
        return costo;
    }
    public void setCosto(String costo) {
        this.costo = costo;
    }
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
    public String getPrecio() {
        return precio;
    }
    public void setPrecio(String precio) {
        this.precio = precio;
    }
    public String getCantidad() {
        return cantidad;
    }
    public void setCantidad(String cantidad) {
        this.cantidad = cantidad;
    }
    public String getIva() {
        return iva;
    }
    public void setIva(String iva) {
        this.iva = iva;
    }
    public String getMensaje() {
        return mensaje;
    }
    public void setMensaje(String mensaje) {
        this.mensaje = mensaje;
    }

    // Guardar producto
    public void guardar() {
        String sql = "INSERT INTO productos (idproductos, pro_nombre, pro_precio, pro_cantidad, pro_iva, pro_costos) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = utilidades.conexion.obtenerConexion();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, codigo);
            ps.setString(2, nombre);
            ps.setString(3, precio);
            ps.setString(4, cantidad);
            ps.setString(5, iva);
            ps.setString(6, costo);

            ps.executeUpdate();
            mensaje = "PRODUCTO GUARDADO";
        } catch (SQLException ex) {
            mensaje = "ERROR AL GUARDAR PRODUCTO: " + ex.getMessage();
            Logger.getLogger(productomodelo.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    // Listar productos
    public List<productomodelo> listar() {
        List<productomodelo> lista = new ArrayList<>();
        String sql = "SELECT * FROM productos";

        try (Connection conn = utilidades.conexion.obtenerConexion();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                productomodelo p = new productomodelo();
                p.setCodigo(rs.getString("idproductos"));
                p.setNombre(rs.getString("pro_nombre"));
                p.setPrecio(rs.getString("pro_precio"));
                p.setCantidad(rs.getString("pro_cantidad"));
                p.setIva(rs.getString("pro_iva"));
                p.setCosto(rs.getString("pro_costos"));
                lista.add(p);
            }

        } catch (SQLException ex) {
            mensaje = "ERROR AL LISTAR PRODUCTOS: " + ex.getMessage();
            Logger.getLogger(productomodelo.class.getName()).log(Level.SEVERE, null, ex);
        }
        return lista;
    }

    // Actualizar producto
    public void actualizar() {
        String sql = "UPDATE productos SET pro_nombre = ?, pro_precio = ?, pro_cantidad = ?, pro_iva = ?, pro_costos = ? WHERE idproductos = ?";

        try (Connection conn = utilidades.conexion.obtenerConexion();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, nombre);
            ps.setString(2, precio);
            ps.setString(3, cantidad);
            ps.setString(4, iva);
            ps.setString(5, costo);
            ps.setString(6, codigo);

            ps.executeUpdate();
            mensaje = "PRODUCTO ACTUALIZADO";
        } catch (SQLException ex) {
            mensaje = "ERROR AL ACTUALIZAR PRODUCTO: " + ex.getMessage();
            Logger.getLogger(productomodelo.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    // Eliminar producto
    public void eliminar(String codigoEliminar) {
        String sql = "DELETE FROM productos WHERE idproductos = ?";

        try (Connection conn = utilidades.conexion.obtenerConexion();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, codigoEliminar);
            ps.executeUpdate();
            mensaje = "PRODUCTO ELIMINADO";
        } catch (SQLException ex) {
            mensaje = "ERROR AL ELIMINAR PRODUCTO: " + ex.getMessage();
            Logger.getLogger(productomodelo.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
