/* Um arquivo chamado "nomes.txt" contém uma relação de nomes de pessoas (um por linha).
Escreva um programa que possibilite consultar se um determinado nome existe nesse arquivo.
Para agilizar a consulta, os nomes devem primeiro serem carregados para uma árvore de pesquisa binária.
Portanto, as consultas devem ser feitas diretamente nessa árvore.

Após criar a árvore, seu programa deve entrar em um loop. Em cada ciclo do loop o programa apresenta este prompt:
Consultar>

... e aguardar que seja fornecido um nome para ser pesquisado.
O resultado da consulta deve ser apresentado da seguinte forma:

Nome Que Foi Consultado: EXISTE

Se o nome não existir, o resultado deve ser este:

Nome Que Foi Consultado: INEXISTENTE

Se em vez de uma nome for teclado ENTER, o programa deve terminar.*/

#include <iostream>
#include <fstream>
#include <list>
#include <string>
#include <set>
#include <prglib.h>

using namespace std;
using prglib::arvore;

#define loop while(true)

int main() {

    // Abre arquivo com base de dados
    ifstream arq("nomes.txt");
    if(!arq.is_open()) {
        perror ("ao abrir ");
        return errno;
    }

    // Cria árvore de pesquisa
    arvore<string> nomes;

    // Percorre todos os nomes do arquivo e armazena em uma árvore
    // Tem que usar o "getline", pois pode haver nome comṕosto
    string nome;
    while (getline(arq, nome)) {
        nomes.adiciona(nome);
    }


    // Confere se o nome existe na base
    loop {
        string n; //nome
        cout << "Consultar>";
        getline(cin, n);
        if (n.empty()) break;

        if (nomes.existe(n)) {
            cout << "Nome Que Foi Consultado: EXISTE" << endl;
        } else {
            cout << "Nome Que Foi Consultado: INEXISTENTE" << endl;
        }
    }

    return 0;
}
