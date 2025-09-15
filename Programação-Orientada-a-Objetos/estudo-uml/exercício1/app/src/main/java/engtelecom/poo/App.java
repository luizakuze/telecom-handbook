package engtelecom.poo;

import java.util.ArrayList;

// um jogo de carros, onde pode comprar um carro e trocar o motos dele

public class App {

    public static final int TOTAL_CARROS = 3;
    public static final int TOTAL_PECAS = 3;

    private ArrayList<Jogador> jogadores;

    public App() {
        this.jogadores = new ArrayList<>();
    }

    // "entrou na partida"
    public void criarJogador(String nome) {
        // já começou com um carro base
        Motor m = new Motor(120, 4);
        Carro c = new Carro("ferrari", m);
        Jogador j = new Jogador(nome, c);
        this.jogadores.add(j);
    }


    public void comprarCarro(Jogador j, Carro c) {
        if (j.comprarCarro(c)) {
            System.out.println("Carro comprado com sucesso!");
        } else {
            System.out.println("Garagem cheia");
        }
    }

    // refatorando o método anterior
    public void comprarMotor(Jogador j) {
        if (j.comprarMotor(new Motor(200, 6))) {
            System.out.println("Motor comprado com sucesso!");
        } else {
            System.out.println("Estante cheia");
        }
    }

    public void venderCarro(Jogador j, int posicao){
        j.venderCarro(posicao);
    }

    public static void main(String[] args) {
        App app = new App();

        app.criarJogador("Juca");

        app.comprarMotor(app.jogadores.get(0)); //trocou o motor do carro atual

        app.criarJogador("Computador"); // jogo de 1 jogador x computador!
        
        // comprando 3 carros p cada jogador
        app.comprarCarro(app.jogadores.get(0), new Carro("fusca", new Motor(123, 4)));
        app.comprarCarro(app.jogadores.get(0), new Carro("gol", new Motor(456, 4)));
        app.comprarCarro(app.jogadores.get(0), new Carro("celta", new Motor(789, 4)));

        app.comprarCarro(app.jogadores.get(1), new Carro("uno", new Motor(111, 4)));
        app.comprarCarro(app.jogadores.get(1), new Carro("hb20", new Motor(222, 4)));
        app.comprarCarro(app.jogadores.get(1), new Carro("cruze", new Motor(333, 4)));

        // só pode vender carros que estão na garagem

        System.out.println("Antes de vender");

        app.venderCarro(app.jogadores.get(0), 0);

        app.jogadores.remove(0); // removendo o jogador 0

        System.out.println("Fim");
    }
}