package com.restapi.agenda.Controller;

import com.restapi.agenda.Entidade.Agendamento;
import com.restapi.agenda.database.RepositorioAgendamento;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/agendamento")
public class AgentamentoRest {

    @Autowired
    private RepositorioAgendamento repositorioAgendamento;

    @GetMapping
    public List<Agendamento>listar(){
        return repositorioAgendamento.findAll();
    }

    @PostMapping
    public void adicionar(@RequestBody Agendamento agendamento){
        repositorioAgendamento.save(agendamento);
    }

    @PutMapping
    public void alterar (@RequestBody Agendamento agendamento){
        repositorioAgendamento.save(agendamento);
    }

    @DeleteMapping
    public void excluir(@RequestBody Agendamento agendamento){
        repositorioAgendamento.delete(agendamento);
    }

}
