// ==========================
// FUNCIONES DEL MODAL CLIENTE
// ==========================

// Abre el modal del cliente
function abrirModal() {
    document.getElementById('modalCliente').style.display = 'block';
}

// Cierra el modal del cliente
function cerrarModal() {
    document.getElementById('modalCliente').style.display = 'none';
}

// Carga los datos seleccionados del cliente al formulario
function seleccionarCliente(id, nombreCompleto) {
    document.getElementById('hiddenCliente').value = id; // campo oculto para enviar
    document.getElementById('nombrecliente').value = nombreCompleto; // mostrar en input
    cerrarModal();
}


// ==========================
// FUNCIONES DEL MODAL PRODUCTO
// ==========================

// Abre el modal de productos
function abrirModalProducto() {
    document.getElementById('modalProducto').style.display = 'block';
}

// Cierra el modal de productos
function cerrarModalProducto() {
    document.getElementById('modalProducto').style.display = 'none';
}

// Carga los datos seleccionados del producto al formulario
function seleccionarProducto(cod, nom, precio, iva) {
    document.getElementById('codigoProducto').value = cod;
    document.getElementById('nombreProducto').value = nom;
    document.getElementById('precioProducto').value = precio;
    document.getElementById('ivaProducto').value = iva;
    cerrarModalProducto();
}

// ==========================
// AGREGAR PRODUCTO A LA TABLA DETALLE
// ==========================

function agregarProducto() {
    const tabla = document.getElementById('tablaDetalle').getElementsByTagName('tbody')[0];

    const codigo = document.getElementById('codigoProducto').value;
    const nombre = document.getElementById('nombreProducto').value;
    const precio = parseInt(document.getElementById('precioProducto').value);
    const cantidad = parseInt(document.getElementById('cantidadProducto').value);
    const iva = document.getElementById('ivaProducto').value;

    console.log("IVA seleccionado:", iva);

    if (!codigo || cantidad < 1) {
        alert('Falta seleccionar producto o cantidad inválida');
        return;
    }

    let exenta = 0, iva5 = 0, iva10 = 0;
    const subtotal = precio * cantidad;

    if (iva === '0' || iva.toUpperCase() === 'EXENTA') {
    exenta = subtotal;
} else if (iva === '5') {
    iva5 = subtotal;
} else if (iva === '10') {
    iva10 = subtotal;
}

    const fila = tabla.insertRow();
    fila.innerHTML = `
        <td style="display:none;" class="idproducto">${codigo}</td>
        <td>${cantidad}</td>
        <td>${nombre}</td>
        <td>${precio}</td>
        <td>${exenta}</td>
        <td>${iva5}</td>
        <td>${iva10}</td>
        <td><button class='eliminar-btn' onclick='eliminarFila(this)'>Eliminar</button></td>
    `;
}


// ==========================
// ELIMINAR UNA FILA DE LA TABLA DETALLE
// ==========================

function eliminarFila(boton) {
    const fila = boton.closest('tr');
    fila.remove();
}

// ==========================
// PREPARAR DATOS PARA ENVIAR AL SERVLET
// ==========================

function prepararVenta() {
    const filas = document.querySelectorAll('#tablaDetalle tbody tr');
    const detalle = [];

    filas.forEach(fila => {
        const columnas = fila.querySelectorAll('td');

        if (columnas.length >= 7) {
            const idproducto = columnas[0].innerText;
            const cantidad = columnas[1].innerText;
            const precio = columnas[3].innerText;
            const exenta = columnas[4].innerText;
            const iva5 = columnas[5].innerText;
            const iva10 = columnas[6].innerText;

            detalle.push({
                idproducto: idproducto,
                cantidad: cantidad,
                precio: precio,
                exenta: exenta,
                iva5: iva5,
                iva10: iva10
            });
        }
    });

    if (detalle.length === 0) {
        alert("Debe agregar al menos un producto.");
        return false;
    }

    document.getElementById('jsonDetalleVenta').value = JSON.stringify(detalle);

    const selectCondicion = document.getElementById('selectCondicion');
    if (selectCondicion) {
        document.getElementById('hiddenCondicion').value = selectCondicion.value;
    }

    // *** LÍNEA CORREGIDA ***
    const idcliente = document.getElementById('hiddenCliente').value;
    document.getElementById('hiddenCliente').value = idcliente; // Esta línea ya no es estrictamente necesaria si la anterior ya asigna, pero no causa daño.
                                                              // Podrías dejar solo la línea que asigna `idcliente` al `value` de `hiddenCliente` directamente.

    return true;
}