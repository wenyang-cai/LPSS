-- MySQL dump 10.13  Distrib 5.5.20, for Win32 (x86)
--
-- Host: localhost    Database: library
-- ------------------------------------------------------
-- Server version	5.5.20

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `book`
--

DROP TABLE IF EXISTS `book`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `book` (
  `title` varchar(30) NOT NULL,
  `author` varchar(20) NOT NULL,
  `publisher` varchar(20) NOT NULL,
  `barcode` varchar(20) NOT NULL,
  `status` enum('Borrowed','Returned') DEFAULT NULL,
  `callNumber` varchar(15) NOT NULL,
  `nameOfShelf` varchar(10) NOT NULL,
  `libraryName` varchar(5) NOT NULL,
  `copy` smallint(6) NOT NULL,
  PRIMARY KEY (`barcode`),
  KEY `nameOfShelf` (`nameOfShelf`),
  KEY `book_title_index` (`title`) USING BTREE,
  KEY `book_barcode_index` (`barcode`) USING HASH,
  KEY `book_callNumber_index` (`callNumber`) USING HASH
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book`
--

LOCK TABLES `book` WRITE;
/*!40000 ALTER TABLE `book` DISABLE KEYS */;
INSERT INTO `book` VALUES ('AI neutal system','Jacek M. ZURADA','St Paul','012446358','Borrowed','518.515.R96','lib10A12','lib1',19),('Program design using JSP','KING, M J','Basingstoke','012850783','Returned','518.57.K51','lib10B13','lib1',8),('PHP and MySQL Web development','Welling, Luke','Ind. : Sams','013737321','Borrowed','518.561.W45','lib10D5','lib1',13),('Matering JS & JS','James Jaworski','SYBEX','013768922','Borrowed','518.59.J41','lib10D4','lib1',15),('Web Site','Robin Nobles','Prima','013828288','Returned','518.532.N75','lib10B4','lib1',20),('Visual C++','Jonathan Bates','Que','013876579','Borrowed','518.579.1.C15','lib10D6','lib1',12),('C++','Bjarne Stroustrup','Addison-Wesley','013909406','Borrowed','518.579.1.S92','lib10A1','lib1',20),('Java & XML','Brett MacLaughlin','OReilly','013937607','Returned','518.59.M16','lib10D1','lib1',14),('Practical bioinformation','Limsoon Wong','Word scientific','013954076','Returned','518.51.W87','lib10B10','lib1',10),('Algorithm design','Kleinberg, Jon M','Addison-Wesley','014045172','Returned','518.564.K61','lib10A12','lib1',10),('Database solutions ','Connolly, Thomas','Pearson','014115917','Borrowed','518.561.C75','lib10C4','lib1',10),('Database systems','Connonlly, Thomas M','Addison-Wesley','014337131','Returned','518.561.C75','lib10C14','lib1',10),('Prolog','Ivan Bratko','Addison Wesley','014350151','Borrowed','518.579.5.B82','lib10B4','lib1',10),('Java, Java, Java ','Morelli, Ralph','Prentice Hall','014366455','Returned','518.59.M84','lib10D12','lib1',1),('AI','Stuart J. Russell','Pearson Education','014377583','Returned','518.51.R96','lib10C1','lib1',20),('Game development essentials','Ahlquist, John','Thomson Learning','014388229','Returned','519.283.A28','lib10A5','lib1',20),('Java 5.0','James P. Cohoon','McGraw-Hill','014396106','Returned','518.59.C67','lib10A10','lib1',10),('Game development','Steven Rabin','Course Technology','014401755','Borrowed','519.283.R11','lib10B3','lib1',12),('Programming in Objective-C','Kochan, Stephen G','Addison-Wesley','014415001','Returned','518.579.1.K71','lib10C10','lib1',10),('Knowledge in action','Raymond Reiter','MIT press','014957624','Borrowed','518.51.R37','lib10C1','lib1',20);
/*!40000 ALTER TABLE `book` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `book_list`
--

DROP TABLE IF EXISTS `book_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `book_list` (
  `name` varchar(20) NOT NULL,
  `ID` int(11) NOT NULL,
  `barcode` varchar(20) NOT NULL,
  PRIMARY KEY (`barcode`),
  KEY `book_list_name_index` (`name`) USING BTREE,
  KEY `book_list_id_index` (`ID`) USING HASH,
  KEY `book_list_barcode_index` (`barcode`) USING HASH
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book_list`
--

LOCK TABLES `book_list` WRITE;
/*!40000 ALTER TABLE `book_list` DISABLE KEYS */;
/*!40000 ALTER TABLE `book_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `borrow_list`
--

DROP TABLE IF EXISTS `borrow_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `borrow_list` (
  `name` varchar(20) NOT NULL,
  `ID` int(11) NOT NULL,
  `barcode` varchar(20) NOT NULL,
  PRIMARY KEY (`barcode`),
  KEY `borrow_list_name_index` (`name`) USING BTREE,
  KEY `borrow_list_id_index` (`ID`) USING HASH,
  KEY `borrow_list_barcode_index` (`barcode`) USING HASH
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `borrow_list`
--

LOCK TABLES `borrow_list` WRITE;
/*!40000 ALTER TABLE `borrow_list` DISABLE KEYS */;
/*!40000 ALTER TABLE `borrow_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `general_user`
--

DROP TABLE IF EXISTS `general_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `general_user` (
  `name` varchar(20) NOT NULL,
  `ID` int(11) NOT NULL,
  `email` varchar(30) NOT NULL,
  `password` varchar(32) NOT NULL,
  `salt` varchar(32) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `email` (`email`),
  KEY `general_user_name_index` (`name`) USING BTREE,
  KEY `general_user_id_index` (`ID`) USING HASH
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `general_user`
--

LOCK TABLES `general_user` WRITE;
/*!40000 ALTER TABLE `general_user` DISABLE KEYS */;
INSERT INTO `general_user` VALUES ('user0',200811110,'user0@liv.ac.uk','65A1832B119F5EAE1FAE93C56453491C','0BA08920BD3547C7CB90FE7E'),('user1',200811111,'user1@liv.ac.uk','11A25C9FE9506215F3734F526C3C0196','F61C92C0D430D942E36706FA'),('user2',200811112,'user2@liv.ac.uk','615B8A28E1DF1DC6996CAE88D0EC021E','2F99DCEDED05C3C66B9F17DC'),('user3',200811113,'user3@liv.ac.uk','A740C3CEBD39B16301B88E69FF92CEA9','3D0A0040BBC244AA714CB01E'),('user4',200811114,'user4@liv.ac.uk','DA7E82323FA758FA710E93464E620517','79A58B2911F6A6E9D5BD21F5'),('user5',200811115,'user5@liv.ac.uk','DCEBB207AEFED003F4EE4E2E044AA719','C85E4EE8AD3FCAB1C67275C9'),('user6',200811116,'user6@liv.ac.uk','E9986542B4B7D08ECA228935D72947C8','693B697FAA6939987DF442A8'),('user7',200811117,'user7@liv.ac.uk','74FA0763D1BF90CE6CBC922BD635A982','8C23A903F3EAD0BAB16F8268');
/*!40000 ALTER TABLE `general_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `geom`
--

DROP TABLE IF EXISTS `geom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `geom` (
  `name` varchar(10) NOT NULL,
  `location` polygon NOT NULL,
  `floor` smallint(6) NOT NULL,
  `libraryName` varchar(5) NOT NULL,
  `maxNumber` smallint(6) NOT NULL,
  `Class` enum('Shelf','Map','Barrier','Entrance/Exit','BorrowedPlace') NOT NULL,
  PRIMARY KEY (`name`),
  KEY `geom_title_index` (`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `geom`
--

LOCK TABLES `geom` WRITE;
/*!40000 ALTER TABLE `geom` DISABLE KEYS */;
INSERT INTO `geom` VALUES ('lib10A1','\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0T@\0\0\0\0\0\0N@\0\0\0\0\0\0T@\0\0\0\0\0Äa@\0\0\0\0\0\0Y@\0\0\0\0\0Äa@\0\0\0\0\0\0Y@\0\0\0\0\0\0N@\0\0\0\0\0\0T@\0\0\0\0\0\0N@',0,'lib1',100,'Shelf'),('lib10A10','\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0‡z@\0\0\0\0\0\0N@\0\0\0\0\0‡z@\0\0\0\0\0Äa@\0\0\0\0\0 |@\0\0\0\0\0Äa@\0\0\0\0\0 |@\0\0\0\0\0\0N@\0\0\0\0\0‡z@\0\0\0\0\0\0N@',0,'lib1',100,'Shelf'),('lib10A11','\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0}@\0\0\0\0\0\0N@\0\0\0\0\0}@\0\0\0\0\0Äa@\0\0\0\0\0P~@\0\0\0\0\0Äa@\0\0\0\0\0P~@\0\0\0\0\0\0N@\0\0\0\0\0}@\0\0\0\0\0\0N@',0,'lib1',100,'Shelf'),('lib10A12','\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0@@\0\0\0\0\0\0N@\0\0\0\0\0@@\0\0\0\0\0Äa@\0\0\0\0\0@Ä@\0\0\0\0\0Äa@\0\0\0\0\0@Ä@\0\0\0\0\0\0N@\0\0\0\0\0@@\0\0\0\0\0\0N@',0,'lib1',100,'Shelf'),('lib10A2','\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0¿\\@\0\0\0\0\0\0N@\0\0\0\0\0¿\\@\0\0\0\0\0Äa@\0\0\0\0\0‡`@\0\0\0\0\0Äa@\0\0\0\0\0‡`@\0\0\0\0\0\0N@\0\0\0\0\0¿\\@\0\0\0\0\0\0N@',0,'lib1',100,'Shelf'),('lib10A3','\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0¿b@\0\0\0\0\0\0N@\0\0\0\0\0¿b@\0\0\0\0\0Äa@\0\0\0\0\0@e@\0\0\0\0\0Äa@\0\0\0\0\0@e@\0\0\0\0\0\0N@\0\0\0\0\0¿b@\0\0\0\0\0\0N@',0,'lib1',100,'Shelf'),('lib10A4','\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0 g@\0\0\0\0\0\0N@\0\0\0\0\0 g@\0\0\0\0\0Äa@\0\0\0\0\0†i@\0\0\0\0\0Äa@\0\0\0\0\0†i@\0\0\0\0\0\0N@\0\0\0\0\0 g@\0\0\0\0\0\0N@',0,'lib1',100,'Shelf'),('lib10A5','\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0Äk@\0\0\0\0\0\0N@\0\0\0\0\0Äk@\0\0\0\0\0Äa@\0\0\0\0\0\0n@\0\0\0\0\0Äa@\0\0\0\0\0\0n@\0\0\0\0\0\0N@\0\0\0\0\0Äk@\0\0\0\0\0\0N@',0,'lib1',100,'Shelf'),('lib10A6','\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0‡o@\0\0\0\0\0\0N@\0\0\0\0\0‡o@\0\0\0\0\0Äa@\0\0\0\0\00q@\0\0\0\0\0Äa@\0\0\0\0\00q@\0\0\0\0\0\0N@\0\0\0\0\0‡o@\0\0\0\0\0\0N@',0,'lib1',100,'Shelf'),('lib10A7','\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0 r@\0\0\0\0\0\0N@\0\0\0\0\0 r@\0\0\0\0\0Äa@\0\0\0\0\0`s@\0\0\0\0\0Äa@\0\0\0\0\0`s@\0\0\0\0\0\0N@\0\0\0\0\0 r@\0\0\0\0\0\0N@',0,'lib1',100,'Shelf'),('lib10A8','\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0Pt@\0\0\0\0\0\0N@\0\0\0\0\0Pt@\0\0\0\0\0Äa@\0\0\0\0\0êu@\0\0\0\0\0Äa@\0\0\0\0\0êu@\0\0\0\0\0\0N@\0\0\0\0\0Pt@\0\0\0\0\0\0N@',0,'lib1',100,'Shelf'),('lib10A9','\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0Äv@\0\0\0\0\0\0N@\0\0\0\0\0Äv@\0\0\0\0\0Äa@\0\0\0\0\0¿w@\0\0\0\0\0Äa@\0\0\0\0\0¿w@\0\0\0\0\0\0N@\0\0\0\0\0Äv@\0\0\0\0\0\0N@',0,'lib1',100,'Shelf'),('lib10B1','\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0¿\\@\0\0\0\0\0\0d@\0\0\0\0\0¿\\@\0\0\0\0\0\0n@\0\0\0\0\0‡`@\0\0\0\0\0\0n@\0\0\0\0\0‡`@\0\0\0\0\0\0d@\0\0\0\0\0¿\\@\0\0\0\0\0\0d@',0,'lib1',100,'Shelf'),('lib10B10','\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0@@\0\0\0\0\0\0d@\0\0\0\0\0@@\0\0\0\0\0\0n@\0\0\0\0\0@Ä@\0\0\0\0\0\0n@\0\0\0\0\0@Ä@\0\0\0\0\0\0d@\0\0\0\0\0@@\0\0\0\0\0\0d@',0,'lib1',100,'Shelf'),('lib10B11','\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0∏Ä@\0\0\0\0\0\0d@\0\0\0\0\0∏Ä@\0\0\0\0\0\0n@\0\0\0\0\0XÅ@\0\0\0\0\0\0n@\0\0\0\0\0XÅ@\0\0\0\0\0\0d@\0\0\0\0\0∏Ä@\0\0\0\0\0\0d@',0,'lib1',100,'Shelf'),('lib10B12','\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0–Å@\0\0\0\0\0\0d@\0\0\0\0\0–Å@\0\0\0\0\0\0n@\0\0\0\0\0pÇ@\0\0\0\0\0\0n@\0\0\0\0\0pÇ@\0\0\0\0\0\0d@\0\0\0\0\0–Å@\0\0\0\0\0\0d@',0,'lib1',100,'Shelf'),('lib10B13','\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0ËÇ@\0\0\0\0\0\0d@\0\0\0\0\0ËÇ@\0\0\0\0\0\0n@\0\0\0\0\0àÉ@\0\0\0\0\0\0n@\0\0\0\0\0àÉ@\0\0\0\0\0\0d@\0\0\0\0\0ËÇ@\0\0\0\0\0\0d@',0,'lib1',100,'Shelf'),('lib10B14','\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0Ñ@\0\0\0\0\0\0d@\0\0\0\0\0\0Ñ@\0\0\0\0\0\0n@\0\0\0\0\0†Ñ@\0\0\0\0\0\0n@\0\0\0\0\0†Ñ@\0\0\0\0\0\0d@\0\0\0\0\0\0Ñ@\0\0\0\0\0\0d@',0,'lib1',100,'Shelf'),('lib10B2','\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0¿b@\0\0\0\0\0\0d@\0\0\0\0\0¿b@\0\0\0\0\0\0n@\0\0\0\0\0@e@\0\0\0\0\0\0n@\0\0\0\0\0@e@\0\0\0\0\0\0d@\0\0\0\0\0¿b@\0\0\0\0\0\0d@',0,'lib1',100,'Shelf'),('lib10B3','\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0 g@\0\0\0\0\0\0d@\0\0\0\0\0 g@\0\0\0\0\0\0n@\0\0\0\0\0†i@\0\0\0\0\0\0n@\0\0\0\0\0†i@\0\0\0\0\0\0d@\0\0\0\0\0 g@\0\0\0\0\0\0d@',0,'lib1',100,'Shelf'),('lib10B4','\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0‡o@\0\0\0\0\0\0d@\0\0\0\0\0‡o@\0\0\0\0\0\0n@\0\0\0\0\00q@\0\0\0\0\0\0n@\0\0\0\0\00q@\0\0\0\0\0\0d@\0\0\0\0\0‡o@\0\0\0\0\0\0d@',0,'lib1',100,'Shelf'),('lib10B5','\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0 r@\0\0\0\0\0\0d@\0\0\0\0\0 r@\0\0\0\0\0\0n@\0\0\0\0\0`s@\0\0\0\0\0\0n@\0\0\0\0\0`s@\0\0\0\0\0\0d@\0\0\0\0\0 r@\0\0\0\0\0\0d@',0,'lib1',100,'Shelf'),('lib10B6','\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0Pt@\0\0\0\0\0\0d@\0\0\0\0\0Pt@\0\0\0\0\0\0n@\0\0\0\0\0êu@\0\0\0\0\0\0n@\0\0\0\0\0êu@\0\0\0\0\0\0d@\0\0\0\0\0Pt@\0\0\0\0\0\0d@',0,'lib1',100,'Shelf'),('lib10B7','\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0Äv@\0\0\0\0\0\0d@\0\0\0\0\0Äv@\0\0\0\0\0\0n@\0\0\0\0\0¿w@\0\0\0\0\0\0n@\0\0\0\0\0¿w@\0\0\0\0\0\0d@\0\0\0\0\0Äv@\0\0\0\0\0\0d@',0,'lib1',100,'Shelf'),('lib10B8','\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0‡z@\0\0\0\0\0\0d@\0\0\0\0\0‡z@\0\0\0\0\0\0n@\0\0\0\0\0 |@\0\0\0\0\0\0n@\0\0\0\0\0 |@\0\0\0\0\0\0d@\0\0\0\0\0‡z@\0\0\0\0\0\0d@',0,'lib1',100,'Shelf'),('lib10B9','\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0}@\0\0\0\0\0\0d@\0\0\0\0\0}@\0\0\0\0\0\0n@\0\0\0\0\0P~@\0\0\0\0\0\0n@\0\0\0\0\0P~@\0\0\0\0\0\0d@\0\0\0\0\0}@\0\0\0\0\0\0d@',0,'lib1',100,'Shelf'),('lib10C1','\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0¿\\@\0\0\0\0\0@p@\0\0\0\0\0¿\\@\0\0\0\0\0@u@\0\0\0\0\0‡`@\0\0\0\0\0@u@\0\0\0\0\0‡`@\0\0\0\0\0@p@\0\0\0\0\0¿\\@\0\0\0\0\0@p@',0,'lib1',100,'Shelf'),('lib10C10','\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0@@\0\0\0\0\0@p@\0\0\0\0\0@@\0\0\0\0\0@u@\0\0\0\0\0@Ä@\0\0\0\0\0@u@\0\0\0\0\0@Ä@\0\0\0\0\0@p@\0\0\0\0\0@@\0\0\0\0\0@p@',0,'lib1',100,'Shelf'),('lib10C11','\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0∏Ä@\0\0\0\0\0@p@\0\0\0\0\0∏Ä@\0\0\0\0\0@u@\0\0\0\0\0XÅ@\0\0\0\0\0@u@\0\0\0\0\0XÅ@\0\0\0\0\0@p@\0\0\0\0\0∏Ä@\0\0\0\0\0@p@',0,'lib1',100,'Shelf'),('lib10C12','\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0–Å@\0\0\0\0\0@p@\0\0\0\0\0–Å@\0\0\0\0\0@u@\0\0\0\0\0pÇ@\0\0\0\0\0@u@\0\0\0\0\0pÇ@\0\0\0\0\0@p@\0\0\0\0\0–Å@\0\0\0\0\0@p@',0,'lib1',100,'Shelf'),('lib10C13','\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0ËÇ@\0\0\0\0\0@p@\0\0\0\0\0ËÇ@\0\0\0\0\0@u@\0\0\0\0\0àÉ@\0\0\0\0\0@u@\0\0\0\0\0àÉ@\0\0\0\0\0@p@\0\0\0\0\0ËÇ@\0\0\0\0\0@p@',0,'lib1',100,'Shelf'),('lib10C14','\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0Ñ@\0\0\0\0\0@p@\0\0\0\0\0\0Ñ@\0\0\0\0\0@u@\0\0\0\0\0†Ñ@\0\0\0\0\0@u@\0\0\0\0\0†Ñ@\0\0\0\0\0@p@\0\0\0\0\0\0Ñ@\0\0\0\0\0@p@',0,'lib1',100,'Shelf'),('lib10C2','\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0¿b@\0\0\0\0\0@p@\0\0\0\0\0¿b@\0\0\0\0\0@u@\0\0\0\0\0@e@\0\0\0\0\0@u@\0\0\0\0\0@e@\0\0\0\0\0@p@\0\0\0\0\0¿b@\0\0\0\0\0@p@',0,'lib1',100,'Shelf'),('lib10C3','\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0 g@\0\0\0\0\0@p@\0\0\0\0\0 g@\0\0\0\0\0@u@\0\0\0\0\0†i@\0\0\0\0\0@u@\0\0\0\0\0†i@\0\0\0\0\0@p@\0\0\0\0\0 g@\0\0\0\0\0@p@',0,'lib1',100,'Shelf'),('lib10C4','\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0‡o@\0\0\0\0\0@p@\0\0\0\0\0‡o@\0\0\0\0\0@u@\0\0\0\0\00q@\0\0\0\0\0@u@\0\0\0\0\00q@\0\0\0\0\0@p@\0\0\0\0\0‡o@\0\0\0\0\0@p@',0,'lib1',100,'Shelf'),('lib10C5','\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0 r@\0\0\0\0\0@p@\0\0\0\0\0 r@\0\0\0\0\0@u@\0\0\0\0\0`s@\0\0\0\0\0@u@\0\0\0\0\0`s@\0\0\0\0\0@p@\0\0\0\0\0 r@\0\0\0\0\0@p@',0,'lib1',100,'Shelf'),('lib10C6','\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0Pt@\0\0\0\0\0@p@\0\0\0\0\0Pt@\0\0\0\0\0@u@\0\0\0\0\0êu@\0\0\0\0\0@u@\0\0\0\0\0êu@\0\0\0\0\0@p@\0\0\0\0\0Pt@\0\0\0\0\0@p@',0,'lib1',100,'Shelf'),('lib10C7','\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0Äv@\0\0\0\0\0@p@\0\0\0\0\0Äv@\0\0\0\0\0@u@\0\0\0\0\0¿w@\0\0\0\0\0@u@\0\0\0\0\0¿w@\0\0\0\0\0@p@\0\0\0\0\0Äv@\0\0\0\0\0@p@',0,'lib1',100,'Shelf'),('lib10C8','\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0‡z@\0\0\0\0\0@p@\0\0\0\0\0‡z@\0\0\0\0\0@u@\0\0\0\0\0 |@\0\0\0\0\0@u@\0\0\0\0\0 |@\0\0\0\0\0@p@\0\0\0\0\0‡z@\0\0\0\0\0@p@',0,'lib1',100,'Shelf'),('lib10C9','\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0}@\0\0\0\0\0@p@\0\0\0\0\0}@\0\0\0\0\0@u@\0\0\0\0\0P~@\0\0\0\0\0@u@\0\0\0\0\0P~@\0\0\0\0\0@p@\0\0\0\0\0}@\0\0\0\0\0@p@',0,'lib1',100,'Shelf'),('lib10D1','\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0T@\0\0\0\0\0Äv@\0\0\0\0\0\0T@\0\0\0\0\0Ä{@\0\0\0\0\0\0Y@\0\0\0\0\0Ä{@\0\0\0\0\0\0Y@\0\0\0\0\0Äv@\0\0\0\0\0\0T@\0\0\0\0\0Äv@',0,'lib1',100,'Shelf'),('lib10D10','\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0}@\0\0\0\0\0Äv@\0\0\0\0\0}@\0\0\0\0\0Ä{@\0\0\0\0\0P~@\0\0\0\0\0Ä{@\0\0\0\0\0P~@\0\0\0\0\0Äv@\0\0\0\0\0}@\0\0\0\0\0Äv@',0,'lib1',100,'Shelf'),('lib10D11','\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0@@\0\0\0\0\0Äv@\0\0\0\0\0@@\0\0\0\0\0Ä{@\0\0\0\0\0@Ä@\0\0\0\0\0Ä{@\0\0\0\0\0@Ä@\0\0\0\0\0Äv@\0\0\0\0\0@@\0\0\0\0\0Äv@',0,'lib1',100,'Shelf'),('lib10D12','\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0∏Ä@\0\0\0\0\0Äv@\0\0\0\0\0∏Ä@\0\0\0\0\0Ä{@\0\0\0\0\0XÅ@\0\0\0\0\0Ä{@\0\0\0\0\0XÅ@\0\0\0\0\0Äv@\0\0\0\0\0∏Ä@\0\0\0\0\0Äv@',0,'lib1',100,'Shelf'),('lib10D13','\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0–Å@\0\0\0\0\0Äv@\0\0\0\0\0–Å@\0\0\0\0\0Ä{@\0\0\0\0\0pÇ@\0\0\0\0\0Ä{@\0\0\0\0\0pÇ@\0\0\0\0\0Äv@\0\0\0\0\0–Å@\0\0\0\0\0Äv@',0,'lib1',100,'Shelf'),('lib10D14','\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0ËÇ@\0\0\0\0\0Äv@\0\0\0\0\0ËÇ@\0\0\0\0\0Ä{@\0\0\0\0\0àÉ@\0\0\0\0\0Ä{@\0\0\0\0\0àÉ@\0\0\0\0\0Äv@\0\0\0\0\0ËÇ@\0\0\0\0\0Äv@',0,'lib1',100,'Shelf'),('lib10D2','\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0¿\\@\0\0\0\0\0Äv@\0\0\0\0\0¿\\@\0\0\0\0\0Ä{@\0\0\0\0\0‡`@\0\0\0\0\0Ä{@\0\0\0\0\0‡`@\0\0\0\0\0Äv@\0\0\0\0\0¿\\@\0\0\0\0\0Äv@',0,'lib1',100,'Shelf'),('lib10D3','\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0¿b@\0\0\0\0\0Äv@\0\0\0\0\0¿b@\0\0\0\0\0Ä{@\0\0\0\0\0@e@\0\0\0\0\0Ä{@\0\0\0\0\0@e@\0\0\0\0\0Äv@\0\0\0\0\0¿b@\0\0\0\0\0Äv@',0,'lib1',100,'Shelf'),('lib10D4','\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0 g@\0\0\0\0\0Äv@\0\0\0\0\0 g@\0\0\0\0\0Ä{@\0\0\0\0\0†i@\0\0\0\0\0Ä{@\0\0\0\0\0†i@\0\0\0\0\0Äv@\0\0\0\0\0 g@\0\0\0\0\0Äv@',0,'lib1',100,'Shelf'),('lib10D5','\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0‡o@\0\0\0\0\0Äv@\0\0\0\0\0‡o@\0\0\0\0\0Ä{@\0\0\0\0\00q@\0\0\0\0\0Ä{@\0\0\0\0\00q@\0\0\0\0\0Äv@\0\0\0\0\0‡o@\0\0\0\0\0Äv@',0,'lib1',100,'Shelf'),('lib10D6','\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0 r@\0\0\0\0\0Äv@\0\0\0\0\0 r@\0\0\0\0\0Ä{@\0\0\0\0\0`s@\0\0\0\0\0Ä{@\0\0\0\0\0`s@\0\0\0\0\0Äv@\0\0\0\0\0 r@\0\0\0\0\0Äv@',0,'lib1',100,'Shelf'),('lib10D7','\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0Pt@\0\0\0\0\0Äv@\0\0\0\0\0Pt@\0\0\0\0\0Ä{@\0\0\0\0\0êu@\0\0\0\0\0Ä{@\0\0\0\0\0êu@\0\0\0\0\0Äv@\0\0\0\0\0Pt@\0\0\0\0\0Äv@',0,'lib1',100,'Shelf'),('lib10D8','\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0Äv@\0\0\0\0\0Äv@\0\0\0\0\0Äv@\0\0\0\0\0Ä{@\0\0\0\0\0¿w@\0\0\0\0\0Ä{@\0\0\0\0\0¿w@\0\0\0\0\0Äv@\0\0\0\0\0Äv@\0\0\0\0\0Äv@',0,'lib1',100,'Shelf'),('lib10D9','\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0‡z@\0\0\0\0\0Äv@\0\0\0\0\0‡z@\0\0\0\0\0Ä{@\0\0\0\0\0 |@\0\0\0\0\0Ä{@\0\0\0\0\0 |@\0\0\0\0\0Äv@\0\0\0\0\0‡z@\0\0\0\0\0Äv@',0,'lib1',100,'Shelf');
/*!40000 ALTER TABLE `geom` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `staff`
--

DROP TABLE IF EXISTS `staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `staff` (
  `name` varchar(20) NOT NULL,
  `ID` int(11) NOT NULL,
  `email` varchar(30) NOT NULL,
  `password` varchar(32) NOT NULL,
  `salt` varchar(32) NOT NULL,
  `position` enum('Curator','Database Administer','Senior Librarian','Junior Librarian') NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `email` (`email`),
  KEY `staff_name_index` (`name`) USING BTREE,
  KEY `staff_id_index` (`ID`) USING HASH
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff`
--

LOCK TABLES `staff` WRITE;
/*!40000 ALTER TABLE `staff` DISABLE KEYS */;
INSERT INTO `staff` VALUES ('staff0',200800000,'staff0@liv.ac.uk','801B44C37ADC0F202F8620965BD9A719','1ACBA51BC4BCBF36C127AE7F','Curator'),('staff1',200800001,'staff1@liv.ac.uk','E944BEA6DC31CEDFD267350D55C3D629','88756C8C85CFA7736A2C558D','Curator'),('staff2',200800002,'staff2@liv.ac.uk','2C2EDA03806BDE4F2EBE0FA0D3FF17D2','62C6FC81C4C73F67475C31E1','Database Administer'),('staff3',200800003,'staff3@liv.ac.uk','46E84AA627C4AB70A1FC8FB070F9C426','2E2093DBAAD10D681E52FE87','Database Administer'),('staff4',200800004,'staff4@liv.ac.uk','4E10D75569EA6C681E2715B99755BB23','91746BD01C6A7F70D78531B7','Senior Librarian'),('staff5',200800005,'staff5@liv.ac.uk','C1B31C982DC70A0C5984F6D762C98A69','86174485639E0F40597EB12B','Senior Librarian'),('staff6',200800006,'staff6@liv.ac.uk','B40FB7EE203F3178B42D74196774068A','62B2DBB0F52E8C4439EE90A2','Junior Librarian'),('staff7',200800007,'staff7@liv.ac.uk','F8F9CDD608F6C34B80E69FD411ECF9BF','2CEA975E0FFA5300DDEF1F1D','Junior Librarian');
/*!40000 ALTER TABLE `staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `to_do_list`
--

DROP TABLE IF EXISTS `to_do_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `to_do_list` (
  `listNO` smallint(6) NOT NULL,
  `name` varchar(20) NOT NULL,
  `ID` int(11) NOT NULL,
  `barcode` varchar(20) NOT NULL,
  PRIMARY KEY (`listNO`),
  KEY `ID` (`ID`),
  KEY `to_do_list_id_index` (`listNO`) USING HASH
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `to_do_list`
--

LOCK TABLES `to_do_list` WRITE;
/*!40000 ALTER TABLE `to_do_list` DISABLE KEYS */;
/*!40000 ALTER TABLE `to_do_list` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2012-05-07 15:28:20
