package engtelecom.poo;

import java.util.HashMap;

public class Telefone {
    private HashMap<String, String> dados;

    public Telefone() {
        this.dados = new HashMap<>();
    }

    private boolean verificaTelefone(String n) {
        String nR = "[0-9]{12,14}";
        if (n.matches(nR)) {
            return true;
        }
        return false;
    }

    // adicionando um telefone
    public boolean add(String r, String n) {
        // verifica se o telefone já existe
        if (!dados.containsKey(r)) {

            // verifica se o telefone é válido
            if (verificaTelefone(n)) {
                dados.put(r, n);
                return true;
            }
        }
        return false;
    }

    // remove um telefone
    public boolean remove(String r) {
        if (dados.containsKey(r)) {
            dados.remove(r);
            return true;
        }
        return false;
    }

    // atualiza um telefone
    public boolean update(String r, String n) {
        // verifica se existe o telefone
        if (dados.containsKey(r)) {

            // verifica se o telefone é válido
            if (verificaTelefone(n)) {
                dados.put(r, n);
                return true;
            }
        }
        return false;
    }

    @Override
    public String toString() {
        StringBuilder str = new StringBuilder();

        dados.forEach((chave, valor) -> str.append(chave).append(":").append(valor).append(", "));

        if (str.length() > 0) {
            str.setLength(str.length() - 2);
        }

        return str.toString();
    }

}
