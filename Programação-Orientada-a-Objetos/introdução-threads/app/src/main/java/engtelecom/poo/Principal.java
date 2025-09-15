package engtelecom.poo;

public class Principal {
    public static void main(String[] args) {
        Contador c = new Contador();
        // Fluxo f1 = new Fluxo(c, 1);
        // Fluxo f2 = new Fluxo(c, 2);
        // System.out.println("Início");
        // f1.disparar();
        // f2.disparar();
        // System.out.println("Fim do programa");


        // Thread comHeranca = new FluxoComHeranca();
        Thread f1 = new Thread(new FluxoComInterface(c, 1));
        Thread f2 = new Thread(new FluxoComInterface(c, 2));
        System.err.println("Início");
        f1.start();
        f2.start();
        System.err.println("Fim do programa");

    }

    

}
