package engtelecom.poo;

import java.util.ArrayList;

public class UnidadeCurricular {
    private String nome;
    private String codigo;
    private String sigla;
    private Integer creditos;
    private String ementa;
    private ArrayList<String> objetivo; 
    private ArrayList<String> conteudo;

    // construtor padrão
    public UnidadeCurricular(String nome, String codigo, String sigla, Integer creditos, String ementa) {
        this.nome = nome;
        this.codigo = codigo;
        this.sigla = sigla;
        this.creditos = creditos;
        this.ementa = ementa;
        this.objetivo = new ArrayList<>();
        this.conteudo = new ArrayList<>();
    }

    @Override
    public String toString() {
        String string = "Nome - " + nome + "\n" +
                        "Codigo - " + codigo + "\n" +
                        "Sigla - " + sigla + "\n" +
                        "Creditos - " + creditos + "\n" +
                        "Ementa - " + ementa + "\n";

        if (!objetivo.isEmpty()) {
            string += "Objetivo - " + objetivo + "\n";
        } else {
            string += "Objetivo - Não cadastrado\n";
        }

        if (!conteudo.isEmpty()) {
            string += "Conteudo - " + conteudo;
        } else {
            string += "Conteudo - Não cadastrado";
        }

        return string;
    }

    public int getCargaHoraria() {
        return this.creditos * Curso.SEMANAS;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getCodigo() {
        return codigo;
    }

    public void setCodigo(String codigo) {
        this.codigo = codigo;
    }

    public String getSigla() {
        return sigla;
    }

    public void setSigla(String sigla) {
        this.sigla = sigla;
    }

    public Integer getCreditos() {
        return creditos;
    }

    public void setCreditos(Integer creditos) {
        this.creditos = creditos;
    }

    public String getEmenta() {
        return ementa;
    }

    public void setEmenta(String ementa) {
        this.ementa = ementa;
    }

    // obter todos os objetivos
    public String obterObjetivo() {
        // sem objetivos cadastrados
        if (objetivo.size() == 0) {
            return null;
        }
        String objetivos = "[";
        for (String dado : this.objetivo) {
            objetivos += dado + '|';
        }
        return objetivos + "]";
    }

    // obter um objetivo específico
    public String obterObjetivo(int pos) {
        // pos inválida
        if (pos > objetivo.size()) {
            return null;
        }
        return objetivo.get(pos);
    }

    public void adicionarObjetivo(String obj) {
        objetivo.add(obj);
    }

    public boolean removerObjetivo(int pos) {
        // pos válida
        if (pos >= 0 && pos < objetivo.size()) {
            objetivo.remove(pos);
            return true;
        }
        return false;
    }

    // obter todos os conteúdos
    public String obterConteudo() {
        // pos inválida
        if (conteudo.size() == 0) {
            return null;
        }
        String conteudos = "[";
        for (String dado : this.conteudo) {
            conteudos += dado + '|';
        }
        return conteudos + "]";
    }

    // obter um conteúdo específico
    public String obterConteudo(int pos) {
        // pos válida
        if (pos >= 0 && pos < conteudo.size()) {
            return conteudo.get(pos);
        }
        return null;
    }

    public void adicionarConteudo(String c) {
        conteudo.add(c);
    }

    public boolean removerConteudo(int pos) {
        // pos válida
        if (pos >= 0 && pos < conteudo.size()) {
            conteudo.remove(pos);
            return true;
        }
        return false;
    }
}