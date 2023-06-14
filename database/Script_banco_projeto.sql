CREATE TABLE `agendamento` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `data` datetime(6) NOT NULL,
  `hora_inicio` time(6) NOT NULL,
  `hora_fim` time(6) NOT NULL,
  `nome` varchar(250) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_agendamento_nome_idx` (`nome`),
  CONSTRAINT `fk_agendamento_nome` FOREIGN KEY (`nome`) REFERENCES `usuario` (`nome`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;


CREATE TABLE `cadastro` (
  `id_matricula` int(11) NOT NULL AUTO_INCREMENT,
  `nome_usuario` varchar(250) NOT NULL,
  `email_usuario` varchar(250) NOT NULL,
  `senha_usuario` varchar(50) NOT NULL,
  PRIMARY KEY (`id_matricula`),
  KEY `fk_cadantro_usuario_idx` (`nome_usuario`,`email_usuario`,`senha_usuario`),
  KEY `fk_teste_idx` (`email_usuario`,`senha_usuario`),
  KEY `fk_senha_idx` (`senha_usuario`),
  CONSTRAINT `fk_email_usuario` FOREIGN KEY (`email_usuario`) REFERENCES `usuario` (`email`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_id_matricula` FOREIGN KEY (`id_matricula`) REFERENCES `usuario` (`matricula`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_nome_usuario` FOREIGN KEY (`nome_usuario`) REFERENCES `usuario` (`nome`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_senha_usuario` FOREIGN KEY (`senha_usuario`) REFERENCES `usuario` (`senha`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1568414 DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

