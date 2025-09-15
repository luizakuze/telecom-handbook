#include <iostream>
#include <cstdlib>
#include <ctime>
#include <set>
#define N 100000 // número de simulações

/* Questão 07 - Lista Básica (Apresentação)
 * Alguns amigos estão em uma lanchonete e há duas travessas na mesa com salgados. A primeira travessa contém 3 pastéis e 5 coxinhas, e a segunda contém 2 coxinhas e 4 pastéis.
 * Se alguém escolher uma das travessas e, em seguida, pegar um salgado ao acaso,
 * qual é a probabilidade de ter pego um pastel? */
void Q7 () {
    srand(time(NULL));

    // probabilidade de pegar um pastel em cada travessa
    const double prob_travessa1 = 3.0 / (3 + 5);
    const double prob_travessa2 = 4.0 / (4 + 2);

    int pegou_pastel = 0;

    for (unsigned i = 0; i < N; i++) {
        int travessa_escolhida = rand() % 2 + 1; // 1 para travessa 1 e 2 para travessa 2
        double salgado_escolhido = (double) rand() / RAND_MAX;

        // verifica se o salgado escolhido é um pastel
        if ((travessa_escolhida == 1 && salgado_escolhido < prob_travessa1) ||
            (travessa_escolhida == 2 && salgado_escolhido < prob_travessa2)) {
            pegou_pastel++;
        }
    }

    double prob_pastel = (double) pegou_pastel / N;
    std::cout << "> Questão 07 - Apresentação" << std::endl;
    std::cout << "Probabilidade total de pegar um pastel: " << prob_pastel << std::endl << std::endl;
}

/* Questão 09 - Lista Básica (Resolvidos)
 * Numa turma de curso de inglês com dez alunos, dentre eles Joana, quatro serão escolhidos para ganhar um livro. Qual a probabilidade de Joana ser sorteada? */
void Q9() {
    srand(time(NULL));

    const int total_alunos = 10;     // número total de alunos na turma
    const int alunos_a_escolher = 4; // alunos a serem escolhidos para ganhar um livro

    int sorteou_joana = 0;

    for (unsigned i = 0; i < N; i++) {
        std::set<int> alunos_escolhidos;

        // escolhe 4 alunos
        while (alunos_escolhidos.size() < alunos_a_escolher) {
            int aluno_sorteado = rand() % total_alunos + 1;  // de 1 até 10 alunos
            alunos_escolhidos.insert(aluno_sorteado);     // insere o aluno sorteado no set
        }

        // verifica se Joana (representada pelo número 1) foi sorteada
        if (alunos_escolhidos.find(1) != alunos_escolhidos.end()) {
            sorteou_joana++;
        }
    }

    double probabilidade = (double) sorteou_joana / N;

    std::cout << "> Questão 09 - Resolvidos" << std::endl;
    std::cout << "A probabilidade de Joana ser sorteada é: " << probabilidade << std::endl << std::endl;
}

/* Questão 09 - Lista Básica (Propostos)
 * Considere um conjunto de 4 números dos quais nenhum deles é zero, dois são positivos e
 * dois são negativos. Sorteamos ao acaso, com reposição, 2 números desse conjunto. 
 * Determine a probabilidade de: 
 * a.) Um deles ser negativo 
 * b.) O quociente entre eles ser negativo.
 * c.) Os dois números terem o mesmo sinal */
void Q9p() {
    srand(time(NULL));

    double prob_negativo = 0;
    double prob_quociente_negativo = 0;
    double prob_mesmo_sinal = 0;

    for (unsigned i = 0; i < N; i++) {
        // escolhe 2 números, considerando:
        // 0 e 1 para positivos e 2 e 3 para negativos
        int num1 = rand() % 4;
        int num2 = rand() % 4;

        // probabilidade de um deles ser negativo (a) e probabilidade do quociente ser negativo (b)
        if ((num1 >= 2 && num2 < 2) || (num2 >= 2 && num1 < 2)) {
            prob_negativo++;
            prob_quociente_negativo++;
        }

        // probabilidade dos números terem o mesmo sinal (c)
        if ((num1 >= 2 && num2 >= 2) || (num1 < 2 && num2 < 2)) {
            prob_mesmo_sinal++;
        }
    }

    prob_negativo /= N;
    prob_quociente_negativo /= N;
    prob_mesmo_sinal /= N;

    std::cout << "> Questão 09 - Propostos" << std::endl;
    std::cout << "Probabilidade de um deles ser negativo: " << prob_negativo << std::endl;
    std::cout << "Probabilidade de quociente ser negativo: " << prob_quociente_negativo << std::endl;
    std::cout << "Probabilidade de terem o mesmo sinal: " << prob_mesmo_sinal << std::endl << std::endl;
}

