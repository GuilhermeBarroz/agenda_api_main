package com.restapi.agenda.database;

import com.restapi.agenda.Entidade.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;

public interface RepositorioUsuario extends JpaRepository<Usuario, Long> {
}
