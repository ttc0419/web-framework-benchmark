-- MySQL dump 10.13  Distrib 8.0.26, for Win64 (x86_64)
--
-- Host: localhost    Database: antique_record
-- ------------------------------------------------------
-- Server version	8.0.26

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `genres`
--

DROP TABLE IF EXISTS `genres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `genres` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `genres_name_unique` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `genres`
--

LOCK TABLES `genres` WRITE;
/*!40000 ALTER TABLE `genres` DISABLE KEYS */;
INSERT INTO `genres` VALUES (1,'Blues'),(2,'Country'),(3,'Dance'),(4,'Hip-Hop'),(5,'Jazz'),(6,'Rhythm and Blues'),(7,'Rock'),(8,'Rock and Roll'),(9,'Soul');
/*!40000 ALTER TABLE `genres` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `records`
--

DROP TABLE IF EXISTS `records`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `records` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `genre_id` int unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `artist` varchar(255) NOT NULL,
  `year` int unsigned NOT NULL,
  `number_of_discs` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `records_genre_id_fk_idx` (`genre_id`),
  CONSTRAINT `records_genre_id_fk` FOREIGN KEY (`genre_id`) REFERENCES `genres` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `records`
--

LOCK TABLES `records` WRITE;
/*!40000 ALTER TABLE `records` DISABLE KEYS */;
INSERT INTO `records` VALUES (1,9,'cursus purus. Nullam scelerisque neque sed sem','Ignatius Moreno',1966,2),(2,1,'dui nec urna suscipit nonummy. Fusce fermentum','Samuel Valenzuela',1989,4),(3,8,'luctus et ultrices posuere cubilia Curae Phasellus ornare.','Gemma Nelson',1997,3),(4,1,'Morbi sit amet massa. Quisque porttitor eros nec tellus.','Deacon Moreno',1989,1),(5,8,'quis lectus. Nullam suscipit, est ac facilisis facilisis, magna tellus','Aubrey Baldwin',1978,1),(6,5,'Nam tempor diam dictum sapien. Aenean massa. Integer vitae nibh.','Regan Warren',1999,3),(7,5,'lorem semper auctor. Mauris vel turpis. Aliquam adipiscing lobortis risus.','Len Richard',1964,3),(8,6,'eget laoreet posuere, enim nisl elementum','Steven Rosa',1989,2),(9,3,'quis accumsan convallis, ante lectus convallis est, vitae','Richard Patel',1963,1),(10,7,'at, libero. Morbi accumsan laoreet ipsum.','Seth Cantrell',1966,3),(11,9,'ridiculus mus. Proin vel arcu eu odio tristique pharetra. Quisque','Richard Mcleod',1972,3),(12,3,'id, mollis nec, cursus a, enim.','Jack Dillon',1973,4),(13,2,'sit amet ornare lectus justo eu','Kitra Soto',1965,3),(14,3,'mi. Duis risus odio, auctor vitae,','Keith Acevedo',1978,3),(15,3,'Quisque varius. Nam porttitor scelerisque neque. Nullam','Magee Kline',1990,3),(16,8,'pellentesque massa lobortis ultrices. Vivamus rhoncus. Donec est. Nunc ullamcorper,','Martin Benson',1999,4),(17,4,'ac orci. Ut semper pretium neque. Morbi quis urna. Nunc','Murphy Pugh',1991,2),(18,7,'mi lacinia mattis. Integer eu lacus.','Erin Rojas',1965,2),(19,8,'a, facilisis non, bibendum sed, est. Nunc','Alma Blake',1977,3),(20,1,'libero. Proin mi. Aliquam gravida mauris','Macey Cook',1992,3),(21,1,'eget ipsum. Suspendisse sagittis. Nullam vitae diam. Proin dolor. Nulla','Kelsey Norton',1967,3),(22,1,'Duis volutpat nunc sit amet metus. Aliquam erat','Morgan Vinson',1994,2),(23,1,'diam. Sed diam lorem, auctor quis, tristique ac, eleifend','Judah Rasmussen',1986,1),(24,2,'diam luctus lobortis. Class aptent taciti sociosqu ad litora torquent','Ciara Velasquez',1997,3),(25,7,'Fusce aliquet magna a neque. Nullam ut','Linda Manning',1977,1),(26,1,'Praesent interdum ligula eu enim. Etiam imperdiet dictum','Gay Crane',1968,4),(27,1,'ut dolor dapibus gravida. Aliquam tincidunt, nunc ac mattis','Whoopi Barker',1988,1),(28,9,'eleifend, nunc risus varius orci, in consequat enim','Ulla Bruce',1970,4),(29,5,'Mauris magna. Duis dignissim tempor arcu. Vestibulum','Elijah Barrett',1984,2),(30,7,'montes, nascetur ridiculus mus. Proin vel arcu','Ian Townsend',1981,3),(31,7,'ut mi. Duis risus odio, auctor vitae,','Sarah Navarro',1997,1),(32,5,'Proin dolor. Nulla semper tellus id nunc interdum feugiat.','Caldwell Willis',1996,4),(33,4,'ante ipsum primis in faucibus orci luctus et ultrices posuere','Kyle Wooten',1971,2),(34,4,'a nunc. In at pede. Cras vulputate velit eu sem.','Echo Hernandez',1963,1),(35,7,'pellentesque a, facilisis non, bibendum sed, est.','Maite Bishop',1971,3),(36,6,'sit amet, consectetuer adipiscing elit. Aliquam auctor,','Odysseus George',1986,4),(37,6,'in, dolor. Fusce feugiat. Lorem ipsum dolor sit','Mary Andrews',1973,3),(38,4,'amet, consectetuer adipiscing elit. Aliquam auctor, velit eget laoreet posuere,','Ferdinand Castillo',1997,1),(39,7,'luctus, ipsum leo elementum sem, vitae aliquam eros turpis non','Lenore Wright',1995,3),(40,4,'vestibulum. Mauris magna. Duis dignissim tempor','Quamar Holmes',1996,1),(41,3,'In at pede. Cras vulputate velit eu sem.','Meghan Goodwin',1973,3),(42,7,'In faucibus. Morbi vehicula. Pellentesque tincidunt tempus risus.','Luke Kane',1974,4),(43,3,'Curabitur massa. Vestibulum accumsan neque et nunc. Quisque ornare','Macon Jones',1991,4),(44,1,'ante lectus convallis est, vitae sodales nisi magna','Irene Chen',1978,4),(45,9,'Mauris vestibulum, neque sed dictum eleifend, nunc risus','Zephania Page',1996,1),(46,6,'elit sed consequat auctor, nunc nulla vulputate dui, nec tempus','Caleb Casey',1967,2),(47,7,'Aliquam erat volutpat. Nulla facilisis. Suspendisse commodo','Reuben Holman',1986,2),(48,8,'venenatis vel, faucibus id, libero. Donec consectetuer','Bruno Carroll',1983,2),(49,3,'feugiat tellus lorem eu metus. In lorem. Donec elementum, lorem','Sydnee Trujillo',1993,3),(50,3,'Curae Donec tincidunt. Donec vitae erat vel','Karleigh Miles',1999,4),(51,7,'in sodales elit erat vitae risus. Duis a mi','Azalia Lynn',1994,4),(52,1,'vel, mauris. Integer sem elit, pharetra ut,','Darrel Heath',1995,1),(53,7,'Nullam enim. Sed nulla ante, iaculis nec, eleifend non,','Lynn Barry',1995,2),(54,6,'augue. Sed molestie. Sed id risus quis','Upton Blanchard',1979,2),(55,4,'lacinia at, iaculis quis, pede. Praesent eu dui. Cum sociis','Leah Santana',1995,2),(56,2,'convallis, ante lectus convallis est, vitae','Ethan Patel',1985,3),(57,5,'mauris sapien, cursus in, hendrerit consectetuer, cursus','Fatima Wright',1980,1),(58,1,'rutrum non, hendrerit id, ante. Nunc mauris','Mechelle Pickett',1974,4),(59,3,'ligula eu enim. Etiam imperdiet dictum magna. Ut','Elton Luna',1978,4),(60,1,'quam. Curabitur vel lectus. Cum sociis natoque','Quail Nunez',1994,3),(61,8,'cursus vestibulum. Mauris magna. Duis dignissim','Nehru Hewitt',1987,2),(62,2,'quis, tristique ac, eleifend vitae, erat.','Ivor Patrick',1993,2),(63,1,'quis urna. Nunc quis arcu vel quam dignissim pharetra. Nam','Kalia Riddle',1981,3),(64,8,'non, hendrerit id, ante. Nunc mauris sapien, cursus in, hendrerit','Summer Whitney',1977,3),(65,9,'vulputate ullamcorper magna. Sed eu eros. Nam consequat dolor vitae','Matthew Obrien',1997,3),(66,3,'ac turpis egestas. Fusce aliquet magna','Cora Vasquez',1975,3),(67,6,'nostra, per inceptos hymenaeos. Mauris ut quam vel sapien','Alec Moreno',1964,2),(68,8,'elit, pharetra ut, pharetra sed, hendrerit a, arcu. Sed et','Mason Maldonado',1977,1),(69,4,'tortor. Nunc commodo auctor velit. Aliquam nisl. Nulla','Tobias Burks',1979,3),(70,4,'malesuada vel, venenatis vel, faucibus id, libero. Donec consectetuer','Adam Mccoy',1967,3),(71,6,'tempor, est ac mattis semper, dui','Miranda Noel',1989,2),(72,1,'Aliquam ornare, libero at auctor ullamcorper, nisl arcu','Leroy Mckenzie',1966,2),(73,5,'magna. Nam ligula elit, pretium et, rutrum non, hendrerit id,','Kasper Stanton',1972,2),(74,9,'aliquet libero. Integer in magna. Phasellus dolor elit, pellentesque a,','Adara Randolph',1999,1),(75,3,'blandit viverra. Donec tempus, lorem fringilla ornare placerat, orci','Michael Nunez',1976,1),(76,4,'in consequat enim diam vel arcu. Curabitur','Venus Shields',1992,3),(77,4,'semper pretium neque. Morbi quis urna. Nunc quis','Autumn Schmidt',1998,2),(78,2,'id, libero. Donec consectetuer mauris id sapien. Cras','Kane Moon',1990,1),(79,6,'nulla. Integer urna. Vivamus molestie dapibus ligula. Aliquam','Isaac Cruz',1964,1),(80,9,'fringilla purus mauris a nunc. In at pede. Cras','Belle Everett',1970,2),(81,2,'Lorem ipsum dolor sit amet, consectetuer adipiscing','Finn Atkins',1986,2),(82,9,'nonummy ipsum non arcu. Vivamus sit amet','Brady Moreno',1979,1),(83,7,'id, libero. Donec consectetuer mauris id sapien. Cras dolor','Donna Bird',1986,2),(84,5,'quis diam luctus lobortis. Class aptent','Mohammad Schneider',1963,3),(85,3,'enim. Etiam imperdiet dictum magna. Ut tincidunt orci','Zeus Odonnell',1971,2),(86,5,'vel lectus. Cum sociis natoque penatibus et magnis dis parturient','Quyn Malone',1987,4),(87,4,'auctor vitae, aliquet nec, imperdiet nec, leo. Morbi neque tellus,','Raphael Bell',1992,4),(88,9,'est arcu ac orci. Ut semper','Coby Riley',1991,1),(89,2,'at, nisi. Cum sociis natoque penatibus et magnis dis','Valentine Beasley',1976,1),(90,2,'aliquet. Phasellus fermentum convallis ligula. Donec','Quyn Graham',1988,2),(91,3,'lobortis mauris. Suspendisse aliquet molestie tellus.','Constance Cash',1978,1),(92,5,'Duis volutpat nunc sit amet metus. Aliquam','Vladimir Hayes',1998,1),(93,9,'sit amet risus. Donec egestas. Aliquam nec enim. Nunc','Tashya Greer',1988,4),(94,6,'nisi magna sed dui. Fusce aliquam, enim nec','Malik Singleton',1998,3),(95,6,'Nullam ut nisi a odio semper cursus. Integer mollis. Integer','Dillon Huffman',1995,3),(96,8,'semper pretium neque. Morbi quis urna. Nunc quis arcu','Oren Abbott',1963,3),(97,2,'molestie. Sed id risus quis diam luctus','Orlando Dejesus',1989,3),(98,2,'felis eget varius ultrices, mauris ipsum porta elit,','Quinn Newman',1991,3),(99,9,'nulla at sem molestie sodales. Mauris blandit','Gretchen Blevins',1998,4),(100,3,'sit amet, consectetuer adipiscing elit. Aliquam auctor, velit eget laoreet','Violet Graham',1999,3);
/*!40000 ALTER TABLE `records` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-10-16 14:18:05
