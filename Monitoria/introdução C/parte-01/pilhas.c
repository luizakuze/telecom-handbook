/* Existes pilhas com determinados números de tijolos: P1 = 120 tijolos, P2 = 60 tijolos, P3 = 15 e P4 = 1
 * Dado o número total de tijolos, mostrar na tela quando de cada pilha é necessário. Do maior p menor a preferência */

#include <stdio.h>

int main() {
    int total, qt_p1, qt_p2, qt_p3, qt_p4;

    printf("Entre com o total de tijolos: ");
    scanf("%d", &total);

    // Calcular a quantidade para a pilha P1
    qt_p1 = total / 120;
    total -= qt_p1 * 120;

    // Calcular a quantidade para a pilha P2
    qt_p2 = total / 60;
    total -= qt_p2 * 60;

    // Calcular a quantidade para a pilha P3
    qt_p3 = total / 15;
    total -= qt_p3 * 15;

    // A quantidade restante vai para a pilha P4
    qt_p4 = total;

    printf("Quantidade de tijolos para cada pilha:\n");
    printf("P1: %d\n", qt_p1);
    printf("P2: %d\n", qt_p2);
    printf("P3: %d\n", qt_p3);
    printf("P4: %d\n", qt_p4);

    return 0;
}
