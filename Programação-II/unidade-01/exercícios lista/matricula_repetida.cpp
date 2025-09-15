/* Um arquivo contém números de matrícula de alunos de uma escola.
Foi detectado que existem números de matrícula repetidos nesse arquivo, e assim deseja-se removê-los.
Ao final, o que se espera é que o arquivo contenha somente números de matrícula únicos.

Escreva um programa que leia esse arquivo, e apresente na saída padrão os números de matrícula (excluindo os números repetidos).
O nome do arquivo é informado como primeiro argumento de linha de comando.
Seu programa deve apresentar esses números de forma ordenada, usando o ordenamento usual para string. */

#include <iostream>
#include <fstream>
#include <list>

using namespace std;

int main(int argc, char* argv[]) {

    // Abre arquivo para leitura
    ifstream arq(argv[1]);

    // Confere se o arquivo realmente abriu
    if(!arq.is_open()) {
        perror ("Erro ");
        return errno;
    }

    // Armazena matrículas ÚNICAS do arquivo em uma lista
    list <string> lista;
    string matricula;
    while (arq >> matricula) {

        bool tem_matricula_igual = false;

        for (auto & dado : lista) {

            // Se achar uma matrícula igual, não add na lista
            if (dado == matricula) {
                tem_matricula_igual = true;
                break;
            }
        }

        // Se achar uma matrícula diferente, add na lista
        if (!tem_matricula_igual) {
            lista.push_back(matricula);
        }
    }

    // Ordena matrículas
    lista.sort();

    // Imprime as matrículas únicas e ordenadas
    for (auto & dado : lista) {
        cout << dado << ' ';
    }



    return 0;
}
