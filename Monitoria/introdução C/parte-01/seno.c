#include <stdio.h>
#include <math.h>
#define PI 3.141593

float seno_bhaskara (float x){
    float sin;

    if (x > 180) {
        sin = - ( 4 * (360-x) * ( 180 - (360-x))) / (40500 - (360-x) * (180 - (360-x)));
    } else {
        sin = ( 4 * x * ( 180 - x)) / (40500 - x * (180 - x));
    }

    return sin;
}

float seno_real (float x) {
    return sin(x * (PI/180));
}

int main() {
    float ang;
    printf("Entre com o valor do ângulo em graus: ");
    scanf("%f", &ang);

    printf("Valor aproximado do seno: %.4f\n", seno_bhaskara(ang));
    printf("Valor real do seno: %.4f\n", seno_real(ang));

    return 0;
}

// outra ideia p função seno_bhaskara
/*
float seno_bhaskara(float x) {
    float sen;

    float numerador, denominador;

    if (x > 180) {
        numerador = -4 * (360 - x) * (180 - (360 - x));
        denominador = 40500 - (360 - x) * (180 - (360 - x));
    } else {
        numerador = 4 * x * (180 - x);
        denominador = 40500 - x * (180 - x);
    }

    sen = numerador / denominador;

    return sen;
}
*/
