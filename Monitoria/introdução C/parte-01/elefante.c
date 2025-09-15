/* Escreva um programa que não lê nada do teclado e escreve na tela a letra da cantiga Um elefante incomoda, como mostrado abaixo.
 * Preste muita atenção na pontuação (ponto final, ponto de exclamação, vírgula) e na concordância (singular, plural). */
#include <stdio.h>

int main() {
    char numeros[10][10] = {
            "Um",
            "Dois",
            "Três",
            "Quatro",
            "Cinco",
            "Seis",
            "Sete",
            "Oito",
            "Nove",
            "Dez"
    };

    for (int i = 1; i <= 10; i++) {
        printf("%s elefante", numeros[i - 1]);

        if (i % 2 == 0 && i != 1) {
            printf("s ");
            for (int j = 1; j <= i; j++) {
                printf("incomodam");
                if (j < i)
                    printf(", ");
                else if (i != 10)
                    printf(" muito mais");
            }
            printf("!\n");
        } else {
            printf(" incomodam muita gente.\n");
        }
    }

    for (int i = 10; i > 1; i--) {
        printf("%s elefante", numeros[i - 1]);

        if (i % 2 != 0) {
            printf("s ");
            for (int j = 1; j <= i; j++) {
                printf("incomodam");
                if (j < i)
                    printf(", ");
                else
                    printf(" muito menos");
            }
            printf("!\n");
        } else {
            printf(" incomodam muita gente.\n");
        }
    }

    printf("%s elefante incomoda muito menos.\n", numeros[0]);

    return 0;
}

/*
#include <stdio.h>

int main() {

    printf("Um elefante incomoda muita gente.\n");

    for (int i = 2; i <= 10; i++) {

        switch (i) {
            case 2:
                printf("Dois ");
                break;
            case 3:
                printf("Três ");
                break;
            case 4:
                printf("Quatro ");
                break;
            case 5:
                printf("Cinco ");
                break;
            case 6:
                printf("Seis ");
                break;
            case 7:
                printf("Sete ");
                break;
            case 8:
                printf("Oito ");
                break;
            case 9:
                printf("Nove ");
                break;
            case 10:
                printf("Dez ");
                break;
        }
        if (i % 2 == 0 && i != 1) {
            int k = i;
            printf("s ");
            while (k > 0) {
                printf("incomodam");
                if (k != 1) {
                    printf(", ");
                } else {
                    printf(" ");
                }
                k--;
            }
            printf(" muito mais!\n");
        } else {
            printf("incomodam muita gente.\n");
        }
    }

    for (int j = 10; j > 1; j--) {

        switch (j) {
            case 2:
                printf("Dois ");
                break;
            case 3:
                printf("Três ");
                break;
            case 4:
                printf("Quatro ");
                break;
            case 5:
                printf("Cinco ");
                break;
            case 6:
                printf("Seis ");
                break;
            case 7:
                printf("Sete ");
                break;
            case 8:
                printf("Oito ");
                break;
            case 9:
                printf("Nove ");
                break;
            case 10:
                printf("Dez ");
                break;
        }
        printf("elefante ");

        if (j % 2 != 0 && j != 1) {
            int k = j;
            while (k > 0) {
                printf("incomodam");
                if (k != 1) {
                    printf(", ");
                } else {
                    printf(" ");
                }
                k--;
            }
            printf(" muito menos!\n");
        } else {
            printf("incomodam muita gente.\n");
        }
    }
  
    printf("Um elefante incomoda muito menos\n");

    return 0;
}
*/
