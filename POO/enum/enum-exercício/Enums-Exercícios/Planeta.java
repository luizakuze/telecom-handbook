package engtelecom.poo;

public enum Planeta {
    
    MERCURIO(1),
    VENUS(2),
    TERRA(3),
    MARTE(4), 
    JUPITER(5),
    SATURNO(6),
    URANO(7),
    NETUNO(8);

    public final int posicao;

    Planeta(int pos){
        posicao = pos;
    }

    public static Planeta getByPosicao(int pos) {

        for (Planeta p : Planeta.values()) {
            if (pos == p.posicao) {
                return p;
            }
        }
        return null;
    }
}
