<%-- 
    Document   : productos
    Created on : 26 mar 2025, 9:06:32
    Author     : ALUMNO
--%>

<%@page import="java.util.List"%>
<%@page import="modelo.productomodelo"%>
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
        <main>
     <main>
    <h1 class="mb-4">FORMULARIO PRODUCTOS</h1>
    <div class="mb-3">
        <button onclick="abrir()" class="btn btn-primary">NUEVO PRODUCTO</button>
        <form action="productocontrolador" method="post" target="_blank" class="d-inline">
            <button name="accion" type="submit" value="informe" class="btn btn-secondary">VER INFORME</button>
        </form>
    </div>

    <div id="modal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="cerrar()">&times;</span>
            <form action="productocontrolador" method="POST">
                <div class="mb-3">
                    <label class="form-label">CODIGO</label>
                    <input type="number" name="txtcodigo" class="form-control">
                </div>
                <div class="mb-3">
                    <label class="form-label">NOMBRE</label>
                    <input type="text" name="txtnombre" class="form-control">
                </div>
                <div class="mb-3">
                    <label class="form-label">PRECIO</label>
                    <input type="number" name="txtprecio" class="form-control">
                </div>
                <div class="mb-3">
                    <label class="form-label">CANTIDAD</label>
                    <input type="number" name="txtcantidad" class="form-control">
                </div>
               <div class="mb-3">
    <label class="form-label">IVA</label>
    <select name="txtiva" class="form-select">
        <option value="0">0%</option>
        <option value="5">5%</option>
        <option value="10">10%</option>
    </select>
</div>
                <div class="mb-3">
                    <label class="form-label">COSTO</label>
                    <input type="text" name="txtcosto" class="form-control">
                </div>
                <button name="accion" value="guardar" class="btn btn-success">GUARDAR</button>
            </form>
        </div>
    </div>

    <div id="modalEditar" class="modal">
        <div class="modal-content">
            <span class="close" onclick="cerrarEditar()">&times;</span>
            <form action="productocontrolador" method="POST">
                <input type="hidden" name="txtcodigo" id="editCodigo">
                <div class="mb-3">
                    <label class="form-label">NOMBRE</label>
                    <input type="text" name="txtnombre" id="editNombre" class="form-control">
                </div>
                <div class="mb-3">
                    <label class="form-label">PRECIO</label>
                    <input type="number" name="txtprecio" id="editPrecio" class="form-control">
                </div>
                <div class="mb-3">
                    <label class="form-label">CANTIDAD</label>
                    <input type="number" name="txtcantidad" id="editCantidad" class="form-control">
                </div>
               <div class="mb-3">
    <label class="form-label">IVA</label>
    <select name="txtiva" id="editIva" class="form-select">
        <option value="0">0%</option>
        <option value="5">5%</option>
        <option value="10">10%</option>
    </select>
</div>

                <div class="mb-3">
                    <label class="form-label">COSTO</label>
                    <input type="number" name="txtcosto" id="editCosto" class="form-control">
                </div>
                <button name="accion" value="actualizar" class="btn btn-primary">ACTUALIZAR</button>
            </form>
        </div>
    </div>

    <%
        String mensaje = (String) request.getAttribute("mensaje");
    if (mensaje != null) {
        out.print("<div class='alert alert-info mt-3' role='alert'>" + mensaje + "</div>");
    }
        productomodelo pro = new productomodelo();
        List<productomodelo> productos = pro.listar();
    %>

    <div class="table-responsive mt-4">
        <table class="table table-striped table-hover table-bordered">
            <thead class="table-dark">
                <tr>
                    <th>CODIGO</th>
                    <th>NOMBRE</th>
                    <th>PRECIO</th>
                    <th>CANTIDAD</th>
                    <th>IVA</th>
                    <th>COSTO</th>
                    <th class="text-center">ACCIONES</th>
                </tr>
            </thead>
            <tbody>
                <% for(productomodelo i : productos){ %>
                <tr>
                    <td><%= i.getCodigo() %></td>
                    <td><%= i.getNombre() %></td>
                    <td><%= i.getPrecio() %></td>
                    <td><%= i.getCantidad() %></td>
                    <td><%= i.getIva() %></td>
                    <td><%= i.getCosto() %></td>
                    <td class="text-center">
                        <button onclick="abrirEditar('<%= i.getCodigo() %>','<%= i.getNombre() %>','<%= i.getPrecio() %>',
                                '<%= i.getCantidad() %>','<%= i.getIva() %>','<%= i.getCosto() %>')" class="btn btn-warning btn-sm me-2">EDIT</button>
                        <form action="productocontrolador" method="post" class="d-inline">
                            <input type="hidden" name="txtcodigo" value="<%= i.getCodigo() %>">
                            <button name="accion" value="eliminar" class="btn btn-danger btn-sm">DELETE</button>
                        </form>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>
</main>

            </main>
        <footer>
            <div class="container text-center">
                <p>Usuario actual: <strong><%=session.getAttribute("usuario")%></strong></p>
                <p>© 2025 LINEASPORT. Todos los derechos reservados.</p>
            </div>
        </footer>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

    <script src="JS/script.js"></script>
    </body>
    <script>
    function abrir() {
        document.getElementById('modal').style.display = 'block';
    }

    function cerrar() {
        document.getElementById('modal').style.display = 'none';
    }

    function abrirEditar(codigo, nombre, precio, cantidad, iva, costo) {
        document.getElementById("editCodigo").value = codigo;
        document.getElementById("editNombre").value = nombre;
        document.getElementById("editPrecio").value = precio;
        document.getElementById("editCantidad").value = cantidad;
        document.getElementById("editIva").value = iva;
        // Selecciona la opción correcta en el select del IVA
let selectIva = document.getElementById("editIva");
for (let i = 0; i < selectIva.options.length; i++) {
    if (selectIva.options[i].value == iva) {
        selectIva.selectedIndex = i;
        break;
    }
}

        document.getElementById("editCosto").value = costo;
        document.getElementById("modalEditar").style.display = "block";
    }

    function cerrarEditar() {
        document.getElementById("modalEditar").style.display = "none";
    }
</script>

        
</html>
