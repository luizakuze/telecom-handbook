# Atendimento 

## Estrutura básica programa C
```c
#include <stdio.h>

int main(void) {
    
    
    return 0;
}
```

## Tipos int, float, char
```c
    // esses são os tipos de variáveis
    int a = 10; 
    float b = 10.5; 
    char c = 'd'; // 1 caracter
    char d[10] = "luiza"; // conjunto de caracteres
```

## Printf, Scanf
```c
#include <stdio.h>

int main(void) {
    int a;
    int b;
    int soma;

    // entrada de dados
    printf("Entre com o valor de A\n"); // mostra na tela
    scanf("%d", &a); // lê do teclado
    printf("Entre com o valor de B\n"); // ESCREVA
    scanf("%d", &b); // LEIA

    soma = a + b; // atribuição

    // saída de dados
    printf("A soma é: %d", soma);

    return 0;

    // SCANF - Tem &
    // PRINTF - Não tem &

}
```
