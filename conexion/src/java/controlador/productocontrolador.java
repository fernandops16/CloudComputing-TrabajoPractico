/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controlador;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.productomodelo;

/**
 *
 * @author ALUMNO
 */
@WebServlet(name = "productocontrolador", urlPatterns = {"/productocontrolador"})
public class productocontrolador extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
   @Override
protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

    String accion = request.getParameter("accion");
    productomodelo p1 = new productomodelo();
    String pagina = "productos.jsp";

    if ("guardar".equals(accion)) {
        p1.setCodigo(request.getParameter("txtcodigo"));
        p1.setNombre(request.getParameter("txtnombre"));
        p1.setCantidad(request.getParameter("txtcantidad"));
        p1.setPrecio(request.getParameter("txtprecio"));
        p1.setIva(request.getParameter("txtiva"));
        p1.setCosto(request.getParameter("txtcosto"));
        p1.guardar();
        request.setAttribute("mensaje", p1.getMensaje()); // ✅ mensaje real
    } else if ("eliminar".equals(accion)) {
        String codigo = request.getParameter("txtcodigo");
        p1.eliminar(codigo);
        request.setAttribute("mensaje", p1.getMensaje()); // ✅ mensaje real
    } else if ("actualizar".equals(accion)) {
        p1.setCodigo(request.getParameter("txtcodigo"));
        p1.setNombre(request.getParameter("txtnombre"));
        p1.setPrecio(request.getParameter("txtprecio"));
        p1.setCantidad(request.getParameter("txtcantidad"));
        p1.setIva(request.getParameter("txtiva"));
        p1.setCosto(request.getParameter("txtcosto"));
        p1.actualizar();
        request.setAttribute("mensaje", p1.getMensaje()); // ✅ mensaje real
    } else if ("informe".equals(accion)) {
        pagina = "rpt/rptproductos.jsp";
    }

    request.getRequestDispatcher(pagina).forward(request, response);
}

    

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
