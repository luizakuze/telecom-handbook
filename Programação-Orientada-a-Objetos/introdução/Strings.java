import java.util.Random;
import java.util.Scanner;

public class Strings {

    public static void main(String[] args) {

       // Objeto da classe Scanner, ele lê bytes
       // System.in = Pegar os bytes do teclado
       Scanner teclado = new Scanner (System.in);

       System.out.print("Entre com o seu nome: ");
       String nome = teclado.nextLine();

       System.out.println("Bom dia, " + nome);

       System.out.println("Entre com o ano do seu nascimento: ");
       int ano = teclado.nextInt();

       System.out.println("Você tem " + (2023-ano) + " anos");

         Scanner teclado = new Scanner (System.in);

         // 10/agosto/2023
         System.out.print("Entre com o uma data (dd/MM/aaaa): ");
         String data = teclado.nextLine();

         // verdade se a string for vazia
         if (!data.isBlank()) {

             // para fatiar a string e criar um vetor
             String[] v = data.split("/");

             // comparar strings (diferente de == (?))
             //agosto.equals(v[1])
             //v[1].equals("agosto") || v[1].equals("ago")
             if (v[1].contains("ago")) {
                 System.out.println("8");
             } else {
                 System.out.println("Mês errado");
             }
         }
    }
}