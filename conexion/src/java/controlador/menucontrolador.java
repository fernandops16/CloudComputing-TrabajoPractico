package controlador;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.aperturamodelo;

@WebServlet(name = "menucontrolador", urlPatterns = {"/menucontrolador"})
public class menucontrolador extends HttpServlet {

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
        String pagina = "";

        aperturamodelo ape = new aperturamodelo();
        ape.setIdusuario((String) request.getSession().getAttribute("codigo"));
        boolean cajaAbierta = "cerrar".equals(ape.verificar());

        if ("productos".equals(accion)) {
            pagina = "productos.jsp";
        } else if ("clientes".equals(accion)) {
            pagina = "clientes.jsp";
        } else if ("personal".equals(accion)) {
            pagina = "personales.jsp";
        } else if ("proveedor".equals(accion)) {
            pagina = "proveedores.jsp";
        } else if ("home".equals(accion)) {
            pagina = "index.jsp";
        } else if ("usuarios".equals(accion)) {
            pagina = "usuarios.jsp";
        } else if ("ventas".equals(accion)) {
            if (cajaAbierta) {
                pagina = "ventas.jsp";
            } else {
                pagina = "index.jsp";
                request.setAttribute("mensaje", "Debe tener una caja abierta para acceder a VENTAS");
            }
        } else if ("compra".equals(accion)) {
            if (cajaAbierta) {
                pagina = "compra.jsp";
            } else {
                pagina = "index.jsp";
                request.setAttribute("mensaje", "Debe tener una caja abierta para acceder a COMPRAS");
            }
        } else if ("cerrarsesion".equals(accion)) {
            pagina = "cerrarsesion.jsp";
        } else if ("apertura".equals(accion)) {
            ape.setIdusuario(request.getParameter("txtcodusu"));
            if ("abrir".equals(ape.verificar())) {
                pagina = "apertura.jsp";
            } else {
                pagina = "index.jsp";
                request.setAttribute("mensaje", "NO SE PUEDE ABRIR CAJA, CIERRE LA CAJA ABIERTA PRIMERO");
            }
        } else if ("cerrar".equals(accion)) {
            pagina = "cierre.jsp";
        }

        request.getRequestDispatcher(pagina).forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
