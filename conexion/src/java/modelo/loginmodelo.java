package modelo;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.Duration;
import java.time.Instant;
import java.util.logging.Level;
import java.util.logging.Logger;

public class loginmodelo {
    private String usuario, clave, tipo, codigo;

    public String getUsuario() {
        return usuario;
    }

    public void setUsuario(String usuario) {
        this.usuario = usuario;
    }

    public String getClave() {
        return clave;
    }

    public void setClave(String clave) {
        this.clave = clave;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    public String getCodigo() {
        return codigo;
    }

    public void setCodigo(String codigo) {
        this.codigo = codigo;
    }

public String iniciar() {
    String mensaje = "ERROR";
    final int MAX_INTENTOS = 3;
    final long BLOQUEO_MS = 60 * 1000; // 1 minuto

    String sqlConsulta = "SELECT * FROM usuarios WHERE usu_nombre = ?";
    String sqlResetIntentos = "UPDATE usuarios SET intentos_fallidos = 0, ultimo_intento = NULL WHERE usu_nombre = ?";
    String sqlActualizarIntentos = "UPDATE usuarios SET intentos_fallidos = ?, ultimo_intento = ? WHERE usu_nombre = ?";
    String sqlActualizarClave = "UPDATE usuarios SET usu_clave = ? WHERE usu_nombre = ?";

    try (
        Connection conn = utilidades.conexion.obtenerConexion();
        PreparedStatement psConsulta = conn.prepareStatement(sqlConsulta);
    ) {
        psConsulta.setString(1, usuario);
        try (ResultSet rs = psConsulta.executeQuery()) {
            if (rs.next()) {
                int intentos = rs.getInt("intentos_fallidos");
                Timestamp ultimoIntento = rs.getTimestamp("ultimo_intento");
                Timestamp ahora = new Timestamp(System.currentTimeMillis());
                String claveBD = rs.getString("usu_clave");

                // Verificar bloqueo
                if (intentos >= MAX_INTENTOS && ultimoIntento != null) {
                    long diferencia = ahora.getTime() - ultimoIntento.getTime();
                    if (diferencia < BLOQUEO_MS) {
                        long segRestantes = (BLOQUEO_MS - diferencia) / 1000;
                        mensaje = "USUARIO BLOQUEADO. INTENTE NUEVO EN " + segRestantes + " SEGUNDOS.";
                        return mensaje;
                    } else {
                        try (PreparedStatement psReset = conn.prepareStatement(sqlResetIntentos)) {
                            psReset.setString(1, usuario);
                            psReset.executeUpdate();
                        }
                        intentos = 0;
                    }
                }

                // Determinar si claveBD es hash SHA-256 (64 caracteres hex)
                boolean esHash = claveBD != null && claveBD.matches("^[a-fA-F0-9]{64}$");

                if (!esHash) {
                    // La clave en BD es texto plano
                    if (claveBD.equals(clave)) {
                        // Actualizar clave a SHA-256
                        String claveHash = sha256(clave);
                        try (PreparedStatement psActClave = conn.prepareStatement(sqlActualizarClave)) {
                            psActClave.setString(1, claveHash);
                            psActClave.setString(2, usuario);
                            psActClave.executeUpdate();
                        }
                        claveBD = claveHash; // Actualizamos variable para comparar luego
                    } else {
                        // Clave incorrecta
                        intentos++;
                        try (PreparedStatement psActualizar = conn.prepareStatement(sqlActualizarIntentos)) {
                            psActualizar.setInt(1, intentos);
                            psActualizar.setTimestamp(2, ahora);
                            psActualizar.setString(3, usuario);
                            psActualizar.executeUpdate();
                        }
                        mensaje = (intentos >= MAX_INTENTOS) ? "USUARIO BLOQUEADO POR 1 MINUTO POR DEMASIADOS INTENTOS FALLIDOS" : "USUARIO O CLAVE INCORRECTOS";
                        return mensaje;
                    }
                }

                // Ahora claveBD debe ser hash, comparamos hash de clave ingresada con claveBD
                String claveIngresadaHash = sha256(clave);
                if (claveBD.equalsIgnoreCase(claveIngresadaHash)) {
                    // Login exitoso
                    try (PreparedStatement psReset = conn.prepareStatement(sqlResetIntentos)) {
                        psReset.setString(1, usuario);
                        psReset.executeUpdate();
                    }
                    mensaje = "ok";
                    codigo = rs.getString("idusuarios");
                    tipo = rs.getString("usu_tipo");
                } else {
                    // Clave incorrecta
                    intentos++;
                    try (PreparedStatement psActualizar = conn.prepareStatement(sqlActualizarIntentos)) {
                        psActualizar.setInt(1, intentos);
                        psActualizar.setTimestamp(2, ahora);
                        psActualizar.setString(3, usuario);
                        psActualizar.executeUpdate();
                    }
                    mensaje = (intentos >= MAX_INTENTOS) ? "USUARIO BLOQUEADO POR 1 MINUTO POR DEMASIADOS INTENTOS FALLIDOS" : "USUARIO O CLAVE INCORRECTOS";
                }
            } else {
                mensaje = "USUARIO O CLAVE INCORRECTOS";
            }
        }
    } catch (SQLException ex) {
        Logger.getLogger(loginmodelo.class.getName()).log(Level.SEVERE, null, ex);
        mensaje = "ERROR DE BASE DE DATOS";
    }
    return mensaje;
}

    public static String sha256(String base) {
    try {
        MessageDigest digest = MessageDigest.getInstance("SHA-256");
        byte[] hash = digest.digest(base.getBytes("UTF-8"));
        StringBuilder hexString = new StringBuilder();
        for (byte b : hash) {
            String hex = Integer.toHexString(0xff & b);
            if (hex.length() == 1) hexString.append('0');
            hexString.append(hex);
        }
        return hexString.toString();
    } catch (Exception ex) {
        throw new RuntimeException(ex);
    }
}
}
