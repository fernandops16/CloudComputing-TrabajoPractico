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
import modelo.personalesmodelo;

/**
 *
 * @author FernandoPS
 */
@WebServlet(name = "personalescontrolador", urlPatterns = {"/personalescontrolador"})
public class personalescontrolador extends HttpServlet {

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
        processRequest(request, response);
        String accion = request.getParameter("accion");
        
        personalesmodelo p1 = new personalesmodelo();
        if(accion.equals("guardar")){
            p1.setCodigo(request.getParameter("txtcodigo"));
            p1.setNombre(request.getParameter("txtnombre"));
            p1.setApellido(request.getParameter("txtapellido"));
            p1.setCi(request.getParameter("txtci"));
            p1.setTelefono(request.getParameter("txttelefono"));
            p1.guardar();
        }else if("actualizar".equals(accion)){
            p1.setCodigo(request.getParameter("txtcodigo"));
            p1.setNombre(request.getParameter("txtnombre"));
            p1.setApellido(request.getParameter("txtapellido"));
            p1.setCi(request.getParameter("txtci"));
            p1.setTelefono(request.getParameter("txttelefono"));
            p1.actualizar();
            request.setAttribute("mensaje", p1);
        }else if("eliminar".equals(accion)){
            String codigo = request.getParameter("txtcodigo");
            p1.eliminar(codigo);
            request.setAttribute("mensaje", p1);
        }if(accion.equals("informe")){
    response.sendRedirect("rpt/rptpersonal.jsp"); // O como se llame tu reporte Jasper
    return ;
}
        request.setAttribute("mensaje", p1);
        request.getRequestDispatcher("personales.jsp").forward(request, response);
        
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
