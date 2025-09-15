package engtelecom.poo;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.Scanner;
import java.util.Map.Entry;

public class App {

    private HashMap<String, UnidadeCurricular> banco;

    Scanner teclado = new Scanner(System.in);

    public App() {
        this.banco = new HashMap<>();
    }

    @Override
    public String toString() {
        return "App [banco=" + banco + "]";
    }

    public boolean adicionarUC(String c, UnidadeCurricular uc) {
        // verifica se a chave já existe, assim não sobrescreve o valor!
        if (!banco.containsKey(c)) {
            this.banco.put(c, uc);
            return true;
        }
        return false;
    }

    public boolean excluirUC(String c) {
        // verifica se contém a uc, assim pode remover
        if (banco.containsKey(c)) {
            this.banco.remove(c);
            return true;
        }
        return false;
    }

    public boolean mostrarUC(String codigo) {
        UnidadeCurricular uc = banco.get(codigo);
        if (uc != null) {
            System.out.println("----- UC " + codigo + " -----");
            System.out.println(uc);
            System.out.println("--------------");
            return true;
        }
        // uc não cadastrada
        return false;
    }

    public boolean mostrarUCs() {
        // banco vazio, não há UCs para mostrar
        if (this.banco.isEmpty()) {
            return false;
        }

        System.out.println("----- UCs Cadastradas -----");
        for (Map.Entry<String, UnidadeCurricular> uc : this.banco.entrySet()) {
            System.out.println(uc.getValue());
            System.out.println("---------------");
        }
        return true;
    }

    public boolean alteraUC(String codigoUc, int dado) {
        UnidadeCurricular uc = this.banco.get(codigoUc);

        // nome inválido da UC
        if (uc == null) {
            return false;
        }

        // variável que analisa se a alteração foi bem sucedida
        boolean alteracaoBemSucedida = false;

        switch (dado) {
            case 1:
                // altera o nome
                System.out.println("Entre com o novo nome da UC:");
                String novoNome = teclado.nextLine();
                uc.setNome(novoNome);
                alteracaoBemSucedida = true;
                break;

            case 2:
                // altera o código
                System.out.println("Entre com o novo código da UC:");
                String novoCodigo = teclado.nextLine();
                uc.setCodigo(novoCodigo);
                alteracaoBemSucedida = true;
                break;

            case 3:
                // altera a sigla
                System.out.println("Entre com a nova sigla da UC:");
                String novaSigla = teclado.nextLine();
                uc.setSigla(novaSigla);
                alteracaoBemSucedida = true;
                break;

            case 4:
                // altera o crédito
                System.out.println("Entre com o novo crédito da UC:");
                int novosCreditos = teclado.nextInt();
                uc.setCreditos(novosCreditos);
                alteracaoBemSucedida = true;
                break;

            case 5:
                // altera a ementa
                System.out.println("Entre com a nova ementa da UC:");
                String novaEmenta = teclado.nextLine();
                uc.setEmenta(novaEmenta);
                alteracaoBemSucedida = true;
                break;

            case 6:
                // altera o objetivo
                System.out.println("Tipo de alteração:");
                System.out.println("1 - Adicionar objetivo");
                System.out.println("2 - Remover objetivo");
                System.out.printf("Entre com uma opção: ");
                int opcao = teclado.nextInt();
                teclado.nextLine();

                switch (opcao) {
                    case 1:
                        // adiciona objetivo
                        System.out.printf("Entre com o novo objetivo:");
                        String novoObjetivo = teclado.nextLine();
                        uc.adicionarObjetivo(novoObjetivo);
                        alteracaoBemSucedida = true;
                        break;

                    case 2:
                        // remove objetivo
                        System.out.println("Objetivos atuais: " + uc.obterObjetivo());
                        System.out.print("Entre com o índice do objetivo a ser removido: ");
                        int indiceObjetivo = teclado.nextInt();
                        teclado.nextLine();
                        // não encontrou posição para remover o objetivo
                        if (uc.removerObjetivo(indiceObjetivo)) {
                            alteracaoBemSucedida = true;
                        }
                        break;
                }
                break;

            case 7:
                // altera o conteúdo
                System.out.println("Tipo de alteração:");
                System.out.println("1 - Adicionar conteúdo");
                System.out.println("2 - Remover conteúdo");
                System.out.printf("Entre com uma opção: ");
                opcao = teclado.nextInt();
                teclado.nextLine();

                switch (opcao) {
                    case 1:
                        // adiciona conteúdo
                        System.out.printf("Entre com o novo conteúdo:");
                        String novoConteudo = teclado.nextLine();
                        uc.adicionarConteudo(novoConteudo);
                        alteracaoBemSucedida = true;
                        break;

                    case 2:
                        // remove conteúdo
                        System.out.println("Conteúdos atuais: " + uc.obterConteudo());
                        System.out.printf("Entre com o índice do conteúdo a ser removido: ");
                        int indiceConteudo = teclado.nextInt();
                        teclado.nextLine();
                        // não encontrou posição para remover o conteúdo
                        if (uc.removerConteudo(indiceConteudo)) {
                            alteracaoBemSucedida = true;
                        }
                        break;
                }
                break;
        }
        return alteracaoBemSucedida;
    }