/* Questão 13 - Lista de Condicional (Apresentação)
 * Um jogo de computador requer que um jogador encontre um refúgio seguro num local onde os seus inimigos
 * não conseguem entrar. Quatro portas aparecem à sua frente, sendo que ele deve escolher uma para entrar.
 * A seguir, o jogador deve fazer uma segunda escolha entre dois, quatro, um ou cinco buracos para descer,
 * dependendo, respectivamente, da porta que ela atravessa. Em cada caso, um buraco leva ao porto seguro.
 * O jogador é pressionado em tomar uma decisão e em sua pressa faz escolhas aleatórias.
 * Qual é a probabilidade de ela chegar em segurança ao refúgio? */
void Q13() {
    srand(time(NULL));
    
    // conta quantas vezes teve sucesso na escolha
    int teve_sucesso = 0;

    for (unsigned i = 0; i < N; i++) {
        int porta_escolhida = rand() % 4 + 1; // escolhe uma porta entre 1, 2, 3, 4

        int buraco_escolhido;
        switch (porta_escolhida) {
            case (1):
                // entrou na P1, tem 2 buracos
                buraco_escolhido = rand() % 2; // entre 0 e 1
                if (buraco_escolhido == 0) // escolhendo buraco correto como o 0
                    teve_sucesso++;
                break;

            case (2):
                // entrou na P2, tem 4 buracos
                buraco_escolhido = rand() % 4;
                if (buraco_escolhido == 0)
                    teve_sucesso++;
                break;

            case (3):
                // entrou na P3, tem 1 buraco
                teve_sucesso++;
                break;

            default:
                // entrou na P4, tem 5 buracos
                buraco_escolhido = rand() % 5;
                if (buraco_escolhido == 0)
                    teve_sucesso++;
        }
    }

    double prob_sucesso = (double) teve_sucesso / N;

    std::cout << "> Questão 13 - Apresentação" << std::endl;
    std::cout << "Probabilidade de sucesso total: " << prob_sucesso << std::endl << std::endl;;
}

/* Questão 12 - Lista de Condicional (Apresentação) 
 * Antes de serem carregados em um caminhão de distribuição, os pacotes estão sujeitos a testes independentes,
 * para garantir que o motorista do caminhão possa segurá-los com segurança.
 * O peso do pacote não deve exceder 30 kg e a soma das três dimensões deve ser inferior a 1m.
 * Tem sido observado que 5% dos pacotes excedem o limite de peso e 2% excedem o limite de dimensão.
 * Qual é a probabilidade de que um pacote que atenda ao requisito de peso falhe no requisito de dimensão?
 * t1 = exceder o limite de peso 
 * t2 = exceder o limite de dimensão */
void Q12() {
    srand(time(NULL));

    // probabilidade de cada teste
    const double prob_aceitacao_t1 = 0.95;
    const double prob_reprovacao_t2 = 0.02;

    // pacote aceito em t1 e reprovado em t2
    int pacotes_aceitacaot1_reprovacaot2 = 0;

    for (unsigned i = 0; i < N; i++) {
        double aceitacao_t1 = (double) rand() / RAND_MAX;  // aceitação em t1
        double reprovacao_t2 = (double) rand() / RAND_MAX; // reprovação em t2

        // verifica se o pacote foi aceito em t1 e reprovado em t2
        if (aceitacao_t1 < prob_aceitacao_t1 && reprovacao_t2 < prob_reprovacao_t2) {
            pacotes_aceitacaot1_reprovacaot2++;
        }
    }

    double prob_t1t2 = (double) pacotes_aceitacaot1_reprovacaot2 / N;

    std::cout << "> Questão 12 - Resolvidos" << std::endl;
    std::cout << "Probabilidade de um pacote ser aceito em t1 e reprovado em t2: " << prob_t1t2 << std::endl;
}

int main() {
    std::cout << "..: Exercícios da Lista Básica :.." << std::endl << std::endl;
    Q7();   // apresentação
    Q9();   // resolvidos
    Q9p();  // propostos

    std::cout << "..: Exercícios da Lista de Condicional :.." << std::endl << std::endl;
    Q13();  // apresentação
    Q12();  // resolvidos

    return 0;
}