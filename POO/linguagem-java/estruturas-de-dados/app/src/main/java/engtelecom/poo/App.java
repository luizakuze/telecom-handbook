package engtelecom.poo;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class App {
    public static void main(String[] args) {

        //ArrayList<Aluno> alunos = new ArrayList<>();
        // ArrayList<String> cidades = new ArrayList<>();
        //String sje = "São José";
        //String fln = "Florianópolis";

        // Aluno joao = new Aluno (123, "Joao");
        // alunos.add(joao);
        // sout(alunos); // invoca o toString dos alemenetos que estão dentro

        // cidades.add(sje);
        // cidades.add(fln);



    
        Map<Integer, Aluno> alunos = new HashMap<>();

        Aluno joao = new Aluno (123, "Joao");
        Aluno maria = new Aluno(456, "Maria");
        Aluno juca = new Aluno(123, "Juca");

        alunos.put(joao.getMatricula(), joao);
        //alunos.put(juca.getMatricula(), juca); //substituiria joao

        // procura pela chave
        Aluno a = alunos.get(123);
        System.out.println(a);




        


        //j= null;
        //joao = null;
        //joao = alunos.get(0);
        //alunos.add(new Aluno(789, "Juca"));
        //j = alunos.get(2);

        // String outra = "Florianópolis";
        //Aluno j = new Aluno (123, "Joao"); //não está na lista!
        // Aluno j = joao; // copiou o endereço do joao, "j" não é um objeto

        // if (cidades.contains(outra)) {
        //     System.out.println("Tem Floripa");
        // } else {
        //     System.out.println("Não tem Floripa");
        // }

        // if (alunos.contains(joao)) {
        //     System.out.println("Tem João");
        // } else {
        //     System.out.println("Não tem João");
        // }

        // alunos.removeIf(a->a.getMatricula() == 123);

        // alunos.forEach(a->{
        //     if (a.getMatricula() == 123) {
        //         System.out.println("Tem João");
        //     }
        // });

    }
}