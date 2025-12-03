-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1
-- Létrehozás ideje: 2025. Dec 03. 11:46
-- Kiszolgáló verziója: 10.4.32-MariaDB
-- PHP verzió: 8.2.12

-- 🛡️ Idegen kulcsok kikapcsolása (kötelezően legelső sor!)
SET FOREIGN_KEY_CHECKS = 0;

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

--
-- Adatbázis: `etterem`
--
CREATE DATABASE IF NOT EXISTS `etterem` DEFAULT CHARACTER SET utf8 COLLATE utf8_hungarian_ci;
USE `etterem`;

-- --------------------------------------------------------

--
-- Kapcsolatok miatt helyes DROP sorrend!
--
DROP TABLE IF EXISTS `rendelestetelek`;
DROP TABLE IF EXISTS `etel`;
DROP TABLE IF EXISTS `rendeles`;
DROP TABLE IF EXISTS `vendeg`;
DROP TABLE IF EXISTS `kategoria`;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `etel`
--

CREATE TABLE `etel` (
  `id` int(11) NOT NULL,
  `nev` varchar(150) NOT NULL,
  `kategoria_id` int(11) NOT NULL,
  `ar` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `etel`
--

INSERT INTO `etel` (`id`, `nev`, `kategoria_id`, `ar`) VALUES
(1, 'Coca Cola', 1, 599),
(2, 'Pepsi Cola', 1, 599),
(3, 'Répatorta', 3, 1299),
(4, 'Csokitorta', 3, 1399),
(5, 'Ír kávé', 2, 1199),
(6, 'Cappuchino', 2, 799);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `kategoria`
--

CREATE TABLE `kategoria` (
  `id` int(11) NOT NULL,
  `nev` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `kategoria`
--

INSERT INTO `kategoria` (`id`, `nev`) VALUES
(1, 'Italok'),
(2, 'Kávé'),
(3, 'Desszert');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `rendeles`
--

CREATE TABLE `rendeles` (
  `id` int(11) NOT NULL,
  `vendeg_id` int(11) NOT NULL,
  `idopont` date NOT NULL,
  `asztalszam` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

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

CREATE TABLE `rendelestetelek` (
  `etel_id` int(11) NOT NULL,
  `mennyiseg` int(11) NOT NULL,
  `rendeles_id` int(11) NOT NULL,
  PRIMARY KEY (`etel_id`,`rendeles_id`)
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

CREATE TABLE `vendeg` (
  `id` int(11) NOT NULL,
  `nev` varchar(150) NOT NULL,
  `telefonszam` varchar(20) NOT NULL COMMENT '+36001234567 formátum '
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `vendeg`
--

INSERT INTO `vendeg` (`id`, `nev`, `telefonszam`) VALUES
(1, 'Példa Irén', '+36001234567'),
(2, 'Pelda Józsi', '36011234567');

--
-- Indexek a kiírt táblákhoz
--

ALTER TABLE `etel`
  ADD PRIMARY KEY (`id`),
  ADD KEY `kategoria_id` (`kategoria_id`);

ALTER TABLE `kategoria`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `rendeles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `vendeg_id` (`vendeg_id`);

ALTER TABLE `vendeg`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT értékek
--

ALTER TABLE `etel`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

ALTER TABLE `kategoria`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

ALTER TABLE `rendeles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

ALTER TABLE `vendeg`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Megkötések hozzáadása
--

ALTER TABLE `etel`
  ADD CONSTRAINT `etel_ibfk_1` FOREIGN KEY (`kategoria_id`) REFERENCES `kategoria` (`id`);

ALTER TABLE `rendeles`
  ADD CONSTRAINT `rendeles_ibfk_1` FOREIGN KEY (`vendeg_id`) REFERENCES `vendeg` (`id`);

ALTER TABLE `rendelestetelek`
  ADD CONSTRAINT `rendelestetelek_ibfk_1` FOREIGN KEY (`etel_id`) REFERENCES `etel` (`id`),
  ADD CONSTRAINT `rendelestetelek_ibfk_2` FOREIGN KEY (`rendeles_id`) REFERENCES `rendeles` (`id`);

-- 🛡️ Idegen kulcs ellenőrzések visszakapcsolása
SET FOREIGN_KEY_CHECKS = 1;

COMMIT;