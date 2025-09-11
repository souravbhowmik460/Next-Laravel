-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Sep 11, 2025 at 03:58 PM
-- Server version: 9.1.0
-- PHP Version: 8.3.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `digital_card`
--

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

DROP TABLE IF EXISTS `cache`;
CREATE TABLE IF NOT EXISTS `cache` (
  `key` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb3_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

DROP TABLE IF EXISTS `cache_locks`;
CREATE TABLE IF NOT EXISTS `cache_locks` (
  `key` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `owner` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cards`
--

DROP TABLE IF EXISTS `cards`;
CREATE TABLE IF NOT EXISTS `cards` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint UNSIGNED NOT NULL,
  `profile` json DEFAULT NULL,
  `business` json DEFAULT NULL,
  `social` json DEFAULT NULL,
  `about` json DEFAULT NULL,
  `cta` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cards_user_id_foreign` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `cards`
--

INSERT INTO `cards` (`id`, `user_id`, `profile`, `business`, `social`, `about`, `cta`, `created_at`, `updated_at`) VALUES
(1, 2, '{\"email\": \"\", \"phone\": \"\", \"photo\": \"\", \"lastName\": \"\", \"firstName\": \"\", \"designation\": \"\"}', '{\"role\": \"\", \"company\": \"\", \"services\": []}', '{\"twitter\": \"\", \"website\": \"\", \"facebook\": \"\", \"linkedin\": \"\", \"instagram\": \"\"}', '{\"bio\": \"\", \"experience\": \"\"}', '{\"call\": \"\", \"email\": \"\", \"website\": \"\", \"whatsapp\": \"\"}', '2025-09-11 03:51:22', '2025-09-11 03:51:22'),
(12, 1, '{\"email\": \"sourav@sundewsolutions.com\", \"phone\": \"08910534559\", \"lastName\": \"Bhowmik\", \"firstName\": \"Sourav\"}', '[]', '[]', '[]', '[]', '2025-09-11 06:12:41', '2025-09-11 06:12:41'),
(16, 1, '{\"email\": \"test@gmail.com\", \"phone\": \"9051230000\", \"lastName\": \"Test\", \"firstName\": \"Bishal\", \"designation\": null}', '{\"role\": \"\", \"company\": \"\", \"services\": []}', '{\"twitter\": \"\", \"website\": \"\", \"facebook\": \"\", \"linkedin\": \"\", \"instagram\": \"\"}', '{\"bio\": \"\", \"experience\": \"\"}', '{\"call\": \"\", \"email\": \"\", \"website\": \"\", \"whatsapp\": \"\"}', '2025-09-11 10:27:39', '2025-09-11 10:27:39'),
(5, 2, '{\"email\": \"souravrealtor@mailinator.com\", \"phone\": \"09174622897\", \"lastName\": \"Bhowmik\", \"firstName\": \"Sourav\"}', '[]', '[]', '[]', '[]', '2025-09-11 04:48:30', '2025-09-11 04:48:30'),
(6, 2, '{\"email\": \"souravrealtor@mailinator.com\", \"phone\": \"09174622897\", \"lastName\": \"Bhowmik\", \"firstName\": \"Sourav\"}', '{\"role\": \"sfrgxrg\", \"company\": \"hhhj\"}', '[]', '[]', '[]', '2025-09-11 04:48:43', '2025-09-11 04:48:43'),
(4, 2, '{\"email\": \"\", \"phone\": \"\", \"photo\": \"\", \"lastName\": \"\", \"firstName\": \"\", \"designation\": \"\"}', '{\"role\": \"\", \"company\": \"\", \"services\": []}', '{\"twitter\": \"\", \"website\": \"\", \"facebook\": \"\", \"linkedin\": \"\", \"instagram\": \"\"}', '{\"bio\": \"\", \"experience\": \"\"}', '{\"call\": \"\", \"email\": \"\", \"website\": \"\", \"whatsapp\": \"\"}', '2025-09-11 04:01:06', '2025-09-11 04:01:06'),
(7, 2, '{\"email\": \"souravrealtor@mailinator.com\", \"phone\": \"09174622897\", \"lastName\": \"Bhowmik\", \"firstName\": \"Sourav\"}', '{\"role\": \"sfrgxrg\", \"company\": \"hhhj\"}', '[]', '{\"bio\": \"gggg\", \"experience\": \"xgg\"}', '{\"call\": \"gggd\", \"email\": \"sou@gmail.com\", \"website\": \"https://www.google.com/\", \"whatsapp\": \"gg\"}', '2025-09-11 04:49:54', '2025-09-11 04:49:54'),
(10, 1, '{\"email\": \"sourav44@gmail.com\", \"phone\": \"09174622897\", \"lastName\": \"Bhowmik\", \"firstName\": \"Sourav\"}', '[]', '[]', '[]', '[]', '2025-09-11 05:40:42', '2025-09-11 05:40:42'),
(15, 1, '{\"email\": \"test@gmail.com\", \"phone\": \"9051230000\", \"lastName\": \"Test\", \"firstName\": \"New\"}', '{\"role\": \"AS\", \"company\": \"Soft\"}', '[]', '[]', '[]', '2025-09-11 07:43:04', '2025-09-11 07:43:04');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
CREATE TABLE IF NOT EXISTS `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb3_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb3_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb3_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb3_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
CREATE TABLE IF NOT EXISTS `jobs` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb3_unicode_ci NOT NULL,
  `attempts` tinyint UNSIGNED NOT NULL,
  `reserved_at` int UNSIGNED DEFAULT NULL,
  `available_at` int UNSIGNED NOT NULL,
  `created_at` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

DROP TABLE IF EXISTS `job_batches`;
CREATE TABLE IF NOT EXISTS `job_batches` (
  `id` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext COLLATE utf8mb3_unicode_ci NOT NULL,
  `options` mediumtext COLLATE utf8mb3_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2025_09_11_043605_create_personal_access_tokens_table', 1),
(5, '2025_09_11_044737_create_cards_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

DROP TABLE IF EXISTS `password_reset_tokens`;
CREATE TABLE IF NOT EXISTS `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `password_reset_tokens`
--

INSERT INTO `password_reset_tokens` (`email`, `token`, `created_at`) VALUES
('saurav@example.com', '$2y$12$sLRwFloRAV.jXw.pVcA7iOR9JcCc33CrjOWDHo3ZHKOFF1/xPRC2.', '2025-09-11 09:56:06');

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

DROP TABLE IF EXISTS `personal_access_tokens`;
CREATE TABLE IF NOT EXISTS `personal_access_tokens` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `tokenable_id` bigint UNSIGNED NOT NULL,
  `name` text COLLATE utf8mb3_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb3_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb3_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`),
  KEY `personal_access_tokens_expires_at_index` (`expires_at`)
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(1, 'App\\Models\\User', 1, 'api-token', '6cbb1fc1bf6002453b6b3f08cf97a569e4f661e49bfea790b8439a0fe04a5de5', '[\"*\"]', NULL, NULL, '2025-09-10 23:57:37', '2025-09-10 23:57:37'),
(2, 'App\\Models\\User', 1, 'api-token', 'd22afac77cdfa449a3f3cfbc066cd9fb5759862d54192ae8fb4bedb797c5a62d', '[\"*\"]', NULL, NULL, '2025-09-11 00:26:28', '2025-09-11 00:26:28'),
(3, 'App\\Models\\User', 1, 'api-token', '8ad46c604889e260a6e1133ffc582034defce8ad99cd2065504397c0fcd8dd6d', '[\"*\"]', '2025-09-11 01:33:12', NULL, '2025-09-11 01:26:37', '2025-09-11 01:33:12'),
(4, 'App\\Models\\User', 2, 'api-token', '51c31cc70c4318689ad23dea5b0512dcf39e0181774e3a0abf1d59271b6355ae', '[\"*\"]', '2025-09-11 02:27:00', NULL, '2025-09-11 01:35:47', '2025-09-11 02:27:00'),
(5, 'App\\Models\\User', 2, 'api-token', 'e9e65ef511a298dd46223b104e7282020126ae68844e8feb9af12359220bec05', '[\"*\"]', '2025-09-11 02:28:08', NULL, '2025-09-11 02:28:02', '2025-09-11 02:28:08'),
(6, 'App\\Models\\User', 1, 'api-token', '8018751883d86ad000cebd0f16b442f38df9a81b2202111b82016fce24f30176', '[\"*\"]', '2025-09-11 02:56:12', NULL, '2025-09-11 02:32:07', '2025-09-11 02:56:12'),
(7, 'App\\Models\\User', 1, 'api-token', '9c432f99620c1786ef9bfd10d425c1ab6cdb8c29c25013841fcf694f772d9d45', '[\"*\"]', '2025-09-11 04:58:13', NULL, '2025-09-11 02:56:23', '2025-09-11 04:58:13'),
(8, 'App\\Models\\User', 2, 'api-token', 'a0423ac02cdf6032d6a76bbb29215df05aa502b060f034e7f0e6c1842714df81', '[\"*\"]', '2025-09-11 05:56:25', NULL, '2025-09-11 03:10:02', '2025-09-11 05:56:25'),
(9, 'App\\Models\\User', 1, 'api-token', 'cc64af21eb4559f288213ea8515cfddf3c3c5d5c00f8d826b14d3e5339c09919', '[\"*\"]', '2025-09-11 05:11:09', NULL, '2025-09-11 04:58:45', '2025-09-11 05:11:09'),
(10, 'App\\Models\\User', 1, 'api-token', '3dd16acc979052f0271dc4df9381b5e8e7285590e41676b2c23e618729a458ac', '[\"*\"]', '2025-09-11 07:32:38', NULL, '2025-09-11 05:00:43', '2025-09-11 07:32:38'),
(11, 'App\\Models\\User', 1, 'api-token', '2378f5644c16dd1d65ca6d0fbc69ab2c43ab67d1d617365c1573b25815adfc33', '[\"*\"]', '2025-09-11 07:20:06', NULL, '2025-09-11 07:17:22', '2025-09-11 07:20:06'),
(12, 'App\\Models\\User', 1, 'api-token', '63509eb3f969da6ce244ed2e334d01a438b0a33f176c9a702df0c3340b694c04', '[\"*\"]', '2025-09-11 07:50:45', NULL, '2025-09-11 07:20:18', '2025-09-11 07:50:45'),
(13, 'App\\Models\\User', 1, 'api-token', 'e86b5c7af4252fd8c8fbd838dc64d5af3048fbbd51e3f084dd1f182f3b7b05c8', '[\"*\"]', '2025-09-11 10:27:50', NULL, '2025-09-11 07:51:04', '2025-09-11 10:27:50');

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
CREATE TABLE IF NOT EXISTS `sessions` (
  `id` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb3_unicode_ci,
  `payload` longtext COLLATE utf8mb3_unicode_ci NOT NULL,
  `last_activity` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('SM11ztRcjLLsqPeGWpjncOF0VFOukQGNXzCrWCcl', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoia1VFbzBydWp3MW9IcDhwQ2tXcnpWcTN5N2lwS0Myb1g2Mzlmd2QyeSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1757570579);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb3_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Saurav Chhetri', 'saurav@example.com', NULL, '$2y$12$LCy8pgthcBeSZWweudjnV.oTr4JvJ2Kb/298VekckIJxSr7fOGFqO', NULL, '2025-09-10 23:57:37', '2025-09-10 23:57:37'),
(2, 'Sourav Bhowmik', 'sourav@yopmail.com', NULL, '$2y$12$hAiPmy5jtQXmA8vRhUZWkOMnMjtSY.WN3tRnSmpWTP6WavzOYfkkm', NULL, '2025-09-11 01:35:47', '2025-09-11 01:35:47');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
