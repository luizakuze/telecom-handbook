package engtelecom.poo;

public enum DiasDaSemana {

    DOMINGO(0), 
    SEGUNDA(1),
    TERCA(2),
    QUARTA(3),
    QUINTA(4),
    SEXTA(5),
    SABADO(6);

    public final int codigo; // atributo de enum

    DiasDaSemana(int cod) {
        codigo = cod;
    }

    public static DiasDaSemana getByCodigo(int cod) {

        for (DiasDaSemana d : DiasDaSemana.values()) {
            if (cod == d.codigo) {
                return d;
            }
        }
        return null;
    }

}