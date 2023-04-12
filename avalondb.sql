CREATE DATABASE `avalondb` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

CREATE TABLE `cargos` (
  `cargo_id` int NOT NULL AUTO_INCREMENT,
  `cargo_nome` varchar(255) NOT NULL,
  PRIMARY KEY (`cargo_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `usuarios` (
  `usuario_id` int NOT NULL AUTO_INCREMENT,
  `usuario_login` varchar(255) NOT NULL,
  `usuario_senha` varchar(255) NOT NULL,
  `usuario_nome` varchar(255) NOT NULL,
  `usuario_cargo` int NOT NULL,
  PRIMARY KEY (`usuario_id`),
  KEY `usuario_cargo` (`usuario_cargo`),
  CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`usuario_cargo`) REFERENCES `cargos` (`cargo_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `refreshtokens` (
  `id` int NOT NULL AUTO_INCREMENT,
  `token` varchar(255) DEFAULT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `userId` int DEFAULT NULL,
  `refreshToken_usuario` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `refreshToken_usuario` (`refreshToken_usuario`),
  CONSTRAINT `refreshtokens_ibfk_1` FOREIGN KEY (`refreshToken_usuario`) REFERENCES `usuarios` (`usuario_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `estados` (
  `est_id` int NOT NULL AUTO_INCREMENT,
  `est_sigla` varchar(2) NOT NULL,
  `est_desc` varchar(50) NOT NULL,
  PRIMARY KEY (`est_id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `cidades` (
  `cid_id` int NOT NULL AUTO_INCREMENT,
  `cid_desc` varchar(250) NOT NULL,
  `cid_estado` int NOT NULL,
  PRIMARY KEY (`cid_id`),
  KEY `cid_estado` (`cid_estado`),
  CONSTRAINT `cidades_ibfk_1` FOREIGN KEY (`cid_estado`) REFERENCES `estados` (`est_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5571 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `eventos` (
  `event_id` int NOT NULL AUTO_INCREMENT,
  `event_nome` varchar(250) NOT NULL,
  `event_local` varchar(250) NOT NULL,
  `event_edicao` int NOT NULL,
  `event_estado` int NOT NULL,
  `event_cidade` int NOT NULL,
  `event_data` datetime NOT NULL,
  `event_EdiNome` varchar(255) NOT NULL,
  PRIMARY KEY (`event_id`),
  KEY `event_estado` (`event_estado`),
  KEY `event_cidade` (`event_cidade`),
  CONSTRAINT `eventos_ibfk_1` FOREIGN KEY (`event_estado`) REFERENCES `estados` (`est_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `eventos_ibfk_2` FOREIGN KEY (`event_cidade`) REFERENCES `cidades` (`cid_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `participantes` (
  `part_id` int NOT NULL AUTO_INCREMENT,
  `part_user` varchar(255) DEFAULT NULL,
  `part_senha` varchar(255) DEFAULT NULL,
  `part_nome` varchar(500) NOT NULL,
  `part_nomeSocial` varchar(500) NOT NULL,
  `part_cpf` varchar(11) NOT NULL,
  `part_nasc` datetime NOT NULL,
  `part_whats` varchar(11) NOT NULL,
  `part_est` int NOT NULL,
  `part_cidade` int NOT NULL,
  PRIMARY KEY (`part_id`),
  KEY `part_est` (`part_est`),
  KEY `part_cidade` (`part_cidade`),
  CONSTRAINT `participantes_ibfk_1` FOREIGN KEY (`part_est`) REFERENCES `estados` (`est_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `participantes_ibfk_2` FOREIGN KEY (`part_cidade`) REFERENCES `cidades` (`cid_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `personagens` (
  `pers_id` int NOT NULL AUTO_INCREMENT,
  `pers_part` int NOT NULL,
  `pers_nome` varchar(250) NOT NULL,
  `pers_origem` varchar(250) NOT NULL,
  `pers_link` varchar(250) NOT NULL,
  `pers_aceite` tinyint(1) NOT NULL,
  PRIMARY KEY (`pers_id`),
  KEY `pers_part` (`pers_part`),
  CONSTRAINT `personagens_ibfk_1` FOREIGN KEY (`pers_part`) REFERENCES `participantes` (`part_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `concursos` (
  `concur_id` int NOT NULL AUTO_INCREMENT,
  `concur_nome` varchar(50) NOT NULL,
  PRIMARY KEY (`concur_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `configs_concursos` (
  `config_id` int NOT NULL AUTO_INCREMENT,
  `config_event` int NOT NULL,
  `config_concurso` int NOT NULL,
  `config_limit_inscr` int NOT NULL,
  `config_limit_espera` int NOT NULL,
  `config_limit_checkin` int NOT NULL,
  `config_ativo` tinyint(1) NOT NULL,
  PRIMARY KEY (`config_id`),
  KEY `config_event` (`config_event`),
  KEY `config_concurso` (`config_concurso`),
  CONSTRAINT `configs_concursos_ibfk_1` FOREIGN KEY (`config_event`) REFERENCES `eventos` (`event_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `configs_concursos_ibfk_2` FOREIGN KEY (`config_concurso`) REFERENCES `concursos` (`concur_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `categorias` (
  `categ_id` int NOT NULL AUTO_INCREMENT,
  `categ_nome` varchar(50) NOT NULL,
  PRIMARY KEY (`categ_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `desfile_cosplays` (
  `desf_id` int NOT NULL AUTO_INCREMENT,
  `desf_event` int NOT NULL,
  `desf_pers` int NOT NULL,
  `desf_conf` tinyint(1) DEFAULT NULL,
  `desf_ordem` int DEFAULT NULL,
  `desf_categ` int NOT NULL,
  `desf_extra` varchar(250) DEFAULT NULL,
  `desf_media` float DEFAULT '0',
  PRIMARY KEY (`desf_id`),
  KEY `desf_event` (`desf_event`),
  KEY `desf_pers` (`desf_pers`),
  KEY `desf_categ` (`desf_categ`),
  CONSTRAINT `desfile_cosplays_ibfk_1` FOREIGN KEY (`desf_event`) REFERENCES `eventos` (`event_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `desfile_cosplays_ibfk_2` FOREIGN KEY (`desf_pers`) REFERENCES `personagens` (`pers_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `desfile_cosplays_ibfk_3` FOREIGN KEY (`desf_categ`) REFERENCES `categorias` (`categ_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `notas` (
  `nota_id` int NOT NULL AUTO_INCREMENT,
  `nota_usuario` int NOT NULL,
  `nota_desfile` int NOT NULL,
  `nota_jurado` int NOT NULL,
  `nota_confec` float DEFAULT NULL,
  `nota_fidel` float DEFAULT NULL,
  PRIMARY KEY (`nota_id`),
  KEY `nota_usuario` (`nota_usuario`),
  KEY `nota_desfile` (`nota_desfile`),
  CONSTRAINT `notas_ibfk_1` FOREIGN KEY (`nota_usuario`) REFERENCES `usuarios` (`usuario_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `notas_ibfk_2` FOREIGN KEY (`nota_desfile`) REFERENCES `desfile_cosplays` (`desf_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;