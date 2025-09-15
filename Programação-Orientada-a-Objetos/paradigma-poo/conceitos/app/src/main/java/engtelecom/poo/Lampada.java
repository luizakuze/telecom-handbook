package engtelecom.poo;

public class Lampada {
    // Atributos
    private String tipo = "led";
    private String estado = "apagada";
    private int potencia = 50;

    // Métodos
    public void acender() {
        if (this.estado.equals("apagada")) {
            this.estado = "acesa";
            System.out.println("Lâmpada acendeu!");
        } else {
            System.out.println("Já está acesa");
        }
    }

    public void apagar() {
        if (this.estado.equals("acesa")) {
            this.estado = "apagada";
            System.out.println("Lâmpada apagou!");
        } else {
            System.out.println("Já está apagada");
        }
    }


    public String getTipo() {
        return tipo;
    }
    public void setTipo(String tipo) {
        this.tipo = tipo;
    }
    public String getEstado() {
        return estado;
    }
    public void setEstado(String estado) {
        this.estado = estado;
    }
    public int getPontecia() {
        return potencia;
    }
    public void setPontecia(int pontecia) {
        this.potencia = pontecia;
    }

    
}
