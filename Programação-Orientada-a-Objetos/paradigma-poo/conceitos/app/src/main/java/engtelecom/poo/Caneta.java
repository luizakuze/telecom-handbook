package engtelecom.poo;

public class Caneta {
    
    // Atributos
    private String cor = "azul";
    private double nivelTinta = 100;

    // Métodos
    public void desenhar(int x0, int y0, int x1, int y1){
        if (this.nivelTinta == 0) {
            System.out.println("Caneta descarregada");
        } else {
            int x = x1 - x0;
            int y = x1 - x0;
            
            double dist = Math.sqrt(Math.pow(x,2) + Math.pow(y,2));
            double tinta = this.nivelTinta - dist*0.2;

            // tinta necessária p desenho
            if (tinta >= 0) {
                System.out.printf("Desenhando %.2f unidades\n", dist);
                this.nivelTinta -= dist*0.2;
            } else {
                System.out.println("Tinta insuficiente");
            }
        }
    }
 
    public void setCor(String c) {
        this.cor = c;
    }

    public String getCor() {
        return cor;
    }

    public void setNivelTinta(double nivelTinta) {
        this.nivelTinta = nivelTinta;
        if (nivelTinta > 100) { 
            this.nivelTinta = 100; 
        } else if (nivelTinta < 0) {
            this.nivelTinta = 0;
        }
    }
  
    public double getNivelTinta() {
        return nivelTinta;
    }



}
