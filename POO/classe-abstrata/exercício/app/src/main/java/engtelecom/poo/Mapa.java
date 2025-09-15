package engtelecom.poo;

import java.util.ArrayList;
import java.util.Random;

import edu.princeton.cs.algs4.TwoPersonZeroSumGame;

public class Mapa {

    private int largura;
    private int altura;

    private ArrayList<ElementoDoJogo> elementos;

    public static final int TOTAL_TESOUROS = 2;

    public Mapa(int largura, int altura, int totalDeTesouros) {
        this.largura = largura;
        this.altura = altura;
        this.elementos = new ArrayList<>();
        this.posicionaElementos();
    }

    /// TODO posicionar tesouros
    public void posicionaElementos() {
        elementos.add(new Tesouro(100, 100, 10));
        elementos.add(new Tesouro(200, 200, 20));
        elementos.add(new Tesouro(300, 300, 30));

        elementos.add(new Parede(200, 400));
        elementos.add(new Parede(300, 500));
    }

    public Tesouro coletarTesouro(int x, int y) {
        for (ElementoDoJogo e : elementos) {
            if (e instanceof Tesouro) {
                if (e.getPosicaoX() == x && e.getPosicaoY() == y) {
                    elementos.remove(e);
                    return (Tesouro) e;
                }
            }
        }
        return null;
    }

    public boolean temTesouroAqui(int x, int y) {
        return false;
    }

    public int getLargura() {
        return largura;
    }

    public int getAltura() {
        return altura;
    }

    public ArrayList<Tesouro> getTesouros() {
        ArrayList<Tesouro> tesouros = new ArrayList<>();
        for (var e : elementos) {
            if (e instanceof Tesouro) {
                tesouros.add((Tesouro) e);
            }
        }
        return tesouros;
    }
}