package engtelecom.poo;

public enum Valor {
    
    AS(1, "A"),
    DOIS(2, "2"), //    DOIS(2, "dois.png") 
    TRES(3, "3"),
    QUATRO(4, "4'"),
    CINCO(5, "5"),
    SEIS(6, "6"),
    SETE(7, "7"),
    OITO(8, "8"),
    NOVE(9, "9"),
    DEZ(10, "10"),
    VALETE(11, "J"),
    DAMA(12, "Q"),
    REI(13, "K");

    public final int valor;
    public final String simbolo;

    Valor(int var, String simb){
        valor = var;
        simbolo = simb;
    }

}
