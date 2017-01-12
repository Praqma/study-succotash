# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 127.0.0.1 (MySQL 5.6.32)
# Database: olhus
# Generation Time: 2016-10-22 10:46:27 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table ol
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ol`;

CREATE TABLE `ol` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(200) DEFAULT NULL,
  `brewery` varchar(200) DEFAULT NULL,
  `percent` double NOT NULL,
  `category` varchar(50) DEFAULT NULL,
  `description` text,
  `active` tinyint(1) DEFAULT NULL,
  `on_tap` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `ol` WRITE;
/*!40000 ALTER TABLE `ol` DISABLE KEYS */;

INSERT INTO `ol` (`id`, `name`, `brewery`, `percent`, `category`, `description`, `active`, `on_tap`)
VALUES
	(1,'Black','Brains',4.1,'1','Description',1,0),
	(2,'Westons Cider','Westons Cider',6,'1','Description',1,1),
	(3,'Abbot Ale','Greene King',5,'1','Description',1,1),
	(4,'Limfjordsporter','Thisted',7.9,'1','Description',1,1),
	(5,'Westmalle Dubbel','Westmalle',7,'1','Description',1,1),
	(6,'Pale Ale','Sierra Nevada',5.6,'1','Description',1,1),
	(7,'Punk IPA','BrewDog',5.6,'1','Description',1,1),
	(8,'Pilsner','Warsteiner',4.8,'1','Description',1,1),
	(9,'Weissbier','König Ludwig',5.5,'1','Description',1,1),
	(10,'Traitors\' Gate','Fuller\'s',4.5,'2','Description',1,1),
	(11,'Rug','Herslev Bryghus',6.4,'2','Description',1,1),
	(12,'Old Speckled Hen','Greene King',5.3,'2','Description',1,1),
	(13,'Twisted Verbena ','Edge',5.9,'2','Description',1,1),
	(14,'Dark Alliance','Moor Beer',4.5,'2','Description',1,1),
	(15,'IDA','Herslev Bryghus',6.2,'2','Description',1,1),
	(16,'Gambrinus','Hancock',9.5,'2','Description',1,1),
	(17,'X-Porter','Huvila',7,'2','Description',1,1),
	(18,'Need Lager','Flying Couch',5,'5','Description',1,1),
	(19,'Nordvest Fest','Flying Couch',5,'5','Description',1,1),
	(20,'testBeer','Best Brewery',0,'0','description',1,1);

/*!40000 ALTER TABLE `ol` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table ol_categories
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ol_categories`;

CREATE TABLE `ol_categories` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `ol_categories` WRITE;
/*!40000 ALTER TABLE `ol_categories` DISABLE KEYS */;

INSERT INTO `ol_categories` (`id`, `name`)
VALUES
	(1,'Fasteøl'),
	(2,'Gæsteøl'),
	(3,'Cask'),
	(4,'Kommende Fasteøl'),
	(5,'Kommende Gæsteøl'),
	(6,'Kommende Cask');

/*!40000 ALTER TABLE `ol_categories` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
