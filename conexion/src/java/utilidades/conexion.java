package utilidades;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class conexion {
    private static final String BD   = System.getenv("DB_NAME")     != null ? System.getenv("DB_NAME")     : "lineasport";
    private static final String USER = System.getenv("DB_USER")     != null ? System.getenv("DB_USER")     : "root";
    private static final String PASS = System.getenv("DB_PASSWORD") != null ? System.getenv("DB_PASSWORD") : "";
    private static final String HOST = System.getenv("DB_HOST")     != null ? System.getenv("DB_HOST")     : "localhost";
    private static final String PORT = System.getenv("DB_PORT")     != null ? System.getenv("DB_PORT")     : "3306";

    private static final String URL = "jdbc:mysql://" + HOST + ":" + PORT + "/" + BD 
    + "?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";

    public static Connection obtenerConexion() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(URL, USER, PASS);
            System.out.println("✅ CONEXIÓN EXITOSA A LA BASE DE DATOS");
            return conn;
        } catch (ClassNotFoundException | SQLException e) {
            System.err.println("❌ ERROR DE CONEXIÓN: " + e.getMessage());
            throw new SQLException("No se pudo conectar a la base de datos", e);
        }
    }

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