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
        // No se usa
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

            // =========================
            // HORA Y FECHA +1 AJUSTADA
            // =========================
            java.util.Calendar cal = java.util.Calendar.getInstance();
            cal.add(java.util.Calendar.HOUR_OF_DAY, 1);

            java.util.Date ahora = cal.getTime();

            java.text.SimpleDateFormat sdfFecha =
                    new java.text.SimpleDateFormat("yyyy-MM-dd");

            java.text.SimpleDateFormat sdfHora =
                    new java.text.SimpleDateFormat("HH:mm:ss");

            cie.setFecha(sdfFecha.format(ahora));
            cie.setHora(sdfHora.format(ahora));

            cie.setMonto(request.getParameter("txtmonto"));
            cie.setIdapertura(request.getParameter("txtapertura"));

            // Ejecutar cierre
            cie.cerrarcaja();
            cie.actualizarapertura();

            request.setAttribute("mensajecie", "✅ CAJA CERRADA CORRECTAMENTE");
        }

        request.getRequestDispatcher("cierre.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Controlador de cierre de caja";
    }
}