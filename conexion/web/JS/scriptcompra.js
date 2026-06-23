// ==========================
// FUNCIONES DEL MODAL PROVEEDOR
// ==========================

// Abre el modal del proveedor
function abrirModalProveedor() {
    document.getElementById('modalProveedor').style.display = 'block';
}

// Cierra el modal del proveedor
function cerrarModalProveedor() {
    document.getElementById('modalProveedor').style.display = 'none';
}

// Carga los datos seleccionados del proveedor al formulario
function seleccionarProveedor(id, nombre) {
    document.getElementById('hiddenProveedor').value = id; // campo oculto para enviar
    document.getElementById('nombreProveedor').value = nombre; // mostrar en input
    cerrarModalProveedor();
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
function seleccionarProducto(codigo, nombre, costo, iva) {
    document.getElementById('codigoProducto').value = codigo;
    document.getElementById('nombreProducto').value = nombre;
    document.getElementById('precioProducto').value = costo;
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
    const precio = parseFloat(document.getElementById('precioProducto').value);
    const cantidad = parseInt(document.getElementById('cantidadProducto').value);
    const iva = document.getElementById('ivaProducto').value;

    if (!codigo || cantidad < 1 || isNaN(precio)) {
        alert('Falta seleccionar producto, precio inválido o cantidad inválida');
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
        <td>${precio.toFixed(2)}</td>
        <td>${exenta.toFixed(2)}</td>
        <td>${iva5.toFixed(2)}</td>
        <td>${iva10.toFixed(2)}</td>
        <td><button class='eliminar-btn btn btn-danger btn-sm' onclick='eliminarFila(this)'>Eliminar</button></td>
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

function prepararCompra() {
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

    document.getElementById('jsonDetalleCompra').value = JSON.stringify(detalle);

    const selectCondicion = document.getElementById('selectCondicion');
    if (selectCondicion) {
        document.getElementById('hiddenCondicion').value = selectCondicion.value;
    }

    const idproveedor = document.getElementById('hiddenProveedor').value;
    if (!idproveedor) {
        alert("Debe seleccionar un proveedor.");
        return false;
    }
    // Asignar el valor al campo oculto (no siempre necesario pero es buena práctica)
    document.getElementById('hiddenProveedor').value = idproveedor;

    return true;
}
