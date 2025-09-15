package engtelecom.poo;

import edu.princeton.cs.algs4.Draw;
import engtelecom.poo.produtos.Celular;
import engtelecom.poo.produtos.SemFio;
import engtelecom.poo.produtos.Telefone;

import java.awt.Color;
import java.awt.Rectangle;
import java.security.CodeSource;

public class App {
    private Draw desenho;

    public App(){
        this.desenho = new Draw();
        this.desenho.setXscale(0,600);
        this.desenho.setYscale(0,600);
        this.desenho.enableDoubleBuffering();
        this.desenho.setDefaultCloseOperation(3);
    }

    public void desenharQuadrado(int x, int y, int dimensao){
        desenho.setPenColor(Color.RED);
        desenho.filledSquare(x, y, dimensao);

    }

    public void desenharCirculo(int x, int y, int raio) {
        desenho.setPenColor(Color.BLUE);
        desenho.filledCircle(x, y, raio);
    }

    public static void main(String[] args) {

        Telefone pleno = new Telefone(1, "123", "pleno", 0.3, new Dimensao(1, 2, 3));
        SemFio sf = new SemFio(2, "456", "sem fio", 0.5, new Dimensao(1, 2, 3), 1.8, 14, 50);
        Celular c = new Celular(2, "456", "sem fio", 0.5, new Dimensao(1, 2, 3), 1.8, 14, 50, 2);
        
        // Telefone pleno = new Telefone(1, "123", "pleno", 0.3, new Dimensao(1, 2, 3));
        // Telefone sf = new SemFio(2, "456", "sem fio", 0.5, new Dimensao(1, 2, 3), 1.8, 14, 50);
        // Telefone c = new Celular(2, "456", "sem fio", 0.5, new Dimensao(1, 2, 3), 1.8, 14, 50, 2);

        pleno.setModelo("novo");
        sf.setCanais(2);
        c.setNumCameras(10);

        Telefone outro = sf; // outro só tem métodos de telefone
        //outro.setCanais(..) não dá porque o telefone não é um sem fio

        // float i = (float) 1/2; ---> mesma coisa (typecasting)
        ((SemFio)outro).setCanais(30);

        SemFio nova;
        nova = (SemFio) outro;
        //nova = (SemFio) pleno; problema em tempo de execução

        // nova = pleno;
        // nova = sf;
        // nova = c;




        // pleno.imprimirDados();
        // sf.imprimirDados(); 




        //Telefone t = c; // Celular é um telefone
        //Telefone t2 = sf;
        //Celular g = pleno; Telefone não é um celular!

        //sf.codigo = 10; //protected não deixa aqui! fora do pacote de Telefone

        //System.out.println(pleno); // toString padrão de Object
        //System.out.println(sf);







        // App app = new App();

        // int x = 150;
        // int y = 150;
        // int raio = 10;
        // int vx = 1;
        // int vy = 2;


        // while (true) {
        //     app.desenharQuadrado(300, 300, 20); 
        //     app.desenharCirculo(x, y, raio); 

        //     x += vx;
        //     y += vy;

        //     if ((x+raio > 600) || (x+raio < 0)) {
        //         vx *= -1;
        //     }

        //     if ((y+raio > 600) || (y+raio < 0)) {
        //         vy *= -1;
        //     }

        //     // verificar intersecção com quadrado
        //     // nesse retângulo x,y está na ponto superior esquerdo
        //     Rectangle quadrado = new Rectangle(300-20,300-20,40,40);
        //     Rectangle circulo = new Rectangle(x-raio,y-raio,2*raio,2*raio);

        //     if (quadrado.intersects(circulo)) {
        //         vx *= -1;
        //         vy *= -1;
        //     }


        //     app.desenho.pause(10);
        //     app.desenho.show();
        //     app.desenho.clear(Color.WHITE);
        // }
    }
}