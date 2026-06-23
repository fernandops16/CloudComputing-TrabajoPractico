package controlador;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.ventamodelo;

@WebServlet(name = "ventacontrolador", urlPatterns = {"/ventacontrolador"})
public class ventacontrolador extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // No usado, pero se mantiene para compatibilidad
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
        String pagina = "ventas.jsp";

        if ("nuevo".equals(accion)) {
            pagina = "ventanuevo.jsp";

        } else if ("guardarventa".equals(accion)) {
            try {
                // 1. Recuperar datos de la cabecera
                String fecha = request.getParameter("txtfecha");
                String condicion = request.getParameter("txtcondicion");
                String estado = request.getParameter("txtestado");
                String cliente = request.getParameter("idcliente");
                String usuario = request.getParameter("txtusuario");

                // 2. Crear objeto venta y cargar datos
                ventamodelo venta = new ventamodelo();
                venta.setFecha(fecha);
                venta.setCondicion(condicion);
                venta.setEstado(estado);
                venta.setCliente(cliente);
                venta.setUsuario(usuario);

                // 3. Guardar cabecera y obtener id venta
                String idventa = venta.guardarCabecera();

                // 4. Procesar detalle JSON
                String jsonDetalle = request.getParameter("jsonDetalle");

                if (jsonDetalle != null && !jsonDetalle.isEmpty()) {
                    org.json.JSONArray detalleArray = new org.json.JSONArray(jsonDetalle);
                    boolean stockSuficiente = true;

                    // Validar stock para cada producto antes de guardar
                    for (int i = 0; i < detalleArray.length(); i++) {
                        org.json.JSONObject item = detalleArray.getJSONObject(i);
                        String idproducto = item.optString("idproducto");
                        int cantidad = item.getInt("cantidad");

                        int stockActual = venta.obtenerStockActual(idproducto);
                        if (cantidad > stockActual) {
                            stockSuficiente = false;
                            request.setAttribute("mensaje", "❌ Stock insuficiente para el producto ID: " + idproducto);
                            break;
                        }
                    }

                    if (stockSuficiente) {
                        // Guardar detalles y actualizar stock
                        for (int i = 0; i < detalleArray.length(); i++) {
                            org.json.JSONObject item = detalleArray.getJSONObject(i);

                            String idproducto = item.optString("idproducto");
                            int cantidad = item.getInt("cantidad");
                            String precio = item.getString("precio");

                            boolean guardado = venta.guardarDetalle(idventa, idproducto, precio, cantidad);
                            if (!guardado) {
                                request.setAttribute("mensaje", "❌ Error al guardar detalle para producto ID: " + idproducto);
                                break;
                            }
                        }
                        if (request.getAttribute("mensaje") == null) {
                            request.setAttribute("mensaje", "✅ VENTA GUARDADA CORRECTAMENTE");
                        }
                    }
                } else {
                    request.setAttribute("mensaje", "⚠️ No se encontró el detalle de la venta.");
                }

            } catch (Exception e) {
                request.setAttribute("mensaje", "❌ ERROR al guardar la venta: " + e.getMessage());
            }

            pagina = "ventas.jsp";

        } else if ("imprimir".equals(accion)) {
            int idventa = Integer.parseInt(request.getParameter("txtid"));
            ventamodelo venta = new ventamodelo();
            String totalLetras = venta.obtenerTotalEnLetras(idventa);

            response.sendRedirect("rpt/rptimprimirventas.jsp?factura=" + idventa + "&letras=" + java.net.URLEncoder.encode(totalLetras, "UTF-8"));
            return;
        }

        request.getRequestDispatcher(pagina).forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
