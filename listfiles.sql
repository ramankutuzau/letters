-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Время создания: Июл 01 2021 г., 22:55
-- Версия сервера: 10.4.12-MariaDB
-- Версия PHP: 7.1.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `letters`
--

-- --------------------------------------------------------

--
-- Структура таблицы `listfiles`
--

CREATE TABLE `listfiles` (
  `FileID` int(11) NOT NULL,
  `FileName` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `FileType` int(11) NOT NULL,
  `TableID` int(11) NOT NULL,
  `Visible` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `listfiles`
--

INSERT INTO `listfiles` (`FileID`, `FileName`, `FileType`, `TableID`, `Visible`) VALUES
(1, 'UnitLettersChange.dcu', 0, 43, 1),
(2, 'UnitLettersChange.dcu', 0, 46, 1),
(3, 'UnitLetters.dcu', 0, 67, 0),
(4, 'UnitLettersChange.dcu', 0, 48, 1),
(5, 'Project1.exe', 0, 48, 1),
(6, 'Unit1.dcu', 0, 54, 1),
(7, 'UnitLetters.dcu', 0, 45, 0),
(8, 'UnitLettersAdd.dcu', 0, 45, 1),
(9, 'UnitLettersChange.dcu', 0, 45, 1),
(10, 'тестExcel.xlsx', 0, 45, 1),
(11, 'тестАрхив.zip', 0, 45, 1),
(12, '41_тестАрхив.zip', 0, 41, 1),
(13, '62_UnitLetters.dcu', 0, 62, 1),
(14, '62_UnitLettersAdd.dcu', 0, 62, 0),
(15, '62_UnitLettersChange.dcu', 0, 62, 1),
(16, '62_тестExcel.xlsx', 0, 62, 1),
(17, '62_тестАрхив.zip', 0, 62, 0),
(18, '57_Unit1.dcu', 0, 57, 1),
(19, '57_UnitLetters.dcu', 0, 57, 0),
(20, '57_UnitLettersAdd.dcu', 0, 57, 0),
(21, '57_UnitLettersChange.dcu', 0, 57, 0),
(22, '57_тестExcel.xlsx', 0, 57, 1),
(23, '57_тестАрхив.zip', 0, 57, 1),
(24, '62_Unit1.dcu', 0, 62, 1),
(25, '62_UnitLetters.dcu', 0, 62, 1),
(26, '62_UnitLettersAdd.dcu', 0, 62, 1),
(27, '62_UnitLettersChange.dcu', 0, 62, 1),
(28, '62_тестExcel.xlsx', 0, 62, 1),
(29, '62_тестАрхив.zip', 0, 62, 1),
(30, '63_Unit1.dcu', 0, 63, 1),
(31, '63_UnitLetters.dcu', 0, 63, 1),
(32, '63_UnitLettersAdd.dcu', 0, 63, 0),
(33, '63_UnitLettersChange.dcu', 0, 63, 0),
(34, '63_тестExcel.xlsx', 0, 63, 1),
(35, '63_тестАрхив.zip', 0, 63, 1),
(36, '67_UnitLettersAdd.dcu', 0, 67, 1),
(37, '67_UnitLettersChange.dcu', 0, 67, 1),
(38, '67_тестExcel.xlsx', 0, 67, 0),
(39, '67_тестАрхив.zip', 0, 67, 1);

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `listfiles`
--
ALTER TABLE `listfiles`
  ADD PRIMARY KEY (`FileID`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `listfiles`
--
ALTER TABLE `listfiles`
  MODIFY `FileID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
