<%@page import="java.util.List"%>
<%@page import="modelo.ventamodelo"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Formulario Ventas</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap y Font Awesome -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" crossorigin="anonymous" referrerpolicy="no-referrer" />

    <link rel="stylesheet" href="CSS/estilo.css"/>
    <script src="JS/scriptventa.js"></script>
</head>
<body>

<%
    String usuario = (String) session.getAttribute("usuario");
    if (usuario == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
 <header>
            <nav class="navbar navbar-expand-lg">
                <div class="container-fluid">
                    <a class="navbar-brand" href="#">
                <form action="menucontrolador" method="POST" class="d-inline">
                    <button type="submit" name="accion" value="home" class="btn p-0 border-0">
                        <img src="IMG/logo.png" alt="Inicio"
     class="navbar-brand-img"
     style="height: 80px; width: 80px; border-radius: 50%; object-fit: cover;"/>

                    </button>
                </form>
            </a>

                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>

                    <div class="collapse navbar-collapse" id="navbarNav">
                        <ul class="navbar-nav">
                            <li class="nav-item dropdown"> <%-- Item del menú desplegable --%>
                                <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                    GESTIÓN
                                </a>
                                <ul class="dropdown-menu"> <%-- Contenido del menú desplegable --%>
                                    <li>
                                        <form action="menucontrolador" method="post" class="d-inline">
                                            <button type="submit" name="accion" value="productos" class="dropdown-item">PRODUCTOS</button>
                                        </form>
                                    </li>
                                    <li>
                                        <form action="menucontrolador" method="post" class="d-inline">
                                            <button type="submit" name="accion" value="clientes" class="dropdown-item">CLIENTES</button>
                                        </form>
                                    </li>
                                    <li>
                                        <form action="menucontrolador" method="post" class="d-inline">
                                            <button type="submit" name="accion" value="personal" class="dropdown-item">PERSONALES</button>
                                        </form>
                                    </li>
                                    <li>
                                        <form action="menucontrolador" method="post" class="d-inline">
                                            <button type="submit" name="accion" value="proveedor" class="dropdown-item">PROVEEDORES</button>
                                        </form>
                                    </li>
                                     <li>
                                        <form action="menucontrolador" method="post" class="d-inline">
                                           <input type="hidden" name="txtcodusu" value="<%= session.getAttribute("codigo")%>">
                                            <button type="submit" name="accion" value="usuarios" class="dropdown-item">USUARIOS</button>
                                        </form>
                                    </li>
                                   
                                </ul>
                            </li>
                             <li class="nav-item dropdown"> <%-- Item del menú desplegable --%>
                                <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                    COMPRA Y VENTAS
                                </a>
                                <ul class="dropdown-menu"> <%-- Contenido del menú desplegable --%>
                                    <li>
                                        <form action="menucontrolador" method="post" class="d-inline">
                                            <button type="submit" name="accion" value="compra" class="dropdown-item">COMPRAS</button>
                                        </form>
                                    </li>
                                    <li>
                                        <form action="menucontrolador" method="post" class="d-inline">
                                            <button type="submit" name="accion" value="ventas" class="dropdown-item">VENTAS</button>
                                        </form>
                                    </li>
                                     </ul>
                            </li>
                             <li class="nav-item dropdown"> <%-- Item del menú desplegable --%>
                                <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                    CIERRE Y APERTURA
                                </a>
                                <ul class="dropdown-menu"> <%-- Contenido del menú desplegable --%>
                                    <li>
                                        <form action="menucontrolador" method="post" class="d-inline">
                                            <button type="submit" name="accion" value="apertura" class="dropdown-item">APERTURA DE CAJA</button>
                                        </form>
                                    </li>
                                    <li>
                                        <form action="menucontrolador" method="post" class="d-inline">
                                            <button type="submit" name="accion" value="cerrar" class="dropdown-item">CIERRE DE CAJA</button>
                                        </form>
                                    </li>
                                     </ul>
                            </li>
    
                            <li class="nav-item">
                                <form action="menucontrolador" method="post" class="d-inline">
                                    <button type="submit" name="accion" value="cerrarsesion" class="nav-link">CERRAR SESION</button>
                                </form>
                            </li>
                        </ul>
                    </div>
                </div>
            </nav>
        </header>
<!-- CONTENIDO PRINCIPAL -->
<main >
    <h1 class="mb-4">FORMULARIO VENTAS</h1>

    <% String mensaje = (String) request.getAttribute("mensaje"); %>
    <% if (mensaje != null) { %>
        <div class="alert alert-success"><%= mensaje %></div>
    <% } %>

    <!-- Botón Nueva Venta -->
    <form action="ventacontrolador" method="POST" class="mb-3">
        <button name="accion" value="nuevo" class="btn btn-primary">NUEVA VENTA</button>
    </form>

    <!-- Cargar datos -->
    <%
        ventamodelo v = new ventamodelo();
        List<ventamodelo> lista = v.listar();
    %>

    <!-- Tabla -->
    <div class="table-responsive">
        <table class="table table-striped table-hover table-bordered">
            <thead class="table-dark">
                <tr>
                    <th>ID</th>
                    <th>FECHA</th>
                    <th>CONDICIÓN</th>
                    <th>ESTADO</th>
                    <th>CLIENTE</th>
                    <th>USUARIO</th>
                    <th>ACCIONES</th>
                </tr>
            </thead>
            <tbody>
                <% for (ventamodelo venta : lista) { %>
                    <tr>
                        <td><%= venta.getId() %></td>
                        <td><%= venta.getFecha() %></td>
                        <td><%= venta.getCondicion() %></td>
                        <td><%= venta.getEstado() %></td>
                        <td><%= venta.getCliente() %></td>
                        <td><%= venta.getUsuario() %></td>
                        <td>
                            <form action="ventacontrolador" method="POST" class="d-inline" target="_blank">
                                <input type="hidden" name="txtid" value="<%= venta.getId() %>">
                                <button name="accion" value="imprimir" class="btn btn-warning btn-sm">IMPRIMIR</button>
                            </form>
                        </td>
                    </tr>
                <% } %>
            </tbody>
        </table>
    </div>
</main>

<!-- FOOTER -->
 <footer>
            <div class="container text-center">
                <p>Usuario actual: <strong><%=session.getAttribute("usuario")%></strong></p>
                <p>© 2025 LINEASPORT. Todos los derechos reservados.</p>
            </div>
        </footer>

<!-- Scripts -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
</body>
</html>
