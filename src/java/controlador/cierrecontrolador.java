package controlador;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.cierremodelo;

@WebServlet(name = "cierrecontrolador", urlPatterns = {"/cierrecontrolador"})
public class cierrecontrolador extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // No se usa en este caso
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");
        cierremodelo cie = new cierremodelo();

        if ("btncerrar".equals(accion)) {
            // Fecha y hora actuales para seguridad
            java.text.SimpleDateFormat sdfFecha = new java.text.SimpleDateFormat("yyyy-MM-dd");
            java.text.SimpleDateFormat sdfHora = new java.text.SimpleDateFormat("HH:mm:ss");
            java.util.Date ahora = new java.util.Date();

            cie.setFecha(sdfFecha.format(ahora));
            cie.setHora(sdfHora.format(ahora));
            cie.setMonto(request.getParameter("txtmonto"));
            cie.setIdapertura(request.getParameter("txtapertura"));

            cie.cerrarcaja();
            cie.actualizarapertura();

            request.setAttribute("mensajecie", "✅ CAJA CERRADA CORRECTAMENTE");
        }

        request.getRequestDispatcher("cierre.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet para cerrar caja";
    }
}
