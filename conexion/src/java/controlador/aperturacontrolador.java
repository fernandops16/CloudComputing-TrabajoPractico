package controlador;

import java.io.IOException;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.aperturamodelo;

@WebServlet(name = "aperturacontrolador", urlPatterns = {"/aperturacontrolador"})
public class aperturacontrolador extends HttpServlet {

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

        processRequest(request, response);

        String accion = request.getParameter("accion");
        aperturamodelo ape = new aperturamodelo();

        if ("btnabrir".equals(accion)) {

            ape.setFecha(request.getParameter("txtfecha"));

            // ✔️ Hora corregida +1 hora (parche)
            LocalTime horaActual = LocalTime.now().plusHours(1);
            DateTimeFormatter formato = DateTimeFormatter.ofPattern("HH:mm:ss");
            String horaCorregida = horaActual.format(formato);

            ape.setHora(horaCorregida);

            ape.setMonto(request.getParameter("txtmonto"));
            ape.setIdusuario(request.getParameter("txtidusuario"));

            // Verificar si ya hay caja abierta
            String estado = ape.verificar();

            if ("cerrar".equals(estado)) {
                request.setAttribute("mensaje", "❌ Ya hay una caja abierta. Debe cerrarla antes de abrir una nueva.");
            } else if ("error".equals(estado)) {
                request.setAttribute("mensaje", "⚠ Error al verificar el estado de la caja.");
            } else {
                ape.guardar();
                request.setAttribute("mensaje", ape.getMensaje());
            }
        }

        request.getRequestDispatcher("apertura.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Controlador de apertura de caja";
    }
}