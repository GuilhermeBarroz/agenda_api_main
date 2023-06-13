package com.restapi.agenda.database;

import com.restapi.agenda.Entidade.Cadastro;
import org.springframework.data.jpa.repository.JpaRepository;

public interface RepositorioCadastro extends JpaRepository<Cadastro, Long> {
}
