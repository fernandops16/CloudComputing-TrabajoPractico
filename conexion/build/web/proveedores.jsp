<%-- 
    Document   : proveedores
    Created on : 22 abr 2025, 23:13:25
    Author     : FernandoPS
--%>

<%@page import="java.util.List"%>
<%@page import="modelo.proveedormodelo"%>
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
    <h1 class="mb-4">FORMULARIO PROVEEDORES</h1>
    <div class="mb-3">
        <button onclick="abrir()" class="btn btn-primary">NUEVO PROVEEDOR</button>
        <form action="proveedorcontrolador" method="post" target="_blank" class="d-inline">
    <button name="accion" type="submit" value="informe" class="btn btn-secondary">VER INFORME</button>
</form>
    </div>


    <div class="modal" id="modal">
        <div class="modal-content">
            <span class="close" onclick="cerrar()">&times;</span>
            <form action="proveedorcontrolador" method="post">
                <div class="mb-3">
                    <label class="form-label">CÓDIGO</label>
                    <input type="number" name="txtcodigo" class="form-control">
                </div>
                <div class="mb-3">
                    <label class="form-label">NOMBRE</label>
                    <input type="text" name="txtnombre" class="form-control">
                </div>
                <div class="mb-3">
                    <label class="form-label">RUC</label>
                    <input type="number" name="txtruc" class="form-control">
                </div>
                <div class="mb-3">
                    <label class="form-label">TELÉFONO</label>
                    <input type="number" name="txttelefono" class="form-control">
                </div>
                <div class="mb-3">
                    <label class="form-label">CORREO</label>
                    <input type="text" name="txtcorreo" class="form-control">
                </div>
                <button name="accion" value="guardar" class="btn btn-success">GUARDAR</button>
            </form>
        </div>
    </div>

    <div id="modalEditar" class="modal">
        <div class="modal-content">
            <span class="close" onclick="cerrarEditar()">&times;</span>
            <form action="proveedorcontrolador" method="post">
                <input type="hidden" name="txtcodigo" id="editCodigo">
                <div class="mb-3">
                    <label class="form-label">NOMBRE</label>
                    <input type="text" name="txtnombre" id="editNombre" class="form-control">
                </div>
                <div class="mb-3">
                    <label class="form-label">RUC</label>
                    <input type="number" name="txtruc" id="editRuc" class="form-control">
                </div>
                <div class="mb-3">
                    <label class="form-label">TELÉFONO</label>
                    <input type="number" name="txttelefono" id="editTelefono" class="form-control">
                </div>
                <div class="mb-3">
                    <label class="form-label">CORREO</label>
                    <input type="text" name="txtcorreo" id="editCorreo" class="form-control">
                </div>
                <button name="accion" value="actualizar" class="btn btn-primary">ACTUALIZAR</button>
            </form>
        </div>
    </div>

    <%
        proveedormodelo p1 = (proveedormodelo) request.getAttribute("mensaje");
        if (p1 != null) {
    %>
        <div class="alert alert-success mt-3">Proveedor guardado/actualizado/eliminado correctamente</div>
    <%
        }

        proveedormodelo pro = new proveedormodelo();
        List<proveedormodelo> proveedor = pro.Listar();
    %>

    <div class="table-responsive mt-4">
        <table class="table table-striped table-hover table-bordered">
            <thead class="table-dark">
                <tr>
                    <th>CODIGO</th>
                    <th>NOMBRE</th>
                    <th>RUC</th>
                    <th>TELEFONO</th>
                    <th>CORREO</th>
                    <th class="text-center">ACCIONES</th>
                </tr>
            </thead>
            <tbody>
                <% for(proveedormodelo i : proveedor){ %>
                <tr>
                    <td><%= i.getCodigo() %></td>
                    <td><%= i.getNombre() %></td>
                    <td><%= i.getRuc() %></td>
                    <td><%= i.getTelefono() %></td>
                    <td><%= i.getCorreo() %></td>
                    <td class="text-center">
                        <button onclick="abrirEditar('<%= i.getCodigo() %>', '<%= i.getNombre() %>', '<%= i.getRuc() %>',
                                 '<%= i.getTelefono() %>', '<%= i.getCorreo() %>')" class="btn btn-warning btn-sm me-2">EDIT</button>
                        <form action="proveedorcontrolador" method="post" class="d-inline">
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

    </body>
     <script>
        function abrir(){
    document.getElementById('modal').style.display = 'block';
}
function cerrar(){
    document.getElementById('modal').style.display = 'none';
}
        function abrirEditar(codigo,nombre,ruc,telefono,correo){
    document.getElementById("editCodigo").value=codigo;
    document.getElementById("editNombre").value=nombre;
    document.getElementById("editRuc").value=ruc;
    document.getElementById("editTelefono").value=telefono;
       document.getElementById("editCorreo").value=correo;
    document.getElementById("modalEditar").style.display="block";
}
function cerrarEditar(){
    document.getElementById("modalEditar").style.display="none";
}
    </script>
</html>
