-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 27-04-2024 a las 03:18:52
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
-- Base de datos: `bd_storeurban`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cart`
--

CREATE TABLE `cart` (
  `id` int(11) NOT NULL,
  `product_id` int(11) DEFAULT NULL,
  `quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `brand` varchar(255) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `image_path` varchar(255) NOT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `products`
--

INSERT INTO `products` (`id`, `name`, `brand`, `price`, `image_path`, `description`) VALUES
(20, 'Nike Air Jordan III Hombre Réplica AAA', 'Nike', 230000.00, 'http://localhost/TiendaOnlineUrbanFootprint/servidor_local_php/images_products/1.jpg', NULL),
(21, 'Nike Kyrie 5 Mujer Réplica AAA', 'Nike', 130000.00, 'http://localhost/TiendaOnlineUrbanFootprint/servidor_local_php/images_products/2.jpg', NULL),
(22, 'Nike Kyrie 7 Hombre Réplica AAA', 'Nike', 300000.00, 'http://localhost/TiendaOnlineUrbanFootprint/servidor_local_php/images_products/3.jpg', NULL),
(23, 'Adidas Response Bad Bunny «Paso fino» Hombre Réplica AAA', 'Adidas', 287000.00, 'http://localhost/TiendaOnlineUrbanFootprint/servidor_local_php/images_products/4.jpg', NULL),
(24, 'Puma Melo Hombre Réplica AAA', 'Puma', 150000.00, 'http://localhost/TiendaOnlineUrbanFootprint/servidor_local_php/images_products/5.jpg', NULL),
(25, 'Adidas Broomfield Hombre Réplica AAA', 'Adidas', 200000.00, 'http://localhost/TiendaOnlineUrbanFootprint/servidor_local_php/images_products/6.jpg', NULL),
(26, 'Adidas Alpha Hombre Réplica AAA', 'Adidas', 250000.00, 'http://localhost/TiendaOnlineUrbanFootprint/servidor_local_php/images_products/7.jpg', NULL),
(27, 'Nike SB Dunk Low Twist Mujer Réplica AAA', 'Nike', 300000.00, 'http://localhost/TiendaOnlineUrbanFootprint/servidor_local_php/images_products/8.jpg', NULL),
(28, 'Nike Air max 270 Hombre Réplica AAA', 'Nike', 350000.00, 'http://localhost/TiendaOnlineUrbanFootprint/servidor_local_php/images_products/9.jpg', NULL),
(29, 'Gazelle Plataforma Mujer Réplica AAA', 'Adidas', 380000.00, 'http://localhost/TiendaOnlineUrbanFootprint/servidor_local_php/images_products/10.jpg', NULL),
(30, 'Veja Velcro Mujer Réplica AAA', 'Veja', 150000.00, 'http://localhost/TiendaOnlineUrbanFootprint/servidor_local_php/images_products/11.jpg', NULL),
(31, 'Adidas Yeezy 500 Hombre Réplica AAA', 'Adidas', 200000.00, 'http://localhost/TiendaOnlineUrbanFootprint/servidor_local_php/images_products/12.jpg', NULL),
(32, 'Nike Zoom Wolf Mujer Réplica AAA', 'Nike', 250000.00, 'http://localhost/TiendaOnlineUrbanFootprint/servidor_local_php/images_products/13.jpg', NULL),
(33, 'Nike Jordan Retro 4 Black Mujer Réplica AAA', 'Nike', 300000.00, 'http://localhost/TiendaOnlineUrbanFootprint/servidor_local_php/images_products/14.jpg', NULL),
(34, 'Nike SB Dunk Low Pro Iso Hombre Réplica AAA', 'Nike', 350000.00, 'http://localhost/TiendaOnlineUrbanFootprint/servidor_local_php/images_products/15.jpg', NULL),
(35, 'Nike Kyrie 7 Hombre Réplica AAA', 'Nike', 300000.00, 'http://localhost/TiendaOnlineUrbanFootprint/servidor_local_php/images_products/3.jpg', NULL);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indices de la tabla `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `cart`
--
ALTER TABLE `cart`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT de la tabla `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `cart`
--
ALTER TABLE `cart`
  ADD CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
