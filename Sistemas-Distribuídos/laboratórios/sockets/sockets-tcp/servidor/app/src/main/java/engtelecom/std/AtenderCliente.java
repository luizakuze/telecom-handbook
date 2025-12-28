package engtelecom.std;
// Runnable -> Threads

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.Socket;

public class AtenderCliente implements Runnable{
    private Socket cliente;  

    public AtenderCliente(Socket cliente) {
        this.cliente = cliente;
    }

    @Override
    public void run() {
        if (cliente != null) {
        int porta = 1234;

        try{

            System.out.println("Cliente conectado: " + cliente.getInetAddress());

            // Estabelecimento dos fluxos de entrada e saída
            BufferedReader entrada = new BufferedReader(
                new InputStreamReader(cliente.getInputStream(), "UTF-8"));

            DataOutputStream saida = new DataOutputStream(cliente.getOutputStream());
            String recebido = "";


            while(!recebido.equals("sair")) {
                // Comunicação (protocolo)
                // cliente envia msg, servidor tem que escutar
                recebido = entrada.readLine();
                System.out.println("Cliente " + cliente.getInetAddress() + "> " + recebido);

                // respondendo o cliente
                saida.writeBytes(recebido.toUpperCase() + " \n");
                // nc localhost 1234
            }


        } catch (IOException e) {
            System.err.println("Erro na thread: " + e.getMessage());
        }

        }
    }
    
}
