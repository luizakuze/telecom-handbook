package engtelecom.poo;

public class App {
    public static void main(String[] args) {
        // Contador
        // Contador cont = new Contador();

        // cont.atribuir(10);
        // System.out.println("Valor do contador: " + cont.valorAtual());
        // cont.incrementar();
        // System.out.println("Valor do contador: " + cont.valorAtual() + " \n");

        // Batedeira
        Batedeira b = new Batedeira();

        b.setEstoque(100);
        b.setModelo("Eletrolux");
        b.setPreco(100000.0);

        b.descricao();

        b.comprar(1);

        System.out.println("Estoque: " + b.getEstoque());

        b.reembolsar(2);

        System.out.println("Estoque: " + b.getEstoque());

    }
}
