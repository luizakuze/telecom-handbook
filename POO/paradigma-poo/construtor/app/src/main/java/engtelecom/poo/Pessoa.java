package engtelecom.poo;

public class Pessoa {
    private String nome;
    private String dataNascimento;
    private String cpf;

    // Construtor padrão
    public Pessoa() {
        this.nome = "ninguém";
        this.dataNascimento = "31/12/1969";
        this.cpf = "000.000.000-00";
    }

    public Pessoa(String nome) {
        this(); // invocando o construtor padrão
        this.nome = nome;
    }

    public Pessoa(String nome, String cpf) {
        this.nome = nome;
        this.cpf = cpf;
    }

    public Pessoa(String nome, String dataNascimento, String cpf) {
        this.nome = nome;
        this.dataNascimento = dataNascimento;
        this.cpf = cpf;
    }


    

    
}
