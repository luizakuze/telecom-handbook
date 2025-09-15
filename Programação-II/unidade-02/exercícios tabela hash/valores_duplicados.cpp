/* Um arquivo contém números de matrícula de alunos de uma escola.
Foi detectado que existem números de matrícula repetidos nesse arquivo, e assim deseja-se removê-los.
Ao final, o que se espera é que o arquivo contenha somente números de matrícula únicos.

Escreva um programa que leia esse arquivo, e apresente na saída padrão os números de matrícula (excluindo os números repetidos).
O nome do arquivo é informado como primeiro argumento de linha de comando.
Seu programa deve apresentar esses números de forma ordenada, usando o ordenamento usual para string.

Use conjunto para resolver este exercício 

Esse exercício feito utilizado tabelas hash é mais eficiendo do que foram feitos anteriormente com lista */

#include <iostream>
#include <string>
#include <fstream>
#include <list>
#include <unordered_set>

using namespace std;

int main(int argc, char *argv[])
{
    // Abre arquivo para leitura
    ifstream arq (argv[1]);

    // Cria um conjunto de string
    unordered_set<string> conj;

    // Adiciona cada dado do arquivo ao conjunto
    // O conjunto contém somente dados únicos
    string palavra;
    while (arq >> palavra) {
        conj.insert(palavra);
    }

    list <string> lista;

    // Armazena matrículas sem repetição em uma lista
    for (auto & dado: conj) {
        lista.push_back(dado);
    }

    // Ordena os dados
    lista.sort();

    // Imprime as matrículas ordenadas e sem repetições
    for (auto & dado: lista) {
        cout << dado << ' ';
    }

    return 0;
}
