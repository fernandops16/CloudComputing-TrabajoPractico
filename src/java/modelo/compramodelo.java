package modelo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import utilidades.conexion;

public class compramodelo {

    private String id, fecha, condicion, estado, proveedor, usuario;

    public String getId() { return id; }
    public void setId(String id) { this.id = id; }

    public String getFecha() { return fecha; }
    public void setFecha(String fecha) { this.fecha = fecha; }

    public String getCondicion() { return condicion; }
    public void setCondicion(String condicion) { this.condicion = condicion; }

    public String getEstado() { return estado; }
    public void setEstado(String estado) { this.estado = estado; }

    public String getProveedor() { return proveedor; }
    public void setProveedor(String proveedor) { this.proveedor = proveedor; }

    public String getUsuario() { return usuario; }
    public void setUsuario(String usuario) { this.usuario = usuario; }

    public List<compramodelo> listar() {
        List<compramodelo> lista = new ArrayList<>();
        String sql = """
            SELECT c.idcompra, c.com_fecha, c.com_condicion, c.com_estado,
                   p.nombre AS proveedor,
                   u.usu_nombre AS usuario
            FROM compra c
            JOIN proveedores p ON c.idproveedor = p.id
            JOIN usuarios u ON c.idusuarios = u.idusuarios
        """;

        try (Connection conn = conexion.obtenerConexion();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                compramodelo cm = new compramodelo();
                cm.setId(rs.getString("idcompra"));
                cm.setFecha(rs.getString("com_fecha"));
                cm.setCondicion(rs.getString("com_condicion"));
                cm.setEstado(rs.getString("com_estado"));
                cm.setProveedor(rs.getString("proveedor"));
                cm.setUsuario(rs.getString("usuario"));
                lista.add(cm);
            }

        } catch (SQLException ex) {
            Logger.getLogger(compramodelo.class.getName()).log(Level.SEVERE, null, ex);
        }

        return lista;
    }

    public List<String[]> listarProveedores() {
        List<String[]> lista = new ArrayList<>();
        String sql = "SELECT id, nombre, ruc FROM proveedores";

        try (Connection conn = conexion.obtenerConexion();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                String[] proveedor = new String[3];
                proveedor[0] = rs.getString("id");
                proveedor[1] = rs.getString("nombre");
                proveedor[2] = rs.getString("ruc");
                lista.add(proveedor);
            }

        } catch (SQLException ex) {
            Logger.getLogger(compramodelo.class.getName()).log(Level.SEVERE, null, ex);
        }

        return lista;
    }

    public List<String[]> listarProductos() {
        List<String[]> lista = new ArrayList<>();
        try {
            Connection con = conexion.obtenerConexion();
            String sql = "SELECT idproductos, pro_nombre, pro_costos, pro_iva FROM productos";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String[] fila = new String[4];
                fila[0] = rs.getString("idproductos");   // ID del producto
                fila[1] = rs.getString("pro_nombre");    // Nombre del producto
                fila[2] = rs.getString("pro_costos");    // COSTO para compras
                fila[3] = rs.getString("pro_iva");       // IVA del producto
                lista.add(fila);
            }
            rs.close();
            ps.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lista;
    }

    public String guardarCabecera() {
        String idGenerado = "";
        String sql = "INSERT INTO compra (com_fecha, com_condicion, com_estado, idproveedor, idusuarios) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = conexion.obtenerConexion();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, fecha);
            ps.setString(2, condicion);
            ps.setString(3, estado);
            ps.setString(4, proveedor);
            ps.setString(5, usuario);
            ps.executeUpdate();

            // Obtener ID generado automáticamente
            String query = "SELECT MAX(idcompra) AS id FROM compra";
            try (PreparedStatement ps2 = conn.prepareStatement(query);
                 ResultSet rs = ps2.executeQuery()) {
                if (rs.next()) {
                    idGenerado = rs.getString("id");
                }
            }

        } catch (SQLException ex) {
            Logger.getLogger(compramodelo.class.getName()).log(Level.SEVERE, null, ex);
        }

        return idGenerado;
    }

    // Modificado para recibir conexión y hacer update del stock dentro de la misma transacción
    public void aumentarStock(Connection conn, String idproducto, int cantidadComprada) throws SQLException {
        String sql = "UPDATE productos SET pro_cantidad = pro_cantidad + ? WHERE idproductos = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, cantidadComprada);
            ps.setString(2, idproducto);
            ps.executeUpdate();
        }
    }

    // Guardar detalle y actualizar stock en la misma transacción
    public void guardarDetalle(String idcompra, String idproducto, String precio, String cantidad) {
        String sql = "INSERT INTO detallecompra (idcompra, idproductos, det_cantidad, det_precio) VALUES (?, ?, ?, ?)";

        try (Connection conn = conexion.obtenerConexion()) {
            conn.setAutoCommit(false); // Iniciar transacción

            try (PreparedStatement ps = conn.prepareStatement(sql)) {

                // Insertar detalle compra
                ps.setString(1, idcompra);
                ps.setString(2, idproducto);
                ps.setString(3, cantidad);
                ps.setString(4, precio);
                ps.executeUpdate();

                // Actualizar stock usando la misma conexión y transacción
                aumentarStock(conn, idproducto, Integer.parseInt(cantidad));

                conn.commit();
            } catch (SQLException e) {
                conn.rollback();
                Logger.getLogger(compramodelo.class.getName()).log(Level.SEVERE, null, e);
            } finally {
                conn.setAutoCommit(true);
            }
        } catch (SQLException ex) {
            Logger.getLogger(compramodelo.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

}
