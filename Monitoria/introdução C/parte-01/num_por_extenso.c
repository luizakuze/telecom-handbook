// O exercício escreve um número por extenso
// Entrada: 1
// Saída: um

#include <stdio.h>

int main() {
    int numero;
    
    printf("Entre com um inteiro de 1 a 99: ");
    scanf("%d", &numero);

    if (numero < 1 || numero > 99) {
        printf("Número fora do intervalo permitido.\n");
    } else {
        // 10 = 1 dezena e 0 unidade
        // 10/10 = 1 (dezena)
        // 10% 10 = 0 (unidade)
        int dezena = numero / 10;
        int unidade = numero % 10;

        printf("Número por extenso: \"");

        switch (dezena) {
            case 0:
                break;
            case 1:
                switch (unidade) {
                    case 0:
                        printf("dez");
                        break;
                    case 1:
                        printf("onze");
                        break;
                    case 2:
                        printf("doze");
                        break;
                    case 3:
                        printf("treze");
                        break;
                    case 4:
                        printf("catorze");
                        break;
                    case 5:
                        printf("quinze");
                        break;
                    case 6:
                        printf("dezesseis");
                        break;
                    case 7:
                        printf("dezessete");
                        break;
                    case 8:
                        printf("dezoito");
                        break;
                    case 9:
                        printf("dezenove");
                        break;
                }
                break;
            case 2:
                printf("vinte");
                break;
            case 3:
                printf("trinta");
                break;
            case 4:
                printf("quarenta");
                break;
            case 5:
                printf("cinquenta");
                break;
            case 6:
                printf("sessenta");
                break;
            case 7:
                printf("setenta");
                break;
            case 8:
                printf("oitenta");
                break;
            case 9:
                printf("noventa");
                break;
        }

        if (dezena != 1 && unidade != 0) {
            printf(" e ");
        }

        switch (unidade) {
            case 1:
                printf("um");
                break;
            case 2:
                printf("dois");
                break;
            case 3:
                printf("três");
                break;
            case 4:
                printf("quatro");
                break;
            case 5:
                printf("cinco");
                break;
            case 6:
                printf("seis");
                break;
            case 7:
                printf("sete");
                break;
            case 8:
                printf("oito");
                break;
            case 9:
                printf("nove");
                break;
        }

        printf("\"\n");
    }

    return 0;
}
