package engtelecom.poo;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.security.Principal;
import java.util.ArrayList;
import java.util.Scanner;

import javax.imageio.stream.FileImageInputStream;

public class App{


    public void escrever(String nomeDoArquivo){

        File arquivo = new File(nomeDoArquivo);

        // try with resources (gera automaticamente um Finally e um arquivo.close()
        try (FileWriter fw = new FileWriter(arquivo, true); // true para não sobreescrever arquivo
            BufferedWriter bw = new BufferedWriter(fw)) {

            bw.write("Olá mundo"); // UTF-8, ISO-8859-1 ---> usa por padrão o da própria plataforma, mas podemos escolher uma // poderia ter um \n, mas nem todos os sistemas operacionais funcionam
            bw.newLine();
            bw.write("Hello world");
            bw.newLine();

        } catch (IOException e) {
            System.err.println("Erro ao abrir o arquivo: " + e);
        }
    }

    public void ler(String nomeDoArquivo) {

        File arquivo = new File(nomeDoArquivo);

        //scanner de arquivos precisa do scanner.close, pro teclado não
        try (Scanner linha = new Scanner(arquivo)) {

            // enquanto houver outra linha para ler
            while(linha.hasNextLine()){
                String s = linha.nextLine();

                String[] campos = s.split(",");

                System.out.println("Nome: " + campos[0]);
                System.out.println("Email: " + campos[1]);
                System.out.println("Nota: " + campos[2]);

            }
        } catch (FileNotFoundException e) {
            System.err.println("Erro ao encontrar o arquivo: " + e);
        }

    }

    public void lerDoResource(String nomeDoArquivo){
        InputStream is = getClass().getClassLoader().getResourceAsStream(nomeDoArquivo);

        Scanner linha = new Scanner(is);

        while(linha.hasNextLine()){
            String s = linha.nextLine();
            System.out.println(s);
        }

    }

    public void salvarPessoa(String nomeDoArquivo, Pessoa p){
        File arquivo = new File(nomeDoArquivo);

        try (FileOutputStream fos = new FileOutputStream(arquivo)) {
            
            ObjectOutputStream oos = new ObjectOutputStream(fos);

            oos.writeObject(p);

        } catch (IOException e) {
            System.err.println("Deu erro: " + e);
        }
    }

    public void lerDoDisco(){
        File arquivo = new File("agenda.dat");

        try (FileInputStream fin = new FileInputStream(arquivo);
            ObjectInputStream oin = new ObjectInputStream(fin)) {

            ArrayList<Pessoa> p = (ArrayList<Pessoa>) oin.readObject();

            p.forEach(System.out::println);

        } catch (Exception ex) {
            System.err.println("erro: " + ex.toString());
        }
    }

    public static void main(String[] args) {
        // var app = new App();
        // //app.escrever("arquivo.txt");
        // app.ler("app/src/main/resources/alunos.csv"); // colocar caminho relativo sempre!
        // //app.lerDoResource("alunos.csv"); 

        var app = new App();

        Pessoa luiza = new Pessoa(1,"Luiza","luiza@gmail.com");

        // dat --> arquivo p data
        app.salvarPessoa("agenda.dat",luiza);
        
        app.lerDoDisco();
    }

}

//arquivo txt;csv
//no projeto: nome,pontuacao
//no máximo 5 linhas
// não precisa ser n resources