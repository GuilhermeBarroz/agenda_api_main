package com.restapi.agenda.Entidade;

import jakarta.persistence.*;

@Entity
@Table(name = "cadastro")
public class Cadastro {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id_matricula;
    @Column(nullable = false, length = 250)
    private String nome_usuario;
    @Column(nullable = false, length = 250, unique = true)
    private String email_usuario;
    @Column(nullable = false, length = 50)
    private String senha_usuario;


    public Long getIdMatricula() {
        return id_matricula;
    }

    public void setIdMatricula(Long idMatricula) {
        id_matricula = idMatricula;
    }

    public String getNome() {
        return nome_usuario;
    }

    public void setNome(String nome) {
        this.nome_usuario = nome;
    }

    public String getEmail() {
        return email_usuario;
    }

    public void setEmail(String email) {
        this.email_usuario = email;
    }

    public String getSenha() {
        return senha_usuario;
    }

    public void setSenha(String senha) {
        this.senha_usuario = senha;
    }
}
