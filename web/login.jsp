<%-- 
    Document   : login
    Created on : 7 may 2025
    Author     : ALUMNO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Iniciar Sesión</title>

        <!-- Bootstrap 5 -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">

        <!-- CSS EMBEBIDO -->
        <style>
            body {
                min-height: 100vh;
                background: linear-gradient(135deg, #0d6efd, #0a58ca);
                display: flex;
                align-items: center;
                justify-content: center;
                font-family: Arial, sans-serif;
            }

            .login-card {
                background: #ffffff;
                padding: 30px;
                width: 100%;
                max-width: 380px;
                border-radius: 12px;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.25);
            }

            .login-card h3 {
                color: #0d6efd;
            }

            .form-label {
                font-weight: 600;
                color: #333;
            }

            .form-control {
                border-radius: 8px;
            }

            .btn-blue {
                background-color: #0d6efd;
                color: #ffffff;
                font-weight: bold;
                border-radius: 8px;
                transition: background-color 0.3s ease;
            }

            .btn-blue:hover {
                background-color: #0a58ca;
                color: #ffffff;
            }

            .mensaje-error {
                margin-top: 15px;
                color: #dc3545;
                font-weight: bold;
                text-align: center;
            }
        </style>
    </head>
    <body>

        <form action="logincontrolador" method="post" class="login-card">
            <h3 class="text-center mb-4 text-uppercase fw-bold">Iniciar Sesión</h3>

            <div class="mb-3">
                <label class="form-label">Usuario</label>
                <input type="text" name="txtusuario" class="form-control" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Contraseña</label>
                <input type="password" name="txtclave" class="form-control" required>
            </div>

            <button type="submit" name="accion" value="btniniciar" class="btn btn-blue w-100">
                Iniciar Sesión
            </button>

            <% 
                String mensaje = (String) request.getAttribute("mensaje");
                if (mensaje != null) {
            %>
                <div class="mensaje-error">
                    <%= mensaje %>
                </div>
            <% } %>
        </form>

    </body>
</html>
