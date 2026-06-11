<%@page import="java.util.Map"%>
<%@page import="java.sql.Connection"%>
<%@page import="net.sf.jasperreports.engine.JasperExportManager"%>
<%@page import="net.sf.jasperreports.engine.JasperPrint"%>
<%@page import="net.sf.jasperreports.engine.JasperFillManager"%>
<%@page import="java.util.HashMap"%>
<%@page import="utilidades.conexion"%>

<%
    Connection conn = null;
    try {
        conn = conexion.obtenerConexion();

        String ruta = application.getRealPath("REPORTES/report1.jasper");

        Map<String, Object> parametros = new HashMap<>();

        String idFactura = request.getParameter("factura");
        String letras = request.getParameter("letras");

        if (idFactura != null && !idFactura.trim().isEmpty()) {
            parametros.put("factura", Integer.parseInt(idFactura));
        } else {
            out.println("No se recibió el parámetro 'factura'.");
            return;
        }

        if (letras != null && !letras.isEmpty()) {
            parametros.put("letras", letras);
        }

        JasperPrint jasperPrint = JasperFillManager.fillReport(ruta, parametros, conn);
        byte[] bytes = JasperExportManager.exportReportToPdf(jasperPrint);

        response.setContentType("application/pdf");
        response.setContentLength(bytes.length);
        response.getOutputStream().write(bytes);
        response.getOutputStream().flush();
        response.getOutputStream().close();
        return;
    } catch (Exception e) {
        out.println("Error al generar el reporte: " + e.getMessage());
    } finally {
        if (conn != null) conn.close();
    }
%>
