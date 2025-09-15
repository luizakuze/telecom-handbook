package engtelecom.poo;

public class Tempo {
    // atributos
    private int horas;
    private int minutos;
    private int segundos;

    // construtor padrão
    public Tempo() {
        this.horas = 0;
        this.minutos = 0;
        this.segundos = 0;
    }

    public Tempo(int horas) {
        this(horas, 0, 0);
    }

    public Tempo(int horas, int minutos) {
        this(horas, minutos, 0);
    }

    public Tempo(int horas, int minutos, int segundos) {
        if (setHoras(horas) && setMinutos(minutos) && setSegundos(segundos)) {
            this.horas = horas;
            this.minutos = minutos;
            this.segundos = segundos;
        }
    }

    public long tempoEmSegundos() {
        long tempo = this.segundos;
        if (this.horas > 0) {
            tempo += this.horas * 3600;
        }
        if (this.minutos > 0) {
            tempo += this.minutos * 60;
        }
        return tempo;
    }

    public long diferencaTempo(Tempo t) {
        long t1 = this.tempoEmSegundos();
        long t2 = t.tempoEmSegundos();
        return Math.abs(t1 - t2); // módulo
    }

    public Tempo definirHorario(int segundos) {
        Tempo t = new Tempo();

        // 1 hora são 60 minutos
        while (segundos >= 3600) {
            t.horas++;
            segundos -= 3600;
        }
        // 1 minuto são 60 segundos
        while (segundos >= 60) {
            t.minutos++;
            segundos -= 60;
        }
        t.segundos = segundos;

        return t;
    }

    public String toString() {
        return String.format("%02d:%02d:%02d", horas, minutos, segundos);
    }

    public int getHoras() {
        return horas;
    }

    public boolean setHoras(int horas) {
        if (horas >= 0 && horas < 24) {
            this.horas = horas;
            return true;
        }
        return false;
    }

    public int getMinutos() {
        return minutos;
    }

    public boolean setMinutos(int minutos) {
        if (minutos >= 0 && minutos < 60) {
            this.minutos = minutos;
            return true;
        }
        return false;
    }

    public int getSegundos() {
        return segundos;
    }

    public boolean setSegundos(int segundos) {
        if (segundos >= 0 && segundos < 60) {
            this.segundos = segundos;
            return true;
        }
        return false;
    }
}
