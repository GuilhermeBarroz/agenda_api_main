package com.restapi.agenda.Entidade;

import jakarta.persistence.*;

@Entity
@Table(name = "cadastro")
public class Cadastro {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long ID_Matricula;
    @Column(nullable = false, length = 250)
    private String nome_usuario;
    @Column(nullable = false, length = 250, unique = true)
    private String email;
    @Column(nullable = false, length = 50)
    private String senha;


    public Long getIdMatricula() {
        return ID_Matricula;
    }

    public void setIdMatricula(Long idMatricula) {
        ID_Matricula = idMatricula;
    }

    public String getNome() {
        return nome_usuario;
    }

    public void setNome(String nome) {
        this.nome_usuario = nome;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getSenha() {
        return senha;
    }

    public void setSenha(String senha) {
        this.senha = senha;
    }
}
