/*Escreva um programa que leia palavras de um arquivo e, ao final, apresente as palavras na tela da seguinte forma:

Todas as palavras que iniciam com letra maiúscula
Todas as palavras que iniciam com letra minúscula
Em ambos os casos, as palavras devem ser mostradas na ordem em que foram lidas do arquivo.
 
* Por exemplo, se o arquivo tiver este conteúdo:

Em um belo dia de sol, Bilica saiu de casa e foi pra praia do Campeche passear.
Após caminhar algumas horas, resolveu ir pro Centro.
 
* O programa deve mostrar:

Em Bilica Campeche Após Centro.
um belo dia de sol, saiu de casa e foi pra praia do passear caminhar algumas horas, resolveu ir pro */

#include <iostream>
#include <string>
#include <queue>
#include <fstream>
#include <ctype.h>

using namespace std;

int main(int argc, char* argv[])
{
    // Filas para armazenarem as palavras do arquivo
    queue <string> maiuscula;
    queue <string> minuscula;

    // Objeto da classe "ifstream" para somente ler o arquivo
    ifstream arq (argv[1]);

    // Mensagem de erro caso o arquivo não seja aberto
    if(!arq.is_open()) {
        perror(argv[1]);
        return errno;
    }

    string palavra;

    // Leitura do arquivo palavra por palavra
    while (arq >> palavra) {

        // Verifica se a palavra inicia com letra maiúscula
        if (isupper(palavra[0])) maiuscula.push(palavra);
        else minuscula.push(palavra);

    }

    // Imprimindo as filas

    while (! maiuscula.empty()) {
        cout << maiuscula.front() << ' ';
        maiuscula.pop();
    }

    cout << endl;

    while (! minuscula.empty()) {
        cout << minuscula.front() << ' ';
        minuscula.pop();
    }
    return 0;
}
