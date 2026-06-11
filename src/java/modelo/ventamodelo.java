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

public class ventamodelo {

    private String id, fecha, condicion, estado, cliente, usuario;

    public String getId() { return id; }
    public void setId(String id) { this.id = id; }

    public String getFecha() { return fecha; }
    public void setFecha(String fecha) { this.fecha = fecha; }

    public String getCondicion() { return condicion; }
    public void setCondicion(String condicion) { this.condicion = condicion; }

    public String getEstado() { return estado; }
    public void setEstado(String estado) { this.estado = estado; }

    public String getCliente() { return cliente; }
    public void setCliente(String cliente) { this.cliente = cliente; }

    public String getUsuario() { return usuario; }
    public void setUsuario(String usuario) { this.usuario = usuario; }

    public List<ventamodelo> listar() {
        List<ventamodelo> lista = new ArrayList<>();
        String sql = """
            SELECT v.idventas, v.ven_fecha, v.ven_condicion, v.ven_estado,
                   CONCAT(c.nombre, ' ', c.apellido) AS cliente,
                   u.usu_nombre AS usuario
            FROM ventas v
            JOIN clientes c ON v.idclientes = c.id
            JOIN usuarios u ON v.idusuarios = u.idusuarios
        """;

        try (Connection conn = conexion.obtenerConexion();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                ventamodelo v = new ventamodelo();
                v.setId(rs.getString("idventas"));
                v.setFecha(rs.getString("ven_fecha"));
                v.setCondicion(rs.getString("ven_condicion"));
                v.setEstado(rs.getString("ven_estado"));
                v.setCliente(rs.getString("cliente"));
                v.setUsuario(rs.getString("usuario"));
                lista.add(v);
            }

        } catch (SQLException ex) {
            Logger.getLogger(ventamodelo.class.getName()).log(Level.SEVERE, null, ex);
        }

        return lista;
    }

    public List<String[]> listarClientes() {
        List<String[]> lista = new ArrayList<>();
        String sql = "SELECT id, nombre, apellido, ci FROM clientes";

        try (Connection conn = conexion.obtenerConexion();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                String[] cliente = new String[4];
                cliente[0] = rs.getString("id");
                cliente[1] = rs.getString("nombre");
                cliente[2] = rs.getString("apellido");
                cliente[3] = rs.getString("ci");
                lista.add(cliente);
            }

        } catch (SQLException ex) {
            Logger.getLogger(ventamodelo.class.getName()).log(Level.SEVERE, null, ex);
        }

        return lista;
    }

    public List<String[]> listarProductos() {
        List<String[]> lista = new ArrayList<>();
        String sql = "SELECT idproductos, pro_nombre, pro_precio, pro_iva FROM productos";

        try (Connection conn = conexion.obtenerConexion();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                String[] producto = new String[4];
                producto[0] = rs.getString("idproductos");
                producto[1] = rs.getString("pro_nombre");
                producto[2] = rs.getString("pro_precio");
                producto[3] = rs.getString("pro_iva");
                lista.add(producto);
            }

        } catch (SQLException ex) {
            Logger.getLogger(ventamodelo.class.getName()).log(Level.SEVERE, null, ex);
        }

        return lista;
    }

    public String guardarCabecera() {
        String idGenerado = "";
        String sql = "INSERT INTO ventas (ven_fecha, ven_condicion, ven_estado, idclientes, idusuarios) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = conexion.obtenerConexion();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, fecha);
            ps.setString(2, condicion);
            ps.setString(3, estado);
            ps.setString(4, cliente);
            ps.setString(5, usuario);
            ps.executeUpdate();

            String query = "SELECT MAX(idventas) AS id FROM ventas";
            try (PreparedStatement ps2 = conn.prepareStatement(query);
                 ResultSet rs = ps2.executeQuery()) {
                if (rs.next()) {
                    idGenerado = rs.getString("id");
                }
            }

        } catch (SQLException ex) {
            Logger.getLogger(ventamodelo.class.getName()).log(Level.SEVERE, null, ex);
        }

        return idGenerado;
    }
public void actualizarStock(String idproducto, int cantidadVendida) {
    String sql = "UPDATE productos SET pro_cantidad = pro_cantidad - ? WHERE idproductos = ?";
    try (Connection conn = conexion.obtenerConexion();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setInt(1, cantidadVendida);
        ps.setString(2, idproducto);
        ps.executeUpdate();
    } catch (SQLException ex) {
        Logger.getLogger(ventamodelo.class.getName()).log(Level.SEVERE, null, ex);
    }
}

  // Método para obtener el stock actual de un producto
