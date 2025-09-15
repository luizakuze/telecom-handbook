package engtelecom.poo;

import java.util.ArrayList;
import edu.princeton.cs.algs4.Draw;

public class App {

    private Draw desenho;
    private Circulo circulos[] = new Circulo[2];

    public static void main(String[] args) {
        App app = new App();

        // Criação de um objeto da classe 
        app.desenho = new Draw();

        app.desenho.clear(Draw.PINK);

        app.desenho.setPenRadius(0.3);

        // Desenha uma linha dada as coordenadas
        app.desenho.line(1, 1, 50, 50);

        System.out.println(Circulo.getTotal());

        ArrayList<Circulo> lista = new ArrayList<>();

        // Criando objetos da classe Circulo
        Circulo c = new Circulo(1, 1, 3);
        Circulo d = new Circulo(1, 1, 3);

        // Adicionando referências dos objetos à lista
        lista.add(c);
        lista.add(d);

        System.out.println(Circulo.getTotal());
        
        // Criando um objeto da classe Circulo e adicionando sua referência diretamente à lista
        lista.add(new Circulo(7, 8, 9));

        // Iterando pela lista e imprimindo os objetos Circulo
        for (int i = 0; i < lista.size(); i++) {
            Circulo a = lista.get(i);
            System.out.println(a);
        }

        for (Circulo a : lista) {
            System.out.println(a);
        }

        // Usando a função forEach para imprimir os objetos da lista
        lista.forEach(a -> System.out.println(a));

        // Usando method reference para imprimir os objetos da lista
        lista.forEach(System.out::println);
    }
}
