package com.restapi.agenda.Controller;

import com.restapi.agenda.Entidade.Cadastro;
import com.restapi.agenda.database.RepositorioCadastro;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/cadastro")
public class CadastroRest {
    @Autowired
    private RepositorioCadastro repositorioCadastro;

    @GetMapping
    public List<Cadastro>listar(){
        return repositorioCadastro.findAll();
    }

    @PostMapping
    public void adicionar(@RequestBody Cadastro cadastro){
        repositorioCadastro.save(cadastro);
    }

    @PutMapping
    public void alterar(@RequestBody Cadastro cadastro){
        repositorioCadastro.save(cadastro);
    }

    @DeleteMapping
    public void excluir(@RequestBody Cadastro cadastro){
        repositorioCadastro.delete(cadastro);
    }
}
