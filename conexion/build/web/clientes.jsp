<%--
    Document   : clientes
    Created on : 22 abr 2025, 15:58:47
    Author     : FernandoPS
--%>

<%@page import="java.util.List"%>
<%@page import="modelo.clientesmodelo"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
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
        <main > <%-- Agregué 'container' y 'mt-4' para centrar y dar margen --%>
            <h1 class="mb-4">FORMULARIO CLIENTES</h1> <%-- mb-4 para margen inferior --%>
            <button onclick="abrir()" class="btn btn-primary mb-3">NUEVO CLIENTE</button> <%-- Clases de botón de Bootstrap y margen inferior --%>
<form action="clientescontrolador" method="post" target="_blank" class="d-inline">
    <button name="accion" type="submit" value="informe" class="btn btn-secondary mb-3">VER INFORME</button>
</form>

            <div id="modal" class="modal">
                <div class="modal-content">
                    <span id="closeBtn" class="close" onclick="cerrar()">&times;</span>
                    <form action="clientescontrolador" method="post">
                        <div class="mb-3"> <%-- Agrupar etiquetas y campos con margen --%>
                            <label for="txtcodigo" class="form-label">CODIGO</label>
                            <input type="number" name="txtcodigo" id="txtcodigo" class="form-control">
                        </div>
                        <div class="mb-3">
                            <label for="txtnombre" class="form-label">NOMBRE</label>
                            <input type="text" name="txtnombre" id="txtnombre" class="form-control">
                        </div>
                        <div class="mb-3">
                            <label for="txtapellido" class="form-label">APELLIDO</label>
                            <input type="text" name="txtapellido" id="txtapellido" class="form-control">
                        </div>
                        <div class="mb-3">
                            <label for="txtci" class="form-label">C.I.</label>
                            <input type="number" name="txtci" id="txtci" class="form-control">
                        </div>
                        <div class="mb-3">
                            <label for="txttelefono" class="form-label">TELEFONO</label>
                            <input type="number" name="txttelefono" id="txttelefono" class="form-control">
                        </div>
                        <button name="accion" value="guardar" class="btn btn-success">GUARDAR</button> <%-- Botón de Bootstrap --%>
                    </form>
                </div>
            </div>

            <div id="modalEditar" class="modal">
                <div class="modal-content">
                    <form action="clientescontrolador" method="post">
                        <span class="close" onclick="cerrarEditar()">&times;</span>
                        <div class="mb-3">
                            <input type="hidden" name="txtcodigo" id="editCodigo" class="form-control">
                        </div>
                        <div class="mb-3">
                            <label for="editNombre" class="form-label">NOMBRE</label>
                            <input type="text" name="txtnombre" id="editNombre" class="form-control">
                        </div>
                        <div class="mb-3">
                            <label for="editApellido" class="form-label">APELLIDO</label>
                            <input type="text" name="txtapellido" id="editApellido" class="form-control">
                        </div>
                        <div class="mb-3">
                            <label for="editCi" class="form-label">C.I.</label>
                            <input type="number" name="txtci" id="editCi" class="form-control">
                        </div>
                        <div class="mb-3">
                            <label for="editTelefono" class="form-label">TELEFONO</label>
                            <input type="number" name="txttelefono" id="editTelefono" class="form-control">
                        </div>
                        <button name="accion" value="actualizar" class="btn btn-primary">ACTUALIZAR</button> <%-- Botón de Bootstrap --%>
                    </form>
                </div>
            </div>

            <%
                clientesmodelo p1 = (clientesmodelo) request.getAttribute("mensaje");
                if(p1 != null){
                    out.print("<div class='alert alert-success mt-3' role='alert'>Cliente guardado/actualizado/eliminado correctamente.</div>");
                }
                clientesmodelo cli = new clientesmodelo();
                List<clientesmodelo> clientes = cli.Listar();
            %>

            <div class="table-responsive"> <%-- Envuelve la tabla para responsividad --%>
                <table class="table table-striped table-hover table-bordered"> <%-- Clases de tabla de Bootstrap --%>
                    <thead class="table-dark"> <%-- Encabezado oscuro --%>
                        <tr>
                            <th>CODIGO</th>
                            <th>NOMBRE</th>
                            <th>APELLIDO</th>
                            <th>CI</th>
                            <th>TELEFONO</th>
                            <th class="text-center">ACCIONES</th> <%-- Centrar el texto en la columna de acciones --%>
                        </tr>
                    </thead>
                    <tbody>
                        <% for(clientesmodelo i : clientes){ %>
                        <tr>
                            <td><%= i.getCodigo() %></td>
                            <td><%= i.getNombre() %></td>
                            <td><%= i.getApellido()%></td>
                            <td><%= i.getCi() %></td>
                            <td><%= i.getTelefono() %></td>
                            <td class="text-center"> <%-- Centrar los botones --%>
                                <button onclick="abrirEditar('<%= i.getCodigo() %>','<%= i.getNombre() %>','<%= i.getApellido() %>','<%= i.getCi() %>','<%= i.getTelefono() %>')" class="btn btn-warning btn-sm me-2">EDIT</button> <%-- Botón de advertencia, pequeño, con margen a la derecha --%>
                                <form action="clientescontrolador" method="post" class="d-inline"> <%-- 'd-inline' para que el formulario no rompa la línea --%>
                                    <input type="hidden" name="txtcodigo" value="<%= i.getCodigo() %>">
                                    <button name="accion" value="eliminar" class="btn btn-danger btn-sm">DELETE</button> <%-- Botón de peligro, pequeño --%>
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

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
        <script src="JS/script.js"></script>
        <script>
            function abrir(){
                document.getElementById('modal').style.display = 'block';
            }
            function cerrar(){
                document.getElementById('modal').style.display = 'none';
            }
            function abrirEditar(codigo,nombre,apellido,ci,telefono){
                document.getElementById("editCodigo").value=codigo;
                document.getElementById("editNombre").value=nombre;
                document.getElementById("editApellido").value=apellido;
                document.getElementById("editCi").value=ci;
                document.getElementById("editTelefono").value=telefono;
                document.getElementById("modalEditar").style.display="block";
            }
            function cerrarEditar(){
                document.getElementById("modalEditar").style.display="none";
            }
        </script>
</html>