package engtelecom.poo;

import java.util.HashMap;

public class Email {
    private HashMap<String, String> dados;

    public Email() {
        this.dados = new HashMap<>();
    }

    private boolean verificaEmail(String e) {
        String eR = "^[\\w-\\+]+(\\.[\\w]+)*@[\\w-]+(\\.[\\w]+)*(\\.[a-z]{2,})$";
        if (e.matches(eR)) {
            return true;
        }
        return false;
    }

    // adicionando um email
    public boolean add(String r, String e) {
        // verifica se o email já existe
        if (!dados.containsKey(r)) {

            // verifica se o email é válido
            if (verificaEmail(e)) {
                dados.put(r, e);
                return true;
            }
        }
        return false;
    }

    // remove um email
    public boolean remove(String r) {
        if (dados.containsKey(r)) {
            dados.remove(r);
            return true;
        }
        return false;
    }

    // atualiza um email
    public boolean update(String r, String e) {
        // verifica se existe esse email
        if (dados.containsKey(r)) {

            // verifica se é um email válido
            if (verificaEmail(e)) {
                dados.put(r, e);
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
