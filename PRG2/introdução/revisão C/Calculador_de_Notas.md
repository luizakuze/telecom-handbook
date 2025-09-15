## Um calculador de nota
Em uma disciplina, as notas seguem uma escala de proficiência
com os seguintes conceitos, do maior para o menor:

1. Excelente
2. Proficiente
3. Suficiente
4. Insuficiente

Dado um conjunto de conceitos, a nota resultante deve ser calculada da seguinte forma:
<br>

- Excelente: metade ou mais das notas ser Excelente, e as demais serem Proficientes.
- Proficiente: metade ou mais das notas ser Proficiente, e as demais serem Suficiente.
- Suficiente: demais casos, contanto que nenhuma nota seja Insuficiente.
- Insuficiente: quando alguma nota for Insuficiente.
Escreva um programa que calcule a nota resultante, dado um conjunto de conceitos fornecidos pelo usuário.
O usuário deve fornecer pelo menos três conceitos para esse cálculo. <br>
Para simplificar, cada conceito deve ser informado pela sua letra inicial. */

### Em C
```
#include <stdio.h>
#include <string.h>


void imprime_conceito_final(char notas[])
{
    int excelente = 0, proficiente = 0, suficiente = 0, insuficiente = 0;

    // Percorre notas e analisa quais tipos de notas o aluno tirou
    for (int i = 0; i < 3; i++) {

        if (notas[i] == 'e')
            excelente++;
        else if (notas[i] == 'p')
            proficiente++;
        else if (notas[i] == 's')
            suficiente++;
        else
            insuficiente++;
    }

    // Imprimindo o resultado
    if ((excelente == 2 && proficiente == 1) || (excelente == 3))
        printf("O aluno(a) obteve 'excelente'\n");
    else if ((proficiente == 2 && suficiente == 1) || (proficiente == 3))
        printf("O aluno(a) obteve 'proficiente'\n");
    else if (insuficiente >= 1)
        printf("O aluno(a) obteve 'insuficiente'\n");
    else
        printf("O aluno(a) obteve 'suficiente'\n");
}

int main()
{
    char notas[3];

    printf("Usuário,\nEntre com a nota1, nota2 e nota3:\n");
    scanf("%c %c %c", &notas[0], &notas[1], &notas[2]);

    imprime_conceito_final(notas);

    return 0;
}

```

### Em C++
```
#include <iostream>

using namespace std;

void imprime_conceito_final(char notas[])
{
    int excelente = 0, proficiente = 0, suficiente = 0, insuficiente = 0;

    // Percorre notas e analisa quais tipos de notas o aluno tirou
    for (int i = 0; i < 3; i++) {

        if (notas[i] == 'e')
            excelente++;
        else if (notas[i] == 'p')
            proficiente++;
        else if (notas[i] == 's')
            suficiente++;
        else
            insuficiente++;
    }

    // Imprimindo o resultado
    if ((excelente == 2 && proficiente == 1) || (excelente == 3))
        cout << "O aluno(a) obteve 'excelente'" << endl;
    else if ((proficiente == 2 && suficiente == 1) || (proficiente == 3))
        cout << "O aluno(a) obteve 'proficiente'" << endl;
    else if (insuficiente >= 1)
        cout << "O aluno(a) obteve 'insuficiente'" << endl;
    else
    cout << "O aluno(a) obteve 'suficiente'" << endl;
}

int main()
{
    char notas[3];

    cout << "Usuario,\nEntre com a nota1, nota2 e nota3:" << endl;
    cin >> notas[0] >> notas[1] >> notas[2];

    imprime_conceito_final(notas);

    return 0;
}
```
