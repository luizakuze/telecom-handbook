#include <stdio.h>

#define CAPACIDADE 400.0  // litros

int main(void)
{
    float nivel = 0.0, chuva;
    int dia, transbordou = 0;

    for (dia = 1; dia <= 7; dia++) {
        printf("Entre com a quantidade de chuva no dia %d em litros: ", dia);
        scanf("%f", &chuva);
        nivel += chuva;
        if (nivel >= CAPACIDADE) {
            transbordou = 1;
            break; // aqui já sai do laço se transbordar
        }
        printf("Nível do reservatório: %.1f litros\n\n", nivel);
    }

    if (transbordou) {
        printf("O reservatório transbordou no dia %d\n", dia);
    } else {
        printf("O reservatório não transbordou após uma semana, com %.1f litros livres.\n", CAPACIDADE - nivel);
    }

    return 0;
}

// A variável "transbordou" como booleana
/* funcina tbm!!*/

// Outra ideia...

/* #include <stdio.h>
#define CAPACIDADE 400.0  // litros

int main(void)
{
    float nivel = 0.0, chuva;
    bool transbordou = false;
    int dia = 1;

    while (!transbordou && dia <= 7) {
        printf("Entre com a quantidade de chuva no dia %d em litros: ", dia);
        scanf("%f", &chuva);
        nivel += chuva;
        if (nivel >= CAPACIDADE) {
            transbordou = true;
            continue;
        }
        dia++;
        printf("Nível do reservatório: %.1f litros\n\n", nivel);
    }

    if (transbordou) {
        printf("O reservatório transbordou no dia %d\n", dia);
    } else {
        printf("O reservatório não transbordou após uma semana, com %.1f litros livres.\n", CAPACIDADE - nivel);
    }

    return 0;
}
*/
