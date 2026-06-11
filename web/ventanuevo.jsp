<%@page contentType="text/html; charset=UTF-8" %>
<%@page import="java.util.*, modelo.ventamodelo" %>

<%
    String usuario = (String) session.getAttribute("usuario");
    String tipo = (String) session.getAttribute("tipo");
    String codigo = (String) session.getAttribute("codigo");
    if (usuario == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    ventamodelo v = new ventamodelo();
    List<String[]> listaClientes = v.listarClientes();
    List<String[]> listaProductos = v.listarProductos();
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Nueva Venta</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Estilos -->
  
    <link rel="stylesheet" href="CSS/estilo.css">

    <!-- Bootstrap y FontAwesome -->
      <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" crossorigin="anonymous" referrerpolicy="no-referrer" />

</head>
<body>
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
<!-- CONTENIDO -->
<main >
    <h2 class="text-center">NUEVA VENTA</h2>
    

    <!-- CABECERA DE VENTA -->
    <div class="row mb-3">
        <div class="col-md-3">
            <label>Fecha:</label>
            <input type="text" class="form-control" value="<%= java.time.LocalDate.now() %>" readonly>
        </div>
        <div class="col-md-3">
            <label>Condición:</label>
            <select id="selectCondicion" class="form-select">
                <option value="Contado">Contado</option>
                <option value="Credito">Crédito</option>
            </select>
        </div>
        <div class="col-md-3">
            <label>Estado:</label>
            <input type="text" class="form-control" value="Pendiente" readonly>
        </div>
        <div class="col-md-3">
            <label>Usuario:</label>
            <input type="text" class="form-control" value="<%= codigo %>" readonly>
        </div>
    </div>

    <!-- CLIENTE -->
    <div class="mb-3">
        <label>Cliente:</label>
        <div class="d-flex">
            <input type="text" id="nombrecliente" class="form-control me-2" readonly>
            <button class="btn btn-primary" type="button" onclick="abrirModal()">Buscar Cliente</button>
        </div>
    </div>

    <!-- PRODUCTOS -->
    <div>
        <h5>DETALLE DE PRODUCTOS</h5>
        <div class="row g-2">
            <div class="col-md-2"><label>Código:</label><input type="text" id="codigoProducto" class="form-control" readonly></div>
            <div class="col-md-2"><label>Nombre:</label><input type="text" id="nombreProducto" class="form-control" readonly></div>
            <div class="col-md-2"><label>Precio:</label><input type="text" id="precioProducto" class="form-control" readonly></div>
            <div class="col-md-2"><label>Cantidad:</label><input type="number" id="cantidadProducto" class="form-control" min="1" value="1"></div>
            <input type="hidden" id="ivaProducto">
            <div class="col-md-2 d-flex align-items-end"><button type="button" class="btn btn-success w-100" onclick="agregarProducto()">Agregar</button></div>
            <div class="col-md-2 d-flex align-items-end"><button type="button" class="btn btn-secondary w-100" onclick="abrirModalProducto()">Buscar Producto</button></div>
        </div>

        <div class="table-responsive mt-3">
            <table id="tablaDetalle" class="table table-bordered text-center">
                <thead>
                    <tr>
                        <th>Cantidad</th>
                        <th>Producto</th>
                        <th>Precio Unitario</th>
                        <th>Exenta</th>
                        <th>IVA 5%</th>
                        <th>IVA 10%</th>
                        <th>Acción</th>
                    </tr>
                </thead>
                <tbody></tbody>
            </table>
        </div>
    </div>

    <!-- FORMULARIO FINAL -->
    <form action="ventacontrolador" method="POST" onsubmit="return prepararVenta()">
        <input type="hidden" name="txtfecha" value="<%= java.time.LocalDate.now() %>">
        <input type="hidden" name="txtcondicion" id="hiddenCondicion">
        <input type="hidden" name="txtestado" value="Pendiente">
        <input type="hidden" name="txtusuario" value="<%= codigo %>">
        <input type="hidden" name="idcliente" id="hiddenCliente">
        <input type="hidden" name="jsonDetalle" id="jsonDetalleVenta">
        <button type="submit" name="accion" value="guardarventa" class="btn btn-success w-100 mt-3">GUARDAR VENTA</button>
    </form>
</main>

<!-- MODAL CLIENTE -->
<div id="modalCliente" class="modal">
    <div class="modal-content">
        <span class="close" onclick="cerrarModal()">&times;</span>
        <h3>Buscar Cliente</h3>
        <table class="table">
            <thead><tr><th>Nombre</th><th>Apellido</th><th>CI</th><th>Acción</th></tr></thead>
            <tbody>
                <%
                    for (String[] cli : listaClientes) {
                %>
                <tr>
                    <td><%= cli[1] %></td>
                    <td><%= cli[2] %></td>
                    <td><%= cli[3] %></td>
                    <td><button type="button" onclick='seleccionarCliente("<%= cli[0] %>", "<%= cli[1] + " " + cli[2] %>")'>Seleccionar</button></td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>
</div>

<!-- MODAL PRODUCTO -->
<div id="modalProducto" class="modal">
    <div class="modal-content">
        <span class="close" onclick="cerrarModalProducto()">&times;</span>
        <h3>Buscar Producto</h3>
        <table class="table">
            <thead><tr><th>Nombre</th><th>Precio</th><th>IVA</th><th>Acción</th></tr></thead>
            <tbody>
                <%
                    for (String[] p : listaProductos) {
                %>
                <tr>
                    <td><%= p[1] %></td>
                    <td><%= p[2] %></td>
                    <td><%= p[3] %></td>
                    <td><button type="button" onclick="seleccionarProducto('<%= p[0] %>', '<%= p[1] %>', '<%= p[2] %>', '<%= p[3] %>')">Seleccionar</button></td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>
</div>

<footer>
            <div class="container text-center">
                <p>Usuario actual: <strong><%=session.getAttribute("usuario")%></strong></p>
                <p>© 2025 LINEASPORT. Todos los derechos reservados.</p>
            </div>
        </footer>

<!-- SCRIPTS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="JS/scriptventa.js"></script>
</body>
</html>
