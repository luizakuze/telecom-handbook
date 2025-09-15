package engtelecom.poo;

import java.util.Scanner;

public class App {
    public static void main(String[] args) {

        Data a = new Data(24, 8);

        System.out.println(a.toString());
        Data b = new Data(25, 8, 2023);

        int diferencaDias = a.diferencaEmDias(b);

        //b.diferencaEmDias(a);
        // Scanner teclado = new Scanner(System.in);

        // System.out.println("Entre com o dia: ");
        // int dia = teclado.nextInt();
        // System.out.println("Entre com o mes: ");
        // int mes = teclado.nextInt();
        // System.out.println("Entre com o ano: ");
        // int ano = teclado.nextInt();

        // System.out.println(d);
    
        // do {
        //     System.out.println("Entre com o mes: ");
        //     mes = teclado.nextInt();
        // } while (!d.setMes(mes));

        // System.out.println(d);
    }
}
