package engtelecom.poo.produtos;

import engtelecom.poo.Dimensao;

public class Celular extends SemFio {
    private int numCameras;

    public Celular(int codigo, String numSerie, String modelo, double peso, Dimensao dim, double frequencia, int canais,
            double distancia, int numCameras) {
        super(codigo, numSerie, modelo, peso, dim, frequencia, canais, distancia);
        this.numCameras = numCameras;
    }

    @Override
    public void imprimirDados(){
        super.imprimirDados();
        System.out.printf("numCameras: %d\n", numCameras);
    }

    public void setNumCameras(int numCameras) {
        this.numCameras = numCameras;
    }
}
