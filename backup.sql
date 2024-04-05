-- MySQL dump 10.13  Distrib 8.0.29, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: gather
-- ------------------------------------------------------
-- Server version	8.0.29-0ubuntu0.20.04.3

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `gather`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `gather` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `gather`;

--
-- Table structure for table `admins`
--

DROP TABLE IF EXISTS `admins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admins` (
  `userID` int NOT NULL,
  PRIMARY KEY (`userID`),
  CONSTRAINT `admins_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `users` (`userID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admins`
--

LOCK TABLES `admins` WRITE;
/*!40000 ALTER TABLE `admins` DISABLE KEYS */;
INSERT INTO `admins` VALUES (1);
/*!40000 ALTER TABLE `admins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attending`
--

DROP TABLE IF EXISTS `attending`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `attending` (
  `arbitraryID` int NOT NULL AUTO_INCREMENT,
  `eventID` int DEFAULT NULL,
  `userID` int DEFAULT NULL,
  `linkKey` int DEFAULT NULL,
  PRIMARY KEY (`arbitraryID`),
  KEY `eventID` (`eventID`),
  KEY `userID` (`userID`),
  KEY `linkKey` (`linkKey`),
  CONSTRAINT `attending_ibfk_1` FOREIGN KEY (`eventID`) REFERENCES `events` (`eventID`) ON DELETE CASCADE,
  CONSTRAINT `attending_ibfk_2` FOREIGN KEY (`userID`) REFERENCES `users` (`userID`) ON DELETE CASCADE,
  CONSTRAINT `attending_ibfk_3` FOREIGN KEY (`linkKey`) REFERENCES `invited` (`linkKey`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attending`
--

LOCK TABLES `attending` WRITE;
/*!40000 ALTER TABLE `attending` DISABLE KEYS */;
/*!40000 ALTER TABLE `attending` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `available`
--

DROP TABLE IF EXISTS `available`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `available` (
  `userID` int DEFAULT NULL,
  `weekDays` json DEFAULT NULL,
  `linkKey` int DEFAULT NULL,
  UNIQUE KEY `unique_id` (`userID`),
  CONSTRAINT `available_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `users` (`userID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `available`
--

LOCK TABLES `available` WRITE;
/*!40000 ALTER TABLE `available` DISABLE KEYS */;
INSERT INTO `available` VALUES (2,'[true, false, true, false, true, false, true]',NULL);
/*!40000 ALTER TABLE `available` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `events`
--

DROP TABLE IF EXISTS `events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `events` (
  `eventID` int NOT NULL AUTO_INCREMENT,
  `eventName` varchar(255) DEFAULT NULL,
  `eventStartTime` datetime DEFAULT NULL,
  `eventEndTime` datetime DEFAULT NULL,
  `eventOwner` int DEFAULT NULL,
  `eventLocation` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`eventID`),
  KEY `eventOwner` (`eventOwner`),
  CONSTRAINT `events_ibfk_1` FOREIGN KEY (`eventOwner`) REFERENCES `users` (`userID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `events`
--

LOCK TABLES `events` WRITE;
/*!40000 ALTER TABLE `events` DISABLE KEYS */;
/*!40000 ALTER TABLE `events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invited`
--

DROP TABLE IF EXISTS `invited`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `invited` (
  `linkKey` int NOT NULL,
  `eventID` int DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`linkKey`),
  UNIQUE KEY `unique_email` (`email`),
  KEY `eventID` (`eventID`),
  CONSTRAINT `invited_ibfk_1` FOREIGN KEY (`eventID`) REFERENCES `events` (`eventID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invited`
--

LOCK TABLES `invited` WRITE;
/*!40000 ALTER TABLE `invited` DISABLE KEYS */;
/*!40000 ALTER TABLE `invited` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `userID` int NOT NULL AUTO_INCREMENT,
  `password` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `firstName` varchar(255) DEFAULT NULL,
  `lastName` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`userID`),
  UNIQUE KEY `unique_email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'816ac74b39ef617b624df1a50f0c786aace9cf17d93bc46d690b6728','admin@gather.com','Supreme','Leader'),(2,'78d8045d684abd2eece923758f3cd781489df3a48e1278982466017f','matt.beltrame8@gmail.com','Matthew','Beltrame');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-06-10 13:23:25
