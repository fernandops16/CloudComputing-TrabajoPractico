package utilidades;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class conexion {

    private static final String BD = "lineasport";
    private static final String USER = "root";
    private static final String PASS = "";
    private static final String URL = "jdbc:mysql://localhost:3306/" + BD + "?useSSL=false&serverTimezone=UTC";

    // Método para obtener conexión segura
    public static Connection obtenerConexion() throws SQLException {
        Connection conn = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(URL, USER, PASS);
            System.out.println("✅ CONEXIÓN EXITOSA A LA BASE DE DATOS");
        } catch (ClassNotFoundException | SQLException e) {
            System.err.println("❌ ERROR DE CONEXIÓN: " + e.getMessage());
            throw new SQLException("No se pudo conectar a la base de datos", e);
        }
        return conn;
    }

    // Método para cerrar conexión de forma segura
    public static void cerrarConexion(Connection conn) {
        try {
            if (conn != null && !conn.isClosed()) {
                conn.close();
                System.out.println("🔒 Conexión cerrada correctamente");
            }
        } catch (SQLException e) {
            System.err.println("❗ Error al cerrar la conexión: " + e.getMessage());
        }
    }
}
