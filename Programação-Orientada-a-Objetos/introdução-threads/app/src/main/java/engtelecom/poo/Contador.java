package engtelecom.poo;

public class Contador {
    private int valor = 0;
    
    public int getNext() {
        return ++this.valor;
    }
}
