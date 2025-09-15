package engtelecom.poo;

public class Carro {
    private String marca;
    private Motor propulsor;

    public Carro(String marca, Motor propulsor) {
        this.marca = marca;
        this.propulsor = propulsor;
    }

    public void acelerar (int v) {
    }

    // seria um set
    public void trocarMotor (Motor m) {
        this.propulsor = m;
    }

    public Motor getPropulsor() {
        return propulsor;
    }

    public void setPropulsor(Motor propulsor) {
        this.propulsor = propulsor;
    }

    
}
