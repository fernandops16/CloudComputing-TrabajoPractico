package modelo;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import utilidades.conexion;

public class usuariomodelo {

    private String idusuarios, usu_nombre, usu_clave, usu_tipo, usu_estado, idpersonales, mensaje;

    public String getIdusuarios() {
        return idusuarios;
    }
    public void setIdusuarios(String idusuarios) {
        this.idusuarios = idusuarios;
    }
    public String getUsu_nombre() {
        return usu_nombre;
    }
    public void setUsu_nombre(String usu_nombre) {
        this.usu_nombre = usu_nombre;
    }
    public String getUsu_clave() {
        return usu_clave;
    }
    public void setUsu_clave(String usu_clave) {
        this.usu_clave = usu_clave;
    }
    public String getUsu_tipo() {
        return usu_tipo;
    }
    public void setUsu_tipo(String usu_tipo) {
        this.usu_tipo = usu_tipo;
    }
    public String getUsu_estado() {
        return usu_estado;
    }
    public void setUsu_estado(String usu_estado) {
        this.usu_estado = usu_estado;
    }
    public String getIdpersonales() {
        return idpersonales;
    }
    public void setIdpersonales(String idpersonales) {
        this.idpersonales = idpersonales;
    }
    public String getMensaje() {
        return mensaje;
    }

    // Método para convertir texto a SHA-256
    private String hashSHA256(String input) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hashBytes = md.digest(input.getBytes());
            StringBuilder sb = new StringBuilder();
            for (byte b : hashBytes) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("Error al generar hash SHA-256", e);
        }
    }

    // Guardar usuario
    public void guardar() {
        Connection con = null;
        PreparedStatement pst = null;
        try {
            con = conexion.obtenerConexion();
            String sql = "INSERT INTO usuarios(idusuarios, usu_nombre, usu_clave, usu_tipo, usu_estado, idpersonales) VALUES (?, ?, ?, ?, ?, ?)";
            pst = con.prepareStatement(sql);
            pst.setString(1, idusuarios);
            pst.setString(2, usu_nombre);
            pst.setString(3, hashSHA256(usu_clave)); // Convertir a SHA-256
            pst.setString(4, usu_tipo);
            pst.setString(5, usu_estado);
            pst.setString(6, idpersonales);
            pst.executeUpdate();
            mensaje = "Usuario guardado correctamente";
        } catch (SQLException e) {
            mensaje = "Error al guardar usuario: " + e.getMessage();
        } finally {
            try { if (pst != null) pst.close(); } catch (SQLException e) { System.err.println(e.getMessage()); }
            conexion.cerrarConexion(con);
        }
    }

    // Listar usuarios
    public List<usuariomodelo> listar() {
        List<usuariomodelo> lista = new ArrayList<>();
        Connection con = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        try {
            con = conexion.obtenerConexion();
            String sql = "SELECT * FROM usuarios";
            pst = con.prepareStatement(sql);
            rs = pst.executeQuery();
            while (rs.next()) {
                usuariomodelo u = new usuariomodelo();
                u.setIdusuarios(rs.getString("idusuarios"));
                u.setUsu_nombre(rs.getString("usu_nombre"));
                u.setUsu_clave(rs.getString("usu_clave"));
                u.setUsu_tipo(rs.getString("usu_tipo"));
                u.setUsu_estado(rs.getString("usu_estado"));
                u.setIdpersonales(rs.getString("idpersonales"));
                lista.add(u);
            }
        } catch (SQLException e) {
            mensaje = "Error al listar usuarios: " + e.getMessage();
        } finally {
            try { if (rs != null) rs.close(); } catch (SQLException e) { System.err.println(e.getMessage()); }
            try { if (pst != null) pst.close(); } catch (SQLException e) { System.err.println(e.getMessage()); }
            conexion.cerrarConexion(con);
        }
        return lista;
    }

    // Obtener usuario por idusuarios
    public usuariomodelo obtenerPorId(String id) {
        usuariomodelo u = null;
        Connection con = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        try {
            con = conexion.obtenerConexion();
            String sql = "SELECT * FROM usuarios WHERE idusuarios = ?";
            pst = con.prepareStatement(sql);
            pst.setString(1, id);
            rs = pst.executeQuery();
            if (rs.next()) {
                u = new usuariomodelo();
                u.setIdusuarios(rs.getString("idusuarios"));
                u.setUsu_nombre(rs.getString("usu_nombre"));
                u.setUsu_clave(rs.getString("usu_clave"));
                u.setUsu_tipo(rs.getString("usu_tipo"));
                u.setUsu_estado(rs.getString("usu_estado"));
                u.setIdpersonales(rs.getString("idpersonales"));
            }
        } catch (SQLException e) {
            mensaje = "Error al obtener usuario: " + e.getMessage();
        } finally {
            try { if (rs != null) rs.close(); } catch (SQLException e) { System.err.println(e.getMessage()); }
            try { if (pst != null) pst.close(); } catch (SQLException e) { System.err.println(e.getMessage()); }
            conexion.cerrarConexion(con);
        }
        return u;
    }

    // Editar usuario
    public void editar() {
        Connection con = null;
        PreparedStatement pst = null;
        try {
            con = conexion.obtenerConexion();
            String sql = "UPDATE usuarios SET usu_nombre=?, usu_clave=?, usu_tipo=?, usu_estado=?, idpersonales=? WHERE idusuarios=?";
            pst = con.prepareStatement(sql);
            pst.setString(1, usu_nombre);
            pst.setString(2, hashSHA256(usu_clave)); // Convertir a SHA-256
            pst.setString(3, usu_tipo);
            pst.setString(4, usu_estado);
            pst.setString(5, idpersonales);
            pst.setString(6, idusuarios);
            pst.executeUpdate();
            mensaje = "Usuario actualizado correctamente";
        } catch (SQLException e) {
            mensaje = "Error al actualizar usuario: " + e.getMessage();
        } finally {
            try { if (pst != null) pst.close(); } catch (SQLException e) { System.err.println(e.getMessage()); }
            conexion.cerrarConexion(con);
        }
    }

    // Eliminar usuario
    public void eliminar() {
        Connection con = null;
        PreparedStatement pst = null;
        try {
            con = conexion.obtenerConexion();
            String sql = "DELETE FROM usuarios WHERE idusuarios = ?";
            pst = con.prepareStatement(sql);
            pst.setString(1, idusuarios);
            pst.executeUpdate();
            mensaje = "Usuario eliminado correctamente";
        } catch (SQLException e) {
            mensaje = "Error al eliminar usuario: " + e.getMessage();
        } finally {
            try { if (pst != null) pst.close(); } catch (SQLException e) { System.err.println(e.getMessage()); }
            conexion.cerrarConexion(con);
        }
    }
}
