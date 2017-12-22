-- phpMyAdmin SQL Dump
-- version 4.7.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 22, 2017 at 03:50 AM
-- Server version: 10.1.25-MariaDB
-- PHP Version: 5.6.31

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `device_management`
--

-- --------------------------------------------------------

--
-- Table structure for table `device_report`
--

CREATE TABLE `device_report` (
  `id` int(11) UNSIGNED NOT NULL,
  `device_id` varchar(255) NOT NULL,
  `device_name` varchar(100) NOT NULL,
  `last_report_on` datetime NOT NULL,
  `device_status` enum('OK','OFFLINE') NOT NULL DEFAULT 'OFFLINE'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `device_report`
--

INSERT INTO `device_report` (`id`, `device_id`, `device_name`, `last_report_on`, `device_status`) VALUES
(1, 'D1', 'Device 1', '2017-12-17 07:30:16', 'OFFLINE'),
(2, 'D2', 'Device 2', '2017-12-17 07:30:54', 'OFFLINE'),
(3, 'D3', 'Device 3', '2017-12-17 07:31:45', 'OFFLINE'),
(4, 'D4', 'Device4', '2017-12-17 07:32:02', 'OFFLINE'),
(5, 'D5', 'Device 5', '2017-12-17 07:32:16', 'OFFLINE'),
(6, 'D1', 'Device1', '2017-12-18 07:34:26', 'OFFLINE'),
(7, 'D1', 'Device 1', '2017-12-19 07:35:29', 'OFFLINE'),
(8, 'D1', 'Device 1', '2017-12-20 07:35:45', 'OFFLINE'),
(9, 'D1', 'Device 1', '2017-12-21 07:36:12', 'OFFLINE'),
(10, 'D1', 'Device 1', '2017-12-22 07:36:24', 'OK'),
(11, 'D3', 'Device 3', '2017-12-19 07:41:15', 'OFFLINE'),
(12, 'D3', 'Device 3', '2017-12-21 07:41:38', 'OFFLINE'),
(13, 'D3', 'Device 3', '2017-12-22 07:41:51', 'OK'),
(14, 'D4', 'Device 4', '2017-12-22 08:12:00', 'OFFLINE');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `device_report`
--
ALTER TABLE `device_report`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `device_report`
--
ALTER TABLE `device_report`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
