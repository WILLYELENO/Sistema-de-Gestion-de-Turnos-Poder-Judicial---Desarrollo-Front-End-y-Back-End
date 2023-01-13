-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3307
-- Tiempo de generación: 13-01-2023 a las 17:26:22
-- Versión del servidor: 10.4.27-MariaDB
-- Versión de PHP: 8.1.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `poderjudicial`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `accpted`
--

CREATE TABLE `accpted` (
  `id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  `block` varchar(50) DEFAULT NULL,
  `sac` varchar(50) DEFAULT NULL,
  `day` varchar(50) DEFAULT NULL,
  `schedule` varchar(50) DEFAULT NULL,
  `affair` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `accpted`
--

INSERT INTO `accpted` (`id`, `name`, `email`, `country`, `block`, `sac`, `day`, `schedule`, `affair`) VALUES
(42, 'wwwwwwwwwwww', 'wwwwww@gmail.com', 'arg', 'B1', '333333', '2022-12-15', '11:00 a 12:00 am', 'prueba'),
(44, 'willy', 'willy@gmail.com', 'argentina', 'B1', '358', '2022-12-14', '9:00 a 10:00 am', 'consulta'),
(45, 'w2', 'we2@gmail.com', 'argentina', 'B1', '111', '2022-12-15', '9:00 a 10:00 am', 'consulta'),
(46, 'willians', 'willy@gmail.com', 'argentina', 'Bloque 1: Juzgados Civiles y Comerciales', '358945', '2022-12-16', '9:00 a 10:00 am', 'Audiencia');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `admin`
--

CREATE TABLE `admin` (
  `id` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `admin`
--

INSERT INTO `admin` (`id`, `name`, `password`) VALUES
(1, 'hamza', '123'),
(2, 'ahmad', '1122');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reject`
--

CREATE TABLE `reject` (
  `id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  `block` varchar(50) DEFAULT NULL,
  `sac` varchar(50) DEFAULT NULL,
  `day` varchar(50) DEFAULT NULL,
  `schedule` varchar(50) DEFAULT NULL,
  `affair` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `reject`
--

INSERT INTO `reject` (`id`, `name`, `email`, `country`, `block`, `sac`, `day`, `schedule`, `affair`) VALUES
(16, 'w2', 'we2@gmail.com', 'argentina', 'B1', '111', '2022-12-15', '9:00 a 10:00 am', 'consulta'),
(17, 'w2', 'we2@gmail.com', 'argentina', 'B1', '111', '2022-12-15', '9:00 a 10:00 am', 'consulta'),
(22, 'w2', 'we2@gmail.com', 'argentina', 'B1', '111', '2022-12-15', '9:00 a 10:00 am', 'consulta');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reservation`
--

CREATE TABLE `reservation` (
  `id` int(11) NOT NULL,
  `condicion` varchar(100) DEFAULT NULL,
  `first_name` varchar(100) DEFAULT NULL,
  `last_name` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `nationality` varchar(100) DEFAULT NULL,
  `phone` varchar(100) DEFAULT NULL,
  `block` varchar(100) DEFAULT NULL,
  `sac` varchar(100) DEFAULT NULL,
  `day` varchar(100) DEFAULT NULL,
  `schedule` varchar(100) DEFAULT NULL,
  `affair` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `reservation`
--

INSERT INTO `reservation` (`id`, `condicion`, `first_name`, `last_name`, `email`, `nationality`, `phone`, `block`, `sac`, `day`, `schedule`, `affair`) VALUES
(68, 'c1', 'willy', 'eleno2', 'willy@gmail.com', 'argen', '3584195616', 'B1', '123', '2022-12-14', '9:00 a 10:00 am', 'consulta');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `id` int(11) NOT NULL,
  `name` varchar(80) NOT NULL,
  `email` varchar(256) NOT NULL,
  `password` varchar(128) NOT NULL,
  `is_admin` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`id`, `name`, `email`, `password`, `is_admin`) VALUES
(1, 'ara', 'ara@gmail.com', 'pbkdf2:sha256:260000$UTVG4LQlMhla5eor$c6ec1dacdbfae7647065f43b73ae0e52de81eafcc33e2303c8549b29bf967d6b', 0),
(2, 'willy2', 'willy2@gmail.com', 'pbkdf2:sha256:260000$Jupr1PtJPyR8covW$650633fb08fdf793b22aefceb1a2faa419b11bcb89edafa911fa47b4e0bed200', 0),
(3, 'kebu', 'kebu@gmail.com', 'pbkdf2:sha256:260000$ZzHeOERifFU4pEO2$775d127032fad3bc9dce29c9f103a5c8c26b39cc806e5df70d8e6b7736f78124', 0),
(4, 'willy', 'willy@gmail.com', 'pbkdf2:sha256:260000$BumYzsVPfB8xiHZA$f5ead929f5db43d3db6156b58002c4238ba27fbd80b70a3d0f33dc39acd1243b', 0),
(5, 'tito', 'tito@tito.com', 'pbkdf2:sha256:260000$f06NW1GEy7zWJYPx$95c2229b8dbc4ef0e8ab8cdf5726e7cac0b393eaadbcd87ed2a900893757c8c7', 0),
(6, 'hhh', 'hhh@gmail.com', 'pbkdf2:sha256:260000$1dA47AJbcjYVcbbc$df4bb705075405b4efefe0147dde990da86c26a7fd7938be37dba7e758d8009c', 0),
(7, 'cacho', 'cacho@gmail.com', 'pbkdf2:sha256:260000$6jWlaSdeVaMd0yYO$c8883d3383881060413c2a2faa36b8fff3ac9e3fa713b901780c4b983183746d', 0),
(8, 'mauri', 'mauri@gmail.com', 'pbkdf2:sha256:260000$yDM7iIgWnHjZKiRr$baf0266aea1edf63dd8aa3d0217a4e7ae5c98ffdfde55d80065572cfa1ab2c28', 0),
(9, 'susana', 'susi@gmail.com', 'pbkdf2:sha256:260000$IpCoEvRGh50vbTEs$a5d0e178aed232be68f4577c4c6e1258ce1372b40ba8f898043e620439bb5551', 0);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `accpted`
--
ALTER TABLE `accpted`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `reject`
--
ALTER TABLE `reject`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `reservation`
--
ALTER TABLE `reservation`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `accpted`
--
ALTER TABLE `accpted`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;

--
-- AUTO_INCREMENT de la tabla `admin`
--
ALTER TABLE `admin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `reject`
--
ALTER TABLE `reject`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT de la tabla `reservation`
--
ALTER TABLE `reservation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=75;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
