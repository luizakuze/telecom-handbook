/* Escreva um programa que mostre as palavras de um arquivo, porém apresentando cada palavra apenas uma única vez.
Se uma mesma palavra aparecer mais de uma vez, apenas a primeira ocorrência é apresentada.
As palavras apresentadas podem estar separadas por espaços ou quebras de linha.

O nome do arquivo é fornecido como primeiro argumento de linha de comando. */

#include <iostream>
#include <string>
#include <list>
#include <fstream>

using namespace std;

int main(int argc, char* argv[])
{
    // Abre arquivo para leitura
    ifstream arq(argv[1]);

    // Caso não consiga abrir o arquivo
    if (!arq.is_open()) {
        perror("ERRO: ");
        return errno;
    }

    // Lê as palavras do arquivo e as add a uma lista
    list <string> lista;
    string palavra;

    while (arq >> palavra) {

        bool tem_palavra_igual = false;

        for (auto & dado : lista) {

            // Se achar uma palavra  igual, não add na lista
            if (dado == palavra) {
                tem_palavra_igual = true;
                break;
            }
        }

        // Se achar uma palavra diferente, add na lista
        if (!tem_palavra_igual) {
            lista.push_back(palavra);
        }
    }

    // Imprime as palavras não repetidas (estão na lista)
    for (auto & dado : lista) {
        cout << dado << ' ';
    }
    cout << endl;


    return 0;
}
