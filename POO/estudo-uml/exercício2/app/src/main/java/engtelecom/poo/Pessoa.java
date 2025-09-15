package engtelecom.poo;

import java.time.LocalDate;

public class Pessoa {
    private String nome;
    private String sobrenome;
    private LocalDate dataNasc;
    private Telefone telefones;
    private Email emails;

    public Pessoa(String nome, String sobrenome, LocalDate dataNasc) {
        this.nome = nome;
        this.sobrenome = sobrenome;
        this.dataNasc = dataNasc;
        // telefone = new...
    }

    public boolean addTelefone(String r, String n) {
        return telefones.add(r, n);
    }

    public boolean addEmail(String r, String e) {
        return emails.add(r, e);
    }

    public boolean removeTelefone(String r) {
        return telefones.remove(r);
    }

    public boolean removeEmail(String e) {
        return emails.remove(e);
    }

    public boolean updateTelefone(String r, String n) {
        return telefones.update(r, n);
    }

    public boolean updateEmail(String r, String e) {
        return emails.update(r, e);
    }

    @Override
    public String toString() {
        String string = "Nome -" + nome + "\n" +
                "Sobrenome - " + sobrenome + "\n" +
                "Data Nascimento - " + dataNasc + "\n" +
                "Telefones - " + telefones + "\n" +
                "Emails - " + emails + "\n";
        return string;
    }
}
