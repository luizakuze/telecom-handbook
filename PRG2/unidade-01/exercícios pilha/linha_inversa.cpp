/* Escreva um programa que leia linhas de um arquivo, e mostre-as em ordem inversa em que foram lidas.

O nome do arquivo é informado como primeiro argumento de linha de comando.

Se o arquivo não existir, ou não puder ser lido, seu programa deve apresentar esta mensagem na tela = "arquivo invalido"

Se o arquivo estiver vazio, seu programa deve terminar sem apresentar qualquer resultado na tela.*/

#include <iostream>
#include <string>
#include <stack>
#include <fstream>

using namespace std;

int main(int argc, char *argv[])
{
    // Armazena cada linha do arquivo
    stack <string> texto;

    // Abre um arquivo somente para leitura
    ifstream arq (argv[1]);

    if ( !arq.is_open()) {
        cout << "arquivo invalido" << endl;
    }

    // Lê cada linha do arquivo
    string linha;
    while (getline(arq, linha)) {
        texto.push(linha);
    }

    // Imprime as linha do arquivo em ordem invertida
    while ( ! texto.empty()) {
        cout << texto.top() << endl;
        texto.pop();
    }

    return 0;
}
