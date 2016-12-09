-- phpMyAdmin SQL Dump
-- version 4.4.15.5
-- http://www.phpmyadmin.net
--
-- Host: localhost:3306
-- Generation Time: Dec 09, 2016 at 12:17 AM
-- Server version: 5.5.49-log
-- PHP Version: 7.0.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Database: `focus`
--

-- --------------------------------------------------------

--
-- Table structure for table `Encuesta`
--

CREATE TABLE IF NOT EXISTS `Encuesta` (
  `id` int(11) NOT NULL,
  `Panel` int(11) NOT NULL,
  `nombre` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `fechaInicio` date NOT NULL,
  `fechaFin` date NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Dumping data for table `Encuesta`
--

INSERT INTO `Encuesta` (`id`, `Panel`, `nombre`, `fechaInicio`, `fechaFin`) VALUES
(1, 1, 'Encuesta', '2016-08-06', '2016-12-31'),
(7, 3, 'Bronco', '2016-09-01', '2017-01-01'),
(9, 5, 'Encuesta de satisfacción del cliente', '2016-09-01', '2017-01-01'),
(10, 6, 'Prueba 2', '2016-01-01', '2017-01-01'),
(11, 5, 'PRUEBA CAMBIOS', '2016-01-01', '2024-01-01');

-- --------------------------------------------------------

--
-- Table structure for table `Historial`
--

CREATE TABLE IF NOT EXISTS `Historial` (
  `id` int(11) NOT NULL,
  `idPanelista` int(11) NOT NULL,
  `nombrePanelista` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `nombrePanel` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `fechaInicioPanel` date NOT NULL,
  `fechaFinPanel` date NOT NULL,
  `nombreEncuesta` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `fechaInicioEncuesta` date NOT NULL,
  `fechaFinEncuesta` date NOT NULL,
  `fechaRespuesta` date NOT NULL,
  `horaRespuesta` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Panel`
--

CREATE TABLE IF NOT EXISTS `Panel` (
  `id` int(11) NOT NULL,
  `nombre` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `descripcion` text COLLATE utf8_spanish_ci NOT NULL,
  `fechaInicio` date NOT NULL,
  `fechaFin` date NOT NULL,
  `numParticipantes` smallint(6) NOT NULL,
  `cliente` int(11) NOT NULL,
  `creador` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Dumping data for table `Panel`
--

INSERT INTO `Panel` (`id`, `nombre`, `descripcion`, `fechaInicio`, `fechaFin`, `numParticipantes`, `cliente`, `creador`) VALUES
(1, 'Margarita Zavala', '', '2016-09-20', '2017-01-27', 0, 2, 1),
(2, 'Votaciones 2018', '', '2016-09-24', '2017-03-10', 0, 2, 1),
(3, 'Bronco', '', '2016-09-24', '2017-03-24', 0, 3, 1),
(4, 'as', '', '2016-01-01', '2020-01-01', 0, 2, 1),
(5, 'Pollo Loco', '', '2016-09-28', '2017-04-20', 0, 4, 1),
(6, 'Prueba', '', '2016-01-01', '2018-01-01', 0, 5, 1),
(7, 'PPEPEPPEPE', '', '2016-01-01', '2018-01-01', 0, 2, 1),
(8, 'asas', '', '2016-01-01', '2018-01-01', 91, 3, 1),
(9, '123', '', '2016-01-01', '2017-01-01', 123, 3, 1),
(10, 'adsfg', '', '2016-01-01', '2017-01-01', 1234, 2, 1),
(11, '00', '', '2016-01-01', '2017-01-01', 1000, 2, 1);

-- --------------------------------------------------------

--
-- Table structure for table `Panelista`
--

CREATE TABLE IF NOT EXISTS `Panelista` (
  `id` int(11) NOT NULL,
  `username` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `password` varchar(25) COLLATE utf8_spanish_ci NOT NULL,
  `nombre` varchar(25) COLLATE utf8_spanish_ci NOT NULL,
  `apellidos` varchar(100) COLLATE utf8_spanish_ci NOT NULL,
  `email` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `genero` int(11) NOT NULL,
  `fechaNacimiento` date NOT NULL,
  `educacion` int(11) NOT NULL,
  `calleNumero` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `colonia` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `municipio` varchar(25) COLLATE utf8_spanish_ci NOT NULL,
  `estado` varchar(25) COLLATE utf8_spanish_ci NOT NULL,
  `cp` int(11) NOT NULL,
  `fechaRegistro` date DEFAULT NULL,
  `deviceToken` text COLLATE utf8_spanish_ci NOT NULL,
  `deviceType` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=461 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Dumping data for table `Panelista`
--

INSERT INTO `Panelista` (`id`, `username`, `password`, `nombre`, `apellidos`, `email`, `genero`, `fechaNacimiento`, `educacion`, `calleNumero`, `colonia`, `municipio`, `estado`, `cp`, `fechaRegistro`, `deviceToken`, `deviceType`) VALUES
(1, 'Carlos', 'pass', 'Carlos', 'Mayo Rodriguez', 'carlosmay@hotmail.com', 0, '1979-04-13', 4, 'Calle y número', 'Colonia', 'Monterrey', 'NL', 0, NULL, '', 0),
(2, 'Alejandra', 'pass', 'Alejandra', 'Sandoval Ramirez', 'alesanra23@hotmail.com', 1, '1979-08-24', 4, '', '', 'Monterrey', 'NL', 0, NULL, '', 0),
(3, 'María', 'pass', 'María', 'Zazueta López', 'mariazaz802@hotmail.com', 1, '1977-03-26', 3, '', '', 'Guadalupe', 'CAMP', 0, NULL, '', 0),
(4, 'Elizabeth', 'pass', 'Elizabeth', 'Verdugo Mayo', 'elizabethvm809824@hotmail.com', 1, '1976-03-17', 1, '', '', 'Monterrey', 'NL', 0, NULL, '', 0),
(5, 'Alberto', 'pass', 'Alberto', 'López Méndez', 'albertolm8970@hotmail.com', 0, '1975-03-09', 2, '', '', 'Juárez', 'SIN', 0, NULL, '', 0),
(6, 'Enrique', 'pass', 'Enrique', 'Martínez Lagos', 'enrmarl9035@hotmail.com', 0, '1974-02-28', 3, '', '', 'Monterrey', 'NL', 0, NULL, '', 0),
(7, 'Mario', 'pass', 'Mario', 'Casas Gutiérrez', 'mariocasas80901@hotmail.com', 0, '1973-02-19', 2, '', '', 'Monterrey', 'SIN', 0, NULL, '', 0),
(8, 'Natalia', 'pass', 'Natalia Paulina', 'Jasso León', 'natapa2815@hotmail.com', 1, '1972-02-11', 4, '', '', 'San Pedro', 'NL', 0, NULL, '', 0),
(9, 'Fernando', 'pass', 'Fernando', 'Portes Zambrano', 'ferpat0713@hotmail.com', 0, '1971-02-02', 2, '', '', 'Apodaca', 'NL', 0, NULL, '', 0),
(10, 'Karla', 'pass', 'Karla María', 'Montes Fuentes', 'karlammf0368@hotmail.com', 1, '1970-01-24', 4, '', '', 'Monterrey', 'CAMP', 0, NULL, '', 0),
(11, 'Alma', 'pass', 'Alma Alexia', 'Muñoz Montes', 'almaa9090@hotmail.com', 1, '1969-01-15', 4, '', '', 'Monterrey', 'NL', 0, NULL, '', 0),
(12, 'Ulises', 'pass', 'Ulises', 'Montemayor Montes', 'ulisesmmm9080@hotmail.com', 0, '1968-01-07', 2, '', '', 'Juárez', 'NL', 0, NULL, '', 1),
(13, 'Filiberto', 'pass', 'Filiberto', 'Zazueta Cordoba', 'filizazc7890@hotmail.com', 0, '1966-12-29', 5, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(14, 'Ricardo', 'pass', 'Ricardo', 'Duarte Fontes', 'rickyduarte5687@hotmail.com', 0, '1985-07-27', 1, '', '', 'Apodaca', 'NL', 0, NULL, '', 1),
(15, 'José Miguel', 'pass', 'José Miguel', 'Zazueta Cordoba', 'josemzc8116@hotmail.com', 0, '1983-01-12', 5, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(16, 'María del Carmen', 'pass', 'María del Carmen', 'Valenzuela Beltrán', 'macarmen_1224@hotmail.com', 1, '1980-06-29', 0, '', '', 'San Nicolás', 'NL', 0, NULL, '', 1),
(17, 'Ariadna', 'pass', 'Ariadna', 'Corral López', 'ariadnacor8024@hotmail.com', 1, '1977-12-15', 3, '', '', 'Escobedo', 'NL', 0, NULL, '', 1),
(18, 'Pedro Ignacio', 'pass', 'Pedro Ignacio', 'Ríos Garay', 'pedrorios0580@hotmail.com', 0, '1975-06-02', 5, '', '', 'San Pedro', 'NL', 0, NULL, '', 1),
(19, 'Julio', 'pass', 'Julio', 'Carranza Arriaga', 'juliocarranza_9080@hotmail.com', 0, '1972-11-17', 2, '', '', 'Santa Catarina', 'NL', 0, NULL, '', 1),
(20, 'Ana Lourdes', 'pass', 'Ana Lourdes', 'Valenzuela López', 'anilu_248090@hotmail.com', 1, '1970-05-05', 4, '', '', 'Guadalupe', 'NL', 0, NULL, '', 1),
(21, 'Vilma', 'pass', 'Vilma', 'López Rodríguez', 'vilma9042@hotmail.com', 1, '1967-10-21', 3, '', '', 'García', 'NL', 0, NULL, '', 1),
(22, 'Roberto', 'pass', 'Roberto', 'Loaiza Maytorena', 'robertoloaiza1292@hotmail.com', 0, '1965-04-07', 1, '', '', 'Escobedo', 'NL', 0, NULL, '', 1),
(23, 'Mar', 'pass', 'Mar', 'González González', 'margonzalez_8479@hotmail.com', 1, '1962-09-23', 1, '', '', 'Santa Catarina', 'NL', 0, NULL, '', 1),
(24, 'Luis Manuel', 'pass', 'Luis Manuel', 'Martínez Sánchez', 'luismanuel_90_80@hotmail.com', 0, '1960-03-10', 2, '', '', 'San Nicolás', 'NL', 0, NULL, '', 1),
(25, 'Karmina', 'pass', 'Karmina', 'Martínez González', 'karminamtz9789@hotmail.com', 1, '1957-08-26', 2, '', '', 'Escobedo', 'NL', 0, NULL, '', 1),
(26, 'Enrique', 'pass', 'Enrique', 'Martínez Lagos', 'enrmarl9035@hotmail.com', 0, '1997-03-11', 3, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(27, 'Mario', 'pass', 'Mario', 'Casas Gutiérrez', 'mariocasas80901@hotmail.com', 0, '1995-05-10', 2, '', '', 'García', 'NL', 0, NULL, '', 1),
(28, 'Natalia Paulina', 'pass', 'Natalia Paulina', 'Jasso León', 'natapa2815@hotmail.com', 1, '1998-07-05', 4, '', '', 'San Pedro', 'NL', 0, NULL, '', 1),
(29, 'Fernando', 'pass', 'Fernando', 'Portes Zambrano', 'ferpat0713@hotmail.com', 0, '1991-01-01', 1, '', '', 'Apodaca', 'NL', 0, NULL, '', 1),
(30, 'Karla María', 'pass', 'Karla María', 'Montes Fuentes', 'karlammf0368@hotmail.com', 1, '1992-02-01', 4, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(31, 'Alma Alexia', 'pass', 'Alma Alexia', 'Muñoz Montes', 'almaa9090@hotmail.com', 1, '1994-03-03', 4, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(32, 'Ariadna', 'pass', 'Ariadna', 'Corral López', 'ariadnacor8024@hotmail.com', 1, '1998-04-05', 2, '', '', 'Escobedo', 'NL', 0, NULL, '', 1),
(33, 'Pedro Ignacio', 'pass', 'Pedro Ignacio', 'Ríos Garay', 'pedrorios0580@hotmail.com', 0, '1996-05-02', 2, '', '', 'San Pedro', 'NL', 0, NULL, '', 1),
(34, 'Julio', 'pass', 'Julio', 'Carranza Arriaga', 'juliocarranza_9080@hotmail.com', 0, '1996-06-06', 3, '', '', 'Santa Catarina', 'NL', 0, NULL, '', 1),
(35, 'Ana Lourdes', 'pass', 'Ana Lourdes', 'Valenzuela López', 'anilu_248090@hotmail.com', 1, '1982-07-21', 4, '', '', 'Guadalupe', 'NL', 0, NULL, '', 1),
(36, 'Vilma', 'pass', 'Vilma', 'López Rodríguez', 'vilma9042@hotmail.com', 1, '1976-08-24', 3, '', '', 'García', 'NL', 0, NULL, '', 1),
(37, 'Roberto', 'pass', 'Roberto', 'Loaiza Maytorena', 'robertoloaiza1292@hotmail.com', 0, '1954-09-30', 3, '', '', 'Escobedo', 'NL', 0, NULL, '', 1),
(38, 'Mar', 'pass', 'Mar', 'González González', 'margonzalez_8479@hotmail.com', 1, '1959-10-10', 1, '', '', 'Santa Catarina', 'NL', 0, NULL, '', 1),
(39, 'Luis Manuel', 'pass', 'Luis Manuel', 'Martínez Sánchez', 'luismanuel_90_80@hotmail.com', 0, '1998-10-05', 3, '', '', 'San Nicolás', 'NL', 0, NULL, '', 1),
(40, 'Carlos', 'pass', 'Carlos', 'Mayo Rodriguez', 'carlosmay@hotmail.com', 0, '1987-12-12', 4, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(41, 'Natalia Paulina', 'pass', 'Natalia Paulina', 'Jasso León', 'natapa2815@hotmail.com', 1, '1988-05-04', 4, '', '', 'Apodaca', 'NL', 0, NULL, '', 1),
(42, 'Fernando', 'pass', 'Fernando', 'Portes Zambrano', 'ferpat0713@hotmail.com', 0, '1982-12-15', 4, '', '', 'Escobedo', 'NL', 0, NULL, '', 1),
(43, 'Ulises', 'pass', 'Ulises', 'Montemayor Montes', 'ulisesmmm9080@hotmail.com', 0, '1977-07-27', 2, '', '', 'Juárez', 'NL', 0, NULL, '', 1),
(44, 'Elizabeth', 'pass', 'Elizabeth', 'Verdugo Mayo', 'elizabethvm809824@hotmail.com', 1, '1972-03-08', 4, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(45, 'Mario', 'pass', 'Mario', 'Casas Gutiérrez', 'mariocasas80901@hotmail.com', 0, '1966-10-19', 2, '', '', 'García', 'NL', 0, NULL, '', 1),
(46, 'Fernando', 'pass', 'Fernando', 'Portes Zambrano', 'ferpat0713@hotmail.com', 0, '1961-05-31', 4, '', '', 'Guadalupe', 'NL', 0, NULL, '', 1),
(47, 'Karla María', 'pass', 'Karla María', 'Montes Fuentes', 'karlammf0368@hotmail.com', 1, '1956-01-11', 4, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(48, 'Filiberto', 'pass', 'Filiberto', 'Zazueta Cordoba', 'filizazc7890@hotmail.com', 0, '1950-08-23', 5, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(49, 'Ariadna', 'pass', 'Ariadna', 'Corral López', 'ariadnacor8024@hotmail.com', 1, '1995-04-04', 3, '', '', 'Escobedo', 'NL', 0, NULL, '', 1),
(50, 'Julio', 'pass', 'Julio', 'Carranza Arriaga', 'juliocarranza_9080@hotmail.com', 0, '1989-11-15', 0, '', '', 'Santa Catarina', 'NL', 0, NULL, '', 1),
(51, 'Vilma', 'pass', 'Vilma', 'López Rodríguez', 'vilma9042@hotmail.com', 1, '1984-06-27', 2, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(52, 'Alejandra', 'pass', 'Alejandra', 'Sandoval Ramirez', 'alesanra23@hotmail.com', 1, '1979-02-07', 3, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(53, 'María', 'pass', 'María', 'Zazueta López', 'mariazaz802@hotmail.com', 1, '1973-09-19', 3, '', '', 'Guadalupe', 'NL', 0, NULL, '', 1),
(54, 'Enrique', 'pass', 'Enrique', 'Martínez Lagos', 'enrmarl9035@hotmail.com', 0, '1968-05-01', 3, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(55, 'Alma Alexia', 'pass', 'Alma Alexia', 'Muñoz Montes', 'almaa9090@hotmail.com', 1, '1962-12-12', 4, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(56, 'José Miguel', 'pass', 'José Miguel', 'Zazueta Cordoba', 'josemzc8116@hotmail.com', 0, '1957-07-24', 2, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(57, 'Luis Manuel', 'pass', 'Luis Manuel', 'Martínez Sánchez', 'luismanuel_90_80@hotmail.com', 0, '1952-03-05', 2, '', '', 'San Nicolás', 'NL', 0, NULL, '', 1),
(58, 'Natalia Paulina', 'pass', 'Natalia Paulina', 'Jasso León', 'natapa2815@hotmail.com', 1, '1998-10-16', 2, '', '', 'San Pedro', 'NL', 0, NULL, '', 1),
(59, 'María', 'pass', 'María', 'Zazueta López', 'mariazaz802@hotmail.com', 1, '1981-05-28', 3, '', '', 'Guadalupe', 'NL', 0, NULL, '', 1),
(60, 'Elizabeth', 'pass', 'Elizabeth', 'Verdugo Mayo', 'elizabethvm809824@hotmail.com', 1, '1986-01-08', 2, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(61, 'Raúl', 'pass', 'Raúl', 'Dominguez López', 'rauldom4598@hotmail.com', 0, '1990-08-20', 2, '', '', 'Juárez', 'NL', 0, NULL, '', 1),
(62, 'Natalia Paulina', 'pass', 'Natalia Paulina', 'Jasso León', 'natapa2815@hotmail.com', 1, '1995-04-01', 4, '', '', 'San Nicolás', 'NL', 0, NULL, '', 1),
(63, 'Fernando', 'pass', 'Fernando', 'Portes Zambrano', 'ferpat0713@hotmail.com', 0, '1989-11-12', 1, '', '', 'Apodaca', 'NL', 0, NULL, '', 1),
(64, 'Karla María', 'pass', 'Karla María', 'Montes Fuentes', 'karlammf0368@hotmail.com', 1, '1974-06-24', 4, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(65, 'Filiberto', 'pass', 'Filiberto', 'Zazueta Cordoba', 'filizazc7890@hotmail.com', 0, '1959-02-03', 3, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(66, 'María del Carmen', 'pass', 'María del Carmen', 'Valenzuela Beltrán', 'macarmen_1224@hotmail.com', 1, '1953-09-15', 0, '', '', 'Apodaca', 'NL', 0, NULL, '', 1),
(67, 'Julio', 'pass', 'Julio', 'Carranza Arriaga', 'juliocarranza_9080@hotmail.com', 0, '1978-04-26', 3, '', '', 'Santa Catarina', 'NL', 0, NULL, '', 1),
(68, 'Vilma', 'pass', 'Vilma', 'López Rodríguez', 'vilma9042@hotmail.com', 1, '1982-12-06', 3, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(69, 'Roberto', 'pass', 'Roberto', 'Loaiza Maytorena', 'robertoloaiza1292@hotmail.com', 0, '1989-11-12', 2, '', '', 'Escobedo', 'NL', 0, NULL, '', 1),
(70, 'Mario', 'pass', 'Mario', 'Casas Gutiérrez', 'mariocasas80901@hotmail.com', 0, '1996-10-19', 3, '', '', 'García', 'NL', 0, NULL, '', 1),
(71, 'Filiberto', 'pass', 'Filiberto', 'Zazueta Cordoba', 'filizazc7890@hotmail.com', 0, '1993-09-26', 5, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(72, 'Alejandra', 'pass', 'Alejandra', 'Sandoval Ramirez', 'alesanra23@hotmail.com', 1, '1970-09-02', 0, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(73, 'Alma Alexia', 'pass', 'Alma Alexia', 'Muñoz Montes', 'almaa9090@hotmail.com', 1, '1997-08-09', 4, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(74, 'Luis Manuel', 'pass', 'Luis Manuel', 'Martínez Sánchez', 'luismanuel_90_80@hotmail.com', 0, '1974-07-16', 2, '', '', 'San Nicolás', 'NL', 0, NULL, '', 1),
(75, 'Elizabeth', 'pass', 'Elizabeth', 'Verdugo Mayo', 'elizabethvm809824@hotmail.com', 1, '1951-06-22', 1, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(76, 'Julian', 'pass', 'Julian', 'Zambrano Treviño', 'julianzam_7887@hotmail.com', 0, '1988-05-28', 2, '', '', 'Juárez', 'NL', 0, NULL, '', 1),
(77, 'Natalia Paulina', 'pass', 'Natalia Paulina', 'Jasso León', 'natapa2815@hotmail.com', 1, '1985-05-04', 4, '', '', 'Guadalupe', 'NL', 0, NULL, '', 1),
(78, 'Enrique', 'pass', 'Enrique', 'Martínez Lagos', 'enrmarl9035@hotmail.com', 0, '1974-07-16', 3, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(79, 'Mario', 'pass', 'Mario', 'Casas Gutiérrez', 'mariocasas80901@hotmail.com', 0, '1963-09-27', 3, '', '', 'García', 'NL', 0, NULL, '', 1),
(80, 'Natalia Paulina', 'pass', 'Natalia Paulina', 'Jasso León', 'natapa2815@hotmail.com', 1, '1952-12-08', 3, '', '', 'Santa Catarina', 'NL', 0, NULL, '', 1),
(81, 'Fernando', 'pass', 'Fernando', 'Portes Zambrano', 'ferpat0713@hotmail.com', 0, '1992-02-19', 2, '', '', 'San Pedro', 'NL', 0, NULL, '', 1),
(82, 'Julio', 'pass', 'Julio', 'Carranza Arriaga', 'juliocarranza_9080@hotmail.com', 0, '1961-05-03', 1, '', '', 'Santa Catarina', 'NL', 0, NULL, '', 1),
(83, 'Ana Lourdes', 'pass', 'Ana Lourdes', 'Valenzuela López', 'anilu_248090@hotmail.com', 1, '1970-07-14', 4, '', '', 'Guadalupe', 'NL', 0, NULL, '', 1),
(84, 'Vilma', 'pass', 'Vilma', 'López Rodríguez', 'vilma9042@hotmail.com', 1, '1998-09-25', 3, '', '', 'García', 'NL', 0, NULL, '', 1),
(85, 'Roberto', 'pass', 'Roberto', 'Loaiza Maytorena', 'robertoloaiza1292@hotmail.com', 0, '1985-05-04', 4, '', '', 'Escobedo', 'NL', 0, NULL, '', 1),
(86, 'Julio', 'pass', 'Julio', 'Carranza Arriaga', 'juliocarranza_9080@hotmail.com', 0, '1971-12-12', 2, '', '', 'Santa Catarina', 'NL', 0, NULL, '', 1),
(87, 'Ana Lourdes', 'pass', 'Ana Lourdes', 'Valenzuela López', 'anilu_248090@hotmail.com', 1, '1958-07-21', 4, '', '', 'Guadalupe', 'NL', 0, NULL, '', 1),
(88, 'Vilma', 'pass', 'Vilma', 'López Rodríguez', 'vilma9042@hotmail.com', 1, '1945-02-27', 2, '', '', 'García', 'NL', 0, NULL, '', 1),
(89, 'Ariadna', 'pass', 'Ariadna', 'Corral López', 'ariadnacor8024@hotmail.com', 1, '1981-10-07', 3, '', '', 'Escobedo', 'NL', 0, NULL, '', 1),
(90, 'Julio', 'pass', 'Julio', 'Carranza Arriaga', 'juliocarranza_9080@hotmail.com', 0, '1988-05-16', 1, '', '', 'Santa Catarina', 'NL', 0, NULL, '', 1),
(91, 'Vilma', 'pass', 'Vilma', 'López Rodríguez', 'vilma9042@hotmail.com', 1, '1994-12-23', 2, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(92, 'Luis Manuel', 'pass', 'Luis Manuel', 'Martínez Sánchez', 'luismanuel_90_80@hotmail.com', 0, '1991-07-31', 2, '', '', 'San Nicolás', 'NL', 0, NULL, '', 1),
(93, 'Natalia Paulina', 'pass', 'Natalia Paulina', 'Jasso León', 'natapa2815@hotmail.com', 1, '1988-03-08', 4, '', '', 'Apodaca', 'NL', 0, NULL, '', 1),
(94, 'Pedro Ignacio', 'pass', 'Pedro Ignacio', 'Ríos Garay', 'pedrorios0580@hotmail.com', 0, '1984-10-15', 5, '', '', 'San Pedro', 'NL', 0, NULL, '', 1),
(95, 'Ana Lourdes', 'pass', 'Ana Lourdes', 'Valenzuela López', 'anilu_248090@hotmail.com', 1, '1971-05-23', 4, '', '', 'Guadalupe', 'NL', 0, NULL, '', 1),
(96, 'Carlos', 'pass', 'Carlos', 'Mayo Rodriguez', 'carlosmay@hotmail.com', 0, '1977-12-30', 4, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(97, 'Elizabeth', 'pass', 'Elizabeth', 'Verdugo Mayo', 'elizabethvm809824@hotmail.com', 1, '1984-08-07', 1, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(98, 'Fernando', 'pass', 'Fernando', 'Portes Zambrano', 'ferpat0713@hotmail.com', 0, '1981-03-15', 1, '', '', 'Apodaca', 'NL', 0, NULL, '', 1),
(99, 'Fernando', 'pass', 'Fernando', 'Portes Zambrano', 'ferpat0713@hotmail.com', 0, '1947-10-22', 1, '', '', 'San Pedro', 'NL', 0, NULL, '', 1),
(100, 'Julio', 'pass', 'Julio', 'Carranza Arriaga', 'juliocarranza_9080@hotmail.com', 0, '1954-05-30', 1, '', '', 'Santa Catarina', 'NL', 0, NULL, '', 1),
(101, 'Filiberto', 'pass', 'Filiberto', 'Zazueta Cordoba', 'filizazc7890@hotmail.com', 0, '1966-12-29', 5, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(102, 'Carlos', 'pass', 'Carlos', 'Mayo Rodriguez', 'carlosmay@hotmail.com', 0, '1985-07-27', 2, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(103, 'Alejandra', 'pass', 'Alejandra', 'Sandoval Ramirez', 'alesanra23@hotmail.com', 1, '1993-02-23', 4, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(104, 'María', 'pass', 'María', 'Zazueta López', 'mariazaz802@hotmail.com', 1, '1992-09-21', 3, '', '', 'Guadalupe', 'NL', 0, NULL, '', 1),
(105, 'Natalia Paulina', 'pass', 'Natalia Paulina', 'Jasso León', 'natapa2815@hotmail.com', 1, '1941-04-19', 4, '', '', 'Apodaca', 'NL', 0, NULL, '', 1),
(106, 'Fernando', 'pass', 'Fernando', 'Portes Zambrano', 'ferpat0713@hotmail.com', 0, '1959-11-16', 3, '', '', 'Apodaca', 'NL', 0, NULL, '', 1),
(107, 'Karla María', 'pass', 'Karla María', 'Montes Fuentes', 'karlammf0368@hotmail.com', 1, '1978-06-14', 4, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(108, 'Ricardo', 'pass', 'Ricardo', 'Duarte Fontes', 'rickyduarte5687@hotmail.com', 0, '1997-01-10', 1, '', '', 'Apodaca', 'NL', 0, NULL, '', 1),
(109, 'José Miguel', 'pass', 'José Miguel', 'Zazueta Cordoba', 'josemzc8116@hotmail.com', 0, '1955-08-10', 0, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(110, 'María del Carmen', 'pass', 'María del Carmen', 'Valenzuela Beltrán', 'macarmen_1224@hotmail.com', 1, '1964-03-08', 0, '', '', 'Escobedo', 'NL', 0, NULL, '', 1),
(111, 'Julio', 'pass', 'Julio', 'Carranza Arriaga', 'juliocarranza_9080@hotmail.com', 0, '1952-10-04', 3, '', '', 'Santa Catarina', 'NL', 0, NULL, '', 1),
(112, 'Ana Lourdes', 'pass', 'Ana Lourdes', 'Valenzuela López', 'anilu_248090@hotmail.com', 1, '1971-05-03', 4, '', '', 'Guadalupe', 'NL', 0, NULL, '', 1),
(113, 'Vilma', 'pass', 'Vilma', 'López Rodríguez', 'vilma9042@hotmail.com', 1, '1996-08-14', 3, '', '', 'García', 'NL', 0, NULL, '', 1),
(114, 'Karmina', 'pass', 'Karmina', 'Martínez González', 'karminamtz9789@hotmail.com', 1, '1980-10-07', 2, '', '', 'Escobedo', 'NL', 0, NULL, '', 1),
(115, 'Enrique', 'pass', 'Enrique', 'Martínez Lagos', 'enrmarl9035@hotmail.com', 0, '1964-11-30', 3, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(116, 'Julio', 'pass', 'Julio', 'Carranza Arriaga', 'juliocarranza_9080@hotmail.com', 0, '1949-01-23', 3, '', '', 'Santa Catarina', 'NL', 0, NULL, '', 1),
(117, 'Ana Lourdes', 'pass', 'Ana Lourdes', 'Valenzuela López', 'anilu_248090@hotmail.com', 1, '1993-03-18', 4, '', '', 'Guadalupe', 'NL', 0, NULL, '', 1),
(118, 'Vilma', 'pass', 'Vilma', 'López Rodríguez', 'vilma9042@hotmail.com', 1, '1997-05-11', 1, '', '', 'García', 'NL', 0, NULL, '', 1),
(119, 'Roberto', 'pass', 'Roberto', 'Loaiza Maytorena', 'robertoloaiza1292@hotmail.com', 0, '1981-07-04', 4, '', '', 'Escobedo', 'NL', 0, NULL, '', 1),
(120, 'Fernando', 'pass', 'Fernando', 'Portes Zambrano', 'ferpat0713@hotmail.com', 0, '1980-10-07', 4, '', '', 'Guadalupe', 'NL', 0, NULL, '', 1),
(121, 'Mario', 'pass', 'Mario', 'Casas Gutiérrez', 'mariocasas80901@hotmail.com', 0, '1996-08-14', 0, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(122, 'Fernando', 'pass', 'Fernando', 'Portes Zambrano', 'ferpat0713@hotmail.com', 0, '1982-06-21', 4, '', '', 'Santa Catarina', 'NL', 0, NULL, '', 1),
(123, 'Karla María', 'pass', 'Karla María', 'Montes Fuentes', 'karlammf0368@hotmail.com', 1, '1998-04-28', 4, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(124, 'Filiberto', 'pass', 'Filiberto', 'Zazueta Cordoba', 'filizazc7890@hotmail.com', 0, '1944-03-05', 5, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(125, 'María', 'pass', 'María', 'Zazueta López', 'mariazaz802@hotmail.com', 1, '1960-01-11', 3, '', '', 'Guadalupe', 'NL', 0, NULL, '', 1),
(126, 'José Miguel', 'pass', 'José Miguel', 'Zazueta Cordoba', 'josemzc8116@hotmail.com', 0, '1975-11-18', 5, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(127, 'María', 'pass', 'María', 'Zazueta López', 'mariazaz802@hotmail.com', 1, '1991-09-25', 3, '', '', 'Guadalupe', 'NL', 0, NULL, '', 1),
(128, 'Filiberto', 'pass', 'Filiberto', 'Zazueta Cordoba', 'filizazc7890@hotmail.com', 0, '1987-08-02', 5, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(129, 'María del Carmen', 'pass', 'María del Carmen', 'Valenzuela Beltrán', 'macarmen_1224@hotmail.com', 1, '1993-06-09', 0, '', '', 'San Nicolás', 'NL', 0, NULL, '', 1),
(130, 'Julio', 'pass', 'Julio', 'Carranza Arriaga', 'juliocarranza_9080@hotmail.com', 0, '1979-04-16', 2, '', '', 'Santa Catarina', 'NL', 0, NULL, '', 1),
(131, 'Vilma', 'pass', 'Vilma', 'López Rodríguez', 'vilma9042@hotmail.com', 1, '1955-02-21', 1, '', '', 'García', 'NL', 0, NULL, '', 1),
(132, 'Roberto', 'pass', 'Roberto', 'Loaiza Maytorena', 'robertoloaiza1292@hotmail.com', 0, '1970-12-29', 1, '', '', 'Escobedo', 'NL', 0, NULL, '', 1),
(133, 'Mario', 'pass', 'Mario', 'Casas Gutiérrez', 'mariocasas80901@hotmail.com', 0, '1986-11-05', 3, '', '', 'García', 'NL', 0, NULL, '', 1),
(134, 'Ariadna', 'pass', 'Ariadna', 'Corral López', 'ariadnacor8024@hotmail.com', 1, '1980-04-21', 1, '', '', 'Escobedo', 'NL', 0, NULL, '', 1),
(135, 'Julio', 'pass', 'Julio', 'Carranza Arriaga', 'juliocarranza_9080@hotmail.com', 0, '1979-04-13', 3, '', '', 'Santa Catarina', 'NL', 0, NULL, '', 1),
(136, 'Vilma', 'pass', 'Vilma', 'López Rodríguez', 'vilma9042@hotmail.com', 1, '1978-04-04', 3, '', '', 'García', 'NL', 0, NULL, '', 1),
(137, 'Luis Manuel', 'pass', 'Luis Manuel', 'Martínez Sánchez', 'luismanuel_90_80@hotmail.com', 0, '1977-03-26', 2, '', '', 'San Nicolás', 'NL', 0, NULL, '', 1),
(138, 'Natalia Paulina', 'pass', 'Natalia Paulina', 'Jasso León', 'natapa2815@hotmail.com', 1, '1976-03-17', 2, '', '', 'Guadalupe', 'NL', 0, NULL, '', 1),
(139, 'Pedro Ignacio', 'pass', 'Pedro Ignacio', 'Ríos Garay', 'pedrorios0580@hotmail.com', 0, '1975-03-09', 5, '', '', 'Apodaca', 'NL', 0, NULL, '', 1),
(140, 'Ana Lourdes', 'pass', 'Ana Lourdes', 'Valenzuela López', 'anilu_248090@hotmail.com', 1, '1974-02-28', 4, '', '', 'Guadalupe', 'NL', 0, NULL, '', 1),
(141, 'Carlos', 'pass', 'Carlos', 'Mayo Rodriguez', 'carlosmay@hotmail.com', 0, '1973-02-19', 1, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(142, 'Elizabeth', 'pass', 'Elizabeth', 'Verdugo Mayo', 'elizabethvm809824@hotmail.com', 1, '1972-02-11', 4, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(143, 'Fernando', 'pass', 'Fernando', 'Portes Zambrano', 'ferpat0713@hotmail.com', 0, '1971-02-02', 4, '', '', 'Guadalupe', 'NL', 0, NULL, '', 1),
(144, 'Natalia Paulina', 'pass', 'Natalia Paulina', 'Jasso León', 'natapa2815@hotmail.com', 1, '1970-01-24', 4, '', '', 'Escobedo', 'NL', 0, NULL, '', 1),
(145, 'Fernando', 'pass', 'Fernando', 'Portes Zambrano', 'ferpat0713@hotmail.com', 0, '1969-01-15', 1, '', '', 'Escobedo', 'NL', 0, NULL, '', 1),
(146, 'Karla María', 'pass', 'Karla María', 'Montes Fuentes', 'karlammf0368@hotmail.com', 1, '1968-01-07', 4, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(147, 'Alma Alexia', 'pass', 'Alma Alexia', 'Muñoz Montes', 'almaa9090@hotmail.com', 1, '1966-12-29', 1, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(148, 'Ariadna', 'pass', 'Ariadna', 'Corral López', 'ariadnacor8024@hotmail.com', 1, '1985-07-27', 2, '', '', 'Escobedo', 'NL', 0, NULL, '', 1),
(149, 'Pedro Ignacio', 'pass', 'Pedro Ignacio', 'Ríos Garay', 'pedrorios0580@hotmail.com', 0, '1983-01-12', 5, '', '', 'Apodaca', 'NL', 0, NULL, '', 1),
(150, 'Julio', 'pass', 'Julio', 'Carranza Arriaga', 'juliocarranza_9080@hotmail.com', 0, '1980-06-29', 2, '', '', 'Santa Catarina', 'NL', 0, NULL, '', 1),
(151, 'Vilma', 'pass', 'Vilma', 'López Rodríguez', 'vilma9042@hotmail.com', 1, '1977-12-15', 3, '', '', 'García', 'NL', 0, NULL, '', 1),
(152, 'Alejandra', 'pass', 'Alejandra', 'Sandoval Ramirez', 'alesanra23@hotmail.com', 1, '1975-06-02', 4, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(153, 'María', 'pass', 'María', 'Zazueta López', 'mariazaz802@hotmail.com', 1, '1972-11-17', 3, '', '', 'Guadalupe', 'NL', 0, NULL, '', 1),
(154, 'Enrique', 'pass', 'Enrique', 'Martínez Lagos', 'enrmarl9035@hotmail.com', 0, '1970-05-05', 3, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(155, 'Karla María', 'pass', 'Karla María', 'Montes Fuentes', 'karlammf0368@hotmail.com', 1, '1967-10-21', 4, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(156, 'Filiberto', 'pass', 'Filiberto', 'Zazueta Cordoba', 'filizazc7890@hotmail.com', 0, '1965-04-07', 3, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(157, 'María del Carmen', 'pass', 'María del Carmen', 'Valenzuela Beltrán', 'macarmen_1224@hotmail.com', 1, '1962-09-23', 0, '', '', 'García', 'NL', 0, NULL, '', 1),
(158, 'Julio', 'pass', 'Julio', 'Carranza Arriaga', 'juliocarranza_9080@hotmail.com', 0, '1960-03-10', 1, '', '', 'Santa Catarina', 'NL', 0, NULL, '', 1),
(159, 'Vilma', 'pass', 'Vilma', 'López Rodríguez', 'vilma9042@hotmail.com', 1, '1957-08-26', 4, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(160, 'Roberto', 'pass', 'Roberto', 'Loaiza Maytorena', 'robertoloaiza1292@hotmail.com', 0, '1997-03-11', 4, '', '', 'Escobedo', 'NL', 0, NULL, '', 1),
(161, 'Natalia Paulina', 'pass', 'Natalia Paulina', 'Jasso León', 'natapa2815@hotmail.com', 1, '1995-05-10', 1, '', '', 'San Pedro', 'NL', 0, NULL, '', 1),
(162, 'Enrique', 'pass', 'Enrique', 'Martínez Lagos', 'enrmarl9035@hotmail.com', 0, '1998-07-05', 3, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(163, 'Mario', 'pass', 'Mario', 'Casas Gutiérrez', 'mariocasas80901@hotmail.com', 0, '1991-01-01', 3, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(164, 'Natalia Paulina', 'pass', 'Natalia Paulina', 'Jasso León', 'natapa2815@hotmail.com', 1, '1992-02-01', 3, '', '', 'San Pedro', 'NL', 0, NULL, '', 1),
(165, 'Fernando', 'pass', 'Fernando', 'Portes Zambrano', 'ferpat0713@hotmail.com', 0, '1994-03-03', 4, '', '', 'Santa Catarina', 'NL', 0, NULL, '', 1),
(166, 'Filiberto', 'pass', 'Filiberto', 'Zazueta Cordoba', 'filizazc7890@hotmail.com', 0, '1998-04-05', 5, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(167, 'Carlos', 'pass', 'Carlos', 'Mayo Rodriguez', 'carlosmay@hotmail.com', 0, '1996-05-02', 4, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(168, 'Alejandra', 'pass', 'Alejandra', 'Sandoval Ramirez', 'alesanra23@hotmail.com', 1, '1996-06-06', 2, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(169, 'María', 'pass', 'María', 'Zazueta López', 'mariazaz802@hotmail.com', 1, '1982-07-21', 3, '', '', 'Guadalupe', 'NL', 0, NULL, '', 1),
(170, 'Natalia Paulina', 'pass', 'Natalia Paulina', 'Jasso León', 'natapa2815@hotmail.com', 1, '1976-08-24', 4, '', '', 'Apodaca', 'NL', 0, NULL, '', 1),
(171, 'Julio', 'pass', 'Julio', 'Carranza Arriaga', 'juliocarranza_9080@hotmail.com', 0, '1954-09-30', 2, '', '', 'Santa Catarina', 'NL', 0, NULL, '', 1),
(172, 'Ana Lourdes', 'pass', 'Ana Lourdes', 'Valenzuela López', 'anilu_248090@hotmail.com', 1, '1959-10-10', 4, '', '', 'Guadalupe', 'NL', 0, NULL, '', 1),
(173, 'Vilma', 'pass', 'Vilma', 'López Rodríguez', 'vilma9042@hotmail.com', 1, '1998-10-05', 4, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(174, 'Roberto', 'pass', 'Roberto', 'Loaiza Maytorena', 'robertoloaiza1292@hotmail.com', 0, '1987-12-12', 4, '', '', 'Escobedo', 'NL', 0, NULL, '', 1),
(175, 'Fernando', 'pass', 'Fernando', 'Portes Zambrano', 'ferpat0713@hotmail.com', 0, '1988-05-04', 2, '', '', 'Apodaca', 'NL', 0, NULL, '', 1),
(176, 'Mario', 'pass', 'Mario', 'Casas Gutiérrez', 'mariocasas80901@hotmail.com', 0, '1982-12-15', 3, '', '', 'García', 'NL', 0, NULL, '', 1),
(177, 'Julio', 'pass', 'Julio', 'Carranza Arriaga', 'juliocarranza_9080@hotmail.com', 0, '1977-07-27', 2, '', '', 'Santa Catarina', 'NL', 0, NULL, '', 1),
(178, 'Vilma', 'pass', 'Vilma', 'López Rodríguez', 'vilma9042@hotmail.com', 1, '1972-03-08', 3, '', '', 'García', 'NL', 0, NULL, '', 1),
(179, 'Luis Manuel', 'pass', 'Luis Manuel', 'Martínez Sánchez', 'luismanuel_90_80@hotmail.com', 0, '1966-10-19', 1, '', '', 'San Nicolás', 'NL', 0, NULL, '', 1),
(180, 'Natalia Paulina', 'pass', 'Natalia Paulina', 'Jasso León', 'natapa2815@hotmail.com', 1, '1961-05-31', 4, '', '', 'San Pedro', 'NL', 0, NULL, '', 1),
(181, 'Pedro Ignacio', 'pass', 'Pedro Ignacio', 'Ríos Garay', 'pedrorios0580@hotmail.com', 0, '1956-01-11', 5, '', '', 'Apodaca', 'NL', 0, NULL, '', 1),
(182, 'Ana Lourdes', 'pass', 'Ana Lourdes', 'Valenzuela López', 'anilu_248090@hotmail.com', 1, '1950-08-23', 4, '', '', 'Guadalupe', 'NL', 0, NULL, '', 1),
(183, 'Carlos', 'pass', 'Carlos', 'Mayo Rodriguez', 'carlosmay@hotmail.com', 0, '1995-04-04', 3, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(184, 'Elizabeth', 'pass', 'Elizabeth', 'Verdugo Mayo', 'elizabethvm809824@hotmail.com', 1, '1989-11-15', 2, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(185, 'Fernando', 'pass', 'Fernando', 'Portes Zambrano', 'ferpat0713@hotmail.com', 0, '1984-06-27', 2, '', '', 'San Nicolás', 'NL', 0, NULL, '', 1),
(186, 'Natalia Paulina', 'pass', 'Natalia Paulina', 'Jasso León', 'natapa2815@hotmail.com', 1, '1979-02-07', 4, '', '', 'Apodaca', 'NL', 0, NULL, '', 1),
(187, 'Fernando', 'pass', 'Fernando', 'Portes Zambrano', 'ferpat0713@hotmail.com', 0, '1973-09-19', 4, '', '', 'San Pedro', 'NL', 0, NULL, '', 1),
(188, 'Karla María', 'pass', 'Karla María', 'Montes Fuentes', 'karlammf0368@hotmail.com', 1, '1968-05-01', 4, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(189, 'Alma Alexia', 'pass', 'Alma Alexia', 'Muñoz Montes', 'almaa9090@hotmail.com', 1, '1962-12-12', 4, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(190, 'Ariadna', 'pass', 'Ariadna', 'Corral López', 'ariadnacor8024@hotmail.com', 1, '1957-07-24', 2, '', '', 'Escobedo', 'NL', 0, NULL, '', 1),
(191, 'Natalia Paulina', 'pass', 'Natalia Paulina', 'Jasso León', 'natapa2815@hotmail.com', 1, '1952-03-05', 3, '', '', 'San Pedro', 'NL', 0, NULL, '', 1),
(192, 'Fernando', 'pass', 'Fernando', 'Portes Zambrano', 'ferpat0713@hotmail.com', 0, '1998-10-16', 4, '', '', 'Apodaca', 'NL', 0, NULL, '', 1),
(193, 'Karla María', 'pass', 'Karla María', 'Montes Fuentes', 'karlammf0368@hotmail.com', 1, '1981-05-28', 4, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(194, 'Alma Alexia', 'pass', 'Alma Alexia', 'Muñoz Montes', 'almaa9090@hotmail.com', 1, '1986-01-08', 4, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(195, 'Ulises', 'pass', 'Ulises', 'Montemayor Montes', 'ulisesmmm9080@hotmail.com', 0, '1990-08-20', 2, '', '', 'Juárez', 'NL', 0, NULL, '', 1),
(196, 'Filiberto', 'pass', 'Filiberto', 'Zazueta Cordoba', 'filizazc7890@hotmail.com', 0, '1995-04-01', 5, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(197, 'Natalia Paulina', 'pass', 'Natalia Paulina', 'Jasso León', 'natapa2815@hotmail.com', 1, '1989-11-12', 4, '', '', 'Apodaca', 'NL', 0, NULL, '', 1),
(198, 'María', 'pass', 'María', 'Zazueta López', 'mariazaz802@hotmail.com', 1, '1974-06-24', 3, '', '', 'Guadalupe', 'NL', 0, NULL, '', 1),
(199, 'Elizabeth', 'pass', 'Elizabeth', 'Verdugo Mayo', 'elizabethvm809824@hotmail.com', 1, '1959-02-03', 3, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(200, 'Alejandro', 'pass', 'Alejandro', 'Muñoz Muñoz', 'alexmm_8970@hotmail.com', 0, '1953-09-15', 2, '', '', 'Juárez', 'NL', 0, NULL, '', 1),
(201, 'Natalia Paulina', 'pass', 'Natalia Paulina', 'Jasso León', 'natapa2815@hotmail.com', 1, '1978-04-26', 4, '', '', 'San Nicolás', 'NL', 0, NULL, '', 1),
(202, 'Fernando', 'pass', 'Fernando', 'Portes Zambrano', 'ferpat0713@hotmail.com', 0, '1982-12-06', 3, '', '', 'Guadalupe', 'NL', 0, NULL, '', 1),
(203, 'Karla María', 'pass', 'Karla María', 'Montes Fuentes', 'karlammf0368@hotmail.com', 1, '1989-11-12', 4, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(204, 'Filiberto', 'pass', 'Filiberto', 'Zazueta Cordoba', 'filizazc7890@hotmail.com', 0, '1996-10-19', 3, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(205, 'Vilma', 'pass', 'Vilma', 'López Rodríguez', 'vilma9042@hotmail.com', 1, '1993-09-26', 1, '', '', 'García', 'NL', 0, NULL, '', 1),
(206, 'Luis Manuel', 'pass', 'Luis Manuel', 'Martínez Sánchez', 'luismanuel_90_80@hotmail.com', 0, '1970-09-02', 0, '', '', 'San Nicolás', 'NL', 0, NULL, '', 1),
(207, 'Natalia Paulina', 'pass', 'Natalia Paulina', 'Jasso León', 'natapa2815@hotmail.com', 1, '1997-08-09', 4, '', '', 'Apodaca', 'NL', 0, NULL, '', 1),
(208, 'Pedro Ignacio', 'pass', 'Pedro Ignacio', 'Ríos Garay', 'pedrorios0580@hotmail.com', 0, '1974-07-16', 2, '', '', 'San Pedro', 'NL', 0, NULL, '', 1),
(209, 'Ana Lourdes', 'pass', 'Ana Lourdes', 'Valenzuela López', 'anilu_248090@hotmail.com', 1, '1951-06-22', 4, '', '', 'Guadalupe', 'NL', 0, NULL, '', 1),
(210, 'Carlos', 'pass', 'Carlos', 'Mayo Rodriguez', 'carlosmay@hotmail.com', 0, '1988-05-28', 3, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(211, 'Ricardo', 'pass', 'Ricardo', 'Duarte Fontes', 'rickyduarte5687@hotmail.com', 0, '1985-05-04', 1, '', '', 'Apodaca', 'NL', 0, NULL, '', 1),
(212, 'José Miguel', 'pass', 'José Miguel', 'Zazueta Cordoba', 'josemzc8116@hotmail.com', 0, '1974-07-16', 5, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(213, 'María del Carmen', 'pass', 'María del Carmen', 'Valenzuela Beltrán', 'macarmen_1224@hotmail.com', 1, '1963-09-27', 0, '', '', 'San Nicolás', 'NL', 0, NULL, '', 1),
(214, 'Julio', 'pass', 'Julio', 'Carranza Arriaga', 'juliocarranza_9080@hotmail.com', 0, '1952-12-08', 3, '', '', 'Santa Catarina', 'NL', 0, NULL, '', 1),
(215, 'Ana Lourdes', 'pass', 'Ana Lourdes', 'Valenzuela López', 'anilu_248090@hotmail.com', 1, '1992-02-19', 4, '', '', 'Guadalupe', 'NL', 0, NULL, '', 1),
(216, 'Vilma', 'pass', 'Vilma', 'López Rodríguez', 'vilma9042@hotmail.com', 1, '1961-05-03', 3, '', '', 'García', 'NL', 0, NULL, '', 1),
(217, 'Karmina', 'pass', 'Karmina', 'Martínez González', 'karminamtz9789@hotmail.com', 1, '1970-07-14', 2, '', '', 'Escobedo', 'NL', 0, NULL, '', 1),
(218, 'Enrique', 'pass', 'Enrique', 'Martínez Lagos', 'enrmarl9035@hotmail.com', 0, '1998-09-25', 3, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(219, 'Vilma', 'pass', 'Vilma', 'López Rodríguez', 'vilma9042@hotmail.com', 1, '1985-05-04', 1, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(220, 'Luis Manuel', 'pass', 'Luis Manuel', 'Martínez Sánchez', 'luismanuel_90_80@hotmail.com', 0, '1971-12-12', 4, '', '', 'San Nicolás', 'NL', 0, NULL, '', 1),
(221, 'Natalia Paulina', 'pass', 'Natalia Paulina', 'Jasso León', 'natapa2815@hotmail.com', 1, '1958-07-21', 4, '', '', 'Guadalupe', 'NL', 0, NULL, '', 1),
(222, 'Pedro Ignacio', 'pass', 'Pedro Ignacio', 'Ríos Garay', 'pedrorios0580@hotmail.com', 0, '1945-02-27', 2, '', '', 'Santa Catarina', 'NL', 0, NULL, '', 1),
(223, 'Ana Lourdes', 'pass', 'Ana Lourdes', 'Valenzuela López', 'anilu_248090@hotmail.com', 1, '1981-10-07', 4, '', '', 'Guadalupe', 'NL', 0, NULL, '', 1),
(224, 'Carlos', 'pass', 'Carlos', 'Mayo Rodriguez', 'carlosmay@hotmail.com', 0, '1988-05-16', 4, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(225, 'Elizabeth', 'pass', 'Elizabeth', 'Verdugo Mayo', 'elizabethvm809824@hotmail.com', 1, '1994-12-23', 2, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(226, 'Fernando', 'pass', 'Fernando', 'Portes Zambrano', 'ferpat0713@hotmail.com', 0, '1991-07-31', 4, '', '', 'Escobedo', 'NL', 0, NULL, '', 1),
(227, 'Filiberto', 'pass', 'Filiberto', 'Zazueta Cordoba', 'filizazc7890@hotmail.com', 0, '1988-03-08', 1, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(228, 'María del Carmen', 'pass', 'María del Carmen', 'Valenzuela Beltrán', 'macarmen_1224@hotmail.com', 1, '1984-10-15', 0, '', '', 'San Nicolás', 'NL', 0, NULL, '', 1),
(229, 'Julio', 'pass', 'Julio', 'Carranza Arriaga', 'juliocarranza_9080@hotmail.com', 0, '1971-05-23', 2, '', '', 'Santa Catarina', 'NL', 0, NULL, '', 1),
(230, 'Vilma', 'pass', 'Vilma', 'López Rodríguez', 'vilma9042@hotmail.com', 1, '1977-12-30', 2, '', '', 'García', 'NL', 0, NULL, '', 1),
(231, 'Roberto', 'pass', 'Roberto', 'Loaiza Maytorena', 'robertoloaiza1292@hotmail.com', 0, '1984-08-07', 4, '', '', 'Escobedo', 'NL', 0, NULL, '', 1),
(232, 'Natalia Paulina', 'pass', 'Natalia Paulina', 'Jasso León', 'natapa2815@hotmail.com', 1, '1981-03-15', 4, '', '', 'San Pedro', 'NL', 0, NULL, '', 1),
(233, 'Alejandra', 'pass', 'Alejandra', 'Sandoval Ramirez', 'alesanra23@hotmail.com', 1, '1947-10-22', 1, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(234, 'Daniel', 'pass', 'Daniel', 'Duarte Muñoz', 'daniduarte_898048@hotmail.com', 0, '1954-05-30', 2, '', '', 'Juárez', 'NL', 0, NULL, '', 1),
(235, 'Fernando', 'pass', 'Fernando', 'Portes Zambrano', 'ferpat0713@hotmail.com', 0, '1966-12-29', 4, '', '', 'Guadalupe', 'NL', 0, NULL, '', 1),
(236, 'Ulises', 'pass', 'Ulises', 'Montemayor Montes', 'ulisesmmm9080@hotmail.com', 0, '1985-07-27', 2, '', '', 'Juárez', 'NL', 0, NULL, '', 1),
(237, 'Ricardo', 'pass', 'Ricardo', 'Duarte Fontes', 'rickyduarte5687@hotmail.com', 0, '1993-02-23', 1, '', '', 'Apodaca', 'NL', 0, NULL, '', 1),
(238, 'María del Carmen', 'pass', 'María del Carmen', 'Valenzuela Beltrán', 'macarmen_1224@hotmail.com', 1, '1992-09-21', 0, '', '', 'Santa Catarina', 'NL', 0, NULL, '', 1),
(239, 'Julio', 'pass', 'Julio', 'Carranza Arriaga', 'juliocarranza_9080@hotmail.com', 0, '1941-04-19', 2, '', '', 'Santa Catarina', 'NL', 0, NULL, '', 1),
(240, 'Pedro Ignacio', 'pass', 'Pedro Ignacio', 'Ríos Garay', 'pedrorios0580@hotmail.com', 0, '1959-11-16', 5, '', '', 'Apodaca', 'NL', 0, NULL, '', 1),
(241, 'Ana Lourdes', 'pass', 'Ana Lourdes', 'Valenzuela López', 'anilu_248090@hotmail.com', 1, '1978-06-14', 4, '', '', 'Guadalupe', 'NL', 0, NULL, '', 1),
(242, 'Roberto', 'pass', 'Roberto', 'Loaiza Maytorena', 'robertoloaiza1292@hotmail.com', 0, '1997-01-10', 4, '', '', 'Escobedo', 'NL', 0, NULL, '', 1),
(243, 'Luis Manuel', 'pass', 'Luis Manuel', 'Martínez Sánchez', 'luismanuel_90_80@hotmail.com', 0, '1955-08-10', 3, '', '', 'San Nicolás', 'NL', 0, NULL, '', 1),
(244, 'Natalia Paulina', 'pass', 'Natalia Paulina', 'Jasso León', 'natapa2815@hotmail.com', 1, '1964-03-08', 3, '', '', 'San Pedro', 'NL', 0, NULL, '', 1),
(245, 'Ulises', 'pass', 'Ulises', 'Montemayor Montes', 'ulisesmmm9080@hotmail.com', 0, '1952-10-04', 2, '', '', 'Juárez', 'NL', 0, NULL, '', 1),
(246, 'Julio', 'pass', 'Julio', 'Carranza Arriaga', 'juliocarranza_9080@hotmail.com', 0, '1971-05-03', 2, '', '', 'Santa Catarina', 'NL', 0, NULL, '', 1),
(247, 'María', 'pass', 'María', 'Zazueta López', 'mariazaz802@hotmail.com', 1, '1996-08-14', 3, '', '', 'Guadalupe', 'NL', 0, NULL, '', 1),
(248, 'Enrique', 'pass', 'Enrique', 'Martínez Lagos', 'enrmarl9035@hotmail.com', 0, '1980-10-07', 3, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(249, 'Luis Manuel', 'pass', 'Luis Manuel', 'Martínez Sánchez', 'luismanuel_90_80@hotmail.com', 0, '1964-11-30', 2, '', '', 'San Nicolás', 'NL', 0, NULL, '', 1),
(250, 'Elizabeth', 'pass', 'Elizabeth', 'Verdugo Mayo', 'elizabethvm809824@hotmail.com', 1, '1949-01-23', 4, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(251, 'Enrique', 'pass', 'Enrique', 'Martínez Lagos', 'enrmarl9035@hotmail.com', 0, '1993-03-18', 3, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(252, 'Natalia Paulina', 'pass', 'Natalia Paulina', 'Jasso León', 'natapa2815@hotmail.com', 1, '1997-05-11', 4, '', '', 'Guadalupe', 'NL', 0, NULL, '', 1),
(253, 'Julio', 'pass', 'Julio', 'Carranza Arriaga', 'juliocarranza_9080@hotmail.com', 0, '1981-07-04', 2, '', '', 'Santa Catarina', 'NL', 0, NULL, '', 1),
(254, 'Pedro Ignacio', 'pass', 'Pedro Ignacio', 'Ríos Garay', 'pedrorios0580@hotmail.com', 0, '1980-10-07', 5, '', '', 'Escobedo', 'NL', 0, NULL, '', 1),
(255, 'Carlos', 'pass', 'Carlos', 'Mayo Rodriguez', 'carlosmay@hotmail.com', 0, '1996-08-14', 4, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(256, 'Fernando', 'pass', 'Fernando', 'Portes Zambrano', 'ferpat0713@hotmail.com', 0, '1982-06-21', 4, '', '', 'Apodaca', 'NL', 0, NULL, '', 1),
(257, 'Pedro Ignacio', 'pass', 'Pedro Ignacio', 'Ríos Garay', 'pedrorios0580@hotmail.com', 0, '1998-04-28', 5, '', '', 'Guadalupe', 'NL', 0, NULL, '', 1),
(258, 'Ana Lourdes', 'pass', 'Ana Lourdes', 'Valenzuela López', 'anilu_248090@hotmail.com', 1, '1944-03-05', 4, '', '', 'Guadalupe', 'NL', 0, NULL, '', 1),
(259, 'Carlos', 'pass', 'Carlos', 'Mayo Rodriguez', 'carlosmay@hotmail.com', 0, '1960-01-11', 2, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(260, 'Ricardo', 'pass', 'Ricardo', 'Duarte Fontes', 'rickyduarte5687@hotmail.com', 0, '1975-11-18', 1, '', '', 'Apodaca', 'NL', 0, NULL, '', 1),
(261, 'José Miguel', 'pass', 'José Miguel', 'Zazueta Cordoba', 'josemzc8116@hotmail.com', 0, '1991-09-25', 5, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(262, 'María del Carmen', 'pass', 'María del Carmen', 'Valenzuela Beltrán', 'macarmen_1224@hotmail.com', 1, '1987-08-02', 0, '', '', 'San Nicolás', 'NL', 0, NULL, '', 1),
(263, 'Julio', 'pass', 'Julio', 'Carranza Arriaga', 'juliocarranza_9080@hotmail.com', 0, '1993-06-09', 0, '', '', 'Santa Catarina', 'NL', 0, NULL, '', 1),
(264, 'Ana Lourdes', 'pass', 'Ana Lourdes', 'Valenzuela López', 'anilu_248090@hotmail.com', 1, '1979-04-16', 4, '', '', 'Guadalupe', 'NL', 0, NULL, '', 1),
(265, 'Vilma', 'pass', 'Vilma', 'López Rodríguez', 'vilma9042@hotmail.com', 1, '1955-02-21', 4, '', '', 'García', 'NL', 0, NULL, '', 1),
(266, 'Karmina', 'pass', 'Karmina', 'Martínez González', 'karminamtz9789@hotmail.com', 1, '1970-12-29', 2, '', '', 'Escobedo', 'NL', 0, NULL, '', 1),
(267, 'Enrique', 'pass', 'Enrique', 'Martínez Lagos', 'enrmarl9035@hotmail.com', 0, '1986-11-05', 3, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(268, 'Vilma', 'pass', 'Vilma', 'López Rodríguez', 'vilma9042@hotmail.com', 1, '1985-04-24', 2, '', '', 'García', 'NL', 0, NULL, '', 1),
(269, 'Luis Manuel', 'pass', 'Luis Manuel', 'Martínez Sánchez', 'luismanuel_90_80@hotmail.com', 0, '1983-01-30', 2, '', '', 'San Nicolás', 'NL', 0, NULL, '', 1),
(270, 'Natalia Paulina', 'pass', 'Natalia Paulina', 'Jasso León', 'natapa2815@hotmail.com', 1, '1980-11-06', 4, '', '', 'San Pedro', 'NL', 0, NULL, '', 1),
(271, 'Pedro Ignacio', 'pass', 'Pedro Ignacio', 'Ríos Garay', 'pedrorios0580@hotmail.com', 0, '1978-08-14', 2, '', '', 'Apodaca', 'NL', 0, NULL, '', 1),
(272, 'Ana Lourdes', 'pass', 'Ana Lourdes', 'Valenzuela López', 'anilu_248090@hotmail.com', 1, '1976-05-21', 4, '', '', 'Guadalupe', 'NL', 0, NULL, '', 1),
(273, 'Carlos', 'pass', 'Carlos', 'Mayo Rodriguez', 'carlosmay@hotmail.com', 0, '1974-02-26', 4, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(274, 'Elizabeth', 'pass', 'Elizabeth', 'Verdugo Mayo', 'elizabethvm809824@hotmail.com', 1, '1971-12-04', 0, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(275, 'Fernando', 'pass', 'Fernando', 'Portes Zambrano', 'ferpat0713@hotmail.com', 0, '1969-09-10', 4, '', '', 'San Pedro', 'NL', 0, NULL, '', 1),
(276, 'Natalia Paulina', 'pass', 'Natalia Paulina', 'Jasso León', 'natapa2815@hotmail.com', 1, '1967-06-18', 4, '', '', 'Santa Catarina', 'NL', 0, NULL, '', 1),
(277, 'Fernando', 'pass', 'Fernando', 'Portes Zambrano', 'ferpat0713@hotmail.com', 0, '1965-03-25', 4, '', '', 'San Pedro', 'NL', 0, NULL, '', 1),
(278, 'Karla María', 'pass', 'Karla María', 'Montes Fuentes', 'karlammf0368@hotmail.com', 1, '1962-12-31', 4, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(279, 'Filiberto', 'pass', 'Filiberto', 'Zazueta Cordoba', 'filizazc7890@hotmail.com', 0, '1960-10-07', 5, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(280, 'María del Carmen', 'pass', 'María del Carmen', 'Valenzuela Beltrán', 'macarmen_1224@hotmail.com', 1, '1958-07-15', 0, '', '', 'San Nicolás', 'NL', 0, NULL, '', 1),
(281, 'Julio', 'pass', 'Julio', 'Carranza Arriaga', 'juliocarranza_9080@hotmail.com', 0, '1956-04-21', 1, '', '', 'Santa Catarina', 'NL', 0, NULL, '', 1),
(282, 'Alejandra', 'pass', 'Alejandra', 'Sandoval Ramirez', 'alesanra23@hotmail.com', 1, '1954-01-27', 4, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(283, 'Alma Alexia', 'pass', 'Alma Alexia', 'Muñoz Montes', 'almaa9090@hotmail.com', 1, '1951-11-04', 4, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(284, 'Luis Manuel', 'pass', 'Luis Manuel', 'Martínez Sánchez', 'luismanuel_90_80@hotmail.com', 0, '1949-08-11', 2, '', '', 'San Nicolás', 'NL', 0, NULL, '', 1),
(285, 'Elizabeth', 'pass', 'Elizabeth', 'Verdugo Mayo', 'elizabethvm809824@hotmail.com', 1, '1947-05-19', 2, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(286, 'Natalia Paulina', 'pass', 'Natalia Paulina', 'Jasso León', 'natapa2815@hotmail.com', 1, '1945-02-23', 4, '', '', 'Apodaca', 'NL', 0, NULL, '', 1),
(287, 'Pedro Ignacio', 'pass', 'Pedro Ignacio', 'Ríos Garay', 'pedrorios0580@hotmail.com', 0, '1992-12-01', 5, '', '', 'Apodaca', 'NL', 0, NULL, '', 1),
(288, 'Ana Lourdes', 'pass', 'Ana Lourdes', 'Valenzuela López', 'anilu_248090@hotmail.com', 1, '1990-09-07', 4, '', '', 'Guadalupe', 'NL', 0, NULL, '', 1),
(289, 'Carlos', 'pass', 'Carlos', 'Mayo Rodriguez', 'carlosmay@hotmail.com', 0, '1960-03-10', 4, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(290, 'Vilma', 'pass', 'Vilma', 'López Rodríguez', 'vilma9042@hotmail.com', 1, '1957-08-26', 3, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(291, 'Karmina', 'pass', 'Karmina', 'Martínez González', 'karminamtz9789@hotmail.com', 1, '1955-02-11', 2, '', '', 'Escobedo', 'NL', 0, NULL, '', 1),
(292, 'Enrique', 'pass', 'Enrique', 'Martínez Lagos', 'enrmarl9035@hotmail.com', 0, '1952-07-29', 3, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(293, 'Julio', 'pass', 'Julio', 'Carranza Arriaga', 'juliocarranza_9080@hotmail.com', 0, '1950-01-14', 2, '', '', 'Santa Catarina', 'NL', 0, NULL, '', 1),
(294, 'Ana Lourdes', 'pass', 'Ana Lourdes', 'Valenzuela López', 'anilu_248090@hotmail.com', 1, '1947-07-02', 4, '', '', 'Guadalupe', 'NL', 0, NULL, '', 1),
(295, 'Vilma', 'pass', 'Vilma', 'López Rodríguez', 'vilma9042@hotmail.com', 1, '1984-12-17', 4, '', '', 'García', 'NL', 0, NULL, '', 1),
(296, 'Roberto', 'pass', 'Roberto', 'Loaiza Maytorena', 'robertoloaiza1292@hotmail.com', 0, '1992-06-04', 4, '', '', 'Escobedo', 'NL', 0, NULL, '', 1),
(297, 'Natalia Paulina', 'pass', 'Natalia Paulina', 'Jasso León', 'natapa2815@hotmail.com', 1, '1989-11-20', 3, '', '', 'San Pedro', 'NL', 0, NULL, '', 1),
(298, 'Pedro Ignacio', 'pass', 'Pedro Ignacio', 'Ríos Garay', 'pedrorios0580@hotmail.com', 0, '1997-05-07', 2, '', '', 'San Pedro', 'NL', 0, NULL, '', 1),
(299, 'Ana Lourdes', 'pass', 'Ana Lourdes', 'Valenzuela López', 'anilu_248090@hotmail.com', 1, '1994-10-23', 4, '', '', 'Guadalupe', 'NL', 0, NULL, '', 1),
(300, 'Carlos', 'pass', 'Carlos', 'Mayo Rodriguez', 'carlosmay@hotmail.com', 0, '1980-04-21', 1, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(301, 'Julio', 'pass', 'Julio', 'Carranza Arriaga', 'juliocarranza_9080@hotmail.com', 0, '1979-04-13', 1, '', '', 'Santa Catarina', 'NL', 0, NULL, '', 1),
(302, 'Ana Lourdes', 'pass', 'Ana Lourdes', 'Valenzuela López', 'anilu_248090@hotmail.com', 1, '1978-04-04', 4, '', '', 'Guadalupe', 'NL', 0, NULL, '', 1),
(303, 'Vilma', 'pass', 'Vilma', 'López Rodríguez', 'vilma9042@hotmail.com', 1, '1976-03-17', 2, '', '', 'García', 'NL', 0, NULL, '', 1),
(304, 'Roberto', 'pass', 'Roberto', 'Loaiza Maytorena', 'robertoloaiza1292@hotmail.com', 0, '1975-03-09', 3, '', '', 'Escobedo', 'NL', 0, NULL, '', 1),
(305, 'Fernando', 'pass', 'Fernando', 'Portes Zambrano', 'ferpat0713@hotmail.com', 0, '1974-02-28', 4, '', '', 'Apodaca', 'NL', 0, NULL, '', 1),
(306, 'Mario', 'pass', 'Mario', 'Casas Gutiérrez', 'mariocasas80901@hotmail.com', 0, '1973-02-19', 2, '', '', 'García', 'NL', 0, NULL, '', 1),
(307, 'Julio', 'pass', 'Julio', 'Carranza Arriaga', 'juliocarranza_9080@hotmail.com', 0, '1972-02-11', 2, '', '', 'Santa Catarina', 'NL', 0, NULL, '', 1),
(308, 'Natalia Paulina', 'pass', 'Natalia Paulina', 'Jasso León', 'natapa2815@hotmail.com', 1, '1971-02-02', 4, '', '', 'Escobedo', 'NL', 0, NULL, '', 1),
(309, 'María', 'pass', 'María', 'Zazueta López', 'mariazaz802@hotmail.com', 1, '1970-01-24', 3, '', '', 'Guadalupe', 'NL', 0, NULL, '', 1),
(310, 'Elizabeth', 'pass', 'Elizabeth', 'Verdugo Mayo', 'elizabethvm809824@hotmail.com', 1, '1969-01-15', 2, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(311, 'Carlos Alberto', 'pass', 'Carlos Alberto', 'López Méndez', 'carlosalberto_8080@hotmail.com', 0, '1968-01-07', 2, '', '', 'Juárez', 'NL', 0, NULL, '', 1),
(312, 'Natalia Paulina', 'pass', 'Natalia Paulina', 'Jasso León', 'natapa2815@hotmail.com', 1, '1966-12-29', 4, '', '', 'San Nicolás', 'NL', 0, NULL, '', 1),
(313, 'Fernando', 'pass', 'Fernando', 'Portes Zambrano', 'ferpat0713@hotmail.com', 0, '1985-07-27', 4, '', '', 'San Pedro', 'NL', 0, NULL, '', 1),
(314, 'Jorge', 'pass', 'Jorge', 'Jimenez González', 'jorgejg_5824@hotmail.com', 0, '1983-01-12', 2, '', '', 'Juárez', 'NL', 0, NULL, '', 1),
(315, 'Fernando', 'pass', 'Fernando', 'Portes Zambrano', 'ferpat0713@hotmail.com', 0, '1980-06-29', 4, '', '', 'Escobedo', 'NL', 0, NULL, '', 1),
(316, 'Ulises', 'pass', 'Ulises', 'Montemayor Montes', 'ulisesmmm9080@hotmail.com', 0, '1977-12-15', 2, '', '', 'Juárez', 'NL', 0, NULL, '', 1),
(317, 'Ricardo', 'pass', 'Ricardo', 'Duarte Fontes', 'rickyduarte5687@hotmail.com', 0, '1975-06-02', 1, '', '', 'Apodaca', 'NL', 0, NULL, '', 1),
(318, 'María del Carmen', 'pass', 'María del Carmen', 'Valenzuela Beltrán', 'macarmen_1224@hotmail.com', 1, '1972-11-17', 0, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(319, 'Natalia Paulina', 'pass', 'Natalia Paulina', 'Jasso León', 'natapa2815@hotmail.com', 1, '1970-05-05', 4, '', '', 'Guadalupe', 'NL', 0, NULL, '', 1),
(320, 'Filiberto', 'pass', 'Filiberto', 'Zazueta Cordoba', 'filizazc7890@hotmail.com', 0, '1967-10-21', 5, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(321, 'Ariadna', 'pass', 'Ariadna', 'Corral López', 'ariadnacor8024@hotmail.com', 1, '1965-04-07', 4, '', '', 'Escobedo', 'NL', 0, NULL, '', 1),
(322, 'Pedro Ignacio', 'pass', 'Pedro Ignacio', 'Ríos Garay', 'pedrorios0580@hotmail.com', 0, '1962-09-23', 5, '', '', 'Guadalupe', 'NL', 0, NULL, '', 1),
(323, 'Ana Lourdes', 'pass', 'Ana Lourdes', 'Valenzuela López', 'anilu_248090@hotmail.com', 1, '1960-03-10', 4, '', '', 'Guadalupe', 'NL', 0, NULL, '', 1),
(324, 'Ariadna', 'pass', 'Ariadna', 'Corral López', 'ariadnacor8024@hotmail.com', 1, '1957-08-26', 4, '', '', 'Escobedo', 'NL', 0, NULL, '', 1),
(325, 'Ana Lourdes', 'pass', 'Ana Lourdes', 'Valenzuela López', 'anilu_248090@hotmail.com', 1, '1997-03-11', 4, '', '', 'Guadalupe', 'NL', 0, NULL, '', 1),
(326, 'Roberto', 'pass', 'Roberto', 'Loaiza Maytorena', 'robertoloaiza1292@hotmail.com', 0, '1995-05-10', 4, '', '', 'Escobedo', 'NL', 0, NULL, '', 1),
(327, 'Carlos', 'pass', 'Carlos', 'Mayo Rodriguez', 'carlosmay@hotmail.com', 0, '1998-07-05', 4, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(328, 'Luis Manuel', 'pass', 'Luis Manuel', 'Martínez Sánchez', 'luismanuel_90_80@hotmail.com', 0, '1991-01-01', 2, '', '', 'San Nicolás', 'NL', 0, NULL, '', 1),
(329, 'Fernando', 'pass', 'Fernando', 'Portes Zambrano', 'ferpat0713@hotmail.com', 0, '1992-02-01', 4, '', '', 'Escobedo', 'NL', 0, NULL, '', 1),
(330, 'Carlos', 'pass', 'Carlos', 'Mayo Rodriguez', 'carlosmay@hotmail.com', 0, '1994-03-03', 3, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(331, 'Enrique', 'pass', 'Enrique', 'Martínez Lagos', 'enrmarl9035@hotmail.com', 0, '1998-04-05', 3, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(332, 'Ana Lourdes', 'pass', 'Ana Lourdes', 'Valenzuela López', 'anilu_248090@hotmail.com', 1, '1996-05-02', 4, '', '', 'Guadalupe', 'NL', 0, NULL, '', 1),
(333, 'Fernando', 'pass', 'Fernando', 'Portes Zambrano', 'ferpat0713@hotmail.com', 0, '1996-06-06', 4, '', '', 'San Pedro', 'NL', 0, NULL, '', 1),
(334, 'Natalia Paulina', 'pass', 'Natalia Paulina', 'Jasso León', 'natapa2815@hotmail.com', 1, '1982-07-21', 4, '', '', 'San Pedro', 'NL', 0, NULL, '', 1),
(335, 'Ana Lourdes', 'pass', 'Ana Lourdes', 'Valenzuela López', 'anilu_248090@hotmail.com', 1, '1976-08-24', 4, '', '', 'Guadalupe', 'NL', 0, NULL, '', 1);
INSERT INTO `Panelista` (`id`, `username`, `password`, `nombre`, `apellidos`, `email`, `genero`, `fechaNacimiento`, `educacion`, `calleNumero`, `colonia`, `municipio`, `estado`, `cp`, `fechaRegistro`, `deviceToken`, `deviceType`) VALUES
(336, 'Fernando', 'pass', 'Fernando', 'Portes Zambrano', 'ferpat0713@hotmail.com', 0, '1954-09-30', 4, '', '', 'Santa Catarina', 'NL', 0, NULL, '', 1),
(337, 'Fernando', 'pass', 'Fernando', 'Portes Zambrano', 'ferpat0713@hotmail.com', 0, '1959-10-10', 4, '', '', 'García', 'NL', 0, NULL, '', 1),
(338, 'Ariadna', 'pass', 'Ariadna', 'Corral López', 'ariadnacor8024@hotmail.com', 1, '1998-10-05', 3, '', '', 'Escobedo', 'NL', 0, NULL, '', 1),
(339, 'Enrique', 'pass', 'Enrique', 'Martínez Lagos', 'enrmarl9035@hotmail.com', 0, '1987-12-12', 3, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(340, 'Filiberto', 'pass', 'Filiberto', 'Zazueta Cordoba', 'filizazc7890@hotmail.com', 0, '1988-05-04', 0, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(341, 'María', 'pass', 'María', 'Zazueta López', 'mariazaz802@hotmail.com', 1, '1982-12-15', 3, '', '', 'Guadalupe', 'NL', 0, NULL, '', 1),
(342, 'Alma Alexia', 'pass', 'Alma Alexia', 'Muñoz Montes', 'almaa9090@hotmail.com', 1, '1977-07-27', 1, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(343, 'Ulises', 'pass', 'Ulises', 'Montemayor Montes', 'ulisesmmm9080@hotmail.com', 0, '1972-03-08', 2, '', '', 'Juárez', 'NL', 0, NULL, '', 1),
(344, 'Filiberto', 'pass', 'Filiberto', 'Zazueta Cordoba', 'filizazc7890@hotmail.com', 0, '1966-10-19', 5, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(345, 'Natalia Paulina', 'pass', 'Natalia Paulina', 'Jasso León', 'natapa2815@hotmail.com', 1, '1961-05-31', 4, '', '', 'San Pedro', 'NL', 0, NULL, '', 1),
(346, 'María', 'pass', 'María', 'Zazueta López', 'mariazaz802@hotmail.com', 1, '1956-01-11', 3, '', '', 'Guadalupe', 'NL', 0, NULL, '', 1),
(347, 'Elizabeth', 'pass', 'Elizabeth', 'Verdugo Mayo', 'elizabethvm809824@hotmail.com', 1, '1950-08-23', 3, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(348, 'Rodrigo', 'pass', 'Rodrigo', 'Martinez Martinez', 'rodrimtzz7845@hotmail.com', 0, '1995-04-04', 2, '', '', 'Juárez', 'NL', 0, NULL, '', 1),
(349, 'Natalia Paulina', 'pass', 'Natalia Paulina', 'Jasso León', 'natapa2815@hotmail.com', 1, '1989-11-15', 4, '', '', 'Juárez', 'NL', 0, NULL, '', 1),
(350, 'Vilma', 'pass', 'Vilma', 'López Rodríguez', 'vilma9042@hotmail.com', 1, '1984-06-27', 3, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(351, 'Luis Manuel', 'pass', 'Luis Manuel', 'Martínez Sánchez', 'luismanuel_90_80@hotmail.com', 0, '1979-02-07', 3, '', '', 'San Nicolás', 'NL', 0, NULL, '', 1),
(352, 'Natalia Paulina', 'pass', 'Natalia Paulina', 'Jasso León', 'natapa2815@hotmail.com', 1, '1973-09-19', 4, '', '', 'Guadalupe', 'NL', 0, NULL, '', 1),
(353, 'Pedro Ignacio', 'pass', 'Pedro Ignacio', 'Ríos Garay', 'pedrorios0580@hotmail.com', 0, '1968-05-01', 2, '', '', 'San Nicolás', 'NL', 0, NULL, '', 1),
(354, 'Ana Lourdes', 'pass', 'Ana Lourdes', 'Valenzuela López', 'anilu_248090@hotmail.com', 1, '1962-12-12', 4, '', '', 'Guadalupe', 'NL', 0, NULL, '', 1),
(355, 'Carlos', 'pass', 'Carlos', 'Mayo Rodriguez', 'carlosmay@hotmail.com', 0, '1957-07-24', 2, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(356, 'Pedro Ignacio', 'pass', 'Pedro Ignacio', 'Ríos Garay', 'pedrorios0580@hotmail.com', 0, '1952-03-05', 5, '', '', 'Guadalupe', 'NL', 0, NULL, '', 1),
(357, 'Ana Lourdes', 'pass', 'Ana Lourdes', 'Valenzuela López', 'anilu_248090@hotmail.com', 1, '1998-10-16', 4, '', '', 'Guadalupe', 'NL', 0, NULL, '', 1),
(358, 'Carlos', 'pass', 'Carlos', 'Mayo Rodriguez', 'carlosmay@hotmail.com', 0, '1981-05-28', 4, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(359, 'Elizabeth', 'pass', 'Elizabeth', 'Verdugo Mayo', 'elizabethvm809824@hotmail.com', 1, '1986-01-08', 4, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(360, 'Fernando', 'pass', 'Fernando', 'Portes Zambrano', 'ferpat0713@hotmail.com', 0, '1990-08-20', 4, '', '', 'San Pedro', 'NL', 0, NULL, '', 1),
(361, 'Filiberto', 'pass', 'Filiberto', 'Zazueta Cordoba', 'filizazc7890@hotmail.com', 0, '1995-04-01', 5, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(362, 'María del Carmen', 'pass', 'María del Carmen', 'Valenzuela Beltrán', 'macarmen_1224@hotmail.com', 1, '1989-11-12', 0, '', '', 'San Nicolás', 'NL', 0, NULL, '', 1),
(363, 'Natalia Paulina', 'pass', 'Natalia Paulina', 'Jasso León', 'natapa2815@hotmail.com', 1, '1974-06-24', 4, '', '', 'Escobedo', 'NL', 0, NULL, '', 1),
(364, 'Fernando', 'pass', 'Fernando', 'Portes Zambrano', 'ferpat0713@hotmail.com', 0, '1959-02-03', 4, '', '', 'Apodaca', 'NL', 0, NULL, '', 1),
(365, 'Karla María', 'pass', 'Karla María', 'Montes Fuentes', 'karlammf0368@hotmail.com', 1, '1953-09-15', 4, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(366, 'Alma Alexia', 'pass', 'Alma Alexia', 'Muñoz Montes', 'almaa9090@hotmail.com', 1, '1978-04-26', 3, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(367, 'Ariadna', 'pass', 'Ariadna', 'Corral López', 'ariadnacor8024@hotmail.com', 1, '1982-12-06', 4, '', '', 'Escobedo', 'NL', 0, NULL, '', 1),
(368, 'Pedro Ignacio', 'pass', 'Pedro Ignacio', 'Ríos Garay', 'pedrorios0580@hotmail.com', 0, '1989-11-12', 5, '', '', 'Apodaca', 'NL', 0, NULL, '', 1),
(369, 'María', 'pass', 'María', 'Zazueta López', 'mariazaz802@hotmail.com', 1, '1996-10-19', 3, '', '', 'Guadalupe', 'NL', 0, NULL, '', 1),
(370, 'Enrique', 'pass', 'Enrique', 'Martínez Lagos', 'enrmarl9035@hotmail.com', 0, '1993-09-26', 3, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(371, 'Karla María', 'pass', 'Karla María', 'Montes Fuentes', 'karlammf0368@hotmail.com', 1, '1970-09-02', 4, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(372, 'Filiberto', 'pass', 'Filiberto', 'Zazueta Cordoba', 'filizazc7890@hotmail.com', 0, '1997-08-09', 3, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(373, 'María del Carmen', 'pass', 'María del Carmen', 'Valenzuela Beltrán', 'macarmen_1224@hotmail.com', 1, '1974-07-16', 0, '', '', 'San Nicolás', 'NL', 0, NULL, '', 1),
(374, 'Julio', 'pass', 'Julio', 'Carranza Arriaga', 'juliocarranza_9080@hotmail.com', 0, '1951-06-22', 2, '', '', 'Santa Catarina', 'NL', 0, NULL, '', 1),
(375, 'Vilma', 'pass', 'Vilma', 'López Rodríguez', 'vilma9042@hotmail.com', 1, '1988-05-28', 4, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(376, 'Carlos', 'pass', 'Carlos', 'Mayo Rodriguez', 'carlosmay@hotmail.com', 0, '1985-05-04', 4, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(377, 'Alejandra', 'pass', 'Alejandra', 'Sandoval Ramirez', 'alesanra23@hotmail.com', 1, '1974-07-16', 4, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(378, 'Mario', 'pass', 'Mario', 'Casas Gutiérrez', 'mariocasas80901@hotmail.com', 0, '1963-09-27', 2, '', '', 'García', 'NL', 0, NULL, '', 1),
(379, 'Natalia Paulina', 'pass', 'Natalia Paulina', 'Jasso León', 'natapa2815@hotmail.com', 1, '1952-12-08', 4, '', '', 'Apodaca', 'NL', 0, NULL, '', 1),
(380, 'Fernando', 'pass', 'Fernando', 'Portes Zambrano', 'ferpat0713@hotmail.com', 0, '1992-02-19', 4, '', '', 'Escobedo', 'NL', 0, NULL, '', 1),
(381, 'Karla María', 'pass', 'Karla María', 'Montes Fuentes', 'karlammf0368@hotmail.com', 1, '1961-05-03', 4, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(382, 'Filiberto', 'pass', 'Filiberto', 'Zazueta Cordoba', 'filizazc7890@hotmail.com', 0, '1970-07-14', 5, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(383, 'Ricardo', 'pass', 'Ricardo', 'Duarte Fontes', 'rickyduarte5687@hotmail.com', 0, '1998-09-25', 1, '', '', 'Apodaca', 'NL', 0, NULL, '', 1),
(384, 'José Miguel', 'pass', 'José Miguel', 'Zazueta Cordoba', 'josemzc8116@hotmail.com', 0, '1985-05-04', 5, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(385, 'María del Carmen', 'pass', 'María del Carmen', 'Valenzuela Beltrán', 'macarmen_1224@hotmail.com', 1, '1971-12-12', 0, '', '', 'San Nicolás', 'NL', 0, NULL, '', 1),
(386, 'Ariadna', 'pass', 'Ariadna', 'Corral López', 'ariadnacor8024@hotmail.com', 1, '1958-07-21', 4, '', '', 'Escobedo', 'NL', 0, NULL, '', 1),
(387, 'Julio', 'pass', 'Julio', 'Carranza Arriaga', 'juliocarranza_9080@hotmail.com', 0, '1945-02-27', 2, '', '', 'Santa Catarina', 'NL', 0, NULL, '', 1),
(388, 'Ana Lourdes', 'pass', 'Ana Lourdes', 'Valenzuela López', 'anilu_248090@hotmail.com', 1, '1981-10-07', 4, '', '', 'Guadalupe', 'NL', 0, NULL, '', 1),
(389, 'Vilma', 'pass', 'Vilma', 'López Rodríguez', 'vilma9042@hotmail.com', 1, '1988-05-16', 3, '', '', 'García', 'NL', 0, NULL, '', 1),
(390, 'Roberto', 'pass', 'Roberto', 'Loaiza Maytorena', 'robertoloaiza1292@hotmail.com', 0, '1994-12-23', 4, '', '', 'Escobedo', 'NL', 0, NULL, '', 1),
(391, 'Mar', 'pass', 'Mar', 'González González', 'margonzalez_8479@hotmail.com', 1, '1991-07-31', 2, '', '', 'Santa Catarina', 'NL', 0, NULL, '', 1),
(392, 'Luis Manuel', 'pass', 'Luis Manuel', 'Martínez Sánchez', 'luismanuel_90_80@hotmail.com', 0, '1988-03-08', 3, '', '', 'San Nicolás', 'NL', 0, NULL, '', 1),
(393, 'Carlos', 'pass', 'Carlos', 'Mayo Rodriguez', 'carlosmay@hotmail.com', 0, '1984-10-15', 1, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(394, 'Natalia Paulina', 'pass', 'Natalia Paulina', 'Jasso León', 'natapa2815@hotmail.com', 1, '1971-05-23', 4, '', '', 'Guadalupe', 'NL', 0, NULL, '', 1),
(395, 'Ulises', 'pass', 'Ulises', 'Montemayor Montes', 'ulisesmmm9080@hotmail.com', 0, '1977-12-30', 2, '', '', 'Juárez', 'NL', 0, NULL, '', 1),
(396, 'Elizabeth', 'pass', 'Elizabeth', 'Verdugo Mayo', 'elizabethvm809824@hotmail.com', 1, '1984-08-07', 4, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(397, 'Fernando', 'pass', 'Fernando', 'Portes Zambrano', 'ferpat0713@hotmail.com', 0, '1981-03-15', 4, '', '', 'San Pedro', 'NL', 0, NULL, '', 1),
(398, 'Karla María', 'pass', 'Karla María', 'Montes Fuentes', 'karlammf0368@hotmail.com', 1, '1947-10-22', 4, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(399, 'Filiberto', 'pass', 'Filiberto', 'Zazueta Cordoba', 'filizazc7890@hotmail.com', 0, '1954-05-30', 2, '', '', 'Monterrey', 'NL', 0, NULL, '', 1),
(400, 'Fernando', 'pass', 'Fernando', 'Portes Zambrano', 'ferpat0713@hotmail.com', 0, '1966-12-29', 4, '', '', 'San Pedro', 'NL', 0, NULL, '', 1),
(405, 'flyflyerson', 'apple123', 'John', 'Snow', 'flyflyerson@gmail.com', 0, '1996-09-24', 2, '1 flyerson 1', 'test', 'test', 'BCS', 94356, NULL, '', 0),
(406, 'ecristerna', 'pass', 'Eduardo', 'Cristenra', 'ec@c.com', 0, '1994-09-04', 4, 'Calle', 'Colonia', 'Mty', 'NL', 12345, NULL, '', 0),
(408, 'prueba', '', 'Prueba', 'p', 'kjfj@hotmail.com', 0, '1998-01-01', 2, 'jdfnj', 'cjakg', 'monterrey', 'NL', 66546, NULL, '', 0),
(409, 'esilva', '3232', 'Enrique', 'Silva', 'enriquesilva@focuscg.com.mx', 0, '1998-09-28', 4, 'ee dd', 'de', 'dd', 'NL', 66230, NULL, '', 0),
(410, 'juane', 'juane1', 'Juan', 'Saenz', 'saenz@me.com', 0, '1997-09-29', 5, 'luis 15', 'francia', 'monterrey', 'NL', 66230, NULL, 'b36831f9edee1f14120b035eaef45ce3227c204fc88b762aafbcf8d841a50065', 1),
(411, 'carlosz', 'zazueta', 'Carlos', 'Zazueta', 'carlos@hotmail.com', 0, '1992-01-01', 3, 'independencia', 'Centro', 'San Pedro', 'NL', 66230, NULL, '', 0),
(412, 'mariap', 'perez', 'María', 'Pérez', 'perez@hotmail.com', 1, '1994-06-01', 2, 'Aldama', 'Centro', 'Monterrey', 'NL', 66234, NULL, '', 0),
(413, 'mariana2', 'lopez', 'Mariana', 'López', 'lop@hotmail.com', 1, '1985-04-01', 4, 'primavera', 'primavera', 'monterrey', 'NL', 66453, NULL, '', 0),
(414, 'alfonso', 'cabrera', 'Alfonso', 'Cabrera', 'alfonso@hotmail.com', 0, '1980-10-01', 5, 'Rincón', 'Primavera', 'Monterrey', 'NL', 66230, NULL, '', 0),
(415, 'josem', 'mendez', 'José Miguel', 'Mendez', 'osgij@hotmail.com', 0, '1983-05-01', 4, 'Lopez', 'Cumbres', 'Monterrey', 'NL', 66345, NULL, '', 0),
(416, 'fer20', 'navarro', 'Fernanda', 'Navarro', 'kdgj@hotmail.com', 1, '1979-10-01', 3, 'Isaac Garza', 'Centro', 'Monterrey', 'NL', 66200, NULL, '', 0),
(417, 'isabel', 'duarte', 'Isabel', 'Duarte', 'osgnf@hotmail.com', 1, '1968-12-01', 3, 'López Mateos', 'La fama', 'Santa Catarina', 'NL', 66455, NULL, '', 0),
(418, 'daniela7', 'cota', 'Daniela', 'Cota', 'skjdg@hotmail.com', 1, '1981-09-01', 4, 'Bugambilia', 'Fovissste', 'Monterrey', 'NL', 66409, NULL, '', 0),
(419, 'marco12', 'ramos', 'Marco', 'Ramos', 'kdfgj@hotmail.com', 0, '1972-02-01', 4, 'Trebol', 'Bugambilias', 'Monterrey', 'NL', 66409, NULL, '', 0),
(420, 'cari2', 'duarte', 'Caridad', 'Duarte', 'fgheg@hotmail.com', 1, '1980-08-01', 4, 'juarez', 'Centro', 'Monterrey', 'NL', 64589, NULL, '', 0),
(421, 'javier30', 'solano', 'Javier', 'Solano', 'jaskjgs@hotmail.com', 0, '1963-10-01', 3, 'lopez', 'moderna', 'santa catarina', 'NL', 65788, NULL, '', 0),
(422, 'romi20', 'rubio', 'Romina', 'Rubio', 'kjfgjd@hotmail.com', 1, '1970-04-10', 4, 'juarez', 'moderna', 'san pedro', 'NL', 66230, NULL, '', 0),
(423, 'lalo12', 'gomez', 'Eduardo', 'Gómez', 'lasjif@hotmail.com', 0, '1960-06-01', 1, 'libertad', 'centro', 'san pedro', 'NL', 66345, NULL, '', 0),
(424, 'karla1', 'cota', 'Karla', 'Cota', 'kdfgud@hotmail.com', 1, '1983-12-29', 1, 'Independencia', 'los puertos', 'juárez', 'NL', 62364, NULL, '', 0),
(425, 'meche4', 'lara', 'Mercedes', 'Lara', 'fgiujg@hotmail.com', 1, '1966-10-01', 2, 'carranza', 'venustiano carranza', 'monterrey', 'NL', 66238, NULL, '', 0),
(426, 'alan14', 'clark', 'Alan', 'Clark', 'dfg@hotmail.com', 0, '1980-07-17', 4, 'Bogota', 'Moderna', 'Monterrey', 'NL', 67834, NULL, '', 0),
(427, 'roge20', 'monge', 'Rogelio', 'Monge', 'jgflkf@hotmail.com', 0, '1982-06-17', 1, 'Dolores', 'Hidalgo', 'Santa Catarina', 'NL', 66789, NULL, '', 0),
(428, 'rosa', 'romo', 'Rosa', 'Romo', 'hukjfdk@hotmail.com', 1, '1970-04-18', 1, 'Hidalgo', 'Callejas', 'Monterrey', 'NL', 66757, NULL, '', 0),
(429, 'poncho', 'barbosa', 'Alfonso', 'Barbosa', 'fjkkfd@hotmail.com', 0, '1979-04-15', 4, 'Polaris', 'Cumbres', 'Monterrey', 'NL', 66238, NULL, '', 0),
(430, 'hector', 'ugarte', 'Héctor', 'Ugarte', 'uhkl@hotmail.com', 0, '1974-10-29', 2, 'Solar', 'Cumbres', 'Monterrey', 'NL', 66784, NULL, '', 0),
(431, 'danni', 'merlo', 'Daniel', 'Merlo', 'iijfddf@hotmail.com', 0, '1980-09-18', 1, 'Libertad', 'Las fuentes', 'Santa Catarina', 'NL', 67893, NULL, '', 0),
(432, 'meli30', 'lopez', 'Melissa', 'López', 'kijfdo@hotmail.com', 1, '1965-08-15', 1, 'Callejas', 'Centro', 'San Pedro', 'NL', 67893, NULL, '', 0),
(433, 'adri80', 'elizondo', 'Adriana', 'Elizondo', 'fuijfi@hotmail.com', 1, '1984-08-27', 5, 'Cumbres elite', 'Cumbres', 'Monterrey', 'NL', 65789, NULL, '', 0),
(434, 'carmen', 'sanchez', 'Carmen', 'Sánchez', 'iiuokof@hotmail.com', 1, '1958-09-30', 3, 'Diego Rivera', 'Pintores', 'Juárez', 'NL', 66789, NULL, '', 0),
(435, 'miguel3', 'acevedo', 'Miguel', 'Acevedo', 'guelmi80@hotmail.com', 0, '1980-03-01', 3, 'Rumania 503', 'Centro', 'Apodaca', 'NL', 66543, NULL, '', 0),
(436, 'maricela6', 'diaz', 'Maricela', 'Díaz', 'cema54@hotmail.com', 1, '1954-09-02', 5, 'Abasolo', 'Coahuila', 'Villa de Juarez', 'NL', 67895, NULL, '', 0),
(437, 'isabel1', 'salinas', 'Isabel', 'Salinas', 'isa_sali@hotmail.com', 1, '1970-12-01', 2, 'Soldado 300', 'Ejercito Mexicano', 'Monterrey', 'NL', 63459, NULL, '', 0),
(438, 'mario5', 'limon', 'Mario', 'Limon', 'mario_789@hotmail.com', 0, '1965-10-01', 5, 'Juno 214', 'Las Puentes', 'San Nicolás de los Garza', 'NL', 66230, NULL, '', 0),
(439, 'teresa8', 'medina', 'Teresa', 'Medina', 'metere_81@hotmail.com', 1, '1981-07-01', 3, 'Girasoles 1001', 'Las Flores', 'Santa Catarina', 'NL', 61784, NULL, '', 0),
(440, 'cristhian1', 'ledezma', 'Cristhian', 'Ledezma', 'cris_ledez@hotmail.com', 0, '1966-04-01', 4, 'Lirios 2560', 'Las Arboledas', 'Monterrey', 'NL', 78906, NULL, '', 0),
(441, 'mariana3', 'gonzalez', 'Mariana', 'Gonzalez', 'mariana_gzz@hotmail.com', 1, '1973-12-01', 2, 'Parcelas 200', 'Huertos', 'Escobedo', 'NL', 65498, NULL, '', 0),
(442, 'cami5', 'flores', 'Camila', 'Flores', 'kfgijg@hotmail.com', 1, '1983-04-10', 3, 'Constitución', 'Centro', 'Monterrey', 'NL', 65000, NULL, '', 0),
(443, 'ivan9', 'picazo', 'Ivan', 'Picazo', 'ivanzo@hotmail.com', 0, '1994-09-01', 4, 'Oso Polar 501', 'Bosque Encantado', 'Garcia', 'NL', 66000, NULL, '', 0),
(444, 'nat4', 'lara', 'Natalia', 'Lara', 'iimvdds@hotmail.com', 1, '1975-03-28', 5, 'Alicante', 'Primavera', 'Monterrey', 'NL', 66538, NULL, '', 0),
(445, 'emmy', 'diaz', 'Emma', 'Diaz', 'kfoj@hotmail.com', 1, '1983-05-16', 1, 'Lazaro Cardenas', 'Valle', 'San Pedro', 'NL', 66230, NULL, '', 0),
(446, 'pablo', 'castilla', 'Pablo', 'Castilla', 'pablo@hotmail.com', 0, '1980-10-30', 5, 'Tapia', 'Centro', 'Monterrey', 'NL', 66579, NULL, '', 0),
(447, 'dante8', 'ruiz', 'Dante', 'Ruiz', 'dante@hotmail.com', 0, '1990-01-01', 4, 'Peñoles 708', 'Los Pinos', 'Guadalupe', 'NL', 65321, NULL, '', 0),
(448, 'juan8', 'flores', 'Juan', 'Flores', 'dfgig@hotmail.com', 0, '1980-08-21', 4, 'Vía satélite', 'Brisas', 'Monterrey', 'NL', 62346, NULL, '', 0),
(449, 'selene2', 'martinez', 'Selene', 'Martinez', 'selenez@hotmail.com', 1, '1980-05-01', 2, 'Inglaterra 401', 'La Fama', 'Santa Catarina', 'NL', 61765, NULL, '', 0),
(450, 'marcelo', 'garay', 'Marcelo', 'Garay', 'mkgjdo@hotmail.com', 0, '1984-07-04', 2, 'Rincón', 'Juárez', 'Monterrey', 'NL', 62324, NULL, '', 0),
(452, 'lalo', 'sandovsl', 'Eduardo', 'Sabdoval', 'sabdoval@me.com', 0, '1998-09-30', 5, 'seis 4', 'sss', 'monteyyey', 'NL', 55541, NULL, '', 0),
(454, 'esveydi', 'elizabeth', 'Esveydi', 'Verdugo Maytorena', 'esveydi@focuscg.com.mx', 1, '1980-07-27', 4, 'Bahía de Alicante  37', 'Bahía de la primavera ', 'Monterrey', 'NL', 64835, NULL, '3e95a48d7623bafa5551f286935149bf889bd90f604925be06ecd44c03d25c5d', 1),
(455, 'hectorzuno', 'Frutsicrew1', 'Hector', 'Zuno', 'hectorzuno92@gmail.com', 0, '1992-01-03', 4, 'zafiro 1000', 'canterias ', 'monterrey', 'NL', 64989, NULL, 'a8d33d0897ea6d1a2b98e005b038d5edf31bc6489f841040027178d65dfca19c', 1),
(456, 'marcela', 'rios', 'Marcela', 'Rios', 'jdfi@hotmail.com', 1, '1983-07-01', 4, 'Independencia', 'Centro', 'Monterrey', 'NL', 66456, NULL, '', 0),
(457, 'Felipe Flores', 'w2tqzn2f', 'Felipe', 'Flores', 'felipe@comunicacionpolitica.com.mx', 0, '1975-08-30', 5, 'Rosellino 815', 'Contry La Silla', 'Guadalupe', 'NL', 67173, NULL, '', 0),
(458, 'Kevinzapata', 'politicas', 'kevin', 'Zapata Celestino', 'kevinzapata2012@gmail.com', 0, '1990-09-28', 5, 'Gustavo Adolfo Becquer 512', 'Anahuac', 'San Nicolas De Los Garza', 'NL', 66450, NULL, '', 0),
(459, 'anglara', '67176ang', 'Alberto', 'Ang', 'anglara@hotmail.com', 0, '1996-07-16', 4, 'maple 2864', 'Bosques del Contry', 'Guadalupe', 'NL', 67176, NULL, '6ad9314e67373fe738e2f06258b2d32e9b8581d713f68ccc52b49332cd8545cd', 1),
(460, 'prueba2', 'prueba2', 'prueba2', 'prueba2', 'prueba2', 0, '1998-01-01', 3, 'prueba', 'prueba', 'Ensenada', 'BC', 10, '2016-11-05', '', 0);

-- --------------------------------------------------------

--
-- Table structure for table `PanelistaEnPanel`
--

CREATE TABLE IF NOT EXISTS `PanelistaEnPanel` (
  `id` int(11) NOT NULL,
  `Panelista` int(11) NOT NULL,
  `Panel` int(11) NOT NULL,
  `estado` tinyint(4) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=891 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Dumping data for table `PanelistaEnPanel`
--

INSERT INTO `PanelistaEnPanel` (`id`, `Panelista`, `Panel`, `estado`) VALUES
(173, 14, 2, 0),
(174, 399, 2, 0),
(322, 409, 3, 0),
(323, 410, 3, 0),
(324, 411, 3, 0),
(325, 412, 3, 0),
(326, 413, 3, 0),
(327, 414, 3, 0),
(328, 415, 3, 0),
(329, 416, 3, 0),
(330, 417, 3, 0),
(331, 418, 3, 0),
(332, 419, 3, 0),
(333, 420, 3, 0),
(334, 421, 3, 0),
(335, 422, 3, 0),
(336, 423, 3, 0),
(337, 424, 3, 0),
(338, 425, 3, 0),
(339, 426, 3, 0),
(340, 427, 3, 0),
(341, 428, 3, 0),
(342, 429, 3, 0),
(343, 430, 3, 0),
(344, 431, 3, 0),
(345, 432, 3, 0),
(346, 433, 3, 0),
(347, 434, 3, 0),
(348, 435, 3, 0),
(349, 436, 3, 0),
(350, 437, 3, 0),
(351, 438, 3, 0),
(352, 439, 3, 0),
(353, 440, 3, 0),
(354, 441, 3, 0),
(355, 442, 3, 0),
(356, 443, 3, 0),
(357, 444, 3, 0),
(358, 445, 3, 0),
(359, 446, 3, 0),
(360, 447, 3, 0),
(361, 448, 3, 0),
(362, 449, 3, 0),
(363, 450, 3, 0),
(365, 452, 3, 0),
(703, 409, 5, 0),
(704, 410, 5, 0),
(705, 411, 5, 0),
(706, 412, 5, 0),
(707, 413, 5, 0),
(708, 414, 5, 0),
(709, 415, 5, 0),
(710, 416, 5, 0),
(711, 417, 5, 0),
(712, 418, 5, 0),
(713, 419, 5, 0),
(714, 420, 5, 0),
(715, 421, 5, 0),
(716, 422, 5, 0),
(717, 423, 5, 0),
(718, 424, 5, 0),
(719, 425, 5, 0),
(720, 426, 5, 0),
(721, 427, 5, 0),
(722, 428, 5, 0),
(723, 429, 5, 0),
(724, 430, 5, 0),
(725, 431, 5, 0),
(726, 432, 5, 0),
(727, 433, 5, 0),
(728, 434, 5, 0),
(729, 435, 5, 0),
(730, 436, 5, 0),
(731, 437, 5, 0),
(732, 438, 5, 0),
(733, 439, 5, 0),
(734, 440, 5, 0),
(735, 441, 5, 0),
(736, 442, 5, 0),
(737, 443, 5, 0),
(738, 444, 5, 0),
(739, 445, 5, 0),
(740, 446, 5, 0),
(741, 447, 5, 0),
(742, 448, 5, 0),
(743, 449, 5, 0),
(744, 450, 5, 0),
(745, 452, 5, 0),
(746, 454, 5, 0),
(747, 455, 5, 0),
(748, 457, 5, 0),
(749, 458, 5, 0),
(814, 1, 1, 0),
(815, 2, 1, 0),
(816, 3, 1, 0),
(817, 4, 1, 0),
(818, 5, 1, 0),
(819, 6, 1, 0),
(820, 7, 1, 0),
(821, 8, 1, 0),
(822, 9, 1, 0),
(823, 10, 1, 0),
(824, 11, 1, 0),
(825, 12, 1, 0),
(826, 13, 1, 0),
(827, 14, 1, 0),
(828, 36, 1, 0),
(829, 126, 1, 0),
(830, 170, 1, 0),
(831, 260, 1, 0),
(832, 400, 1, 0),
(833, 405, 1, 0),
(834, 406, 1, 0),
(835, 409, 1, 0),
(836, 410, 1, 0),
(837, 411, 1, 0),
(838, 412, 1, 0),
(839, 413, 1, 0),
(840, 414, 1, 0),
(841, 415, 1, 0),
(842, 416, 1, 0),
(843, 417, 1, 0),
(844, 418, 1, 0),
(845, 419, 1, 0),
(846, 420, 1, 0),
(847, 421, 1, 0),
(848, 422, 1, 0),
(849, 423, 1, 0),
(850, 424, 1, 0),
(851, 425, 1, 0),
(852, 426, 1, 0),
(853, 427, 1, 0),
(854, 428, 1, 0),
(855, 429, 1, 0),
(856, 430, 1, 0),
(857, 431, 1, 0),
(858, 432, 1, 0),
(859, 433, 1, 0),
(860, 434, 1, 0),
(861, 435, 1, 0),
(862, 436, 1, 0),
(863, 437, 1, 0),
(864, 438, 1, 0),
(865, 439, 1, 0),
(866, 440, 1, 0),
(867, 441, 1, 0),
(868, 442, 1, 0),
(869, 443, 1, 0),
(870, 444, 1, 0),
(871, 445, 1, 0),
(872, 446, 1, 0),
(873, 447, 1, 0),
(874, 448, 1, 0),
(875, 449, 1, 0),
(876, 450, 1, 0),
(877, 452, 1, 0),
(878, 454, 1, 0),
(879, 455, 1, 0),
(880, 457, 1, 0),
(881, 458, 1, 0),
(888, 406, 6, 0),
(889, 460, 11, 0),
(890, 285, 11, 0);

-- --------------------------------------------------------

--
-- Table structure for table `Pregunta`
--

CREATE TABLE IF NOT EXISTS `Pregunta` (
  `id` int(11) NOT NULL,
  `titulo` text COLLATE utf8_spanish_ci NOT NULL,
  `Encuesta` int(11) NOT NULL,
  `tipo` int(11) NOT NULL,
  `combo` tinyint(1) NOT NULL,
  `numPregunta` int(11) NOT NULL,
  `Pregunta` text COLLATE utf8_spanish_ci NOT NULL,
  `video` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `imagen` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `numOpciones` tinyint(4) NOT NULL,
  `numSubPreguntas` tinyint(4) NOT NULL,
  `opciones` text COLLATE utf8_spanish_ci NOT NULL,
  `subPreguntas` text COLLATE utf8_spanish_ci NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=235 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Dumping data for table `Pregunta`
--

INSERT INTO `Pregunta` (`id`, `titulo`, `Encuesta`, `tipo`, `combo`, `numPregunta`, `Pregunta`, `video`, `imagen`, `numOpciones`, `numSubPreguntas`, `opciones`, `subPreguntas`) VALUES
(101, '', 9, 2, 0, 1, '¿Es la primera vez que visita Pollo Loco?', '', '', 2, 0, 'Sí&No', ''),
(102, '', 9, 3, 0, 2, '¿Que fue lo que ordenó en esta visita?', '', '', 5, 0, 'Combo&Piezas de pollo&Complementos&Postre&Bebida', ''),
(103, '', 9, 2, 0, 3, '¿Qué le pareció la comida de hoy?', '', '', 5, 0, 'Excelente&Buena&Regular&Mala&Pésima&', ''),
(104, '', 9, 2, 0, 4, 'Del 1 al 10, donde 1 es la más baja calificación y 10 la más alta, ¿Cómo califica la calidad del producto que consumió hoy?', '', '', 10, 0, '1&2&3&4&5&6&7&8&9&10', ''),
(105, '', 9, 2, 0, 5, 'Del 1 al 10, donde 1 es la más baja calificación y 10 la más alta, ¿Cómo califica la atención del personal el día de hoy?', '', '', 10, 0, '1&2&3&4&5&6&7&8&9&10', ''),
(106, '', 9, 2, 0, 6, 'Del 1 al 10, donde 1 es la más baja calificación y 10 la más alta, ¿Cómo califica las instalaciones, limpieza, orden, temperatura, etc?', '', '', 10, 0, '1&2&3&4&5&6&7&8&9&10', ''),
(107, '', 9, 1, 0, 7, '¿Qué fue lo que más le gusto de su visita el día de hoy?', '', '', 0, 0, '', ''),
(108, '', 9, 1, 0, 8, '¿Qué mejoraría en Pollo loco?', '', '', 0, 0, '', ''),
(109, '', 9, 2, 0, 9, '¿Volvería a comprar en Pollo Loco?', '', '', 2, 0, 'Sí&No', ''),
(110, '', 9, 1, 0, 10, '¿Qué le gustaría que hubiera o que cambiaría en Pollo Loco?', '', '', 0, 0, '', ''),
(111, '', 9, 2, 0, 11, 'Ahora le pedimos que vea este video y nos diga si le gusto.', 'PolloLoco.mp4', '', 2, 0, 'Sí&No', ''),
(112, '', 9, 2, 0, 12, '¿Le pareció creíble?', '', '', 2, 0, 'Sí&No', ''),
(113, '', 9, 1, 0, 13, '¿Qué le cambiaría?', '', '', 0, 0, '', ''),
(114, '', 9, 2, 0, 14, 'Por último, ¿recomendaría Pollo Loco a algun familiar o amigo?', '', '', 2, 0, 'Sí&No', ''),
(115, '', 1, 1, 0, 1, '¿Qué cosas ha escuchado recientemente de Margarita Zavala?', '', '', 0, 0, '', ''),
(116, '', 1, 2, 0, 2, '¿Su opinión sobre Margarita Zavala es?', '', '', 3, 0, 'Positiva&Neutra&Negativa', ''),
(117, '', 1, 2, 0, 3, '¿Conoce la asociación que promueve Margarita Zavala?', '', '', 2, 0, 'Sí&No', ''),
(118, '', 1, 2, 0, 4, '¿Sabe usted qué promueve dicha asociación?', '', '', 2, 0, 'Sí&No', ''),
(119, 'Título', 1, 2, 0, 5, 'Después de ver el video, su opinión sobre MZ...', 'MZ.mp4', '', 3, 0, 'Mejoró&Empeoró&Sigue igual', ''),
(120, '', 1, 2, 0, 6, '¿Cree usted que tiene posibilidades para ser Presidenta de México?', '', '', 4, 0, 'Sí&No&Aún es muy pronto para dar una opinión&Tal vez', ''),
(121, '', 10, 2, 0, 1, 'gfdgfdgfdfdgf', '', '', 0, 0, '', ''),
(122, '', 10, 3, 0, 2, '', '', '', 0, 0, '', ''),
(139, 'PRUEBA CAMBIOS12345', 11, 2, 0, 1, 'PRUEBA CAMBIOS1234', '', '', 17, 0, 'OP1121212&OP2&OP2&OP2&OP2&OP2&OP2&OP2&OP2&OP2&OP2&OP2&OP2&OP2&OP2&OP2&OP2', ''),
(221, 'TITULO', 7, 2, 0, 1, 'El primer año del “El Bronco”, ¿cumplió con sus expectativas? ', '', '', 4, 0, 'Sí las cumplió&Las superó&Estuvo por debajo&No sé', ''),
(222, 'TITULO 2', 7, 3, 0, 2, '¿Cómo califica el primer año de gobierno de Jaime Rodríguez?', '', '', 20, 0, '1&2&3&4&5&6&7&8&9&10&1&2&3&4&5&6&7&8&9&10', ''),
(223, '', 7, 1, 0, 3, 'Diga en una palabra ¿cómo califica su gobierno? ', '', '', 0, 0, '', ''),
(224, '', 7, 2, 1, 4, '¿Qué opina de las propuestas del gobernador, como la invitación a los ciudadanos a tapar baches en las calles de sus colonias?', '', '', 3, 0, 'No me agradan, y no participaría.&Sí me agradan, y sí participaría.&Me es indiferente.', ''),
(225, '', 7, 3, 0, 5, '¿Elija algunos temas en el que considera que el gobernador ha realizado un mal trabajo?', '', '', 10, 0, 'Seguridad&Inversión en obra pública&Acciones en contra del ex gobernador Rodrigo Medina.&Restructura de la deuda de NL y en el gobierno en general.&Nuevos programas de apoyo a la comunidad.&Reducción gradual del pago de la Tenencia.&Transparencia.&Rendición de Cuentas.&Combate a la corrupción.&No sé', ''),
(226, '', 7, 2, 0, 6, '¿Elija un tema en el que considera que el gobernador ha hecho un buen trabajo?', '', '', 10, 0, 'Seguridad&Inversión en obra pública&Acciones en contra del ex gobernador Rodrigo Medina.&Restructura de la deuda de NL y en el gobierno en general.&Nuevos programas de apoyo a la comunidad.&Reducción gradual del pago de la Tenencia.&Transparencia.&Rendición de Cuentas.&Combate a la corrupción.&No sé', ''),
(227, '', 7, 2, 0, 7, '¿Percibe una mejoría al tener un gobierno independiente en Nuevo León?', '', '', 4, 0, 'Sí&No&Igual&No sé', ''),
(228, '', 7, 3, 0, 8, '¿En qué rubros considera que “El Bronco” tiene retos para su siguiente año de gobierno?', '', '', 9, 0, 'Seguridad&Inversión en obra pública &Concluir la Línea 3 del Metro&Combate a la Corrupción&Definir si se realizará la obra del Monterrey VI&Transparencia&Rendición de Cuentas&Impulso en la generación de empleo&No sé', ''),
(229, '', 7, 1, 0, 9, 'En una palabra, ¿cómo define el primer año de gobierno de “El Bronco”?', '', '', 0, 0, '', ''),
(230, '', 7, 2, 0, 10, '¿Qué expectativas tiene del primer “informe de gobierno”, sobre algún anuncio para los ciudadanos?', '', '', 4, 0, 'Positivo.&Negativo.&Sin afectar a los ciudadanos.&No sé.', ''),
(231, '', 7, 2, 1, 11, 'Si las elecciones para Gobernador fueran hoy, votaría nuevamente por Jaime Rodríguez', '', '', 3, 0, 'Sí&No&No sé', ''),
(232, '', 7, 6, 0, 12, 'PREGUNTA ESCALA', '', '', 2, 0, '1&10', ''),
(233, '', 7, 6, 0, 13, 'PREGUNTA ESCALA 2', '', '', 2, 0, '1&100', ''),
(234, 'TITULO MATRIZ', 7, 5, 0, 14, 'PREGUNTA MATRIZ', '', '', 3, 5, 'Op1&Op2&Op3', 'sub1&sub2&sub3&sub4&sub5');

-- --------------------------------------------------------

--
-- Table structure for table `Recurso`
--

CREATE TABLE IF NOT EXISTS `Recurso` (
  `id` int(11) NOT NULL,
  `nombre` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `tipo` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Respuesta`
--

CREATE TABLE IF NOT EXISTS `Respuesta` (
  `id` int(11) NOT NULL,
  `Encuesta` int(11) NOT NULL,
  `Panelista` int(11) NOT NULL,
  `respuestas` longtext COLLATE utf8_spanish_ci NOT NULL,
  `fechaIni` date DEFAULT NULL,
  `horaIni` time DEFAULT NULL,
  `fechaFin` date DEFAULT NULL,
  `horaFin` time DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=82 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Dumping data for table `Respuesta`
--

INSERT INTO `Respuesta` (`id`, `Encuesta`, `Panelista`, `respuestas`, `fechaIni`, `horaIni`, `fechaFin`, `horaFin`) VALUES
(10, 1, 1, 'shido|Positiva&|Sí|Sí|Sigue igual|Tal vez|', NULL, NULL, '0000-00-00', NULL),
(11, 1, 2, 'no me quejo|Neutra&|No|Sí|Empeoró|Aún es muy pronto para dar una opinión|', NULL, NULL, '2016-09-15', NULL),
(12, 1, 6, 'Respuesta|Positiva&Negativa&Neutra&|Sí|No|Empeoró|Aún es muy pronto para dar una opinión|', NULL, NULL, '2016-09-15', NULL),
(13, 1, 3, 'nada|Muy Mala&|No|No|Mejoró|Sí|', NULL, NULL, '2016-09-15', NULL),
(14, 1, 7, 'Qwerty|Positiva&Muy Buena&|Sí|Sí|Mejoró|Tal vez|', NULL, NULL, '2016-09-15', NULL),
(15, 1, 4, 'no me parce|Muy Buena&|Sí|No|Sigue igual|No|', NULL, NULL, '2016-09-15', NULL),
(16, 1, 8, 'Pop outer|Positiva&Negativa&Neutra&Muy Mala&Muy Buena&|No|No|Sigue igual|No|', NULL, NULL, '2016-09-15', NULL),
(17, 1, 9, 'Más,más fuerte|Muy Buena&|No|Sí|Empeoró|Tal vez|', NULL, NULL, '2016-09-15', NULL),
(18, 1, 5, 'betoooo|Muy Mala&|No|No|Sigue igual|Tal vez|', NULL, NULL, '2016-09-15', NULL),
(19, 1, 10, 'Cobb |Neutra&Muy Mala&Muy Buena&|Sí|No|Mejoró|Aún es muy pronto para dar una opinión|', NULL, NULL, '2016-09-15', NULL),
(60, 1, 410, 'Gghgjghhh|Positiva|Sí|Sí|Empeoró|Sí|', NULL, NULL, '2016-09-30', '16:48:49'),
(61, 7, 410, 'Las superó|2|Abajarse|No me agradan, y no participaría.|Inversión en obra pública&|No sé|Igual|Definir si se realizará la obra del Monterrey VI&|Haga|Negativo.|No sé|7|89|Op1&Op2&Op3&Op1&Op2&', NULL, NULL, '2016-09-30', '16:50:12'),
(62, 9, 411, 'Sí|Combo&|Excelente|7|9|9|Hghgghh|Fgfgggg|Sí|Gggggggg|Sí|Sí|Hhhhhh|Sí|', NULL, NULL, '2016-09-30', '16:54:14'),
(63, 1, 411, 'Dhshshs|Neutra|No|Sí|Empeoró|Sí|', NULL, NULL, '2016-10-03', '09:55:40'),
(65, 1, 454, 'Va para la presidencia |Neutra|Sí|No|Sigue igual|Sí|', NULL, NULL, '2016-10-04', '10:53:26'),
(66, 1, 455, 'Busca la presidencia |Positiva|Sí|No|Sigue igual|Sí|', NULL, NULL, '2016-10-04', '15:32:34'),
(81, 7, 409, 'Las superó|2|Abajarse|No me agradan, y no participaría.|Inversión en obra pública&|No sé|Igual|Definir si se realizará la obra del Monterrey VI&|Haga|Negativo.|Sí|7|89|Op2&Op3&Op1&Op2&Op3&', '2016-12-04', '19:52:06', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `Usuario`
--

CREATE TABLE IF NOT EXISTS `Usuario` (
  `id` int(11) NOT NULL,
  `username` varchar(25) COLLATE utf8_spanish_ci NOT NULL,
  `password` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `nombre` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `apellidos` varchar(100) COLLATE utf8_spanish_ci NOT NULL,
  `email` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `tipo` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Dumping data for table `Usuario`
--

INSERT INTO `Usuario` (`id`, `username`, `password`, `nombre`, `apellidos`, `email`, `tipo`) VALUES
(1, 'admin', 'focuscg', 'Administrador', '', '', 0),
(2, 'mzavala', 'pass', 'Margarita', 'Zavala', 'mzavala@pan.com', 1),
(3, 'jrodriguez', 'focuscg233', 'Jaime ', 'Rodriguez', '', 1),
(4, 'polloloco', 'pollo', 'Pollo Loco', 'Apellidos', 'email', 1),
(5, 'Prueba2', 'Prueba', 'Prueba 2', '', '', 1),
(6, 'nuevo', 'cliente', 'Nuevo', 'Cliente', '', 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Encuesta`
--
ALTER TABLE `Encuesta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Panel` (`Panel`);

--
-- Indexes for table `Historial`
--
ALTER TABLE `Historial`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `Panel`
--
ALTER TABLE `Panel`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cliente` (`cliente`,`creador`),
  ADD KEY `cliente_2` (`cliente`),
  ADD KEY `creador` (`creador`);

--
-- Indexes for table `Panelista`
--
ALTER TABLE `Panelista`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `PanelistaEnPanel`
--
ALTER TABLE `PanelistaEnPanel`
  ADD PRIMARY KEY (`id`,`Panelista`,`Panel`),
  ADD KEY `Panelista` (`Panelista`),
  ADD KEY `Panel` (`Panel`);

--
-- Indexes for table `Pregunta`
--
ALTER TABLE `Pregunta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Encuesta` (`Encuesta`);

--
-- Indexes for table `Recurso`
--
ALTER TABLE `Recurso`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `Respuesta`
--
ALTER TABLE `Respuesta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Encuesta` (`Encuesta`),
  ADD KEY `Panelista` (`Panelista`);

--
-- Indexes for table `Usuario`
--
ALTER TABLE `Usuario`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Encuesta`
--
ALTER TABLE `Encuesta`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=12;
--
-- AUTO_INCREMENT for table `Historial`
--
ALTER TABLE `Historial`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `Panel`
--
ALTER TABLE `Panel`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=12;
--
-- AUTO_INCREMENT for table `Panelista`
--
ALTER TABLE `Panelista`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=461;
--
-- AUTO_INCREMENT for table `PanelistaEnPanel`
--
ALTER TABLE `PanelistaEnPanel`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=891;
--
-- AUTO_INCREMENT for table `Pregunta`
--
ALTER TABLE `Pregunta`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=235;
--
-- AUTO_INCREMENT for table `Recurso`
--
ALTER TABLE `Recurso`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `Respuesta`
--
ALTER TABLE `Respuesta`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=82;
--
-- AUTO_INCREMENT for table `Usuario`
--
ALTER TABLE `Usuario`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=7;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `Encuesta`
--
ALTER TABLE `Encuesta`
  ADD CONSTRAINT `Encuesta_ibfk_1` FOREIGN KEY (`Panel`) REFERENCES `Panel` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `Panel`
--
ALTER TABLE `Panel`
  ADD CONSTRAINT `Panel_ibfk_1` FOREIGN KEY (`cliente`) REFERENCES `Usuario` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Panel_ibfk_2` FOREIGN KEY (`creador`) REFERENCES `Usuario` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `PanelistaEnPanel`
--
ALTER TABLE `PanelistaEnPanel`
  ADD CONSTRAINT `PanelistaEnPanel_ibfk_1` FOREIGN KEY (`Panelista`) REFERENCES `Panelista` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `PanelistaEnPanel_ibfk_2` FOREIGN KEY (`Panel`) REFERENCES `Panel` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `Pregunta`
--
ALTER TABLE `Pregunta`
  ADD CONSTRAINT `Pregunta_ibfk_1` FOREIGN KEY (`Encuesta`) REFERENCES `Encuesta` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `Respuesta`
--
ALTER TABLE `Respuesta`
  ADD CONSTRAINT `Respuesta_ibfk_1` FOREIGN KEY (`Encuesta`) REFERENCES `Encuesta` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Respuesta_ibfk_2` FOREIGN KEY (`Panelista`) REFERENCES `Panelista` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
