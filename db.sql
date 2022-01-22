-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Dec 20, 2021 at 12:55 AM
-- Server version: 10.6.4-MariaDB
-- PHP Version: 8.0.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `roblosium`
--

-- --------------------------------------------------------

--
-- Table structure for table `assets`
--

CREATE TABLE `assets` (
  `id` int(11) NOT NULL,
  `title` text NOT NULL,
  `description` text NOT NULL,
  `uid` int(11) NOT NULL,
  `assettype` int(11) NOT NULL,
  `genre` text NOT NULL,
  `robux` int(11) NOT NULL DEFAULT 0,
  `tickets` int(11) NOT NULL DEFAULT 0,
  `islimited` int(11) NOT NULL DEFAULT 0,
  `limitedamount` int(11) NOT NULL DEFAULT 0,
  `notforsale` int(11) NOT NULL DEFAULT 1,
  `copylocked` int(11) NOT NULL DEFAULT 1,
  `item_created` int(11) NOT NULL,
  `item_updated` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `asset_versions`
--

CREATE TABLE `asset_versions` (
  `id` int(255) NOT NULL,
  `aid` int(255) NOT NULL,
  `hash` text NOT NULL,
  `time` int(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `authentication_tokens`
--

CREATE TABLE `authentication_tokens` (
  `id` int(255) NOT NULL,
  `token` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `bans`
--

CREATE TABLE `bans` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `isbanned` int(11) NOT NULL DEFAULT 1,
  `banstart` int(11) NOT NULL DEFAULT current_timestamp(),
  `banend` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `charapp`
--

CREATE TABLE `charapp` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `head` int(11) NOT NULL DEFAULT 0,
  `torso` int(11) NOT NULL DEFAULT 0,
  `larm` int(11) NOT NULL DEFAULT 0,
  `rarm` int(11) NOT NULL DEFAULT 0,
  `lleg` int(11) NOT NULL DEFAULT 0,
  `rleg` int(11) NOT NULL DEFAULT 0,
  `head_c` int(11) NOT NULL DEFAULT 1,
  `torso_c` int(11) NOT NULL DEFAULT 1,
  `larm_c` int(11) NOT NULL DEFAULT 1,
  `rarm_c` int(11) NOT NULL DEFAULT 1,
  `lleg_c` int(11) NOT NULL DEFAULT 1,
  `rleg_c` int(11) NOT NULL DEFAULT 1,
  `hat1` int(11) NOT NULL,
  `hat2` int(11) NOT NULL,
  `hat3` int(11) NOT NULL,
  `shirt` int(11) NOT NULL,
  `pants` int(11) NOT NULL,
  `tshirt` int(11) NOT NULL,
  `gear` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `friends`
--

CREATE TABLE `friends` (
  `id` int(11) NOT NULL,
  `sender` int(11) NOT NULL,
  `receiver` int(11) NOT NULL,
  `status` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `inventory`
--

CREATE TABLE `inventory` (
  `id` int(255) NOT NULL,
  `item` int(255) NOT NULL,
  `sold` int(255) NOT NULL,
  `owner` int(255) NOT NULL,
  `date` int(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `statuses`
--

CREATE TABLE `statuses` (
  `id` int(255) NOT NULL,
  `uid` int(255) NOT NULL,
  `status` text CHARACTER SET utf8mb4 NOT NULL,
  `date` int(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(20) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` text NOT NULL,
  `birthday` text NOT NULL,
  `gender` text NOT NULL DEFAULT 'Male',
  `bio` text NOT NULL,
  `robux` bigint(255) NOT NULL,
  `tickets` bigint(255) NOT NULL,
  `membershiptype` text NOT NULL DEFAULT 'None',
  `membershipstart` int(255) NOT NULL,
  `membershipend` int(255) NOT NULL,
  `reg_ip` text NOT NULL,
  `latest_ip` text NOT NULL,
  `mac` text NOT NULL,
  `lastonline` int(255) NOT NULL,
  `status` text NOT NULL DEFAULT 'Play Roblosium',
  `registered` int(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `assets`
--
ALTER TABLE `assets`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `asset_versions`
--
ALTER TABLE `asset_versions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `authentication_tokens`
--
ALTER TABLE `authentication_tokens`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `bans`
--
ALTER TABLE `bans`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `charapp`
--
ALTER TABLE `charapp`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `friends`
--
ALTER TABLE `friends`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `inventory`
--
ALTER TABLE `inventory`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `statuses`
--
ALTER TABLE `statuses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `assets`
--
ALTER TABLE `assets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `asset_versions`
--
ALTER TABLE `asset_versions`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `authentication_tokens`
--
ALTER TABLE `authentication_tokens`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `bans`
--
ALTER TABLE `bans`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `charapp`
--
ALTER TABLE `charapp`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `friends`
--
ALTER TABLE `friends`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `inventory`
--
ALTER TABLE `inventory`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `statuses`
--
ALTER TABLE `statuses`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
