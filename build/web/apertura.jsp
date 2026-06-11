<%-- 
    Document   : apertura
    Created on : 27 may 2025, 19:05:34
    Author     : FernandoPS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Menú Principal - Tu Sistema</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFdV7zJcWtm7sB/fA/fLwW6R9z04JdG+s" crossorigin="anonymous" referrerpolicy="no-referrer" />

        <link rel="stylesheet" href="CSS/estilo.css"/>
    </head>
    <body>
        <%
            String usuario = (String) session.getAttribute("usuario");

            if(usuario == null){
                response.sendRedirect("login.jsp");
                return;
            }

            // Verificar si hay caja abierta para este usuario
            modelo.aperturamodelo ape = new modelo.aperturamodelo();
            String codigoUsuario = (String) session.getAttribute("codigo");
            ape.setIdusuario(codigoUsuario);
            String estadoCaja = ape.verificar(); // "cerrar" si ya hay caja abierta

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

<main class="container mt-5 p-4 rounded shadow" style="max-width: 500px;">
    <h2 class="text-center mb-4 text-primary">💰 ABRIR CAJA</h2>

    <%
        if("cerrar".equals(estadoCaja)) {
    %>
        <div class="alert alert-warning text-center">
            ❌ Ya hay una caja abierta. Debe cerrarla antes de abrir una nueva.
        </div>
    <%
        } else {
    %>

    <form action="aperturacontrolador" method="post">
        <div class="mb-3">
            <label class="form-label">📅 Fecha:</label>
            <input type="text" name="txtfecha" value="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>" readonly class="form-control">
        </div>

        <div class="mb-3">
            <label class="form-label">⏰ Hora:</label>
            <input type="text" name="txthora" value="<%= new java.text.SimpleDateFormat("HH:mm:ss").format(new java.util.Date()) %>" readonly class="form-control">
        </div>

        <div class="mb-3">
            <label class="form-label">💵 Monto de Apertura:</label>
            <input type="number" name="txtmonto" class="form-control" placeholder="Ingrese monto inicial..." required step="0.01" min="0">
        </div>

        <div class="mb-3">
            <label class="form-label">👤 Usuario:</label>
            <input type="text" name="txtidusuario" value="<%= codigoUsuario %>" readonly class="form-control">
        </div>

        <div class="d-grid">
            <button type="submit" name="accion" value="btnabrir" class="btn btn-success">
                🚀 ABRIR CAJA
            </button>
        </div>
    </form>

    <%
        }
    %>

    <%
        String mensaje = (String) request.getAttribute("mensaje");
        if (mensaje != null) {
    %>
    <div class="alert alert-info mt-3 text-center">
        <%= mensaje %>
    </div>
    <%
        }
    %>
</main>

            <footer>
            <div class="container text-center">
                <p>Usuario actual: <strong><%=session.getAttribute("usuario")%></strong></p>
                <p>© 2025 LINEASPORT. Todos los derechos reservados.</p>
            </div>
        </footer>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

    </body>
</html>
