// O exercício tem como entrada N alunos e suas notas A1 e A2
// A1 tem peso 3 e A2 tem peso 7, a saída deve ser a média das notas dos alunos

#include <stdio.h>

int main()
{
    // variáveis
    int N;
    float A1, A2;
    float media_aluno, media_turma = 0;
    int conta_aluno = 0;

    // entra com a quantidade de N alunos
    printf("Entre com a quantidade de alunos:\n");
    scanf("%d", &N);

    while (conta_aluno < N) {

        // lendo avaliações
        printf("Aluno %d: Entre com A1 e A2:\n", conta_aluno);
        scanf("%f %f", &A1, &A2);

        // fazendo média do aluno e adicionando à média da turma
        media_aluno = A1 * 0.3 + A2 * 0.7;
        media_turma = media_turma + media_aluno;

        // conta repetição, leu um aluno
        conta_aluno = conta_aluno + 1;
    }

    // faz a divisão pela quantidade de alunos;
    // tem que ser fora do laço, pois no laço adicionamos "media_aluno"
    // a cada iteração (cada repetição do loop)
    media_turma = media_turma / N;

    // mostra a média da turma
    printf("Média turma = %f\n", media_turma);

    return 0;
}


// //VERSÃO PARA VER OS VALORES DE 'conta_alunos' E 'N'
// #include <stdio.h>

// int main()
// {
//     variáveis
//     int N;
//     float A1, A2;
//     float media_aluno, media_turma;
//     int conta_aluno = 0;

//     início
//     printf("Entre com a quantidade de alunos:\n");
//     scanf("%d", &N);

//     media_turma = 0;

//     printf("ANTES DO LAÇO\n");
//     printf("---> conta_aluno = %d\n", conta_aluno);
//     printf("---> N = %d\n", N);

//     printf("DURANTE O LAÇO\n");

//     while (conta_aluno < N) {  // ENQUANTO

//         lendo avaliações
//         printf("Aluno %d: Entre com A1 e A2:\n", conta_aluno);
//         scanf("%f %f", &A1, &A2);

//         media_aluno = A1 * 0.3 + A2 * 0.7;
//         media_turma = media_turma + media_aluno;
//         media_turma += media_aluno;

//         conta_aluno += 1;
//         conta_aluno++;

//         printf("---> conta_aluno = %d\n", conta_aluno);
//         printf("---> N = %d\n", N);

//     }  // FIM ENQUANTO

//     printf("DEPOIS DO LAÇO\n");

//     media_turma = media_turma / N;
//     media_turma /= N;

//     printf("Média turma = %f\n", media_turma);

//     return 0;
// }
