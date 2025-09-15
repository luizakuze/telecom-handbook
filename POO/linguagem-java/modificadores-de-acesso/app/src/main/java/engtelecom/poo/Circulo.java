package engtelecom.poo;

public class Circulo {

    private int x;
    private int y;
    private double raio;

    // Atributo estático para contar o total de objetos Circulo
    private static int total;

    private final int MAX_X = 400;
    private final int MAX_Y = 400;

    // Construtor da classe Circulo
    public Circulo(int x, int y, double raio) {
        this.x = x;
        this.y = y;
        this.raio = raio;
        // Incrementa o total de objetos Circulo ao criar um novo objeto
        this.total++;
    }

    public String toString () {
        return "Círculo: x - " + this.x + " | y - " + this.y + " | raio - " + this.raio;
    }

    // Método estático para obter o total de objetos Circulo criados
    public static int getTotal() {
        return total;
    }

    // Getters e setters para os atributos da classe Circulo
    public int getX() {
        return x;
    }

    public boolean setX(int x) {
        if (x >= 0 && x <= MAX_X) {
            this.x = x;
            return true;
        }
        return false;
    }

    public int getY() {
        return y;
    }

    public boolean setY(int y) {
        if (x >= 0 && x <= MAX_Y) {
            this.y = y;
            return true;
        }
        return false;
    }

    public double getRaio() {
        return raio;
    }

    public void setRaio(double raio) {
        this.raio = raio;
    }

    // Método estático para definir o total de objetos Circulo (não recomendado)
    // public static void setTotal(int total) {
    //     Circulo.total = total;
    // }
}
