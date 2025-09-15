package engtelecom.poo;

import java.awt.Color;
import java.util.ArrayList;
import java.util.Random;
import java.awt.event.KeyEvent;

import edu.princeton.cs.algs4.Draw;
import edu.princeton.cs.algs4.DrawListener;

public class Robo extends ElementoDoJogo {

    public static final int LARGURA = 40;
    public static final int ALTURA = 40;

    private int velocidadeX;
    private int velocidadeY;

    private int pontuacao;

    private Mapa mapa;

    private int capacidadeMochila;
    private ArrayList<Tesouro> mochila;

    public static final int MAX_TENTATIVAS = 5;

    public Robo(Mapa mapa, int posicaoX, int posicaoY, int velocidadeX, int velocidadeY, int capacidadeMochila) {
        super(posicaoX, posicaoY);

        this.mapa = mapa;
        this.velocidadeX = velocidadeX;
        this.velocidadeY = velocidadeY;

        this.posicionarRoboNoMapa(this.mapa);

        this.pontuacao = 0;

        this.capacidadeMochila = capacidadeMochila;
        this.mochila = new ArrayList<>();
    }

    /**
     * Sorteia uma posição aleatória dentro dos limtes do mapa para o robô.
     * 
     * @param mapa Mapa que o robô está.
     * @return True se o robô for posicionado com sucesso e
     *         False caso contrário.
     */
    public void posicionarRoboNoMapa(Mapa mapa) {
        /// TODO implementar verificação de posições
        this.posicaoX = posicaoX;
        this.posicaoY = posicaoY;

    }

    /**
     * O robô cava na posição que está se tiver espaço na mochila.
     * 
     * @return True se encontrar um tesouro e False caso contrário.
     */
    public boolean cavar() {
        if (!mochilaCheia()) {
            Tesouro t = mapa.coletarTesouro(posicaoX, posicaoY);

            // achou um tesouro!
            if (t != null) {
                this.mochila.add(t);
                return true;
            }
        }
        return false; // não encontrou tesouro
    }

    /**
     * Remove o último tesouro colocado na mochila.
     * 
     * @return O tesouro removido.
     */
    public Tesouro removerTesouro() {
        Tesouro t = null;
        if (!mochila.isEmpty()) {
            t = mochila.remove(mochila.size() - 1);
            this.pontuacao -= t.getValor();
        }
        return t;
    }

    /**
     * Retorna a pontuação do jogo.
     * 
     * @return A pontuação.
     */
    public int pontuacao() {
        return this.pontuacao;
    }

    /**
     * Verifica se a mochila está cheia.
     * 
     * @return True se a mochial estiver cheia e False caso contrário.
     */
    public boolean mochilaCheia() {
        return this.mochila.size() == this.capacidadeMochila; // "isFull"
    }

    /**
     * Movimenta o robô de acordo com a direção informada.
     * 
     * @param direcao A direção para onde o robô deve se mover.
     *                0 para cima, 1 para a direita, 2 para baixo e 3 para a
     *                esquerda.
     * @return True se o robô conseguiu se mover com sucesso dentro dos limites do
     *         mapa e False caso contrário (quando está fora dos limites do mapa).
     */
    public boolean movimentar(int direcao) {

        // calcula a nova posição
        switch (direcao) {
            case KeyEvent.VK_RIGHT:
                this.posicaoX += 1;
                break;
            case KeyEvent.VK_UP:
                this.posicaoY += 1;
                break;
            case KeyEvent.VK_LEFT:
                this.posicaoX -= 1;
                break;
            case KeyEvent.VK_DOWN:
                this.posicaoY -= 1;
                break;

        }

        return true;
    }

    /// TODO coloco documentação??
    @Override
    public void desenhar(Draw d) {
        // d.setPenColor(Color.RED);
        // d.filledSquare(posicaoX, posicaoY, LARGURA);
        d.picture(this.posicaoX, this.posicaoY, "robo.png");

    }

    public boolean colisao() {
        return false;
    }

    public int getCapacidadeMochila() {
        return capacidadeMochila;
    }

}