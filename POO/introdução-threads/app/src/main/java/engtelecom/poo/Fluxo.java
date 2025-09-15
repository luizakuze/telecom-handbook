package engtelecom.poo;

public class Fluxo {
    private Contador c;
    private int id;

    public Fluxo (Contador c, int id) {
        this.c = c; this.id = id;
    }

    public void disparar(){
        for (int i = 0; i < 100; i++) {
            System.out.println(this.id + " - " + this.c.getNext());
        }
    }
}
