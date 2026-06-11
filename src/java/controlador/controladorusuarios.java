package controlador;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import modelo.usuariomodelo;
import modelo.personalesmodelo;
@WebServlet(name = "controladorusuarios", urlPatterns = {"/controladorusuarios"})
public class controladorusuarios extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
modelo.personalesmodelo p = new modelo.personalesmodelo();
request.setAttribute("personales", p.listar());
        String accion = request.getParameter("accion");

        if ("editar".equals(accion)) {
            String id = request.getParameter("idusuarios");

            if (id != null && !id.isEmpty()) {
                usuariomodelo modelo = new usuariomodelo();
                usuariomodelo usuario = modelo.obtenerPorId(id);

                if (usuario != null) {
                    request.setAttribute("editar", usuario);
                    request.setAttribute("abrirModalEditar", true); // En tu JSP verificás este atributo
                } else {
                    request.setAttribute("mensaje", "Usuario no encontrado.");
                }
            } else {
                request.setAttribute("mensaje", "ID inválido para editar.");
            }
        }

        // Siempre cargar lista de usuarios
        usuariomodelo usu = new usuariomodelo();
        request.setAttribute("usuarios", usu.listar());
        request.getRequestDispatcher("usuarios.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
modelo.personalesmodelo p = new modelo.personalesmodelo();
request.setAttribute("personales", p.listar());
        String accion = request.getParameter("accion");
        usuariomodelo usuario = new usuariomodelo();

        if ("guardar".equals(accion)) {
            usuario.setIdusuarios(request.getParameter("txtcodigo"));
            usuario.setUsu_nombre(request.getParameter("txtnombre"));
            usuario.setUsu_clave(request.getParameter("txtclave"));
            usuario.setUsu_tipo(request.getParameter("txttipo"));
            usuario.setUsu_estado(request.getParameter("txtestado"));
            usuario.setIdpersonales(request.getParameter("txtidpersonal"));
            usuario.guardar();

        } else if ("actualizar".equals(accion)) {
            usuario.setIdusuarios(request.getParameter("txtcodigo"));
            usuario.setUsu_nombre(request.getParameter("txtnombre"));
            usuario.setUsu_clave(request.getParameter("txtclave"));
            usuario.setUsu_tipo(request.getParameter("txttipo"));
            usuario.setUsu_estado(request.getParameter("txtestado"));
            usuario.setIdpersonales(request.getParameter("txtidpersonal"));
            usuario.editar();

        } else if ("eliminar".equals(accion)) {
            usuario.setIdusuarios(request.getParameter("txtcodigo"));
            usuario.eliminar();
        }if(accion.equals("informe")){
    response.sendRedirect("rpt/rptusuarios.jsp"); // O como se llame tu reporte Jasper
    return ;
}

        // Después de cualquier acción, recarga la lista
        request.setAttribute("mensaje", usuario.getMensaje());
        usuariomodelo usu = new usuariomodelo();
        request.setAttribute("usuarios", usu.listar());
        request.getRequestDispatcher("usuarios.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Controlador de usuarios";
    }
}
