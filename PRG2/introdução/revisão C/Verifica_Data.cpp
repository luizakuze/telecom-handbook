// O programa verifica se uma data é válida.

#include <iostream>

using namespace std;

// Verifica se a data é válida,
void confere_data (int dia, int mes, int ano, char sep1, char sep2)
{
    bool situacao_data = false;


    // Se o mês está entre 01 - 12
    if ((mes <= 12 && mes >= 1)

    // Se o dia está entre 01 - 30
    && (dia <= 30 && dia >= 01)

    // Se tem a separação por barras ou hífen
    && ((sep1 == '/' && sep2 == '/') || (sep1 == '-' && sep2 == '-')))
        situacao_data = true;


    if (situacao_data)
        cout <<dia<<sep1<<mes<<sep2<<ano << endl;
    else
        cout << "data invalida" << endl;
}

int main(int argc, char **argv)
{
    int dia, mes, ano;
    char sep1, sep2; // Separadores ('/')

    
    cin >> dia;
    cin >> sep1;
    cin >> mes;
    cin >> sep2;
    cin >> ano;

    confere_data(dia, mes, ano, sep1, sep2);

    return 0;
}
