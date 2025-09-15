package engtelecom.poo.produtos;

import engtelecom.poo.Dimensao;

public class SemFio extends Telefone{

    private double frequencia;
    private int canais;
    private double distancia;

    public SemFio(int codigo, String numSerie, String modelo, double peso, Dimensao dim, double frequencia, int canais,
            double distancia) {
        super(codigo, numSerie, modelo, peso, dim);
        this.frequencia = frequencia;
        this.canais = canais;
        this.distancia = distancia;
    }

    @Override
    public void imprimirDados() {
        super.imprimirDados(); // Override não é obrigatório chamar método da superclasse
        System.out.printf(" frequencia: %.2f, canais: %d, distancia: %.2f\n",frequencia, canais, distancia);
        this.codigo = 123; // protected deixa aqui! mesmo pacote
    }

    public void setCanais(int canais) {
        this.canais = canais;
    } 

    
    
}
