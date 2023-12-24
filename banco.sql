-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 18-12-2023 a las 22:23:20
-- Versión del servidor: 10.3.16-MariaDB
-- Versión de PHP: 7.3.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `banco`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

CREATE TABLE `clientes` (
  `cedula` varchar(10) NOT NULL,
  `nombres` varchar(100) NOT NULL,
  `apellidos` varchar(100) NOT NULL,
  `email` varchar(50) NOT NULL,
  `direccion` text NOT NULL,
  `telefono` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`cedula`, `nombres`, `apellidos`, `email`, `direccion`, `telefono`) VALUES
('1766443157', 'Josue', 'Mena', 'menajosue@gmail.com', 'Quito', '0995125722'),
('1734673920', 'Andres', 'Chiriboga', 'andres.ch@gmail.com', 'Quito', '098067919'),
('1763778160', 'Brandon', 'Gomez', 'brandon.gomez@gmail.com', 'Quito', '0979100381'),
('1723226443', 'Anthony', 'Delgado', 'anthony.delgado@gmail.com', 'Quito', '098575549'),
('1777328756', 'Maria', 'Mercedez', 'maria.mercedez@gmail.com', 'Cumbaya', '098765432');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cuentas`
--

CREATE TABLE `cuentas` (
  `numero` int(12) NOT NULL,
  `tipo` varchar(50) NOT NULL,
  `saldo` double NOT NULL,
  `cedula` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `cuentas`
--

INSERT INTO `cuentas` (`numero`, `tipo`, `saldo`, `cedula`) VALUES
(1808464236, 'corriente', 350, '1766443157'),
(1864122499, 'corriente', 700.9, '1734673920'),
(1878300886, 'ahorros', 200, '1763778160'),
(1889348197, 'ahorros', 700, '1723226443'),
(1895495609, 'ahorros', 200, '1777328756');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sol_creditos`
--

CREATE TABLE `sol_creditos` (
  `id_solicitud` int(11) NOT NULL,
  `cedula` varchar(10) NOT NULL,
  `nombres` varchar(100) NOT NULL,
  `apellidos` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `telefono` varchar(10) NOT NULL,
  `monto` double NOT NULL,
  `uso` text NOT NULL,
  `tasa` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `sol_creditos`
--



INSERT INTO `sol_creditos` (`id_solicitud`, `cedula`, `nombres`, `apellidos`, `email`, `telefono`, `monto`, `uso`, `tasa`) VALUES
(1, '1766443157', 'Josue', 'Mena', 'menajosue@gmail.com', '0995125722', 5000, 'Compra de mercaderia', 10);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `transacciones`
--

CREATE TABLE `transacciones` (
  `id_transaccion` int(11) NOT NULL,
  `num_cuenta_ori` int(12) NOT NULL,
  `num_cuenta_dest` int(12) NOT NULL,
  `monto` double NOT NULL,
  `fecha` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `transacciones`
--

INSERT INTO `transacciones` (`id_transaccion`, `num_cuenta_ori`, `num_cuenta_dest`, `monto`, `fecha`) VALUES
(4, 1878300886, 1889348197, 50, '0000-00-00'),
(7, 1878300886, 1889348197, 50, '0000-00-00'),
(8, 1878300886, 1889348197, 50, '0000-00-00'),
(12, 1878300886, 1889348197, 500, '0000-00-00'),
(13, 1878300886, 1889348197, 500, '0000-00-00'),
(14, 1878300886, 1889348197, 500, '0000-00-00'),
(17, 1878300886, 1889348197, 100, '0000-00-00');

--
-- Indices de la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`cedula`);

--
-- Indices de la tabla `cuentas`
--
ALTER TABLE `cuentas`
  ADD PRIMARY KEY (`numero`),
  ADD KEY `fk_cedula` (`cedula`);

--
-- Indices de la tabla `sol_creditos`
--
ALTER TABLE `sol_creditos`
  ADD PRIMARY KEY (`id_solicitud`);

--
-- Indices de la tabla `transacciones`
--
ALTER TABLE `transacciones`
  ADD PRIMARY KEY (`id_transaccion`);

--
-- AUTO_INCREMENT de la tabla `sol_creditos`
--
ALTER TABLE `sol_creditos`
  MODIFY `id_solicitud` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `transacciones`
--
ALTER TABLE `transacciones`
  MODIFY `id_transaccion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- Filtros para la tabla `cuentas`
--
ALTER TABLE `cuentas`
  ADD CONSTRAINT `fk_cedula` FOREIGN KEY (`cedula`) REFERENCES `clientes` (`cedula`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
