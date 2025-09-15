package engtelecom.poo.produtos;

import engtelecom.poo.Dimensao;

public class Telefone {
    protected int codigo;
    private String numSerie;
    private String modelo;
    private double peso;
    private Dimensao dim;

    public Telefone(int codigo, String numSerie, String modelo, double peso, Dimensao dim) {
        this.codigo = codigo;
        this.numSerie = numSerie;
        this.modelo = modelo;
        this.peso = peso;
        this.dim = dim;
    }

    public void imprimirDados() {
        System.out.println("codigo: " + this.codigo);
        System.out.println(this.dim);
    }

    public void setModelo(String modelo) {
        this.modelo = modelo;
    }

    
    
}
