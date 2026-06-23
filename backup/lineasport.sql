-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 23-06-2026 a las 21:29:45
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `lineasport`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `apertura`
--

CREATE TABLE `apertura` (
  `idapertura` int(11) NOT NULL,
  `ape_fecha` date NOT NULL,
  `ape_hora` time NOT NULL,
  `ape_monto` int(11) NOT NULL,
  `idusuarios` int(11) NOT NULL,
  `ape_estado` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `apertura`
--

INSERT INTO `apertura` (`idapertura`, `ape_fecha`, `ape_hora`, `ape_monto`, `idusuarios`, `ape_estado`) VALUES
(1, '2025-12-14', '22:02:19', 10000, 2, 'CERRADA'),
(2, '2025-12-15', '08:27:01', 10000, 2, 'CERRADA'),
(3, '2025-12-15', '09:13:22', 10000, 2, 'CERRADA'),
(4, '2026-06-10', '23:43:28', 100000, 3, 'CERRADA'),
(5, '2026-06-11', '01:01:24', 1333333, 3, 'CERRADA'),
(6, '2026-06-11', '01:12:26', 333333, 3, 'CERRADA'),
(7, '2026-06-11', '09:27:10', 1000000, 3, 'ABIERTA');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cierre`
--

CREATE TABLE `cierre` (
  `idcierre` int(11) NOT NULL,
  `cie_fecha` date NOT NULL,
  `cie_hora` time NOT NULL,
  `cie_monto` int(11) NOT NULL,
  `idapertura` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `cierre`
--

INSERT INTO `cierre` (`idcierre`, `cie_fecha`, `cie_hora`, `cie_monto`, `idapertura`) VALUES
(1, '2025-12-14', '23:05:38', 30000, 1),
(2, '2025-12-15', '08:28:14', 500, 2),
(3, '2026-06-10', '21:20:56', 35555646, 3),
(4, '2026-06-10', '23:48:15', 111000, 4),
(5, '2026-06-11', '00:09:11', 400000, 5),
(6, '2026-06-11', '01:12:35', 4444444, 6);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

CREATE TABLE `clientes` (
  `id` int(11) NOT NULL,
  `nombre` text NOT NULL,
  `apellido` text NOT NULL,
  `ci` int(11) NOT NULL,
  `telefono` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`id`, `nombre`, `apellido`, `ci`, `telefono`) VALUES
(1, 'David', 'Caceres', 2848412, 985666777),
(2, 'Marcelo', 'Gallardo', 3566677, 987666777),
(4, 'Lucia', 'Gonzalez', 4567447, 984577444);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `compra`
--

CREATE TABLE `compra` (
  `idcompra` int(11) NOT NULL,
  `com_fecha` date NOT NULL,
  `com_condicion` varchar(15) NOT NULL,
  `com_estado` varchar(15) NOT NULL,
  `idusuarios` int(11) NOT NULL,
  `idproveedor` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `compra`
--

INSERT INTO `compra` (`idcompra`, `com_fecha`, `com_condicion`, `com_estado`, `idusuarios`, `idproveedor`) VALUES
(1, '2025-12-14', 'Contado', 'Pendiente', 2, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detallecompra`
--

CREATE TABLE `detallecompra` (
  `idcompra` int(11) NOT NULL,
  `idproductos` int(11) NOT NULL,
  `det_cantidad` int(11) NOT NULL,
  `det_precio` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `detallecompra`
--

INSERT INTO `detallecompra` (`idcompra`, `idproductos`, `det_cantidad`, `det_precio`) VALUES
(1, 1, 1, 800000),
(1, 2, 1, 750000);

--
-- Disparadores `detallecompra`
--
DELIMITER $$
CREATE TRIGGER `trg_aumentar_stock` AFTER INSERT ON `detallecompra` FOR EACH ROW BEGIN
    UPDATE productos
    SET pro_cantidad = pro_cantidad + NEW.det_cantidad
    WHERE idproductos = NEW.idproductos;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalleventas`
--

CREATE TABLE `detalleventas` (
  `idventas` int(11) NOT NULL,
  `idproductos` int(11) NOT NULL,
  `det_cantidad` int(11) NOT NULL,
  `det_precio` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `detalleventas`
--

INSERT INTO `detalleventas` (`idventas`, `idproductos`, `det_cantidad`, `det_precio`) VALUES
(1, 1, 1, 650000),
(1, 2, 1, 600000),
(1, 3, 1, 500000),
(2, 1, 1, 650000),
(2, 2, 1, 600000);

--
-- Disparadores `detalleventas`
--
DELIMITER $$
CREATE TRIGGER `disminuir_stock` AFTER INSERT ON `detalleventas` FOR EACH ROW BEGIN
    UPDATE productos
    SET pro_cantidad = pro_cantidad - NEW.det_cantidad
    WHERE idproductos = NEW.idproductos;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `personales`
--

CREATE TABLE `personales` (
  `id` int(11) NOT NULL,
  `nombre` varchar(30) NOT NULL,
  `apellido` varchar(30) NOT NULL,
  `ci` int(11) NOT NULL,
  `telefono` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `personales`
--

INSERT INTO `personales` (`id`, `nombre`, `apellido`, `ci`, `telefono`) VALUES
(1, 'Fernando', 'Cuenca', 7613098, 982566723),
(2, 'Mauricio', 'Cuenca', 6899077, 985667444),
(3, 'Marcos', 'Acosta', 6899077, 985667444),
(4, 'Jose', 'Fernandez', 673412, 983777333);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `idproductos` int(11) NOT NULL,
  `pro_nombre` varchar(30) NOT NULL,
  `pro_precio` int(11) NOT NULL,
  `pro_cantidad` int(11) NOT NULL,
  `pro_iva` int(11) NOT NULL,
  `pro_costos` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`idproductos`, `pro_nombre`, `pro_precio`, `pro_cantidad`, `pro_iva`, `pro_costos`) VALUES
(1, 'Botines Nike Mercurial', 650000, 8, 10, '800000'),
(2, 'Air force calzado', 600000, 13, 10, '750000'),
(3, 'Pelota Jabulani adidas', 500000, 8, 5, '600000');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedores`
--

CREATE TABLE `proveedores` (
  `id` int(11) NOT NULL,
  `nombre` varchar(30) NOT NULL,
  `ruc` bigint(30) NOT NULL,
  `telefono` bigint(15) NOT NULL,
  `correo` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `proveedores`
--

INSERT INTO `proveedores` (`id`, `nombre`, `ruc`, `telefono`, `correo`) VALUES
(1, 'Lucas Martinez', 5211324, 992397492, 'macroventas@gmail.com'),
(2, 'Joel Alegre', 1234567, 982566723, 'unodostres@gmail.com');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `idusuarios` int(11) NOT NULL,
  `usu_nombre` varchar(15) NOT NULL,
  `usu_clave` varchar(100) NOT NULL,
  `usu_tipo` varchar(15) NOT NULL,
  `usu_estado` varchar(10) NOT NULL,
  `idpersonales` int(11) NOT NULL,
  `intentos_fallidos` int(11) DEFAULT 0,
  `ultimo_intento` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`idusuarios`, `usu_nombre`, `usu_clave`, `usu_tipo`, `usu_estado`, `idpersonales`, `intentos_fallidos`, `ultimo_intento`) VALUES
(2, 'ferchu', '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4', 'user', 'activo', 1, 0, NULL),
(3, 'Lucas', '0ffe1abd1a08215353c233d6e009613e95eec4253832a761af28ff37ac5a150c', 'user', 'activo', 1, 0, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventas`
--

CREATE TABLE `ventas` (
  `idventas` int(11) NOT NULL,
  `ven_fecha` date DEFAULT NULL,
  `ven_condicion` varchar(15) NOT NULL,
  `ven_estado` varchar(15) NOT NULL,
  `idclientes` int(11) NOT NULL,
  `idusuarios` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `ventas`
--

INSERT INTO `ventas` (`idventas`, `ven_fecha`, `ven_condicion`, `ven_estado`, `idclientes`, `idusuarios`) VALUES
(1, '2025-12-14', 'Contado', 'Pendiente', 2, 2),
(2, '2025-12-15', 'Contado', 'Pendiente', 4, 2);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `apertura`
--
ALTER TABLE `apertura`
  ADD PRIMARY KEY (`idapertura`),
  ADD KEY `idusuarios` (`idusuarios`);

--
-- Indices de la tabla `cierre`
--
ALTER TABLE `cierre`
  ADD PRIMARY KEY (`idcierre`),
  ADD KEY `idapertura` (`idapertura`);

--
-- Indices de la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `compra`
--
ALTER TABLE `compra`
  ADD PRIMARY KEY (`idcompra`),
  ADD KEY `idusuarios` (`idusuarios`),
  ADD KEY `idproveedor` (`idproveedor`);

--
-- Indices de la tabla `detallecompra`
--
ALTER TABLE `detallecompra`
  ADD PRIMARY KEY (`idcompra`,`idproductos`),
  ADD KEY `idproductos` (`idproductos`);

--
-- Indices de la tabla `detalleventas`
--
ALTER TABLE `detalleventas`
  ADD PRIMARY KEY (`idventas`,`idproductos`),
  ADD KEY `idproductos` (`idproductos`);

--
-- Indices de la tabla `personales`
--
ALTER TABLE `personales`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`idproductos`);

--
-- Indices de la tabla `proveedores`
--
ALTER TABLE `proveedores`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`idusuarios`),
  ADD KEY `idpersonales` (`idpersonales`);

--
-- Indices de la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD PRIMARY KEY (`idventas`),
  ADD KEY `idclientes` (`idclientes`),
  ADD KEY `idusuarios` (`idusuarios`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `apertura`
--
ALTER TABLE `apertura`
  MODIFY `idapertura` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `cierre`
--
ALTER TABLE `cierre`
  MODIFY `idcierre` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `compra`
--
ALTER TABLE `compra`
  MODIFY `idcompra` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `idproductos` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `ventas`
--
ALTER TABLE `ventas`
  MODIFY `idventas` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `compra`
--
ALTER TABLE `compra`
  ADD CONSTRAINT `compra_ibfk_1` FOREIGN KEY (`idusuarios`) REFERENCES `usuarios` (`idusuarios`),
  ADD CONSTRAINT `compra_ibfk_2` FOREIGN KEY (`idproveedor`) REFERENCES `proveedores` (`id`);

--
-- Filtros para la tabla `detallecompra`
--
ALTER TABLE `detallecompra`
  ADD CONSTRAINT `detallecompra_ibfk_1` FOREIGN KEY (`idcompra`) REFERENCES `compra` (`idcompra`),
  ADD CONSTRAINT `detallecompra_ibfk_2` FOREIGN KEY (`idproductos`) REFERENCES `productos` (`idproductos`);

--
-- Filtros para la tabla `detalleventas`
--
ALTER TABLE `detalleventas`
  ADD CONSTRAINT `detalleventas_ibfk_1` FOREIGN KEY (`idventas`) REFERENCES `ventas` (`idventas`),
  ADD CONSTRAINT `detalleventas_ibfk_2` FOREIGN KEY (`idproductos`) REFERENCES `productos` (`idproductos`);

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`idpersonales`) REFERENCES `personales` (`id`);

--
-- Filtros para la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD CONSTRAINT `ventas_ibfk_1` FOREIGN KEY (`idclientes`) REFERENCES `clientes` (`id`),
  ADD CONSTRAINT `ventas_ibfk_2` FOREIGN KEY (`idusuarios`) REFERENCES `usuarios` (`idusuarios`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
