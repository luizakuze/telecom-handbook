package engtelecom.poo;

import java.time.Duration;
import java.time.Instant;

import raytracer.ABunchOfSpheres;

// NÃO FINALIZADO

public class App implements Runnable{

    private int num_frames;

    public App(int num_frames)  {
        this.num_frames = num_frames;
    }

    public void run() {
        ABunchOfSpheres movie = new ABunchOfSpheres();

        movie.render_scene("./frame" + String.format("%05d", this.num_frames) + ".png", this.num_frames);
 
    }

    public static void main(String[] args) {
        int num_frames = 30;


        Instant inicio = Instant.now();

  
        for (int i = 0; i < num_frames; i++) {
            Thread app = new Thread(new App(i));

            app.start();
            

        }

        Instant fim = Instant.now();

        Duration d = Duration.between(inicio,fim);

        System.out.println("Tempo decorrido em milissegundos: " + d.toMillis());

    }
}
