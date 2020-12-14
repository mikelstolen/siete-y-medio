CREATE DATABASE  IF NOT EXISTS `proyecto` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `proyecto`;
-- MySQL dump 10.13  Distrib 8.0.21, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: proyecto
-- ------------------------------------------------------
-- Server version	8.0.21

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
-- Table structure for table `accion`
--

DROP TABLE IF EXISTS `accion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accion` (
  `idaccion` int NOT NULL AUTO_INCREMENT,
  `id_tipoaccion` int DEFAULT NULL,
  `carta_robada` int DEFAULT NULL,
  `sumacartas` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`idaccion`),
  KEY `FK_ACCION_TIPO_idx` (`id_tipoaccion`),
  KEY `FK_CARTA_ACCION_idx` (`carta_robada`),
  CONSTRAINT `FK_ACCION_TIPO` FOREIGN KEY (`id_tipoaccion`) REFERENCES `tipo_accion` (`idtipo_accion`),
  CONSTRAINT `FK_CARTA_ACCION` FOREIGN KEY (`carta_robada`) REFERENCES `cartas` (`idcartas`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accion`
--

LOCK TABLES `accion` WRITE;
/*!40000 ALTER TABLE `accion` DISABLE KEYS */;
/*!40000 ALTER TABLE `accion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bot`
--

DROP TABLE IF EXISTS `bot`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bot` (
  `idbot` int NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idbot`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bot`
--

LOCK TABLES `bot` WRITE;
/*!40000 ALTER TABLE `bot` DISABLE KEYS */;
/*!40000 ALTER TABLE `bot` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cartas`
--

DROP TABLE IF EXISTS `cartas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cartas` (
  `idcartas` int NOT NULL AUTO_INCREMENT,
  `numero_carta` int DEFAULT NULL,
  `tipo` int DEFAULT NULL,
  `valor` decimal(10,2) DEFAULT NULL,
  `es_activa` int DEFAULT NULL,
  PRIMARY KEY (`idcartas`),
  KEY `FK_CARTAS_TIPO_idx` (`tipo`),
  CONSTRAINT `FK_CARTAS_TIPO` FOREIGN KEY (`tipo`) REFERENCES `tipo_carta` (`idtipo_carta`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cartas`
--

LOCK TABLES `cartas` WRITE;
/*!40000 ALTER TABLE `cartas` DISABLE KEYS */;
/*!40000 ALTER TABLE `cartas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jugador`
--

DROP TABLE IF EXISTS `jugador`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jugador` (
  `idjugador` int NOT NULL AUTO_INCREMENT,
  `idusuario` int DEFAULT NULL,
  `idbot` int DEFAULT NULL,
  PRIMARY KEY (`idjugador`),
  KEY `FK_JUGADOR_USUARIO_idx` (`idusuario`),
  KEY `FK_JUGADOR_BOT_idx` (`idbot`),
  CONSTRAINT `FK_JUGADOR_BOT` FOREIGN KEY (`idbot`) REFERENCES `bot` (`idbot`),
  CONSTRAINT `FK_JUGADOR_USUARIO` FOREIGN KEY (`idusuario`) REFERENCES `usuario` (`idusuario`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jugador`
--

LOCK TABLES `jugador` WRITE;
/*!40000 ALTER TABLE `jugador` DISABLE KEYS */;
/*!40000 ALTER TABLE `jugador` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `participante`
--

DROP TABLE IF EXISTS `participante`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `participante` (
  `id_participante` int NOT NULL AUTO_INCREMENT,
  `id_jugador` int DEFAULT NULL,
  `id_partida` int DEFAULT NULL,
  PRIMARY KEY (`id_participante`),
  KEY `FK_PARTIDA_idx` (`id_partida`),
  KEY `FK_REL_JUGADOR_idx` (`id_jugador`),
  CONSTRAINT `FK_PARTIDA` FOREIGN KEY (`id_partida`) REFERENCES `partida` (`idpartida`),
  CONSTRAINT `FK_REL_JUGADOR` FOREIGN KEY (`id_jugador`) REFERENCES `jugador` (`idjugador`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `participante`
--

LOCK TABLES `participante` WRITE;
/*!40000 ALTER TABLE `participante` DISABLE KEYS */;
/*!40000 ALTER TABLE `participante` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `partida`
--

DROP TABLE IF EXISTS `partida`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `partida` (
  `idpartida` int NOT NULL AUTO_INCREMENT,
  `nombre_sala` varchar(45) DEFAULT NULL,
  `numero_jugadores` int DEFAULT NULL,
  `apuesta_minima` decimal(10,2) DEFAULT NULL,
  `condiciones_victoria` varchar(45) DEFAULT NULL,
  `ganador_partida` int DEFAULT NULL,
  `hora_inicio` datetime DEFAULT NULL,
  `hora_fin` datetime DEFAULT NULL,
  `duracion` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idpartida`),
  KEY `FK_PARTIDA_PARTICIPANTE_idx` (`ganador_partida`),
  CONSTRAINT `FK_PARTIDA_PARTICIPANTE` FOREIGN KEY (`ganador_partida`) REFERENCES `participante` (`id_participante`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `partida`
--

LOCK TABLES `partida` WRITE;
/*!40000 ALTER TABLE `partida` DISABLE KEYS */;
/*!40000 ALTER TABLE `partida` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `puntuacion`
--

DROP TABLE IF EXISTS `puntuacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `puntuacion` (
  `idpuntuacion` int NOT NULL AUTO_INCREMENT,
  `idparticipante` int DEFAULT NULL,
  `id_partida` int DEFAULT NULL,
  `puntuacion` decimal(10,2) DEFAULT NULL,
  `ganador` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idpuntuacion`),
  KEY `FK_PUNTUAICON_JUGADOR_idx` (`idparticipante`),
  KEY `FK_PUNTUACION_PARTIDA_idx` (`id_partida`),
  CONSTRAINT `FK_PUNTUACION_JUGADOR` FOREIGN KEY (`idparticipante`) REFERENCES `participante` (`id_participante`),
  CONSTRAINT `FK_PUNTUACION_PARTIDA` FOREIGN KEY (`id_partida`) REFERENCES `partida` (`idpartida`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `puntuacion`
--

LOCK TABLES `puntuacion` WRITE;
/*!40000 ALTER TABLE `puntuacion` DISABLE KEYS */;
/*!40000 ALTER TABLE `puntuacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rel_turno_accion`
--

DROP TABLE IF EXISTS `rel_turno_accion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rel_turno_accion` (
  `idrel_turno_accion` int NOT NULL AUTO_INCREMENT,
  `iturno` int DEFAULT NULL,
  `idaccion` int DEFAULT NULL,
  PRIMARY KEY (`idrel_turno_accion`),
  KEY `FK_REL_TURNO_idx` (`iturno`),
  KEY `FK_REL_ACCION_idx` (`idaccion`),
  CONSTRAINT `FK_REL_ACCION` FOREIGN KEY (`idaccion`) REFERENCES `accion` (`idaccion`),
  CONSTRAINT `FK_REL_TURNO` FOREIGN KEY (`iturno`) REFERENCES `turnos` (`idturnos`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rel_turno_accion`
--

LOCK TABLES `rel_turno_accion` WRITE;
/*!40000 ALTER TABLE `rel_turno_accion` DISABLE KEYS */;
/*!40000 ALTER TABLE `rel_turno_accion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_accion`
--

DROP TABLE IF EXISTS `tipo_accion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipo_accion` (
  `idtipo_accion` int NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idtipo_accion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_accion`
--

LOCK TABLES `tipo_accion` WRITE;
/*!40000 ALTER TABLE `tipo_accion` DISABLE KEYS */;
/*!40000 ALTER TABLE `tipo_accion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_carta`
--

DROP TABLE IF EXISTS `tipo_carta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipo_carta` (
  `idtipo_carta` int NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idtipo_carta`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_carta`
--

LOCK TABLES `tipo_carta` WRITE;
/*!40000 ALTER TABLE `tipo_carta` DISABLE KEYS */;
/*!40000 ALTER TABLE `tipo_carta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `turnos`
--

DROP TABLE IF EXISTS `turnos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `turnos` (
  `idturnos` int NOT NULL AUTO_INCREMENT,
  `numero_turno` int DEFAULT NULL,
  `carta_inicial` int DEFAULT NULL,
  `idparticipante` int DEFAULT NULL,
  `puntos_inicio` decimal(10,2) DEFAULT NULL,
  `apuesta` decimal(10,2) DEFAULT NULL,
  `puntos_final` decimal(10,2) DEFAULT NULL,
  `resultado` varchar(45) DEFAULT NULL,
  `orden_jugador` int DEFAULT NULL,
  `es_banca` int DEFAULT NULL,
  `idpartida` int DEFAULT NULL,
  PRIMARY KEY (`idturnos`),
  KEY `FK_TURNO_CARTA_idx` (`carta_inicial`),
  KEY `fk_turnos_jugador_idx` (`idparticipante`),
  KEY `FK_TURNOS_PARTIDA_idx` (`idpartida`),
  CONSTRAINT `FK_TURNO_CARTA` FOREIGN KEY (`carta_inicial`) REFERENCES `cartas` (`idcartas`),
  CONSTRAINT `fk_turnos_jugador` FOREIGN KEY (`idparticipante`) REFERENCES `participante` (`id_participante`),
  CONSTRAINT `FK_TURNOS_PARTIDA` FOREIGN KEY (`idpartida`) REFERENCES `partida` (`idpartida`)
) ENGINE=InnoDB AUTO_INCREMENT=175 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `turnos`
--

LOCK TABLES `turnos` WRITE;
/*!40000 ALTER TABLE `turnos` DISABLE KEYS */;
/*!40000 ALTER TABLE `turnos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario` (
  `idusuario` int NOT NULL,
  `username` varchar(45) NOT NULL,
  `password` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idusuario`),
  UNIQUE KEY `Nickname_UNIQUE` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-12-06 12:26:56



-- Insert Tipo_Cartas
 insert into tipo_carta values(1,'Oros');
 insert into tipo_carta values(2,'Copas');
 insert into tipo_carta values(3,'Espadas');
 insert into tipo_carta values(4,'Bastos');

-- Insert Cartas
insert into cartas values(1,1,1,1,1);
insert into cartas values(2,2,1,2,1);
insert into cartas values(3,3,1,3,1);
insert into cartas values(4,4,1,4,1);
insert into cartas values(5,5,1,5,1);
insert into cartas values(6,6,1,6,1);
insert into cartas values(7,7,1,7,1);
insert into cartas values(8,8,1,8,0);
insert into cartas values(9,9,1,9,0);
insert into cartas values(10,10,1,0.5,1);
insert into cartas values(11,11,1,0.5,1);
insert into cartas values(12,12,1,0.5,1);

insert into cartas values(13,1,2,1,1);
insert into cartas values(14,2,2,2,1);
insert into cartas values(15,3,2,3,1);
insert into cartas values(16,4,2,4,1);
insert into cartas values(17,5,2,5,1);
insert into cartas values(18,6,2,6,1);
insert into cartas values(19,7,2,7,1);
insert into cartas values(20,8,2,8,0);
insert into cartas values(21,9,2,9,0);
insert into cartas values(22,10,2,0.5,1);
insert into cartas values(23,11,2,0.5,1);
insert into cartas values(24,12,2,0.5,1);


insert into cartas values(25,1,3,1,1);
insert into cartas values(26,2,3,2,1);
insert into cartas values(27,3,3,3,1);
insert into cartas values(28,4,3,4,1);
insert into cartas values(29,5,3,5,1);
insert into cartas values(30,6,3,6,1);
insert into cartas values(31,7,3,7,1);
insert into cartas values(32,8,3,8,0);
insert into cartas values(33,9,3,9,0);
insert into cartas values(34,10,3,0.5,1);
insert into cartas values(35,11,3,0.5,1);
insert into cartas values(36,12,3,0.5,1);

insert into cartas values(37,1,4,1,1);
insert into cartas values(38,2,4,2,1);
insert into cartas values(39,3,4,3,1);
insert into cartas values(40,4,4,4,1);
insert into cartas values(41,5,4,5,1);
insert into cartas values(42,6,4,6,1);
insert into cartas values(43,7,4,7,1);
insert into cartas values(44,8,4,8,0);
insert into cartas values(45,9,4,9,0);
insert into cartas values(46,10,4,0.5,1);
insert into cartas values(47,11,4,0.5,1);
insert into cartas values(48,12,4,0.5,1);

/*
select idcartas,numero_carta,t.descripcion,
CASE
    WHEN valor like '0.%' THEN truncate(valor,1)
    else round(valor,0)
    end as valor,
CASE
    WHEN es_activa = 1 THEN "SI"
    WHEN es_activa = 0 THEN "NO"
    end as es_activa
 from cartas c
inner join tipo_carta t on t.idtipo_carta=c.tipo

*/

insert into bot  values (1,'BotRojo');
insert into bot  values (2,'BotAzul');
insert into bot  values (3,'BotVerde');
insert into bot  values (4,'BotAmarillo');
insert into bot  values (5,'BotBeige');
insert into bot  values (6,'BotNegro');
insert into bot  values (7,'BotBlando');


insert into usuario (idusuario,username,password,email) values(1,'Rafa','qwerty','rafa@gmail.com');
insert into usuario (idusuario,username,password,email) values(2,'Jenni','asdfg','jenni@gmail.com');
insert into usuario (idusuario,username,password,email) values(3,'Leandro','qazxww','lean@gmail.com');
insert into usuario (idusuario,username,password,email) values(4,'Belen','wsxzaq','mbelen@gmail.com');
insert into usuario (idusuario,username,password,email) values(5,'Xavi','rfvbgt','xavi@gmail.com');
insert into usuario (idusuario,username,password,email) values(6,'Jordi','tgbvfr','jorge@gmail.com');
insert into usuario (idusuario,username,password,email) values(7,'Lluis','yhnmju','lluis@gmail.com');


insert into jugador (IDJUGADOR,idusuario) values (1,1);
insert into jugador (IDJUGADOR,idusuario) values (2,2);
insert into jugador (IDJUGADOR,idusuario) values (3,3);
insert into jugador (IDJUGADOR,idusuario) values (4,4);
insert into jugador (IDJUGADOR,idusuario) values (5,5);
insert into jugador (IDJUGADOR,idusuario) values (6,6);
insert into jugador (IDJUGADOR,idusuario) values (7,7);
insert into jugador (IDJUGADOR,idbot) values (8,1);
insert into jugador (IDJUGADOR,idbot) values (9,2);
insert into jugador (IDJUGADOR,idbot) values (10,3);
insert into jugador (IDJUGADOR,idbot) values (11,4);
insert into jugador (IDJUGADOR,idbot) values (12,5);
insert into jugador (IDJUGADOR,idbot) values (13,6);
insert into jugador (IDJUGADOR,idbot) values (14,7);


/* PARTIDA 1 */

-- select * from participante
insert into partida(idpartida,nombre_sala,numero_jugadores,apuesta_minima,condiciones_victoria,hora_inicio,hora_fin)
values(1,'Sala AWS',4,1,'30 Rondas max. Gana la puntuación mas alta.',(select now() from dual),(select DATE_ADD(NOW(), INTERVAL 1 HOUR) from dual));

update partida set duracion= TIMESTAMPDIFF(HOUR,hora_inicio,hora_fin) where idpartida>0;

insert into participante  values (1,1,1);
insert into participante  values (2,2,1);
insert into participante  values (3,3,1);
insert into participante  values (4,4,1);

insert into turnos (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)   values(1,3,1,20,2,18,'pierde turno',5,0,1);
insert into turnos  (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)values(1,5,2,20,2,22,'gana turno',4,0,1);
insert into turnos  (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)values(1,2,3,20,2,18,'pierde turno',3,0,1);
insert into turnos (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)values(1,4,4,20,null,22,null,1,1,1);
insert into turnos (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA) values(2,3,1,18,5,23,null,5,0,1);
insert into turnos (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)values(2,5,2,22,10,32,null,4,0,1);
insert into turnos (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)values(2,2,3,18,7,11,null,3,0,1);
insert into turnos (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)values(2,4,4,22,null,18,null,1,1,1);
insert into turnos (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA) values(3,24,1,23,2,21,null,5,0,1);
insert into turnos (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)values(3,27,2,32,3,29,null,4,0,1);
insert into turnos (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)values(3,44,3,11,4,7,null,3,0,1);
insert into turnos (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)values(3,12,4,18,null,27,null,1,1,1);
insert into turnos (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA) values(4,24,1,21,7,14,null,5,0,1);
insert into turnos (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)values(4,27,2,32,null,67,null,4,1,1);
insert into turnos (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)values(4,44,3,11,11,0,null,3,0,1);
insert into turnos (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)values(4,12,4,27,17,10,null,1,0,1);
insert into turnos (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA) values(5,14,1,14,8,6,null,5,0,1);
insert into turnos (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)values(5,24,2,67,null,83,null,4,1,1);
insert into turnos (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)values(5,16,4,10,10,0,null,1,0,1);
insert into turnos (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA) values(6,14,1,6,6,0,null,5,0,1);
insert into turnos (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)values(6,24,2,74,null,80,null,4,1,1);

update partida set ganador_partida = 2 where  idpartida=1;
/* PARTIDA 2 */

-- select * from participante
insert into partida(idpartida,nombre_sala,numero_jugadores,apuesta_minima,condiciones_victoria,hora_inicio,hora_fin)
values(2,'Sala AMS',4,1,'30 Rondas max. Gana la puntuación mas alta.',(select now() from dual),(select DATE_ADD(NOW(), INTERVAL 3 HOUR) from dual));

update partida set duracion= TIMESTAMPDIFF(HOUR,hora_inicio,hora_fin) where idpartida>0;


insert into participante values (5,6,2);
insert into participante  values (6,12,2);
insert into participante  values (7,13,2);

insert into turnos (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)   values(1,(select idcartas from cartas where es_activa=1 order by rand() limit 1),5,20,3,17,null,3,0,2);
insert into turnos  (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)values(1,(select idcartas from cartas where es_activa=1 order by rand() limit 1),6,20,2,22,null,2,0,2);
insert into turnos  (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)values(1,(select idcartas from cartas where es_activa=1 order by rand() limit 1),7,20,null,21,null,1,1,2);

insert into turnos (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)   values(2,(select idcartas from cartas where es_activa=1 order by rand() limit 1),5,17,5,22,null,3,0,2);
insert into turnos  (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)values(2,(select idcartas from cartas where es_activa=1 order by rand() limit 1),6,22,4,18,null,2,0,2);
insert into turnos  (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)values(2,(select idcartas from cartas where es_activa=1 order by rand() limit 1),7,21,null,20,null,1,1,2);

insert into turnos (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)   values(3,(select idcartas from cartas where es_activa=1 order by rand() limit 1),5,22,3,19,null,3,0,2);
insert into turnos  (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)values(3,(select idcartas from cartas where es_activa=1 order by rand() limit 1),6,18,1,17,null,2,0,2);
insert into turnos  (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)values(3,(select idcartas from cartas where es_activa=1 order by rand() limit 1),7,20,null,24,null,1,1,2);

insert into turnos (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)   values(4,(select idcartas from cartas where es_activa=1 order by rand() limit 1),5,19,5,24,null,3,0,2);
insert into turnos  (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)values(4,(select idcartas from cartas where es_activa=1 order by rand() limit 1),6,17,1,16,null,2,0,2);
insert into turnos  (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)values(4,(select idcartas from cartas where es_activa=1 order by rand() limit 1),7,24,null,20,null,1,1,2);

insert into turnos (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)   values(5,(select idcartas from cartas where es_activa=1 order by rand() limit 1),5,24,null,22,null,3,1,2);
insert into turnos  (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)values(5,(select idcartas from cartas where es_activa=1 order by rand() limit 1),6,16,4,20,null,2,0,2);
insert into turnos  (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)values(5,(select idcartas from cartas where es_activa=1 order by rand() limit 1),7,20,2,18,null,1,0,2);

insert into turnos (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)   values(6,(select idcartas from cartas where es_activa=1 order by rand() limit 1),5,22,5,17,null,3,0,1);
insert into turnos  (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)values(6,(select idcartas from cartas where es_activa=1 order by rand() limit 1),6,20,null,30,null,2,1,2);
insert into turnos  (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)values(6,(select idcartas from cartas where es_activa=1 order by rand() limit 1),7,18,5,13,null,1,0,2);

insert into turnos (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)   values(7,(select idcartas from cartas where es_activa=1 order by rand() limit 1),5,17,1,18,null,3,0,2);
insert into turnos  (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)values(7,(select idcartas from cartas where es_activa=1 order by rand() limit 1),6,30,null,30,null,2,1,2);
insert into turnos  (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)values(7,(select idcartas from cartas where es_activa=1 order by rand() limit 1),7,13,1,12,null,1,0,2);

insert into turnos (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)   values(8,(select idcartas from cartas where es_activa=1 order by rand() limit 1),5,18,4,14,null,3,0,2);
insert into turnos  (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)values(8,(select idcartas from cartas where es_activa=1 order by rand() limit 1),6,30,null,33,null,2,1,2);
insert into turnos  (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)values(8,(select idcartas from cartas where es_activa=1 order by rand() limit 1),7,12,1,13,null,1,0,2);

insert into turnos (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)   values(9,(select idcartas from cartas where es_activa=1 order by rand() limit 1),5,14,1,15,null,3,0,2);
insert into turnos  (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)values(9,(select idcartas from cartas where es_activa=1 order by rand() limit 1),6,33,10,23,null,2,0,2);
insert into turnos  (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)values(9,(select idcartas from cartas where es_activa=1 order by rand() limit 1),7,13,null,22,null,1,1,2);

insert into turnos (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)   values(10,(select idcartas from cartas where es_activa=1 order by rand() limit 1),5,15,3,18,null,3,0,2);
insert into turnos  (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)values(10,(select idcartas from cartas where es_activa=1 order by rand() limit 1),6,23,5,18,null,2,0,2);
insert into turnos  (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)values(10,(select idcartas from cartas where es_activa=1 order by rand() limit 1),7,22,null,24,null,1,1,2);

insert into turnos (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)   values(11,(select idcartas from cartas where es_activa=1 order by rand() limit 1),5,18,3,21,null,3,0,2);
insert into turnos  (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)values(11,(select idcartas from cartas where es_activa=1 order by rand() limit 1),6,18,5,23,null,2,0,2);
insert into turnos  (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)values(11,(select idcartas from cartas where es_activa=1 order by rand() limit 1),7,24,null,16,null,1,1,2);

insert into turnos (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)   values(12,(select idcartas from cartas where es_activa=1 order by rand() limit 1),5,21,1,20,null,3,0,2);
insert into turnos  (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)values(12,(select idcartas from cartas where es_activa=1 order by rand() limit 1),6,23,1,22,null,2,0,2);
insert into turnos  (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)values(12,(select idcartas from cartas where es_activa=1 order by rand() limit 1),7,16,null,18,null,1,1,2);

insert into turnos (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)   values(13,(select idcartas from cartas where es_activa=1 order by rand() limit 1),5,20,3,17,null,3,0,2);
insert into turnos  (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)values(13,(select idcartas from cartas where es_activa=1 order by rand() limit 1),6,22,3,25,null,2,0,2);
insert into turnos  (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)values(13,(select idcartas from cartas where es_activa=1 order by rand() limit 1),7,18,null,18,null,1,1,2);

insert into turnos (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)   values(14,(select idcartas from cartas where es_activa=1 order by rand() limit 1),5,17,3,14,null,3,0,2);
insert into turnos  (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)values(14,(select idcartas from cartas where es_activa=1 order by rand() limit 1),6,25,null,31,null,2,1,2);
insert into turnos  (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)values(14,(select idcartas from cartas where es_activa=1 order by rand() limit 1),7,18,3,15,null,1,0,2);

insert into turnos (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)   values(15,(select idcartas from cartas where es_activa=1 order by rand() limit 1),5,14,3,11,null,3,0,2);
insert into turnos  (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)values(15,(select idcartas from cartas where es_activa=1 order by rand() limit 1),6,31,null,37,null,2,1,2);
insert into turnos  (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)values(15,(select idcartas from cartas where es_activa=1 order by rand() limit 1),7,15,3,12,null,1,0,2);

insert into turnos (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)   values(16,(select idcartas from cartas where es_activa=1 order by rand() limit 1),5,11,3,8,null,3,0,2);
insert into turnos  (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)values(16,(select idcartas from cartas where es_activa=1 order by rand() limit 1),6,37,null,43,null,2,1,2);
insert into turnos  (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)values(16,(select idcartas from cartas where es_activa=1 order by rand() limit 1),7,12,3,9,null,1,0,2);

insert into turnos (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)   values(17,(select idcartas from cartas where es_activa=1 order by rand() limit 1),5,8,2,6,null,3,0,2);
insert into turnos  (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)values(17,(select idcartas from cartas where es_activa=1 order by rand() limit 1),6,43,null,48,null,2,1,2);
insert into turnos  (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)values(17,(select idcartas from cartas where es_activa=1 order by rand() limit 1),7,9,3,6,null,1,0,2);

insert into turnos (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)   values(18,(select idcartas from cartas where es_activa=1 order by rand() limit 1),5,6,3,3,null,3,0,2);
insert into turnos  (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)values(18,(select idcartas from cartas where es_activa=1 order by rand() limit 1),6,48,null,54,null,2,1,2);
insert into turnos  (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)values(18,(select idcartas from cartas where es_activa=1 order by rand() limit 1),7,6,3,3,null,1,0,2);

insert into turnos (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)   values(19,(select idcartas from cartas where es_activa=1 order by rand() limit 1),5,3,3,0,null,3,0,2);
insert into turnos  (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)values(19,(select idcartas from cartas where es_activa=1 order by rand() limit 1),6,54,null,60,null,2,1,2);
insert into turnos  (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)values(19,(select idcartas from cartas where es_activa=1 order by rand() limit 1),7,3,3,0,null,1,0,2);
update partida set ganador_partida = 6 where  idpartida=2;


/* PARTIDA 3 */

-- select * from participante
insert into partida(idpartida,nombre_sala,numero_jugadores,apuesta_minima,condiciones_victoria,hora_inicio,hora_fin)
values(3,'Sala Xavi contra el Bot',4,1,'30 Rondas max. Gana la puntuación mas alta.',(select now() from dual),(select DATE_ADD(NOW(), INTERVAL 30 minute) from dual));

update partida set duracion= TIMESTAMPDIFF(HOUR,hora_inicio,hora_fin) where idpartida>0;

insert into participante values (8,6,3);
insert into participante  values (9,12,3);


insert into turnos (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)   values(1,(select idcartas from cartas where es_activa=1 order by rand() limit 1),5,20,null,21,null,1,1,3);
insert into turnos  (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)values(1,(select idcartas from cartas where es_activa=1 order by rand() limit 1),6,20,1,19,null,2,0,3);

insert into turnos (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)   values(2,(select idcartas from cartas where es_activa=1 order by rand() limit 1),5,21,null,22,null,1,1,3);
insert into turnos  (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)values(2,(select idcartas from cartas where es_activa=1 order by rand() limit 1),6,19,1,18,null,2,0,3);

insert into turnos (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)   values(3,(select idcartas from cartas where es_activa=1 order by rand() limit 1),5,22,null,23,null,1,1,3);
insert into turnos  (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)values(3,(select idcartas from cartas where es_activa=1 order by rand() limit 1),6,18,1,17,null,2,0,3);

insert into turnos (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)   values(4,(select idcartas from cartas where es_activa=1 order by rand() limit 1),5,23,null,24,null,1,1,3);
insert into turnos  (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)values(4,(select idcartas from cartas where es_activa=1 order by rand() limit 1),6,17,1,16,null,2,0,3);

insert into turnos (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)   values(5,(select idcartas from cartas where es_activa=1 order by rand() limit 1),5,24,null,25,null,1,1,3);
insert into turnos  (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)values(5,(select idcartas from cartas where es_activa=1 order by rand() limit 1),6,16,1,15,null,2,0,3);

insert into turnos (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)   values(6,(select idcartas from cartas where es_activa=1 order by rand() limit 1),5,25,null,26,null,1,1,3);
insert into turnos  (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)values(6,(select idcartas from cartas where es_activa=1 order by rand() limit 1),6,15,1,14,null,2,0,3);


insert into turnos (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)   values(8,(select idcartas from cartas where es_activa=1 order by rand() limit 1),5,26,null,27,null,1,1,3);
insert into turnos  (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)values(8,(select idcartas from cartas where es_activa=1 order by rand() limit 1),6,14,1,13,null,2,0,3);


insert into turnos (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)   values(9,(select idcartas from cartas where es_activa=1 order by rand() limit 1),5,27,null,28,null,1,1,3);
insert into turnos  (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)values(9,(select idcartas from cartas where es_activa=1 order by rand() limit 1),6,13,1,12,null,2,0,3);


insert into turnos (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)   values(10,(select idcartas from cartas where es_activa=1 order by rand() limit 1),5,28,null,29,null,1,1,3);
insert into turnos  (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)values(10,(select idcartas from cartas where es_activa=1 order by rand() limit 1),6,12,1,11,null,2,0,3);



insert into turnos (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)   values(11,(select idcartas from cartas where es_activa=1 order by rand() limit 1),5,29,null,30,null,1,1,3);
insert into turnos  (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)values(11,(select idcartas from cartas where es_activa=1 order by rand() limit 1),6,11,1,10,null,2,0,3);


insert into turnos (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)   values(12,(select idcartas from cartas where es_activa=1 order by rand() limit 1),5,30,null,31,null,1,1,3);
insert into turnos  (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)values(12,(select idcartas from cartas where es_activa=1 order by rand() limit 1),6,10,1,9,null,2,0,3);


insert into turnos (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)   values(13,(select idcartas from cartas where es_activa=1 order by rand() limit 1),5,31,null,32,null,1,1,3);
insert into turnos  (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)values(13,(select idcartas from cartas where es_activa=1 order by rand() limit 1),6,9,1,8,null,2,0,3);


insert into turnos (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)   values(14,(select idcartas from cartas where es_activa=1 order by rand() limit 1),5,32,null,34,null,1,1,3);
insert into turnos  (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)values(14,(select idcartas from cartas where es_activa=1 order by rand() limit 1),6,8,2,6,null,2,0,3);


insert into turnos (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)   values(15,(select idcartas from cartas where es_activa=1 order by rand() limit 1),5,34,null,36,null,1,1,3);
insert into turnos  (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)values(15,(select idcartas from cartas where es_activa=1 order by rand() limit 1),6,6,2,4,null,2,0,3);


insert into turnos (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)   values(16,(select idcartas from cartas where es_activa=1 order by rand() limit 1),5,36,null,38,null,1,1,3);
insert into turnos  (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)values(16,(select idcartas from cartas where es_activa=1 order by rand() limit 1),6,4,2,2,null,2,0,3);


insert into turnos (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)   values(17,(select idcartas from cartas where es_activa=1 order by rand() limit 1),5,38,null,40,null,1,1,3);
insert into turnos  (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)values(17,(select idcartas from cartas where es_activa=1 order by rand() limit 1),6,2,2,0,null,2,0,3);

update partida set ganador_partida = 6 where  idpartida=3;



/* PARTIDA 4 */

-- select * from participante
insert into partida(idpartida,nombre_sala,numero_jugadores,apuesta_minima,condiciones_victoria,hora_inicio,hora_fin)
values(4,'Sala Rafa contra Leandro',2,1,'30 Rondas max. Gana la puntuación mas alta.',(select now() from dual),(select DATE_ADD(NOW(), INTERVAL 30 minute) from dual));

update partida set duracion= TIMESTAMPDIFF(HOUR,hora_inicio,hora_fin) where idpartida>0;

insert into participante values (10,1,4);
insert into participante  values (11,3,4);


insert into turnos (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)   values(1,(select idcartas from cartas where es_activa=1 order by rand() limit 1),3,20,null,21,null,1,1,4);
insert into turnos  (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)values(1,(select idcartas from cartas where es_activa=1 order by rand() limit 1),1,20,1,19,null,2,0,4);

insert into turnos (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)   values(2,(select idcartas from cartas where es_activa=1 order by rand() limit 1),3,21,null,22,null,1,1,4);
insert into turnos  (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)values(2,(select idcartas from cartas where es_activa=1 order by rand() limit 1),1,19,1,18,null,2,0,4);

insert into turnos (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)   values(3,(select idcartas from cartas where es_activa=1 order by rand() limit 1),3,22,null,23,null,1,1,4);
insert into turnos  (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)values(3,(select idcartas from cartas where es_activa=1 order by rand() limit 1),1,18,1,17,null,2,0,4);

insert into turnos (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)   values(4,(select idcartas from cartas where es_activa=1 order by rand() limit 1),3,23,null,24,null,1,1,4);
insert into turnos  (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)values(4,(select idcartas from cartas where es_activa=1 order by rand() limit 1),1,17,1,16,null,2,0,4);

insert into turnos (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)   values(5,(select idcartas from cartas where es_activa=1 order by rand() limit 1),3,24,null,25,null,1,1,4);
insert into turnos  (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)values(5,(select idcartas from cartas where es_activa=1 order by rand() limit 1),1,16,1,15,null,2,0,4);

insert into turnos (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)   values(6,(select idcartas from cartas where es_activa=1 order by rand() limit 1),3,25,null,26,null,1,1,4);
insert into turnos  (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)values(6,(select idcartas from cartas where es_activa=1 order by rand() limit 1),1,15,1,14,null,2,0,4);


insert into turnos (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)   values(8,(select idcartas from cartas where es_activa=1 order by rand() limit 1),3,26,null,27,null,1,1,4);
insert into turnos  (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)values(8,(select idcartas from cartas where es_activa=1 order by rand() limit 1),1,14,1,13,null,2,0,4);


insert into turnos (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)   values(9,(select idcartas from cartas where es_activa=1 order by rand() limit 1),3,27,null,28,null,1,1,4);
insert into turnos  (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)values(9,(select idcartas from cartas where es_activa=1 order by rand() limit 1),1,13,1,12,null,2,0,4);


insert into turnos (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)   values(10,(select idcartas from cartas where es_activa=1 order by rand() limit 1),3,28,null,29,null,1,1,4);
insert into turnos  (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)values(10,(select idcartas from cartas where es_activa=1 order by rand() limit 1),1,12,1,11,null,2,0,4);



insert into turnos (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)   values(11,(select idcartas from cartas where es_activa=1 order by rand() limit 1),3,29,null,30,null,1,1,4);
insert into turnos  (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)values(11,(select idcartas from cartas where es_activa=1 order by rand() limit 1),1,11,1,10,null,2,0,4);


insert into turnos (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)   values(12,(select idcartas from cartas where es_activa=1 order by rand() limit 1),3,30,null,31,null,1,1,4);
insert into turnos  (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)values(12,(select idcartas from cartas where es_activa=1 order by rand() limit 1),1,10,1,9,null,2,0,4);


insert into turnos (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)   values(13,(select idcartas from cartas where es_activa=1 order by rand() limit 1),3,31,null,32,null,1,1,4);
insert into turnos  (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)values(13,(select idcartas from cartas where es_activa=1 order by rand() limit 1),1,9,1,8,null,2,0,4);


insert into turnos (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)   values(14,(select idcartas from cartas where es_activa=1 order by rand() limit 1),3,32,null,34,null,1,1,4);
insert into turnos  (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)values(14,(select idcartas from cartas where es_activa=1 order by rand() limit 1),1,8,2,6,null,2,0,4);


insert into turnos (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)   values(15,(select idcartas from cartas where es_activa=1 order by rand() limit 1),3,34,null,36,null,1,1,4);
insert into turnos  (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)values(15,(select idcartas from cartas where es_activa=1 order by rand() limit 1),1,6,2,4,null,2,0,4);


insert into turnos (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)   values(16,(select idcartas from cartas where es_activa=1 order by rand() limit 1),3,36,null,38,null,1,1,4);
insert into turnos  (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)values(16,(select idcartas from cartas where es_activa=1 order by rand() limit 1),1,4,2,2,null,2,0,4);


insert into turnos (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)   values(17,(select idcartas from cartas where es_activa=1 order by rand() limit 1),3,38,null,40,null,1,1,4);
insert into turnos  (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)values(17,(select idcartas from cartas where es_activa=1 order by rand() limit 1),1,2,2,0,null,2,0,4);

update partida set ganador_partida = 3 where  idpartida=4;


/* PARTIDA 5 */

-- select * from participante
insert into partida(idpartida,nombre_sala,numero_jugadores,apuesta_minima,condiciones_victoria,hora_inicio,hora_fin)
values(5,'Sala Rafa contra Leandro 2',2,1,'30 Rondas max. Gana la puntuación mas alta.',(select now() from dual),(select DATE_ADD(NOW(), INTERVAL 4 hour) from dual));

update partida set duracion= TIMESTAMPDIFF(HOUR,hora_inicio,hora_fin) where idpartida>0;

insert into participante values (12,1,5);
insert into participante  values (13,3,5);

insert into turnos (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)   values(1,(select idcartas from cartas where es_activa=1 order by rand() limit 1),3,20,null,21,null,1,1,5);
insert into turnos  (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)values(1,(select idcartas from cartas where es_activa=1 order by rand() limit 1),1,20,1,19,null,2,0,5);

insert into turnos (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)   values(2,(select idcartas from cartas where es_activa=1 order by rand() limit 1),3,21,null,22,null,1,1,5);
insert into turnos  (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)values(2,(select idcartas from cartas where es_activa=1 order by rand() limit 1),1,19,1,18,null,2,0,5);

insert into turnos (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)   values(3,(select idcartas from cartas where es_activa=1 order by rand() limit 1),3,22,null,23,null,1,1,5);
insert into turnos  (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)values(3,(select idcartas from cartas where es_activa=1 order by rand() limit 1),1,18,1,17,null,2,0,5);

insert into turnos (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)   values(4,(select idcartas from cartas where es_activa=1 order by rand() limit 1),3,23,null,24,null,1,1,5);
insert into turnos  (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)values(4,(select idcartas from cartas where es_activa=1 order by rand() limit 1),1,17,1,16,null,2,0,5);

insert into turnos (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)   values(5,(select idcartas from cartas where es_activa=1 order by rand() limit 1),3,24,null,25,null,1,1,5);
insert into turnos  (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)values(5,(select idcartas from cartas where es_activa=1 order by rand() limit 1),1,16,1,15,null,2,0,5);

insert into turnos (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)   values(6,(select idcartas from cartas where es_activa=1 order by rand() limit 1),3,25,null,26,null,1,1,5);
insert into turnos  (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)values(6,(select idcartas from cartas where es_activa=1 order by rand() limit 1),1,15,1,14,null,2,0,5);


insert into turnos (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)   values(8,(select idcartas from cartas where es_activa=1 order by rand() limit 1),3,26,null,27,null,1,1,5);
insert into turnos  (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)values(8,(select idcartas from cartas where es_activa=1 order by rand() limit 1),1,14,1,13,null,2,0,5);


insert into turnos (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)   values(9,(select idcartas from cartas where es_activa=1 order by rand() limit 1),3,27,null,28,null,1,1,5);
insert into turnos  (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)values(9,(select idcartas from cartas where es_activa=1 order by rand() limit 1),1,13,1,12,null,2,0,5);


insert into turnos (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)   values(10,(select idcartas from cartas where es_activa=1 order by rand() limit 1),3,28,null,29,null,1,1,5);
insert into turnos  (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)values(10,(select idcartas from cartas where es_activa=1 order by rand() limit 1),1,12,1,11,null,2,0,5);



insert into turnos (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)   values(11,(select idcartas from cartas where es_activa=1 order by rand() limit 1),3,29,null,30,null,1,1,5);
insert into turnos  (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)values(11,(select idcartas from cartas where es_activa=1 order by rand() limit 1),1,11,1,10,null,2,0,5);


insert into turnos (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)   values(12,(select idcartas from cartas where es_activa=1 order by rand() limit 1),3,30,null,31,null,1,1,5);
insert into turnos  (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)values(12,(select idcartas from cartas where es_activa=1 order by rand() limit 1),1,10,1,9,null,2,0,5);


insert into turnos (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)   values(13,(select idcartas from cartas where es_activa=1 order by rand() limit 1),3,31,null,32,null,1,1,5);
insert into turnos  (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)values(13,(select idcartas from cartas where es_activa=1 order by rand() limit 1),1,9,1,8,null,2,0,5);


insert into turnos (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)   values(14,(select idcartas from cartas where es_activa=1 order by rand() limit 1),3,32,null,34,null,1,1,5);
insert into turnos  (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)values(14,(select idcartas from cartas where es_activa=1 order by rand() limit 1),1,8,2,6,null,2,0,5);


insert into turnos (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)   values(15,(select idcartas from cartas where es_activa=1 order by rand() limit 1),3,34,null,36,null,1,1,5);
insert into turnos  (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)values(15,(select idcartas from cartas where es_activa=1 order by rand() limit 1),1,6,2,4,null,2,0,5);


insert into turnos (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)   values(16,(select idcartas from cartas where es_activa=1 order by rand() limit 1),3,36,null,38,null,1,1,5);
insert into turnos  (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)values(16,(select idcartas from cartas where es_activa=1 order by rand() limit 1),1,4,2,2,null,2,0,5);


insert into turnos (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)   values(17,(select idcartas from cartas where es_activa=1 order by rand() limit 1),3,38,null,40,null,1,1,5);
insert into turnos  (numero_turno,carta_inicial,idparticipante,puntos_inicio,apuesta,puntos_final,resultado,orden_jugador,es_banca,IDPARTIDA)values(17,(select idcartas from cartas where es_activa=1 order by rand() limit 1),1,2,2,0,null,2,0,5);

update partida set ganador_partida = 3 where  idpartida=5;





