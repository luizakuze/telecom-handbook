## Previsor de tempo
- Escreva um programa que informe a previsão do tempo dada a condições de uum termômetro e de um barômetro.

## Em C++ e utilizando matriz
```
// Previsor de tempo utilizando uma matriz

#include <iostream>
#include <string>

using namespace std;

string calcula_previsao (int bar, int ter)
{
    string opcao [3][3] = {
            "Tempo bom, ventos quentes e secos",
            "Tempo bom, ventos de leste frescos",
            "Tempo bom, ventos de sul a sudeste",
            "Tempo mudando para bom, ventos de leste",
            "Tempo incerto, ventos variáveis",
            "Chuva provável, ventos de sul a sudeste",
            "Tempo minstávfel, aproximação de frente",
            "Frente quente com chuvas prováveis",
            "Chuvas abundantes e ventos de sul a sudoestes fortes"
    };

    return opcao[bar][ter];
}

int main()
{
    int bar, ter;
    string previsao;

    cout << "Entre com o valor para o BAROMETRO. 0 para subindo, 1 para estacionario, 2 para baixando" << endl;
    cin >> bar;
    cout << "Entre com o valor para o TERMOMETRO. 0 para subindo, 1 para estacionario, 2 para baixando" << endl;
    cin >> ter;

    previsao = calcula_previsao (bar, ter);
    cout << "A previsão é: " << previsao << endl;

    return 0;
}
```




### Em C e utilizando laços de repetição
```
#include <stdio.h>
#include <string.h>

int main()
{
    char barometro[15], termometro[15];
    int tam_barometro, tam_termometro;

    printf("Entre com o barômetro:\n");
    scanf("%s", barometro);
    printf("Entre com o termômetro:\n");
    scanf("%s", termometro);

    tam_barometro = strlen(barometro);
    tam_termometro = strlen(termometro);

    // barometro subindo
    if (tam_barometro == 7) {

        // condições termometro
        if (tam_termometro == 7) 
            printf("Tempo bom, ventos quentes e secos\n");
        else if (tam_termometro == 12)
            printf("Tempo bom, ventos de leste frescos\n");
        else if (tam_termometro == 8)
            printf("Tempo bom, ventos de sul a sudeste\n");
            
    }

    // barometro estacionário
    else if (tam_barometro == 12) {

        // condições termometro
        if (tam_termometro == 7) 
            printf("Tempo mudando para bom, ventos de leste\n");
        else if (tam_termometro == 12)
            printf("Tempo incerto, ventos variáveis\n");
        else if (tam_termometro == 8)
            printf("Chuva provável, ventos de sul a sudeste\n");

    }

    // barometro baixando
    else if (tam_barometro == 8) {

        // condições termometro
        if (tam_termometro == 7) 
            printf("Tempo minstávfel, aproximação de frente\n");
        else if (tam_termometro == 12)
            printf("Frente quente com chuvas prováveis\n");
        else if (tam_termometro == 8)
            printf("Chuvas abundantes e ventos de sul a sudoestes fortes\n");

    }

    return 0;
}
```
