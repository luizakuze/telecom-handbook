/* Escreva um programa lê do teclado uma sequência de números inteiros positivos e escreve na tela o maior deles, bem como a quantidade de números iguais ao maior. 
   A sequência de números termina quando o usuário digitar zero ou um número negativo. Assuma que o usuário digitará pelo menos um número positivo.
  -> Restrições
        1.Utilize o comando do/while.
        2.Não utilize arranjos.
  -> Formato
        Entre com inteiros positivos. Entre com 0 ou um inteiro negativo para terminar.
        > {int}
        > {int}
        ...
        > {int}
        O maior inteiro foi {int}, que ocorreu apenas uma vez.
            ou
        O maior inteiro foi {int}, que ocorreu {int} vezes. */

#include <stdio.h>

int main() {
    int num, maior = 0, qt = 0;

    printf("Entre com inteiros positivos. Entre com 0 ou um inteiro negativo para terminar.\n");
    
    do {
        printf(">");
        scanf("%d", &num);

        if (num == maior) {
            qt++;
        } else if (num > maior) {
            maior = num;
            qt = 1;
        }

    } while (num != 0);

    if (qt > 1) {
        printf("O maior inteiro foi %d, que ocorreu %d vezes.\n", maior, qt);
    } else {
        printf("O maior inteiro foi %d, que ocorreu apenas uma vez.\n", maior);
    }

    return 0;
}
