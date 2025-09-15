package engtelecom.poo;

public class App2 {
    public static void main(String[] args) {
        // construtores
        Tempo t1 = new Tempo();
        Tempo t2 = new Tempo(1);
        Tempo t3 = new Tempo(1, 2);
        Tempo t4 = new Tempo(1, 2, 3);

        System.out.println("Tempo: " + t1);
        System.out.println("Tempo: " + t2);
        System.out.println("Tempo: " + t3);
        System.out.println("Tempo: " + t4 + "\n");

        // minuto = 60 -----> mais uma hora
        Tempo t5 = new Tempo();
        System.out.println("Tempo: " + t5.toString());

        t5.setMinutos(70);
        System.out.println("Tempo: " + t5.toString());

        t5.setSegundos(60);
        System.out.println("Tempo: " + t5.toString());

        t5.setSegundos(3600);
        System.out.println("Tempo: " + t5.toString());
        t5.setSegundos(7000);
        System.out.println("Tempo: " + t5.toString());
        t5.setSegundos(-7000);
        System.out.println("Tempo: " + t5.toString() + "\n");

        // o tempo total em segundos
        System.out.println("Tempo em segundos: " + t2.tempoEmSegundos());

        // a diferença de tempos
        System.out.println("Diferença de tempo: " + t3.diferencaTempo(t2) + "\n");

        // teste para um tempo negativo
        Tempo t6 = new Tempo(-100000000, -1000, 80);
        System.out.println("Tempo: " + t6);

        Tempo t7 = new Tempo(1);
        Tempo t8 = new Tempo(2);
        System.out.println("Dif teste: " + t7.diferencaTempo(t8));
        System.out.println("Dif teste: " + t8.diferencaTempo(t7));
    }
}