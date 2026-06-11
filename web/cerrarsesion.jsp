<%-- 
    Document   : cerrarsesion
    Created on : 27 may 2025, 18:20:47
    Author     : FernandoPS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% 
    session.invalidate();//rompe la variable de sesion
    //redirigir a login desde cerrar sesion
    response.sendRedirect("login.jsp");

%>


