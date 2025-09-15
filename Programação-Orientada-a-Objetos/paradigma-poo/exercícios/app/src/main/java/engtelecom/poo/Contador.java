package engtelecom.poo;

public class Contador {
    private int valorAtual;

    public void incrementar() {
        this.valorAtual++;
    }

    public void atribuir(int valor) {
        this.valorAtual = valor;

        // contador negativo não existe
        if (valor < 0) {
            this.valorAtual = 0;
        }
    }

    public int valorAtual() {
        return valorAtual;
    }

}
