CREATE TABLE `agendamento` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `data` datetime(6) NOT NULL,
  `hora_inicio` time(6) NOT NULL,
  `hora_fim` time(6) NOT NULL,
  `nome` varchar(250) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_agendamento_nome_idx` (`nome`),
  CONSTRAINT `fk_agendamento_nome` FOREIGN KEY (`nome`) REFERENCES `usuario` (`nome`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8;


CREATE TABLE `curso` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome_curso` varchar(250) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=301 DEFAULT CHARSET=utf8;


CREATE TABLE `usuario` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `matricula` int(11) NOT NULL,
  `nome` varchar(250) NOT NULL,
  `email` varchar(250) NOT NULL,
  `senha` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email_UNIQUE` (`email`),
  UNIQUE KEY `senha_UNIQUE` (`senha`),
  KEY `fk_matricula_idx` (`matricula`),
  KEY `fk_nome_idx` (`nome`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
