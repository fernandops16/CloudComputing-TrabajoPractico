<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Iniciar Sesión - LineaSport</title>

        <!-- Bootstrap 5 -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">

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
                max-width: 400px;
                border-radius: 12px;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.25);
                animation: aparecer 0.6s ease;
            }

            @keyframes aparecer {
                from {
                    opacity: 0;
                    transform: translateY(-20px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .login-card:hover {
                transform: translateY(-3px);
                transition: 0.3s ease;
            }

            .login-card h3 {
                color: #0d6efd;
            }

            .logo-text {
                color: #0d6efd;
                font-size: 14px;
                text-align: center;
                margin-bottom: 15px;
                font-weight: bold;
            }

            .info-login {
                background: #e7f1ff;
                border-left: 4px solid #0d6efd;
                padding: 10px;
                border-radius: 5px;
                margin-bottom: 20px;
                font-size: 13px;
                color: #084298;
            }

            .form-label {
                font-weight: 600;
                color: #333;
            }

            .form-control {
                border-radius: 8px;
            }

            .form-control:focus {
                border-color: #0d6efd;
                box-shadow: 0 0 10px rgba(13, 110, 253, 0.3);
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

            .footer-login {
                text-align: center;
                color: #6c757d;
                font-size: 12px;
                margin-top: 10px;
            }
        </style>
    </head>

    <body>

        <form action="logincontrolador" method="post" class="login-card">

            <h3 class="text-center mb-2 text-uppercase fw-bold">
                Iniciar Sesión
            </h3>

            <div class="logo-text">
                Sistema de Gestión LineaSport
            </div>

            <div class="info-login">
                Ingrese sus credenciales para acceder al sistema de compras y ventas.
            </div>

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

            <div class="text-center mt-3">
                <small class="text-muted">
                    🔒 Sus credenciales están protegidas mediante medidas de seguridad.
                </small>
            </div>

            <%
                String mensaje = (String) request.getAttribute("mensaje");
                if (mensaje != null) {
            %>
                <div class="alert alert-danger mt-3 text-center" role="alert">
                    <strong>Acceso denegado:</strong> <%= mensaje %>
                </div>
            <%
                }
            %>

            <hr>

            <div class="footer-login">
                © 2025 LineaSport - Sistema de Compras y Ventas
            </div>

        </form>

    </body>
</html>