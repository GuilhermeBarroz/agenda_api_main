package com.restapi.agenda.Controller;

import com.restapi.agenda.Entidade.Cadastro;
import com.restapi.agenda.Entidade.Usuario;
import com.restapi.agenda.database.RepositorioUsuario;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/usuario")
public class UsuarioRest {

    @Autowired
    private RepositorioUsuario repositorioUsuario;

    @GetMapping
    public List<Usuario> listar(){
        return repositorioUsuario.findAll();
    }

    @PostMapping
    public void adicionar(@RequestBody Usuario usuario){
        repositorioUsuario.save(usuario);
    }

    @PutMapping
    public void alterar(@RequestBody Usuario usuario){
        repositorioUsuario.save(usuario);
    }

    @DeleteMapping
    public void excluir(@RequestBody Usuario usuario){
        repositorioUsuario.delete(usuario);
    }

}
