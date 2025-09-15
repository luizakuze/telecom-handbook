```c
#include <stdio.h>

int main() {
    int i = 1;

    while (i <= 10) {
        printf("%d ", i);
        i++;
    }

    return 0;
}
```
```c
#include <stdio.h>

int main(void)
{
    // laços condicional
    // WHILE

    int i = 1;

    // enquanto essa condição for verdadeira
    while (i < 11) {
        // faz isso

        if (i % 2 == 0) {
            printf("o número %d par\n", i);
        } else {
            printf("o número %d é ímpar\n", i);
        }

        // incrementa
        i = i + 1;
    }

    return 0;
}
```
```c
#include <stdio.h>

int main() {
    for (int i = 1; i <= 10; i++) {
        printf("%d ", i);
    }

    return 0;
}
```
```c
#include <stdio.h>

int main() {
    int contador = 1;

    do {
        printf("Contagem: %d\n", contador);
        contador++;
    } while (contador <= 5);

    return 0;
}
```
```c
#include <stdio.h>

int main() {
    int numero, soma = 0;

    do {
        printf("Digite um número (0 para sair): ");
        scanf("%d", &numero);

        if (numero != 0) {
            soma += numero;
        }
    } while (numero != 0);

    printf("A soma dos números digitados é: %d\n", soma);

    return 0;
}
```

```c
// DESAFIO
#include <stdio.h>

int main() {
    int N;
    int soma = 0;

    printf("Digite um número inteiro N: ");
    scanf("%d", &N);

    for (int i = 1; i <= N; i++) {
        if (i % 2 != 0) { // Verifica se o número é ímpar
            soma += i;
        }
    }

    printf("A soma dos números ímpares de 1 a %d é: %d\n", N, soma);

    return 0;
}
```
```C
#include <stdio.h>

int main(void)
{
    // laços condicional
    // WHILE / FOR

    int i;

    // dada uma condição inicial
    // faz o que tem dentro do for
    // verifica condição 2
    // depois que acabar, faz o i = i + 1
    for (i = 1; i < 11; i = i + 1) {
        printf("%d\n", i);
    }

    while (i < 11) {
        printf("%d\n", i);
        i = i + 1;
    }

    return 0;
}
```
```c
#include <stdio.h>

int main(void)
{
    int num;

    printf("Entre com o número\n");
    scanf("%d", &num);

    for (int i = 1; i <= 10; i++) {
        printf("%d x %d = %d\n", num, i, num * i);
    }

    return 0;
}
```
