// implementar um programa C para ler 10 números inteiros para um vetor
// e imprimir a quantidade (o número) de números acima da média.

#include <stdio.h>

#define NUM_ELEMENTOS 10

int main() {
    int vet[NUM_ELEMENTOS];
    int soma_num = 0;

    // leitura dos números inteiros para o vetor
    for (int i = 0; i < NUM_ELEMENTOS; i++) {
        printf("vet[%d] = ", i);
        scanf("%d", &vet[i]);
        soma_num += vet[i];
    }

    // cálculo da média
    float media = (float)soma_num / NUM_ELEMENTOS;
    int acima_media = 0;

    // contagem de números acima da média
    for (int i = 0; i < NUM_ELEMENTOS; i++) {
        if (vet[i] > media) {
            acima_media++;
        }
    }

    // impressão do resultado
    printf("Existem %d números acima da média.\n", acima_media);

    return 0;
}
