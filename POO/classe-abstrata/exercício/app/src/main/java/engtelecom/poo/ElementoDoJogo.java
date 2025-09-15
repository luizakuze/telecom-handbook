package engtelecom.poo;

import edu.princeton.cs.algs4.Draw;

// classe abstrata p não poder instanciar objetos do tipo ElementoDoJogo no App!
public abstract class ElementoDoJogo {
    protected int posicaoX;
    protected int posicaoY;

    public ElementoDoJogo(int posicaoX, int posicaoY) {
        this.posicaoX = posicaoX;
        this.posicaoY = posicaoY;
    }

    public int getPosicaoX() {
        return posicaoX;
    }

    public int getPosicaoY() {
        return posicaoY;
    }

    // existe para poder chamar na app o desenho de todos os elementos!
    // POLIMORFISMO
    // public void desenhar(Draw d){
    // }

    // método abstrato não preca de implementação
    // todas as classes filhas precisam ter a implementação!
    public abstract void desenhar(Draw d);

}