-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Czas generowania: 03 Lip 2023, 16:51
-- Wersja serwera: 10.4.27-MariaDB
-- Wersja PHP: 8.0.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Baza danych: `justplay`
--

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `tr_accounts`
--

CREATE TABLE `tr_accounts` (
  `UID` int(11) NOT NULL,
  `login` varchar(40) NOT NULL,
  `username` varchar(22) DEFAULT NULL,
  `usernameRP` varchar(64) DEFAULT NULL,
  `password` varchar(128) NOT NULL,
  `email` varchar(60) NOT NULL,
  `serial` varchar(32) NOT NULL,
  `created` datetime NOT NULL DEFAULT current_timestamp(),
  `gold` datetime DEFAULT NULL,
  `diamond` datetime DEFAULT NULL,
  `skin` varchar(32) NOT NULL DEFAULT '0',
  `health` int(11) NOT NULL DEFAULT 100,
  `stamina` int(11) NOT NULL DEFAULT 100,
  `position` varchar(32) DEFAULT NULL,
  `money` varchar(32) NOT NULL DEFAULT '0',
  `bankmoney` varchar(32) NOT NULL DEFAULT '0',
  `bankcode` int(11) DEFAULT NULL,
  `casinoChips` int(11) NOT NULL DEFAULT 0,
  `phone` varchar(6) NOT NULL DEFAULT '1,1',
  `phoneBlocked` text NOT NULL,
  `licenceTheory` varchar(100) DEFAULT NULL,
  `features` varchar(40) NOT NULL DEFAULT '0,0,0,0,0,0,0,0,0,0',
  `licence` varchar(100) DEFAULT NULL,
  `licenceCreated` date DEFAULT NULL,
  `jobPoints` int(11) NOT NULL DEFAULT 0,
  `ticketPrice` varchar(12) DEFAULT NULL,
  `createIP` varchar(256) DEFAULT NULL,
  `ip` varchar(256) DEFAULT NULL,
  `tutorial` int(11) DEFAULT 1,
  `online` varchar(32) NOT NULL DEFAULT '0',
  `lastOnline` datetime NOT NULL DEFAULT current_timestamp(),
  `isOnline` tinyint(1) DEFAULT NULL,
  `bwTime` int(11) DEFAULT NULL,
  `cardPlay` datetime NOT NULL DEFAULT current_timestamp(),
  `cardPlays` int(11) DEFAULT 0,
  `houseLimit` int(11) NOT NULL DEFAULT 1,
  `vehicleLimit` int(11) NOT NULL DEFAULT 3,
  `referenced` int(11) NOT NULL DEFAULT 0,
  `referencedPlayer` int(11) DEFAULT NULL,
  `passwordResetCode` int(11) DEFAULT NULL,
  `personalToken` text DEFAULT NULL,
  `raceWin` int(11) NOT NULL DEFAULT 0,
  `prisonData` text DEFAULT NULL,
  `voiceWL` tinyint(1) DEFAULT NULL,
  `lastNameChange` datetime DEFAULT NULL,
  `lastRPNameChange` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Zrzut danych tabeli `tr_accounts`
--

INSERT INTO `tr_accounts` (`UID`, `login`, `username`, `usernameRP`, `password`, `email`, `serial`, `created`, `gold`, `diamond`, `skin`, `health`, `stamina`, `position`, `money`, `bankmoney`, `bankcode`, `casinoChips`, `phone`, `phoneBlocked`, `licenceTheory`, `features`, `licence`, `licenceCreated`, `jobPoints`, `ticketPrice`, `createIP`, `ip`, `tutorial`, `online`, `lastOnline`, `isOnline`, `bwTime`, `cardPlay`, `cardPlays`, `houseLimit`, `vehicleLimit`, `referenced`, `referencedPlayer`, `passwordResetCode`, `personalToken`, `raceWin`, `prisonData`, `voiceWL`, `lastNameChange`, `lastRPNameChange`) VALUES
(1, 'DeMoNeK', 'DeMoNeK', NULL, 'lKRqeyHqkT5gNm5YM2Uwag==', 'elo@justplay.pl', '14E4593C9956141973534D5654FC1BA3', '2023-07-02 11:54:04', '2023-07-05 12:31:47', '2297-04-15 12:12:25', '0', 100, 100, '-1892.27,911.38,35.02,0,0', '2829999999998672384.00', '0', NULL, 0, '1,1', '[[]]', NULL, '0,0,0,0,0,0,0,0,0,60', NULL, NULL, 0, '0', '192.168.0.31', NULL, 1, '2240', '2023-07-02 11:58:46', NULL, NULL, '2023-07-02 11:54:04', 0, 1, 3, 0, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `tr_accountsbackup`
--

CREATE TABLE `tr_accountsbackup` (
  `UID` int(11) NOT NULL,
  `login` varchar(40) NOT NULL,
  `username` varchar(22) DEFAULT NULL,
  `usernameRP` varchar(64) DEFAULT NULL,
  `password` varchar(128) NOT NULL,
  `email` varchar(60) NOT NULL,
  `serial` varchar(32) NOT NULL,
  `created` datetime NOT NULL DEFAULT current_timestamp(),
  `gold` datetime DEFAULT NULL,
  `diamond` datetime DEFAULT NULL,
  `skin` int(11) NOT NULL DEFAULT 0,
  `health` int(11) NOT NULL DEFAULT 100,
  `stamina` int(11) NOT NULL DEFAULT 100,
  `position` varchar(32) DEFAULT NULL,
  `money` varchar(11) NOT NULL DEFAULT '0',
  `bankmoney` varchar(11) NOT NULL DEFAULT '0',
  `bankcode` int(11) DEFAULT NULL,
  `casinoChips` int(11) NOT NULL DEFAULT 0,
  `phone` varchar(6) NOT NULL DEFAULT '1,1',
  `phoneBlocked` text NOT NULL,
  `licenceTheory` varchar(100) DEFAULT NULL,
  `features` varchar(40) NOT NULL DEFAULT '0,0,0,0,0,0,0,0,0,0',
  `licence` varchar(100) DEFAULT NULL,
  `licenceCreated` date DEFAULT NULL,
  `jobPoints` int(11) NOT NULL DEFAULT 0,
  `ticketPrice` varchar(12) DEFAULT NULL,
  `createIP` varchar(256) DEFAULT NULL,
  `ip` varchar(256) DEFAULT NULL,
  `tutorial` int(11) DEFAULT 1,
  `online` varchar(32) NOT NULL DEFAULT '0',
  `lastOnline` datetime NOT NULL DEFAULT current_timestamp(),
  `isOnline` tinyint(1) DEFAULT NULL,
  `bwTime` int(11) DEFAULT NULL,
  `cardPlay` datetime NOT NULL DEFAULT current_timestamp(),
  `cardPlays` int(11) DEFAULT 0,
  `houseLimit` int(11) NOT NULL DEFAULT 1,
  `vehicleLimit` int(11) NOT NULL DEFAULT 3,
  `referenced` int(11) NOT NULL DEFAULT 0,
  `referencedPlayer` int(11) DEFAULT NULL,
  `passwordResetCode` int(11) DEFAULT NULL,
  `personalToken` text DEFAULT NULL,
  `raceWin` int(11) NOT NULL DEFAULT 0,
  `prisonData` text DEFAULT NULL,
  `lastNameChange` datetime DEFAULT NULL,
  `lastRPNameChange` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `tr_achievements`
--

CREATE TABLE `tr_achievements` (
  `ID` int(11) NOT NULL,
  `plrUID` int(11) NOT NULL,
  `achievement` varchar(32) NOT NULL,
  `achieved` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Zrzut danych tabeli `tr_achievements`
--

INSERT INTO `tr_achievements` (`ID`, `plrUID`, `achievement`, `achieved`) VALUES
(1, 1, 'diceThrow', '2023-07-02'),
(2, 1, 'fishingSell', '2023-07-02'),
(3, 1, 'money1000', '2023-07-02'),
(4, 1, 'money10000', '2023-07-02'),
(5, 1, 'money50000', '2023-07-02'),
(6, 1, 'money100000', '2023-07-02'),
(7, 1, 'money500000', '2023-07-02'),
(8, 1, 'money1000000', '2023-07-02'),
(9, 1, 'vehicleSaloonBuy', '2023-07-02'),
(10, 1, 'clutchTuning', '2023-07-02'),
(11, 1, 'intercoolerTuning', '2023-07-02'),
(12, 1, 'injectionTuning', '2023-07-02'),
(13, 1, 'pistonTuning', '2023-07-02'),
(14, 1, 'distributionTuning', '2023-07-02'),
(15, 1, 'turboTuning', '2023-07-02'),
(16, 1, 'breakingTuning', '2023-07-02'),
(17, 1, 'breakpadTuning', '2023-07-02'),
(18, 1, 'steeringTuning', '2023-07-02'),
(19, 1, 'suspensionTuning', '2023-07-02'),
(20, 1, 'drivetypeTuning', '2023-07-02'),
(21, 1, 'setUpgradeTuning', '2023-07-02'),
(22, 1, 'lampsTuning', '2023-07-02'),
(23, 1, 'speedoColorTuning', '2023-07-02'),
(24, 1, 'diamondAccount', '2023-07-02'),
(25, 1, 'glassTintTuning', '2023-07-02'),
(26, 1, 'wheelResizeTuning', '2023-07-02'),
(27, 1, 'wheelTiltTuning', '2023-07-02'),
(28, 1, 'neonTuning', '2023-07-02'),
(29, 1, 'vehicle240', '2023-07-02');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `tr_admin`
--

CREATE TABLE `tr_admin` (
  `ID` int(11) NOT NULL,
  `uid` int(11) DEFAULT NULL,
  `serial` varchar(32) NOT NULL,
  `rankName` varchar(32) DEFAULT NULL,
  `isDev` tinyint(1) DEFAULT NULL,
  `clearChat` tinyint(1) DEFAULT NULL,
  `ban` tinyint(1) DEFAULT NULL,
  `kick` tinyint(1) DEFAULT NULL,
  `tpl` int(11) DEFAULT NULL,
  `bwOff` int(11) DEFAULT NULL,
  `heal` int(11) NOT NULL DEFAULT 1,
  `playerTp` tinyint(1) DEFAULT NULL,
  `vehicleTp` tinyint(1) DEFAULT NULL,
  `vehicleFuel` int(11) DEFAULT NULL,
  `orgLogos` int(11) DEFAULT NULL,
  `air` int(11) NOT NULL DEFAULT 1,
  `allReports` int(11) DEFAULT NULL,
  `itemCreate` int(11) DEFAULT NULL,
  `resetMail` int(11) DEFAULT NULL,
  `editAdmin` int(11) DEFAULT NULL,
  `editOrg` int(11) DEFAULT NULL,
  `dutyTime` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Zrzut danych tabeli `tr_admin`
--

INSERT INTO `tr_admin` (`ID`, `uid`, `serial`, `rankName`, `isDev`, `clearChat`, `ban`, `kick`, `tpl`, `bwOff`, `heal`, `playerTp`, `vehicleTp`, `vehicleFuel`, `orgLogos`, `air`, `allReports`, `itemCreate`, `resetMail`, `editAdmin`, `editOrg`, `dutyTime`) VALUES
(1, 1, '14E4593C9956141973534D5654FC1BA3', 'owner', 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `tr_collectibles`
--

CREATE TABLE `tr_collectibles` (
  `ID` int(11) NOT NULL,
  `playerUID` int(11) NOT NULL,
  `collectibleID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `tr_computerlogs`
--

CREATE TABLE `tr_computerlogs` (
  `ID` int(11) NOT NULL,
  `text` text NOT NULL,
  `name` varchar(32) NOT NULL,
  `owner` int(11) NOT NULL,
  `type` varchar(16) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `tr_darkweb`
--

CREATE TABLE `tr_darkweb` (
  `ID` int(11) NOT NULL,
  `text` varchar(200) NOT NULL,
  `location` varchar(200) NOT NULL,
  `type` varchar(16) NOT NULL,
  `hour` varchar(5) NOT NULL,
  `added` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `tr_flowers`
--

CREATE TABLE `tr_flowers` (
  `ID` int(11) NOT NULL,
  `plrUID` int(11) NOT NULL,
  `womanID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `tr_fractions`
--

CREATE TABLE `tr_fractions` (
  `ID` int(11) NOT NULL,
  `fractionID` int(11) NOT NULL,
  `name` varchar(32) NOT NULL,
  `type` varchar(12) NOT NULL,
  `color` varchar(11) NOT NULL,
  `pos` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `tr_fractionsdutytimes`
--

CREATE TABLE `tr_fractionsdutytimes` (
  `ID` int(11) NOT NULL,
  `playerUID` int(11) NOT NULL,
  `minutes` int(11) NOT NULL,
  `count` varchar(32) NOT NULL,
  `day` date NOT NULL,
  `takenMoney` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `tr_fractionsplayers`
--

CREATE TABLE `tr_fractionsplayers` (
  `ID` int(11) NOT NULL,
  `playerUID` int(11) DEFAULT NULL,
  `fractionID` int(11) DEFAULT NULL,
  `rankID` int(11) DEFAULT NULL,
  `added` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `tr_fractionsranks`
--

CREATE TABLE `tr_fractionsranks` (
  `ID` int(11) NOT NULL,
  `level` int(11) NOT NULL,
  `fractionID` int(11) NOT NULL,
  `rankName` varchar(32) NOT NULL,
  `canManage` smallint(6) DEFAULT NULL,
  `veh1` int(11) DEFAULT NULL,
  `veh2` int(11) DEFAULT NULL,
  `veh3` int(11) DEFAULT NULL,
  `veh4` int(11) DEFAULT NULL,
  `veh5` int(11) DEFAULT NULL,
  `veh6` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `tr_friends`
--

CREATE TABLE `tr_friends` (
  `ID` int(11) NOT NULL,
  `sender` int(11) NOT NULL,
  `target` int(11) NOT NULL,
  `friendsFor` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `tr_gangcorners`
--

CREATE TABLE `tr_gangcorners` (
  `ID` int(11) NOT NULL,
  `plrUID` int(11) NOT NULL,
  `zoneID` int(11) DEFAULT NULL,
  `date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `tr_ganghousedrugs`
--

CREATE TABLE `tr_ganghousedrugs` (
  `ID` int(11) NOT NULL,
  `homeID` int(11) NOT NULL,
  `objectIndex` int(11) NOT NULL,
  `fertilizer` datetime NOT NULL,
  `growth` datetime NOT NULL,
  `plantType` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `tr_gangorders`
--

CREATE TABLE `tr_gangorders` (
  `ID` int(11) NOT NULL,
  `orgID` int(11) NOT NULL,
  `orderHour` int(11) NOT NULL,
  `orderDate` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `tr_gangzones`
--

CREATE TABLE `tr_gangzones` (
  `ID` int(11) NOT NULL,
  `ownedGang` text DEFAULT NULL,
  `protectTime` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `tr_govjobs`
--

CREATE TABLE `tr_govjobs` (
  `ID` int(11) NOT NULL,
  `govID` int(11) NOT NULL,
  `name` varchar(32) NOT NULL,
  `type` varchar(32) NOT NULL,
  `description` text NOT NULL,
  `place` varchar(32) NOT NULL,
  `slots` int(11) NOT NULL DEFAULT 0,
  `payment` varchar(32) NOT NULL,
  `requirements` varchar(64) DEFAULT NULL,
  `position` varchar(40) DEFAULT NULL,
  `distanceLimit` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `tr_govjobsplayers`
--

CREATE TABLE `tr_govjobsplayers` (
  `ID` int(11) NOT NULL,
  `jobID` int(11) NOT NULL,
  `plrUID` varchar(11) DEFAULT NULL,
  `start` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `tr_houses`
--

CREATE TABLE `tr_houses` (
  `ID` int(11) NOT NULL,
  `date` datetime DEFAULT NULL,
  `price` varchar(11) DEFAULT NULL,
  `owner` int(11) DEFAULT NULL,
  `ownedOrg` int(11) DEFAULT NULL,
  `interiorFloor` text DEFAULT NULL,
  `interiorWalls` text DEFAULT NULL,
  `interiorObjects` text DEFAULT NULL,
  `interiorSize` varchar(256) DEFAULT NULL,
  `pos` varchar(256) DEFAULT NULL,
  `locked` tinyint(1) DEFAULT NULL,
  `premium` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `tr_housesgarage`
--

CREATE TABLE `tr_housesgarage` (
  `ID` int(11) NOT NULL,
  `homeID` int(11) NOT NULL,
  `garageSize` int(11) NOT NULL,
  `pos` varchar(128) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `tr_housesrent`
--

CREATE TABLE `tr_housesrent` (
  `ID` int(11) NOT NULL,
  `plrUID` int(11) NOT NULL,
  `houseID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `tr_items`
--

CREATE TABLE `tr_items` (
  `ID` int(11) NOT NULL,
  `owner` int(11) DEFAULT NULL,
  `ownedType` int(11) NOT NULL DEFAULT 0,
  `type` int(11) DEFAULT NULL,
  `variant` int(11) DEFAULT NULL,
  `variant2` int(11) DEFAULT NULL,
  `value` varchar(32) DEFAULT NULL,
  `value2` int(11) NOT NULL DEFAULT 1,
  `durability` float NOT NULL DEFAULT 100,
  `used` int(11) DEFAULT NULL,
  `favourite` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Zrzut danych tabeli `tr_items`
--

INSERT INTO `tr_items` (`ID`, `owner`, `ownedType`, `type`, `variant`, `variant2`, `value`, `value2`, `durability`, `used`, `favourite`) VALUES
(1, 1, 0, 1, 1, 12, '0', 1, 100, NULL, NULL),
(7, 1, 0, 1, 2, 1, '2445234', 1, 100, NULL, NULL),
(9, 1, 0, 16, 1, 0, '1', 1, 100, NULL, NULL),
(10, 1, 0, 16, 2, 0, '1', 1, 100, NULL, NULL),
(11, 1, 0, 16, 3, 0, '1', 1, 100, NULL, NULL),
(14, 1, 0, 25, 0, 0, '1', 1, 100, NULL, NULL),
(16, 1, 0, 18, 0, 0, '2', 1, 100, NULL, NULL),
(17, 1, 0, 18, 0, 1, '2', 1, 100, NULL, 1);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `tr_jobsplayers`
--

CREATE TABLE `tr_jobsplayers` (
  `ID` int(11) NOT NULL,
  `playerUID` int(11) NOT NULL,
  `jobID` varchar(32) NOT NULL,
  `points` int(11) NOT NULL DEFAULT 0,
  `totalPoints` int(11) NOT NULL DEFAULT 0,
  `upgrades` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `tr_jobsplayersprizes`
--

CREATE TABLE `tr_jobsplayersprizes` (
  `ID` int(11) NOT NULL,
  `playerUID` int(11) NOT NULL,
  `jobID` varchar(32) NOT NULL,
  `amount` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `tr_logs`
--

CREATE TABLE `tr_logs` (
  `ID` int(11) NOT NULL,
  `player` int(11) NOT NULL,
  `text` varchar(128) NOT NULL,
  `serial` varchar(32) DEFAULT NULL,
  `ip` varchar(16) DEFAULT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp(),
  `type` varchar(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Zrzut danych tabeli `tr_logs`
--

INSERT INTO `tr_logs` (`ID`, `player`, `text`, `serial`, `ip`, `date`, `type`) VALUES
(1, 1, 'Pomyślnie zalogowano na konto.', '14E4593C9956141973534D5654FC1BA3', '192.168.0.31', '2023-07-02 11:54:06', 'login'),
(2, 1, 'Pomyślnie zalogowano na konto.', '14E4593C9956141973534D5654FC1BA3', '192.168.0.31', '2023-07-02 11:58:46', 'login');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `tr_mdtplayers`
--

CREATE TABLE `tr_mdtplayers` (
  `ID` int(11) NOT NULL,
  `plrUID` int(11) NOT NULL,
  `text` text NOT NULL,
  `policeUID` int(11) NOT NULL,
  `added` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `tr_mdtwanted`
--

CREATE TABLE `tr_mdtwanted` (
  `ID` int(11) NOT NULL,
  `plrUID` int(11) NOT NULL,
  `wantedTime` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `tr_organizations`
--

CREATE TABLE `tr_organizations` (
  `ID` int(11) NOT NULL,
  `name` varchar(32) NOT NULL,
  `type` varchar(16) NOT NULL,
  `interior` int(11) NOT NULL DEFAULT 1,
  `img` varchar(128) DEFAULT NULL,
  `logoRequest` text DEFAULT NULL,
  `zoneColor` varchar(12) DEFAULT NULL,
  `created` datetime NOT NULL DEFAULT current_timestamp(),
  `rent` date DEFAULT NULL,
  `owner` varchar(32) NOT NULL,
  `money` varchar(16) NOT NULL DEFAULT '0',
  `players` int(11) NOT NULL DEFAULT 1,
  `vehicles` int(11) NOT NULL DEFAULT 1,
  `moneyBonus` int(11) NOT NULL DEFAULT 0,
  `lastPayment` datetime NOT NULL DEFAULT current_timestamp(),
  `gangType` varchar(16) DEFAULT NULL,
  `removed` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `tr_organizationsearnings`
--

CREATE TABLE `tr_organizationsearnings` (
  `ID` int(11) NOT NULL,
  `orgID` int(11) NOT NULL,
  `totalEarn` varchar(32) NOT NULL,
  `day` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `tr_organizationsplayers`
--

CREATE TABLE `tr_organizationsplayers` (
  `ID` int(11) NOT NULL,
  `playerUID` int(11) DEFAULT NULL,
  `orgID` int(11) DEFAULT NULL,
  `rankID` int(11) DEFAULT NULL,
  `added` datetime NOT NULL DEFAULT current_timestamp(),
  `toPay` varchar(12) NOT NULL DEFAULT '0',
  `allEarn` varchar(12) NOT NULL DEFAULT '0',
  `allPaid` varchar(32) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `tr_organizationsranks`
--

CREATE TABLE `tr_organizationsranks` (
  `ID` int(11) NOT NULL,
  `level` int(11) NOT NULL,
  `orgID` int(11) NOT NULL,
  `rankName` varchar(32) NOT NULL,
  `canManage` smallint(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `tr_penalties`
--

CREATE TABLE `tr_penalties` (
  `ID` int(11) NOT NULL,
  `username` varchar(22) DEFAULT NULL,
  `plrUID` int(11) DEFAULT NULL,
  `serial` varchar(32) DEFAULT NULL,
  `reason` text DEFAULT NULL,
  `time` datetime NOT NULL DEFAULT current_timestamp(),
  `timeEnd` datetime DEFAULT NULL,
  `type` varchar(10) DEFAULT NULL,
  `admin` varchar(22) DEFAULT NULL,
  `takenBy` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Zrzut danych tabeli `tr_penalties`
--

INSERT INTO `tr_penalties` (`ID`, `username`, `plrUID`, `serial`, `reason`, `time`, `timeEnd`, `type`, `admin`, `takenBy`) VALUES
(1, NULL, 1, '14E4593C9956141973534D5654FC1BA3', 'elo', '2023-07-02 12:18:04', NULL, 'warn', 'DeMoNeK', NULL);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `tr_premiumoptions`
--

CREATE TABLE `tr_premiumoptions` (
  `option_id` int(11) NOT NULL,
  `option_days` int(11) NOT NULL,
  `option_price` varchar(6) NOT NULL,
  `option_price_now` varchar(6) NOT NULL,
  `option_shop` int(11) NOT NULL,
  `option_smsCode` varchar(45) DEFAULT NULL,
  `option_smsNumber` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `tr_racetimes`
--

CREATE TABLE `tr_racetimes` (
  `ID` int(11) NOT NULL,
  `playerUID` int(11) NOT NULL,
  `playerTime` int(11) NOT NULL,
  `trackID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `tr_racetracks`
--

CREATE TABLE `tr_racetracks` (
  `ID` int(11) NOT NULL,
  `createdPlayer` int(11) NOT NULL,
  `track` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `type` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `laps` int(11) DEFAULT NULL,
  `vehicleType` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `vehicleSpeed` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `created` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `tr_reports`
--

CREATE TABLE `tr_reports` (
  `ID` int(11) NOT NULL,
  `reporter` varchar(22) DEFAULT NULL,
  `reported` varchar(22) DEFAULT NULL,
  `reason` text DEFAULT NULL,
  `admin` varchar(22) DEFAULT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `tr_santagifts`
--

CREATE TABLE `tr_santagifts` (
  `ID` int(11) NOT NULL,
  `playerUID` int(11) NOT NULL,
  `money` int(11) NOT NULL DEFAULT 0,
  `gold` int(11) NOT NULL DEFAULT 0,
  `diamond` int(11) NOT NULL DEFAULT 0,
  `vehicle` int(11) NOT NULL DEFAULT 0,
  `house` int(11) NOT NULL DEFAULT 0,
  `takenTime` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `tr_santaquests`
--

CREATE TABLE `tr_santaquests` (
  `ID` int(11) NOT NULL,
  `playerUID` int(11) NOT NULL,
  `stage` int(11) NOT NULL,
  `completed` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `tr_shop`
--

CREATE TABLE `tr_shop` (
  `shop_id` int(11) NOT NULL,
  `shop_value` int(11) DEFAULT NULL,
  `shop_item_name` varchar(64) DEFAULT NULL,
  `shop_item_category` int(11) DEFAULT NULL,
  `shop_price_stripe` int(11) DEFAULT NULL,
  `shop_price_hotpay` int(11) DEFAULT NULL,
  `shop_number_hotpay` int(11) DEFAULT NULL,
  `shop_price_cashbill` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `tr_sweepers`
--

CREATE TABLE `tr_sweepers` (
  `ID` int(11) NOT NULL,
  `plrUID` int(11) NOT NULL,
  `count` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `tr_sweeperssorting`
--

CREATE TABLE `tr_sweeperssorting` (
  `ID` int(11) NOT NULL,
  `plrUID` int(11) DEFAULT NULL,
  `money` int(11) DEFAULT NULL,
  `takeoutTime` datetime NOT NULL,
  `taken` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `tr_updates`
--

CREATE TABLE `tr_updates` (
  `ID` int(11) NOT NULL,
  `text` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `tr_vehicles`
--

CREATE TABLE `tr_vehicles` (
  `ID` int(11) NOT NULL,
  `model` int(11) DEFAULT NULL,
  `pos` varchar(256) DEFAULT NULL,
  `health` int(11) DEFAULT 1000,
  `fuel` float DEFAULT NULL,
  `mileage` float DEFAULT NULL,
  `color` varchar(256) DEFAULT NULL,
  `engineCapacity` varchar(32) DEFAULT NULL,
  `engineType` varchar(1) DEFAULT NULL,
  `tuning` varchar(64) DEFAULT NULL,
  `visualTuning` text DEFAULT NULL,
  `performanceTuning` text DEFAULT NULL,
  `paintjob` tinyint(1) DEFAULT NULL,
  `variant` varchar(8) NOT NULL DEFAULT '0,0',
  `panelstates` varchar(17) DEFAULT '0,0,0,0,0,0,0,0,0',
  `doorstates` varchar(11) DEFAULT '0,0,0,0,0,0',
  `vehicleDirt` int(11) NOT NULL DEFAULT 0,
  `plateText` varchar(64) DEFAULT NULL,
  `ownedPlayer` int(11) DEFAULT NULL,
  `ownedOrg` int(11) DEFAULT NULL,
  `requestOrg` int(11) DEFAULT NULL,
  `rent` varchar(100) DEFAULT NULL,
  `parking` int(11) DEFAULT NULL,
  `policeParkingInfo` varchar(150) DEFAULT NULL,
  `wheelBlock` int(11) DEFAULT NULL,
  `boughtDate` datetime NOT NULL DEFAULT current_timestamp(),
  `exchangePrice` varchar(64) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Zrzut danych tabeli `tr_vehicles`
--

INSERT INTO `tr_vehicles` (`ID`, `model`, `pos`, `health`, `fuel`, `mileage`, `color`, `engineCapacity`, `engineType`, `tuning`, `visualTuning`, `performanceTuning`, `paintjob`, `variant`, `panelstates`, `doorstates`, `vehicleDirt`, `plateText`, `ownedPlayer`, `ownedOrg`, `requestOrg`, `rent`, `parking`, `policeParkingInfo`, `wheelBlock`, `boughtDate`, `exchangePrice`) VALUES
(1, 541, '-1787.02,1204.95,24.75,359,0,0', 1000, 9.53543, 1.09429, '170,170,170,170,170,170,170,170,170,170,170,170,255,85,0', '5.0 V8 Biturbo', 'p', '[ [ 1074 ] ]', '[ { \"speedoColor\": [ 255, 85, 0 ], \"neon\": [ 3, 255, 85, 0, 94 ], \"wheelResize\": 1.1, \"wheelTilt\": -8, \"engineCapacity\": \"5.0 V8 Biturbo\", \"glassTint\": 0.9 } ]', '[ { \"breaking\": 1, \"drivetype\": \"awd\", \"steering\": 20, \"engineCapacity\": \"5.0 V8 Biturbo\", \"distribution\": 0.4, \"breakpad\": 1, \"intercooler\": 0.2, \"piston\": 0.6, \"injection\": 0.8, \"clutch\": 0.2, \"suspension\": true } ]', NULL, '255,255', '0,0,0,0,0,0,0,0,0', '0,0,0,0,0,0', 0, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2023-07-02 12:09:03', NULL);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `tr_vehiclesdrivers`
--

CREATE TABLE `tr_vehiclesdrivers` (
  `ID` int(11) NOT NULL,
  `vehID` int(11) NOT NULL,
  `driverUID` int(11) NOT NULL,
  `driveDate` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Zrzut danych tabeli `tr_vehiclesdrivers`
--

INSERT INTO `tr_vehiclesdrivers` (`ID`, `vehID`, `driverUID`, `driveDate`) VALUES
(1, 1, 1, '2023-07-02 12:09:03'),
(2, 1, 1, '2023-07-02 12:10:29'),
(3, 1, 1, '2023-07-02 12:11:51'),
(4, 1, 1, '2023-07-02 12:13:05'),
(5, 1, 1, '2023-07-02 12:14:31'),
(6, 1, 1, '2023-07-02 12:26:17'),
(7, 1, 1, '2023-07-02 12:33:25');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `tr_vehiclesrent`
--

CREATE TABLE `tr_vehiclesrent` (
  `ID` int(11) NOT NULL,
  `plrUID` int(11) NOT NULL,
  `vehID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `tr_weather`
--

CREATE TABLE `tr_weather` (
  `weather_id` int(11) NOT NULL,
  `weather_zone` varchar(64) DEFAULT NULL,
  `weather_value` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Zrzut danych tabeli `tr_weather`
--

INSERT INTO `tr_weather` (`weather_id`, `weather_zone`, `weather_value`) VALUES
(1, 'Los Santos', '0'),
(2, 'Red County', '7'),
(3, 'San Fierro', '5'),
(4, 'Flint County', '7'),
(5, 'Whetstone', '15'),
(6, 'Las Venturas', '17'),
(7, 'Bone County', '17'),
(8, 'Tierra Robada', '18');

--
-- Indeksy dla zrzutów tabel
--

--
-- Indeksy dla tabeli `tr_accounts`
--
ALTER TABLE `tr_accounts`
  ADD PRIMARY KEY (`UID`);

--
-- Indeksy dla tabeli `tr_achievements`
--
ALTER TABLE `tr_achievements`
  ADD PRIMARY KEY (`ID`);

--
-- Indeksy dla tabeli `tr_admin`
--
ALTER TABLE `tr_admin`
  ADD PRIMARY KEY (`ID`);

--
-- Indeksy dla tabeli `tr_collectibles`
--
ALTER TABLE `tr_collectibles`
  ADD PRIMARY KEY (`ID`);

--
-- Indeksy dla tabeli `tr_computerlogs`
--
ALTER TABLE `tr_computerlogs`
  ADD PRIMARY KEY (`ID`);

--
-- Indeksy dla tabeli `tr_darkweb`
--
ALTER TABLE `tr_darkweb`
  ADD PRIMARY KEY (`ID`);

--
-- Indeksy dla tabeli `tr_flowers`
--
ALTER TABLE `tr_flowers`
  ADD PRIMARY KEY (`ID`);

--
-- Indeksy dla tabeli `tr_fractions`
--
ALTER TABLE `tr_fractions`
  ADD PRIMARY KEY (`ID`);

--
-- Indeksy dla tabeli `tr_fractionsdutytimes`
--
ALTER TABLE `tr_fractionsdutytimes`
  ADD PRIMARY KEY (`ID`);

--
-- Indeksy dla tabeli `tr_fractionsplayers`
--
ALTER TABLE `tr_fractionsplayers`
  ADD PRIMARY KEY (`ID`);

--
-- Indeksy dla tabeli `tr_fractionsranks`
--
ALTER TABLE `tr_fractionsranks`
  ADD PRIMARY KEY (`ID`);

--
-- Indeksy dla tabeli `tr_friends`
--
ALTER TABLE `tr_friends`
  ADD PRIMARY KEY (`ID`);

--
-- Indeksy dla tabeli `tr_gangcorners`
--
ALTER TABLE `tr_gangcorners`
  ADD PRIMARY KEY (`ID`);

--
-- Indeksy dla tabeli `tr_ganghousedrugs`
--
ALTER TABLE `tr_ganghousedrugs`
  ADD PRIMARY KEY (`ID`);

--
-- Indeksy dla tabeli `tr_gangorders`
--
ALTER TABLE `tr_gangorders`
  ADD PRIMARY KEY (`ID`);

--
-- Indeksy dla tabeli `tr_gangzones`
--
ALTER TABLE `tr_gangzones`
  ADD PRIMARY KEY (`ID`);

--
-- Indeksy dla tabeli `tr_govjobs`
--
ALTER TABLE `tr_govjobs`
  ADD PRIMARY KEY (`ID`);

--
-- Indeksy dla tabeli `tr_govjobsplayers`
--
ALTER TABLE `tr_govjobsplayers`
  ADD PRIMARY KEY (`ID`);

--
-- Indeksy dla tabeli `tr_houses`
--
ALTER TABLE `tr_houses`
  ADD PRIMARY KEY (`ID`);

--
-- Indeksy dla tabeli `tr_housesgarage`
--
ALTER TABLE `tr_housesgarage`
  ADD PRIMARY KEY (`ID`);

--
-- Indeksy dla tabeli `tr_housesrent`
--
ALTER TABLE `tr_housesrent`
  ADD PRIMARY KEY (`ID`);

--
-- Indeksy dla tabeli `tr_items`
--
ALTER TABLE `tr_items`
  ADD PRIMARY KEY (`ID`);

--
-- Indeksy dla tabeli `tr_jobsplayers`
--
ALTER TABLE `tr_jobsplayers`
  ADD PRIMARY KEY (`ID`);

--
-- Indeksy dla tabeli `tr_jobsplayersprizes`
--
ALTER TABLE `tr_jobsplayersprizes`
  ADD PRIMARY KEY (`ID`);

--
-- Indeksy dla tabeli `tr_logs`
--
ALTER TABLE `tr_logs`
  ADD PRIMARY KEY (`ID`);

--
-- Indeksy dla tabeli `tr_mdtplayers`
--
ALTER TABLE `tr_mdtplayers`
  ADD PRIMARY KEY (`ID`);

--
-- Indeksy dla tabeli `tr_mdtwanted`
--
ALTER TABLE `tr_mdtwanted`
  ADD PRIMARY KEY (`ID`);

--
-- Indeksy dla tabeli `tr_organizations`
--
ALTER TABLE `tr_organizations`
  ADD PRIMARY KEY (`ID`);

--
-- Indeksy dla tabeli `tr_organizationsearnings`
--
ALTER TABLE `tr_organizationsearnings`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `OrganizationEarnings` (`orgID`,`day`);

--
-- Indeksy dla tabeli `tr_organizationsplayers`
--
ALTER TABLE `tr_organizationsplayers`
  ADD PRIMARY KEY (`ID`);

--
-- Indeksy dla tabeli `tr_organizationsranks`
--
ALTER TABLE `tr_organizationsranks`
  ADD PRIMARY KEY (`ID`);

--
-- Indeksy dla tabeli `tr_penalties`
--
ALTER TABLE `tr_penalties`
  ADD PRIMARY KEY (`ID`);

--
-- Indeksy dla tabeli `tr_premiumoptions`
--
ALTER TABLE `tr_premiumoptions`
  ADD PRIMARY KEY (`option_id`);

--
-- Indeksy dla tabeli `tr_racetimes`
--
ALTER TABLE `tr_racetimes`
  ADD PRIMARY KEY (`ID`);

--
-- Indeksy dla tabeli `tr_racetracks`
--
ALTER TABLE `tr_racetracks`
  ADD PRIMARY KEY (`ID`);

--
-- Indeksy dla tabeli `tr_reports`
--
ALTER TABLE `tr_reports`
  ADD PRIMARY KEY (`ID`);

--
-- Indeksy dla tabeli `tr_santagifts`
--
ALTER TABLE `tr_santagifts`
  ADD PRIMARY KEY (`ID`);

--
-- Indeksy dla tabeli `tr_santaquests`
--
ALTER TABLE `tr_santaquests`
  ADD PRIMARY KEY (`ID`);

--
-- Indeksy dla tabeli `tr_shop`
--
ALTER TABLE `tr_shop`
  ADD PRIMARY KEY (`shop_id`);

--
-- Indeksy dla tabeli `tr_sweepers`
--
ALTER TABLE `tr_sweepers`
  ADD PRIMARY KEY (`ID`);

--
-- Indeksy dla tabeli `tr_sweeperssorting`
--
ALTER TABLE `tr_sweeperssorting`
  ADD PRIMARY KEY (`ID`);

--
-- Indeksy dla tabeli `tr_updates`
--
ALTER TABLE `tr_updates`
  ADD PRIMARY KEY (`ID`);

--
-- Indeksy dla tabeli `tr_vehicles`
--
ALTER TABLE `tr_vehicles`
  ADD PRIMARY KEY (`ID`);

--
-- Indeksy dla tabeli `tr_vehiclesdrivers`
--
ALTER TABLE `tr_vehiclesdrivers`
  ADD PRIMARY KEY (`ID`);

--
-- Indeksy dla tabeli `tr_vehiclesrent`
--
ALTER TABLE `tr_vehiclesrent`
  ADD PRIMARY KEY (`ID`);

--
-- Indeksy dla tabeli `tr_weather`
--
ALTER TABLE `tr_weather`
  ADD PRIMARY KEY (`weather_id`);

--
-- AUTO_INCREMENT dla zrzuconych tabel
--

--
-- AUTO_INCREMENT dla tabeli `tr_accounts`
--
ALTER TABLE `tr_accounts`
  MODIFY `UID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT dla tabeli `tr_achievements`
--
ALTER TABLE `tr_achievements`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT dla tabeli `tr_admin`
--
ALTER TABLE `tr_admin`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT dla tabeli `tr_collectibles`
--
ALTER TABLE `tr_collectibles`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `tr_computerlogs`
--
ALTER TABLE `tr_computerlogs`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `tr_darkweb`
--
ALTER TABLE `tr_darkweb`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `tr_flowers`
--
ALTER TABLE `tr_flowers`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `tr_fractions`
--
ALTER TABLE `tr_fractions`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `tr_fractionsdutytimes`
--
ALTER TABLE `tr_fractionsdutytimes`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `tr_fractionsplayers`
--
ALTER TABLE `tr_fractionsplayers`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `tr_fractionsranks`
--
ALTER TABLE `tr_fractionsranks`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `tr_friends`
--
ALTER TABLE `tr_friends`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `tr_gangcorners`
--
ALTER TABLE `tr_gangcorners`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `tr_ganghousedrugs`
--
ALTER TABLE `tr_ganghousedrugs`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `tr_gangorders`
--
ALTER TABLE `tr_gangorders`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `tr_gangzones`
--
ALTER TABLE `tr_gangzones`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `tr_govjobs`
--
ALTER TABLE `tr_govjobs`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `tr_govjobsplayers`
--
ALTER TABLE `tr_govjobsplayers`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `tr_houses`
--
ALTER TABLE `tr_houses`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `tr_housesgarage`
--
ALTER TABLE `tr_housesgarage`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `tr_housesrent`
--
ALTER TABLE `tr_housesrent`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `tr_items`
--
ALTER TABLE `tr_items`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT dla tabeli `tr_jobsplayers`
--
ALTER TABLE `tr_jobsplayers`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `tr_jobsplayersprizes`
--
ALTER TABLE `tr_jobsplayersprizes`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `tr_logs`
--
ALTER TABLE `tr_logs`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT dla tabeli `tr_mdtplayers`
--
ALTER TABLE `tr_mdtplayers`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `tr_mdtwanted`
--
ALTER TABLE `tr_mdtwanted`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `tr_organizations`
--
ALTER TABLE `tr_organizations`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `tr_organizationsearnings`
--
ALTER TABLE `tr_organizationsearnings`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `tr_organizationsplayers`
--
ALTER TABLE `tr_organizationsplayers`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `tr_organizationsranks`
--
ALTER TABLE `tr_organizationsranks`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `tr_penalties`
--
ALTER TABLE `tr_penalties`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT dla tabeli `tr_premiumoptions`
--
ALTER TABLE `tr_premiumoptions`
  MODIFY `option_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `tr_racetimes`
--
ALTER TABLE `tr_racetimes`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `tr_racetracks`
--
ALTER TABLE `tr_racetracks`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `tr_reports`
--
ALTER TABLE `tr_reports`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `tr_santagifts`
--
ALTER TABLE `tr_santagifts`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `tr_santaquests`
--
ALTER TABLE `tr_santaquests`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `tr_shop`
--
ALTER TABLE `tr_shop`
  MODIFY `shop_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `tr_sweepers`
--
ALTER TABLE `tr_sweepers`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `tr_sweeperssorting`
--
ALTER TABLE `tr_sweeperssorting`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `tr_updates`
--
ALTER TABLE `tr_updates`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `tr_vehicles`
--
ALTER TABLE `tr_vehicles`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT dla tabeli `tr_vehiclesdrivers`
--
ALTER TABLE `tr_vehiclesdrivers`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT dla tabeli `tr_vehiclesrent`
--
ALTER TABLE `tr_vehiclesrent`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `tr_weather`
--
ALTER TABLE `tr_weather`
  MODIFY `weather_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
