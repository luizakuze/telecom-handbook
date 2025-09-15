package engtelecom.poo;

//1 mes se for invalido
// mes pode alterar

public class Data {
    // atributos
    private int dia;
    private int mes;
    private int ano;

    // construtor vazio
    public Data() {
        this.dia = 0;
        this.mes = 0;
        this.ano = 0;
    }

    public Data(int dia, int mes) {
        this();
        this.dia = dia;
        this.mes = mes;
    }

    public Data(int dia, int mes, int ano) {
        this();
        this.dia = dia;
        this.mes = 1;
        this.setMes(mes);
        this.ano = ano;
    }

    public String toString() {
        return dia + "/" + mes + "/" + ano;
    }

    public int diferencaEmDias(Data d) {
        return this.dia - d.dia;
    }

    public int getDia() {
        return dia;
    }

    public void setDia(int dia) {
        this.dia = dia;
    }

    public int getMes() {
        return mes;
    }

    public boolean setMes(int mes) {
        if (mes <= 12 && mes >= 1) {
            this.mes = mes;
            return true;
        } 
        return false;
    }

    public int getAno() {
        return ano;
    }

    public void setAno(int ano) {
        this.ano = ano;
    }

}