public int obtenerStockActual(String idproducto) {
    int stock = 0;
    String sql = "SELECT pro_cantidad FROM productos WHERE idproductos = ?";
    try (Connection conn = conexion.obtenerConexion();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setString(1, idproducto);
        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                stock = rs.getInt("pro_cantidad");
            }
        }
    } catch (SQLException ex) {
        Logger.getLogger(ventamodelo.class.getName()).log(Level.SEVERE, null, ex);
    }
    return stock;
}

// Método para guardar el detalle de venta y actualizar stock sólo si hay suficiente stock
public boolean guardarDetalle(String idventa, String idproducto, String precio, int cantidad) {
    int stockActual = obtenerStockActual(idproducto);
    if (cantidad > stockActual) {
        // No hay suficiente stock
        return false;
    }

    String sqlDetalle = "INSERT INTO detalleventas (idventas, idproductos, det_cantidad, det_precio) VALUES (?, ?, ?, ?)";
    String sqlActualizarStock = "UPDATE productos SET pro_cantidad = pro_cantidad - ? WHERE idproductos = ?";

    try (Connection conn = conexion.obtenerConexion()) {
        conn.setAutoCommit(false); // iniciar transacción

        try (PreparedStatement psDetalle = conn.prepareStatement(sqlDetalle);
             PreparedStatement psActualizarStock = conn.prepareStatement(sqlActualizarStock)) {

            // Guardar detalle
            psDetalle.setString(1, idventa);
            psDetalle.setString(2, idproducto);
            psDetalle.setInt(3, cantidad);
            psDetalle.setString(4, precio);
            psDetalle.executeUpdate();

            // Actualizar stock
            psActualizarStock.setInt(1, cantidad);
            psActualizarStock.setString(2, idproducto);
            psActualizarStock.executeUpdate();

            conn.commit();
            return true;

        } catch (SQLException e) {
            conn.rollback();
            Logger.getLogger(ventamodelo.class.getName()).log(Level.SEVERE, null, e);
            return false;
        } finally {
            conn.setAutoCommit(true); // volver a modo autocommit
        }

    } catch (SQLException e) {
        Logger.getLogger(ventamodelo.class.getName()).log(Level.SEVERE, null, e);
        return false;
    }
}

   public int obtenerTotalVenta(int idventa) {
    int total = 0;
    String sql = "SELECT SUM(det_cantidad * det_precio) AS total FROM detalleventas WHERE idventas = ?";
    try (Connection conn = conexion.obtenerConexion();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setInt(1, idventa);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            total = rs.getInt("total");
        }
    } catch (SQLException ex) {
        ex.printStackTrace();
    }
    return total;
}

public String obtenerTotalEnLetras(int idventa) {
    int total = obtenerTotalVenta(idventa);
    return NumerosEnLetras.convertir(total);
}

// Clase estática para convertir a letras
public static class NumerosEnLetras {
     private static final String[] UNIDADES = {
        "", "uno", "dos", "tres", "cuatro", "cinco",
        "seis", "siete", "ocho", "nueve", "diez",
        "once", "doce", "trece", "catorce", "quince",
        "dieciséis", "diecisiete", "dieciocho", "diecinueve"
    };

    private static final String[] DECENAS = {
        "", "", "veinte", "treinta", "cuarenta", "cincuenta",
        "sesenta", "setenta", "ochenta", "noventa"
    };

    private static final String[] CENTENAS = {
        "", "ciento", "doscientos", "trescientos", "cuatrocientos",
        "quinientos", "seiscientos", "setecientos", "ochocientos", "novecientos"
    };

    public static String convertir(int numero) {
        if (numero == 0) return "cero guaraníes";
        if (numero == 100) return "cien guaraníes";
        return convertirNumero(numero).trim() + " guaraníes";
    }

    private static String convertirNumero(int numero) {
        StringBuilder resultado = new StringBuilder();

        if (numero >= 1_000_000) {
            int millones = numero / 1_000_000;
            resultado.append(millones == 1 ? "un millón " : convertirNumero(millones) + " millones ");
            numero %= 1_000_000;
        }

        if (numero >= 1000) {
            int miles = numero / 1000;
            resultado.append(miles == 1 ? "mil " : convertirNumero(miles) + " mil ");
            numero %= 1000;
        }

        if (numero >= 100) {
            resultado.append(CENTENAS[numero / 100]).append(" ");
            numero %= 100;
        }

        if (numero >= 20) {
            resultado.append(DECENAS[numero / 10]);
            if (numero % 10 != 0) {
                resultado.append(" y ").append(UNIDADES[numero % 10]);
            }
        } else if (numero > 0) {
            resultado.append(UNIDADES[numero]);
        }

        return resultado.toString();
    }
    

}

}
