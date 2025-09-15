package engtelecom.poo;

import edu.princeton.cs.algs4.Draw;

import java.awt.Color;

public class Tesouro extends ElementoDoJogo {

    public static final int LARGURA = 10;
    public static final int ALTURA = 10;
    public static final int RAIO = 2;

    private int valor;

    public Tesouro(int valor, int posicaoX, int posicaoY) {
        super(posicaoX, posicaoY);
        this.valor = valor;
    }

    public int getValor() {
        return valor;
    }

    @Override
    public void desenhar(Draw d) {
        d.picture(this.posicaoX, this.posicaoY, "tesouro.png");
    }


}
