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
        this();
        this.setHoras(horas);
    }

    public Tempo(int horas, int minutos) {
        this();
        this.setHoras(horas);
        this.setMinutos(minutos);
    }

    public Tempo(int horas, int minutos, int segundos) {
        this.setHoras(horas);
        this.setMinutos(minutos);
        this.setSegundos(segundos);
    }

    public long tempoEmSegundos() {
        long tempo = 0;
        if (this.horas > 0) {
            tempo += this.horas * 3600;
        }
        if (this.minutos > 0) {
            tempo += this.minutos * 60;
        }
        tempo += this.segundos;
        return tempo;
    }

    public long diferencaTempo(Tempo t) {
        long t1 = this.tempoEmSegundos();
        long t2 = t.tempoEmSegundos();
        return Math.abs(t1 - t2); // módulo
    }

    public String toString() {
        String h = String.format("%02d", horas);
        String min = String.format("%02d", minutos);
        String seg = String.format("%02d", segundos);
        return h + ":" + min + ":" + seg;
    }

    public int getHoras() {
        return horas;
    }

    public boolean setHoras(int horas) {
        if (horas >= 0) {
            this.horas += horas;
            return true;
        }
        return false;
    }

    public int getMinutos() {
        return minutos;
    }

    public boolean setMinutos(int minutos) {
        if (minutos >= 0) {
            // 1 minuto são 60 segundos
            while (minutos >= 60) {
                this.horas++;
                minutos -= 60;
            }
            this.minutos += minutos;
            return true;
        }
        return false;
    }

    public int getSegundos() {
        return segundos;
    }

    public boolean setSegundos(int segundos) {
        if (segundos >= 0) {
            // 1 hora são 60 minutos
            while (segundos >= 3600) {
                this.horas++;
                segundos -= 3600;
            }
            // 1 minuto são 60 segundos
            while (segundos >= 60) {
                this.minutos++;
                segundos -= 60;
            }
            this.segundos += segundos;
            return true;
        }
        return false;
    }

}