function abrir(){
    document.getElementById('modal').style.display = 'block';
}
function cerrar(){
    document.getElementById('modal').style.display = 'none';
}
function abrirEditar(codigo,nombre,precio,cantidad,iva,costo){
    document.getElementById("editCodigo").value=codigo;
    document.getElementById("editNombre").value=nombre;
    document.getElementById("editPrecio").value=precio;
    document.getElementById("editCantidad").value=cantidad;
    document.getElementById("editIva").value=iva;
    document.getElementById("editCosto").value=costo;
    document.getElementById("modalEditar").style.display="block";
}
function cerrarEditar(){
    document.getElementById("modalEditar").style.display="none";
}
function toggleMenu() {
    const menu = document.getElementById("menuContenido");
    menu.style.display = (menu.style.display === "block") ? "none" : "block";
}

// Cerrar el menú si se hace clic fuera
document.addEventListener("click", function(event) {
    const menu = document.getElementById("menuContenido");
    const button = document.querySelector(".menu-hamburguesa-icono");

    if (!menu.contains(event.target) && !button.contains(event.target)) {
        menu.style.display = "none";
    }
});

