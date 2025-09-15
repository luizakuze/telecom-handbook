package engtelecom.poo;

import java.text.ParseException;
import java.util.InputMismatchException;
import java.util.Scanner;

import javax.swing.text.MaskFormatter;

public class App {
    Scanner ler = new Scanner(System.in);


    public static String formataCep(String numero) throws ParseException {

        MaskFormatter mascara = new MaskFormatter("#####-###");

        return "";  
    }

    public static String formataTelefone(String numero) {

        try {
            MaskFormatter mascara = new MaskFormatter("(##) #####-####");
        } catch (ParseException e) {
            System.err.println("valor errado");
        } 

        return "";
    }

    public static void main(String[] args) throws ParseException {

        String formatado = formataTelefone("48984566635");
        System.out.println(formatado);


        String cepFormatado = formataCep("12345-678");
        System.out.println(cepFormatado);



        System.out.println("Fim");



        // int a, b;

        // try{
        //     a = ler.nextInt();
        //     b = ler.nextInt();

        //     int res = (int) a / b;

        //     System.out.println(a + " dividido por " + b + " = " + res);
        
        // } catch (InputMismatchException e) {
        //     System.err.println("Entrou com valor diferente de int");
        // } catch (ArithmeticException e) {
        //     System.err.println("Divisão por zero");
        // } catch (Exception e) { 
        //     System.err.println("Comportamento Inesperado");
        // }
    }
}
