package engtelecom.poo;

public enum Naipe {
    
    OURO(1, "ouro", '\u2666'),
    ESPADA(2, "espada", '\u2660'),
    COPA(3, "copa", '\u2665'),
    PAUS(4, "paus", '\u2663');

    public final int valor;
    public final String nome;
    public final char simbolo;
    
    Naipe(int var, String n, char s){
        valor = var;
        nome = n;
        simbolo = s;
    }


}
