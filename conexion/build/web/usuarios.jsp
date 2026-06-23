<%@page import="java.util.List"%>
<%@page import="modelo.usuariomodelo"%>
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
    <div class="container mt-4">
        <h1 class="mb-4">FORMULARIO USUARIOS</h1>
        <div class="mb-3">
            <button onclick="abrir()" class="btn btn-primary">NUEVO USUARIO</button>
             <form action="controladorusuarios" method="post" target="_blank" class="d-inline">
    <button name="accion" type="submit" value="informe" class="btn btn-secondary">VER INFORME</button>
</form>
        </div>

        <%
            String accion = "guardar";
            usuariomodelo uedit = (usuariomodelo) request.getAttribute("editar");
            if (uedit != null) {
                accion = "actualizar";
            }
        %>

        <div class="modal" id="modal" style="display:none;">
            <div class="modal-content p-4 border rounded bg-light">
                <span id="closeBtn" class="close" onclick="cerrar()">&times;</span>
                <form action="controladorusuarios" method="post">
                    <div class="mb-3">
                        <label class="form-label">CÓDIGO</label>
                        <input type="number" name="txtcodigo" class="form-control"
                               value="<%= uedit != null ? uedit.getIdusuarios() : "" %>"
                               <%= uedit != null ? "readonly" : "" %> required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">NOMBRE</label>
                        <input type="text" name="txtnombre" class="form-control"
                               value="<%= uedit != null ? uedit.getUsu_nombre() : "" %>" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">CLAVE</label>
                        <input type="password" name="txtclave" class="form-control"
                               value="" placeholder="<%= uedit != null ? "Dejar vacío para no cambiar" : "" %>"
                               <%= uedit == null ? "required" : "" %> >
                    </div>

                    <div class="mb-3">
                        <label class="form-label">TIPO</label>
                        <select name="txttipo" class="form-select" required>
                            <option value="">--Seleccione--</option>
                            <option value="admin" <%= "admin".equals(uedit != null ? uedit.getUsu_tipo() : "") ? "selected" : "" %>>Administrador</option>
                            <option value="user" <%= "user".equals(uedit != null ? uedit.getUsu_tipo() : "") ? "selected" : "" %>>Usuario</option>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">ESTADO</label>
                        <select name="txtestado" class="form-select" required>
                            <option value="">--Seleccione--</option>
                            <option value="activo" <%= "activo".equals(uedit != null ? uedit.getUsu_estado() : "") ? "selected" : "" %>>Activo</option>
                            <option value="inactivo" <%= "inactivo".equals(uedit != null ? uedit.getUsu_estado() : "") ? "selected" : "" %>>Inactivo</option>
                        </select>
                    </div>

                   <div class="mb-3">
    <label class="form-label">PERSONAL</label>
    <select name="txtidpersonal" class="form-select" required>
        <option value="">--Seleccione--</option>
        <%
            List<modelo.personalesmodelo> personales = (List<modelo.personalesmodelo>) request.getAttribute("personales");
            if (personales == null) {
                personales = new modelo.personalesmodelo().listar(); // 🔥 Carga desde el modelo si el servlet no lo hizo
            }

            if (personales != null) {
                for (modelo.personalesmodelo p : personales) {
                    String id = p.getCodigo();
                    String nombreCompleto = p.getNombre() + " " + p.getApellido();
                    String selected = (uedit != null && id.equals(uedit.getIdpersonales())) ? "selected" : "";
        %>
                    <option value="<%= id %>" <%= selected %>><%= nombreCompleto %></option>
        <%
                }
            }
        %>
    </select>
</div>



                    <button name="accion" value="<%= accion %>" class="btn btn-success"><%= accion.toUpperCase() %></button>
                </form>
            </div>
        </div>

        <% 
            String mensaje = (String) request.getAttribute("mensaje");
            if (mensaje != null) {
        %>
            <div class="alert alert-success mt-3"><%= mensaje %></div>
        <% } %>

        <%
            List<usuariomodelo> usuarios = (List<usuariomodelo>) request.getAttribute("usuarios");
            if (usuarios == null) {
                usuarios = new usuariomodelo().listar();
            }
        %>

        <div class="table-responsive mt-4">
            <table class="table table-striped table-hover table-bordered">
                <thead class="table-dark">
                    <tr>
                        <th>CÓDIGO</th>
                        <th>NOMBRE</th>
                        <th>CLAVE</th>
                        <th>TIPO</th>
                        <th>ESTADO</th>
                        <th>CÓD. PERSONAL</th>
                        <th>ACCIONES</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (usuariomodelo i : usuarios) { %>
                        <tr>
                            <td><%= i.getIdusuarios() %></td>
                            <td><%= i.getUsu_nombre() %></td>
                            <td>******</td>
                            <td><%= i.getUsu_tipo() %></td>
                            <td><%= i.getUsu_estado() %></td>
                            <td><%= i.getIdpersonales() %></td>
                            <td>
                                <form action="controladorusuarios" method="get" class="d-inline">
                                    <input type="hidden" name="idusuarios" value="<%= i.getIdusuarios() %>">
                                    <button name="accion" value="editar" class="btn btn-warning btn-sm">EDITAR</button>
                                </form>
                                <form action="controladorusuarios" method="post" class="d-inline">
                                    <input type="hidden" name="txtcodigo" value="<%= i.getIdusuarios() %>">
                                    <button name="accion" value="eliminar" class="btn btn-danger btn-sm" onclick="return confirm('¿Seguro que desea eliminar este usuario?')">ELIMINAR</button>
                                </form>
                            </td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
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


<script>
function abrir() {
    document.getElementById('modal').style.display = 'block';
}

function cerrar() {
    document.getElementById('modal').style.display = 'none';
}

<% if (request.getAttribute("abrirModalEditar") != null && (Boolean) request.getAttribute("abrirModalEditar")) { %>
window.onload = function () {
    abrir();
};
<% } %>
</script>

</body>
</html>

