package engtelecom.poo;

// Uma batedeira de um site de compras

public class Batedeira {
    private String modelo;
    private double preco;
    private int estoque; // qt

    public void comprar(int quantidade) {
        if (this.estoque > quantidade) {
            System.out.println("Comprou " + quantidade + " batedeiras");
            this.estoque -= quantidade;
        } else {
            System.out.println("Não há " + quantidade + " no estoque!");
        }
    }

    public void reembolsar(int quantidade) {
        System.out.println("Reembolsou " + quantidade + " batedeiras");
        this.estoque += quantidade;
    }

    public void descricao() {
        if (modelo != null) {
            System.out.println("Modelo: " + modelo);
            System.out.println("Preço: " + preco);
            System.out.println("Estoque: " + estoque);
        } else {
            System.out.println("Modelo da batedeira não dado!");
        }
    }

    public void setModelo(String modelo) {
        this.modelo = modelo;
    }

    public String getModelo() {
        return modelo;
    }

    public void setPreco(double preco) {
        this.preco = preco;
    }

    public double getPreco() {
        return preco;
    }

    public void setEstoque(int estoque) {
        this.estoque = estoque;
    }

    public int getEstoque() {
        return estoque;
    }

}
