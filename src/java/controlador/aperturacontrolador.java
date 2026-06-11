package controlador;

import java.io.IOException;
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
        // Método sin uso en este caso
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

        if (accion.equals("btnabrir")) {
            ape.setFecha(request.getParameter("txtfecha"));
            ape.setHora(request.getParameter("txthora"));
            ape.setMonto(request.getParameter("txtmonto"));
            ape.setIdusuario(request.getParameter("txtidusuario"));

            // Verificar si ya hay caja abierta antes de guardar
            String estado = ape.verificar(); // "cerrar" si ya hay una caja abierta

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
        return "Short description";
    }
}
