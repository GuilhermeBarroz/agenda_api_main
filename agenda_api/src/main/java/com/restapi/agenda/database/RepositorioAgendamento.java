package com.restapi.agenda.database;

import com.restapi.agenda.Entidade.Agendamento;
import org.springframework.data.jpa.repository.JpaRepository;

public interface RepositorioAgendamento extends JpaRepository<Agendamento, Long> {
}
