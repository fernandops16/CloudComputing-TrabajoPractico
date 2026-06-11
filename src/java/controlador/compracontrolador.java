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
import modelo.compramodelo;

/**
 *
 * @author FernandoPS
 */
@WebServlet(name = "compracontrolador", urlPatterns = {"/compracontrolador"})
public class compracontrolador extends HttpServlet {

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
        String pagina = "compra.jsp";

        if ("nuevo".equals(accion)) {
            pagina = "nuevacompra.jsp";

        } else if ("guardarcompra".equals(accion)) {
            try {
                // 1. Capturar datos del formulario
                String fecha = request.getParameter("txtfecha");
                String condicion = request.getParameter("txtcondicion");
                String estado = request.getParameter("txtestado");
                String proveedor = request.getParameter("idproveedor");
                String usuario = request.getParameter("txtusuario");

                // 2. Crear objeto del modelo
                compramodelo compra = new compramodelo();
                compra.setFecha(fecha);
                compra.setCondicion(condicion);
                compra.setEstado(estado);
                compra.setProveedor(proveedor);
                compra.setUsuario(usuario);

                // 3. Guardar cabecera y obtener el ID generado
                String idcompra = compra.guardarCabecera();

                // 4. Guardar detalle desde el JSON recibido
                String jsonDetalle = request.getParameter("jsonDetalle");

                if (jsonDetalle != null && !jsonDetalle.isEmpty()) {
                    org.json.JSONArray detalleArray = new org.json.JSONArray(jsonDetalle);

                    for (int i = 0; i < detalleArray.length(); i++) {
                        org.json.JSONObject item = detalleArray.getJSONObject(i);

                        String idproducto = item.optString("idproducto");
                        String cantidad = item.getString("cantidad");
                        String precio = item.getString("precio");

                        compra.guardarDetalle(idcompra, idproducto, precio, cantidad);
                    }

                    request.setAttribute("mensaje", "✅ COMPRA GUARDADA CORRECTAMENTE");
                } else {
                    request.setAttribute("mensaje", "⚠️ No se recibió detalle de la compra.");
                }

            } catch (Exception e) {
                request.setAttribute("mensaje", "❌ ERROR al guardar la compra: " + e.getMessage());
            }

            pagina = "compra.jsp";

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