    public int menuDeOperacoes() {
        int opcao = 0;

        do {
            System.out.println("..:: Sistema Acadêmico ::..");
            System.out.println(" 1 - Adicionar UC");
            System.out.println(" 2 - Remover UC");
            System.out.println(" 3 - Alterar UC");
            System.out.println(" 4 - Exibir UC");
            System.out.println(" 5 - Listar todas as UC");
            System.out.println(" 6 - Sair");
            System.out.printf("Entre com uma opção: ");

            opcao = teclado.nextInt();

            switch (opcao) {
                case 1:
                    teclado.nextLine();

                    System.out.printf("Código:");
                    String codigo = teclado.nextLine();

                    System.out.printf("Nome:");
                    String nome = teclado.nextLine();

                    System.out.printf("Sigla:");
                    String sigla = teclado.nextLine();

                    System.out.printf("Créditos:");
                    Integer creditos = teclado.nextInt();

                    teclado.nextLine();

                    System.out.printf("Ementa:");
                    String ementa = teclado.nextLine();

                    UnidadeCurricular uc = new UnidadeCurricular(nome, codigo, sigla, creditos, ementa);
                    if (adicionarUC(codigo, uc)) {
                        System.out.println("Unidade curricular " + codigo + " cadastrada!");
                    } else {
                        System.out.println("Erro! Unidade curricular " + codigo + " já existente!");
                    }
                    break;

                case 2:
                    // remover uma UC
                    teclado.nextLine();

                    System.out.printf("Entre com o código da UC");
                    codigo = teclado.nextLine();

                    if (excluirUC(codigo)) {
                        System.out.println("Unidade curricular " + codigo + " removida!");
                    } else {
                        System.out.println("Erro! Unidade curricular " + codigo + " não existe!");
                    }
                    break;

                case 3:
                    // alterar uma UC
                    teclado.nextLine();

                    System.out.printf("Entre com o código da UC que deseja alterar: ");
                    String codigoUC = teclado.nextLine();

                    System.out.println("Tipo de dado:");
                    System.out.println("1 - Nome");
                    System.out.println("2 - Código");
                    System.out.println("3 - Sigla");
                    System.out.println("4 - Créditos");
                    System.out.println("5 - Ementa");
                    System.out.println("6 - Objetivo");
                    System.out.println("7 - Conteúdo");
                    System.out.printf("Entre com uma opção: ");
                    int dado = teclado.nextInt();

                    if (alteraUC(codigoUC, dado)) {
                        System.out.println("Dado alterado!");
                    } else {
                        System.out.println("Erro! Operação inválida.");
                    }
                    break;

                case 4:
                    // mostrar uma UC
                    System.out.printf("Entre com o código da UC:");
                    teclado.nextLine();
                    codigo = teclado.nextLine();

                    if (!mostrarUC(codigo)) {
                        System.out.println("UC " + codigo + " não existe!");
                    }
                    break;

                case 5:
                    // mostrar todas as UCs
                    if (!mostrarUCs()) {
                        System.out.println("Nenhuma UC cadastrada!");
                    }
                    break;

                case 6:
                    // sair
                    System.out.println("Fechando acesso ao sistema...");
                    break;

                default:
                    System.out.println("Opção inválida!");
            }

        } while (opcao != 6);

        return opcao;
    }

    public static void main(String[] args) {

        App app = new App();

        // app.adicionarUC();

        app.menuDeOperacoes();

    }
}
