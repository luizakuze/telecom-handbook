package engtelecom.poo;

public class FluxoComInterface implements Runnable{
    private Contador c;
    private int id;

    public FluxoComInterface (Contador c, int id) {
        this.c = c; this.id = id;
    }


    public void run(){
        for (int i = 0; i < 100; i++) {
            System.err.println(this.id + " - " + this.c.getNext());
        }
    }
}
