@echo off
echo === DEPLOY LINEASPORT ===

echo [1/4] Subiendo cambios a Git...
git add .
set /p msg="Mensaje de commit: "
git commit -m "%msg%"
git push origin main

echo [2/4] Bajando contenedores...
docker compose down

echo [3/4] Buildando e iniciando...
docker compose up --build -d

echo [4/4] Listo!
echo App corriendo en http://localhost:8080/lineasport
pause