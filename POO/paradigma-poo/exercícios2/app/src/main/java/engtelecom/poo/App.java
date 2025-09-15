package engtelecom.poo;

public class App {
    public static void main(String[] args) {
        // Crie um objeto Tempo usando o construtor padrão
        Tempo tempo1 = new Tempo();
        System.out.println("Tempo1 (construtor padrão): " + tempo1);

        // Crie um objeto Tempo especificando apenas as horas
        Tempo tempo2 = new Tempo(7);
        System.out.println("Tempo2 (horas): " + tempo2);

        // Crie um objeto Tempo especificando horas e minutos
        Tempo tempo3 = new Tempo(7, 30);
        System.out.println("Tempo3 (horas e minutos): " + tempo3);

        // Crie um objeto Tempo especificando horas, minutos e segundos
        Tempo tempo4 = new Tempo(7, 30, 45);
        System.out.println("Tempo4 (horas, minutos e segundos): " + tempo4);

        // Altere o tempo4 para um valor inválido de horas
        boolean alterado = tempo4.setHoras(25);
        if (alterado) {
            System.out.println("Tempo4 (após alteração): " + tempo4);
        } else {
            System.out.println("Horas inválidas. Tempo4 não foi alterado.");
        }

        // Altere o tempo4 para um valor válido de horas
        alterado = tempo4.setHoras(12);
        if (alterado) {
            System.out.println("Tempo4 (após alteração): " + tempo4);
        } else {
            System.out.println("Horas inválidas. Tempo4 não foi alterado.");
        }

        // Calcule o tempo em segundos para tempo3
        System.out.println("Tempo em segundos (tempo3): " + tempo3.tempoEmSegundos());

        // Calcule a diferença de tempo entre tempo3 e tempo4
        long diferenca = tempo3.diferencaTempo(tempo4);
        System.out.println("Diferença de tempo entre tempo3 e tempo4: " + diferenca);

        // Defina um horário em segundos para tempo1
        tempo1 = tempo1.definirHorario(3665);
        System.out.println("Tempo1 (após definir horário em segundos): " + tempo1);
    }
}
