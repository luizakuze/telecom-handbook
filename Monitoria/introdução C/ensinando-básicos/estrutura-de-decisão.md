```c
#include <stdio.h>

int main() {
    int nota;

    printf("Digite a nota do aluno: ");
    scanf("%d", &nota);

    if (nota >= 90) {
        printf("Aprovado com A\n");
    } else if (nota >= 80) {
        printf("Aprovado com B\n");
    } else if (nota >= 70) {
        printf("Aprovado com C\n");
    } else if (nota >= 60) {
        printf("Aprovado com D\n");
    } else {
        printf("Reprovado\n");
    }

    return 0;
}
```
```c
#include <stdio.h>

int main() {
    int numero;

    printf("Digite um número: ");
    scanf("%d", &numero);

    if (numero > 0) {
        printf("O número é positivo.\n");
    } else if (numero < 0) {
        printf("O número é negativo.\n");
    } else {
        printf("O número é zero.\n");
    }

    return 0;
}
```
```c
#include <stdio.h>

int main() {
    int dia;

    // Solicitar ao usuário um número de 1 a 7
    printf("Digite um número de 1 a 7: ");
    scanf("%d", &dia);

    // Usar switch para determinar o dia da semana
    switch (dia) {
        case 1:
            printf("Domingo\n");
            break;
        case 2:
            printf("Segunda-feira\n");
            break;
        case 3:
            printf("Terça-feira\n");
            break;
        case 4:
            printf("Quarta-feira\n");
            break;
        case 5:
            printf("Quinta-feira\n");
            break;
        case 6:
            printf("Sexta-feira\n");
            break;
        case 7:
            printf("Sábado\n");
            break;
        default:
            printf("Número fora do intervalo válido.\n");
            break;
    }

    return 0;
}
````
```c
#include <stdio.h>

int main() {
    int numero;

    printf("Digite um número (1, 2, 3 ou 4): ");
    scanf("%d", &numero);

    switch (numero) {
        case 1:
            printf("Um\n");
            break;
        case 2:
            printf("Dois\n");
            break;
        case 3:
            printf("Três\n");
            break;
        case 4:
            printf("Quatro\n");
            break;
        default:
            printf("Número fora do intervalo permitido\n");
    }

    return 0;
}
```
```c
#include <stdio.h>

int main() {
    int numero;

    printf("Digite um número inteiro: ");
    scanf("%d", &numero);

    int i = 1;

    while (i <= 10) {
        printf("%d x %d = %d\n", numero, i, numero * i);
        i++;
    }

    return 0;
}
```
```c
#include <stdio.h>

int main() {
    int numero, fatorial = 1;

    printf("Digite um número inteiro não negativo: ");
    scanf("%d", &numero);

    if (numero < 0) {
        printf("Por favor, insira um número inteiro não negativo.\n");
        return 1;
    }

    int i = 1;
    while (i <= numero) {
        fatorial *= i;
        contador++;
    }

    printf("O fatorial de %d é %d.\n", numero, fatorial);

    return 0;
}
```
