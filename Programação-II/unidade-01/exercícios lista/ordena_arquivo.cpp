#include <iostream>
/* Escreva um programa que leia as linhas de um arquivo e as ordene, apresentando-as ao final na tela.
O nome do arquivo é informado como primeiro argumento de linha de comando. */

#include <string>
#include <list>
#include <algorithm>
#include <fstream>

using namespace std;

int main(int argc, char *argv[]){

    // Abre arquivo para leitura
    ifstream arq(argv[1]);

    // Confere se o arquivo foi aberto
    if (!arq.is_open()) {
        perror  ("Erro ");
        return errno;
    }

    // Adiciona as linhas do arquivo em uma lista
    list<string> lista;
    string linha;
    while (getline(arq, linha)) {
        lista.push_back(linha);
    }

    // Ordena as linhas
    lista.sort();

    // Imprime as linhas formatadas
    for (auto & l : lista) {
        cout << l << endl;
    }

    return 0;
}
