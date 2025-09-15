package engtelecom.poo;

import java.io.Serializable;

public class Pessoa implements Serializable{

    private Integer codigo;
    private String nome;
    private String email;

    public Pessoa(Integer codigo, String nome, String email) {
        this.codigo = codigo;
        this.nome = nome;
        this.email = email;
    }

    @Override
    public String toString() {
        return "Pessoa [codigo=" + codigo + ", nome=" + nome + ", email=" + email + "]";
    }

    

    
}
