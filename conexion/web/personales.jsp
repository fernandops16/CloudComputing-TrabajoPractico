<%@page import="java.util.List"%>
<%@page import="modelo.personalesmodelo"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Formulario Personales</title>

    <!-- Bootstrap + Iconos -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"/>

    <!-- Tu estilo personalizado -->
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

<main >
    <h1 class="mb-4">FORMULARIO PERSONALES</h1>
    <div>
    <button onclick="abrir()" class="btn btn-primary">NUEVO PERSONAL</button>
      <form action="personalescontrolador" method="post" target="_blank" class="d-inline">
            <button name="accion" type="submit" value="informe" class="btn btn-secondary">VER INFORME</button>
        </form>
</div>
    <!-- Modal Crear -->
    <div id="modal" class="modal">
        <div class="modal-content">
            <span id="closeBtn" class="close" onclick="cerrar()">&times;</span>
            <form action="personalescontrolador" method="post">
                <div class="mb-3">
                    <label class="form-label">CÓDIGO</label>
                    <input type="number" name="txtcodigo" class="form-control">
                </div>
                <div class="mb-3">
                    <label class="form-label">NOMBRE</label>
                    <input type="text" name="txtnombre" class="form-control">
                </div>
                <div class="mb-3">
                    <label class="form-label">APELLIDO</label>
                    <input type="text" name="txtapellido" class="form-control">
                </div>
                <div class="mb-3">
                    <label class="form-label">CI</label>
                    <input type="number" name="txtci" class="form-control">
                </div>
                <div class="mb-3">
                    <label class="form-label">TELÉFONO</label>
                    <input type="number" name="txttelefono" class="form-control">
                </div>
                <button type="submit" name="accion" value="guardar" class="btn btn-success">GUARDAR</button>
            </form>
        </div>
    </div>

    <!-- Modal Editar -->
    <div id="modalEditar" class="modal">
        <div class="modal-content">
            <span class="close" onclick="cerrarEditar()">&times;</span>
            <form action="personalescontrolador" method="post">
                <input type="hidden" name="txtcodigo" id="editCodigo">
                <div class="mb-3">
                    <label class="form-label">NOMBRE</label>
                    <input type="text" name="txtnombre" id="editNombre" class="form-control">
                </div>
                <div class="mb-3">
                    <label class="form-label">APELLIDO</label>
                    <input type="text" name="txtapellido" id="editApellido" class="form-control">
                </div>
                <div class="mb-3">
                    <label class="form-label">CI</label>
                    <input type="number" name="txtci" id="editCi" class="form-control">
                </div>
                <div class="mb-3">
                    <label class="form-label">TELÉFONO</label>
                    <input type="number" name="txttelefono" id="editTelefono" class="form-control">
                </div>
                <button type="submit" name="accion" value="actualizar" class="btn btn-primary">ACTUALIZAR</button>
            </form>
        </div>
    </div>

    <!-- Alerta de éxito -->
    <%
        personalesmodelo p1 = (personalesmodelo) request.getAttribute("mensaje");
        if(p1 != null){
            out.print("<div class='alert alert-success mt-3'>Personal guardado/actualizado/eliminado correctamente.</div>");
        }
        personalesmodelo per = new personalesmodelo();
        List<personalesmodelo> personales = per.listar();
    %>

    <!-- Tabla -->
    <div class="table-responsive">
        <table class="table table-striped table-hover table-bordered">
            <thead class="table-dark">
                <tr>
                    <th>CÓDIGO</th>
                    <th>NOMBRE</th>
                    <th>APELLIDO</th>
                    <th>CI</th>
                    <th>TELÉFONO</th>
                    <th class="text-center">ACCIONES</th>
                </tr>
            </thead>
            <tbody>
                <% for(personalesmodelo i : personales){ %>
                <tr>
                    <td><%= i.getCodigo() %></td>
                    <td><%= i.getNombre() %></td>
                    <td><%= i.getApellido() %></td>
                    <td><%= i.getCi() %></td>
                    <td><%= i.getTelefono() %></td>
                    <td class="text-center">
                        <button onclick="abrirEditar('<%= i.getCodigo() %>', '<%= i.getNombre() %>', '<%= i.getApellido() %>', '<%= i.getCi() %>', '<%= i.getTelefono() %>')" class="btn btn-warning btn-sm me-2">EDIT</button>
                        <form action="personalescontrolador" method="post" class="d-inline">
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

  <footer>
            <div class="container text-center">
                <p>Usuario actual: <strong><%=session.getAttribute("usuario")%></strong></p>
                <p>© 2025 LINEASPORT. Todos los derechos reservados.</p>
            </div>
        </footer>

<!-- JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="JS/script.js"></script>
<script>
    function abrir(){
        document.getElementById('modal').style.display = 'block';
    }
    function cerrar(){
        document.getElementById('modal').style.display = 'none';
    }
    function abrirEditar(codigo, nombre, apellido, ci, telefono){
        document.getElementById("editCodigo").value = codigo;
        document.getElementById("editNombre").value = nombre;
        document.getElementById("editApellido").value = apellido;
        document.getElementById("editCi").value = ci;
        document.getElementById("editTelefono").value = telefono;
        document.getElementById("modalEditar").style.display = "block";
    }
    function cerrarEditar(){
        document.getElementById("modalEditar").style.display = "none";
    }
</script>
</body>
</html>
