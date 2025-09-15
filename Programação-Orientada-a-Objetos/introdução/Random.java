//package engtelecom.poo;

import java.util.Random;
import java.util.Scanner;

public class Random {

    public static void main(String[] args) {
        
        Scanner teclado = new Scanner(System.in);
        Random r = new Random();
        int num = r.nextInt(10) + 1; // bound(0 a 9) e soma + 1

        System.out.print("Entre com um número (0 a 10): ");
        int n = teclado.nextInt();

        while (num != n) {
           System.out.println("Errou");
           n = teclado.nextInt();
        }

        System.out.println("Parabéns");

    }
}
