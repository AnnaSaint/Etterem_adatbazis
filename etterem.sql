-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1
-- Létrehozás ideje: 2025. Dec 03. 11:03
-- Kiszolgáló verziója: 10.4.32-MariaDB
-- PHP verzió: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Adatbázis: `etterem`
--
CREATE DATABASE IF NOT EXISTS `etterem` DEFAULT CHARACTER SET utf8 COLLATE utf8_hungarian_ci;
USE `etterem`;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `etel`
--

DROP TABLE IF EXISTS `etel`;
CREATE TABLE IF NOT EXISTS `etel` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nev` varchar(150) NOT NULL,
  `kategoria` varchar(150) NOT NULL,
  `ar` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `etel`
--

INSERT INTO `etel` (`id`, `nev`, `kategoria`, `ar`) VALUES
(1, 'Coca Cola', 'Italok', 599),
(2, 'Pepsi Cola', 'Italok', 599),
(3, 'Répatorta', 'Desszert', 1299),
(4, 'Csokitorta', 'Desszert', 1399),
(5, 'Ír kávé', 'Kávé', 1199),
(6, 'Cappuchino', 'Kávé', 799);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `rendeles`
--

DROP TABLE IF EXISTS `rendeles`;
CREATE TABLE IF NOT EXISTS `rendeles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `vendeg_id` int(11) NOT NULL,
  `idopont` date NOT NULL,
  `asztalszam` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `vendeg_id` (`vendeg_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `rendeles`
--

INSERT INTO `rendeles` (`id`, `vendeg_id`, `idopont`, `asztalszam`) VALUES
(1, 2, '2025-12-03', 2),
(2, 1, '2025-12-02', 1),
(3, 1, '2025-12-01', 2);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `rendelestetelek`
--

DROP TABLE IF EXISTS `rendelestetelek`;
CREATE TABLE IF NOT EXISTS `rendelestetelek` (
  `etel_id` int(11) NOT NULL,
  `mennyiseg` int(11) NOT NULL,
  `rendeles_id` int(11) NOT NULL,
  KEY `etel_id` (`etel_id`),
  KEY `rendeles_id` (`rendeles_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `rendelestetelek`
--

INSERT INTO `rendelestetelek` (`etel_id`, `mennyiseg`, `rendeles_id`) VALUES
(6, 2, 2),
(4, 1, 3),
(3, 6, 1),
(5, 2, 1);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `vendeg`
--

DROP TABLE IF EXISTS `vendeg`;
CREATE TABLE IF NOT EXISTS `vendeg` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nev` varchar(150) NOT NULL,
  `telefonszam` varchar(20) NOT NULL COMMENT '+36001234567 formátum ',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `vendeg`
--

INSERT INTO `vendeg` (`id`, `nev`, `telefonszam`) VALUES
(1, 'Példa Irén', '+36001234567'),
(2, 'Pelda Józsi', '36011234567');

--
-- Megkötések a kiírt táblákhoz
--

--
-- Megkötések a táblához `rendeles`
--
ALTER TABLE `rendeles`
  ADD CONSTRAINT `rendeles_ibfk_1` FOREIGN KEY (`vendeg_id`) REFERENCES `vendeg` (`id`);

--
-- Megkötések a táblához `rendelestetelek`
--
ALTER TABLE `rendelestetelek`
  ADD CONSTRAINT `rendelestetelek_ibfk_1` FOREIGN KEY (`etel_id`) REFERENCES `etel` (`id`),
  ADD CONSTRAINT `rendelestetelek_ibfk_2` FOREIGN KEY (`rendeles_id`) REFERENCES `rendeles` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
