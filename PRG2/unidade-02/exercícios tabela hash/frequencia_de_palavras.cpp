/* Escreva um programa que leia palavras de um arquivo, e, ao final, mostre as N palavras mais frequentes (que aparecem mais vezes).
As palavras devem ser mostradas na tela em ordem decrescente de frequência, apresentando-se uma palavra por linha, acompanhada de sua frequência.

Exemplo: se as palavras lidas forem estas:

No meio do caminho tinha uma pedra
tinha uma pedra no meio do caminho
tinha uma pedra
no meio do caminho tinha uma pedra
... e foram pedidas as 4 palavras mais frequentes, o resultado final deve ser este:

pedra 4
tinha 4
uma 4
caminho 3
Note que, quando houver empate na frequência, as palavras devem estar apresentadas em ordem alfabética.

O nome do arquivo a ser lido está no primeiro argumento de linha de comando,
e a quantidade de palavras a serem apresentadas está no segundo argumento.*/

#include <iostream>
#include <string>
#include <fstream>
#include <list>
#include <unordered_map>

using namespace std;

// FUnção que indica para o sort que ele deve ordenar pela quantidade de palavras
bool compara_par (const pair<string,int> & p1, const pair<string,int> & p2) {

    // Se tiverem a mesma quantidade de caracteres
    if(p1.second == p2.second) {
        return p1.first < p2.first;
    }
    // Ordena decrescente
    return p1.second > p2.second;
}

int main(int argc, char *argv[])
{
    // Abre arquivo para leitura
    ifstream arq (argv[1]);

    // Cria um conjunto com palavras e suas quantidades
    unordered_map<string,int> totais;

    // Adiciona cada dado do arquivo ao conjunto
    // O conjunto contém somente dados únicos
    string palavra;

    // Conta as palavras
    while (arq >> palavra) {
        if (totais.count(palavra) > 0) {
            totais[palavra]++;
        } else {
            totais[palavra] = 1;
        }
    }

    // Cria uma lista com palavras e número de repetições
    list<pair<string,int>> resultado (totais.begin(), totais.end());

    // Como é a forma de comparar
    resultado.sort(compara_par);

    // Imprime dados
    int cont = 0;
    for (auto &dado: resultado) {
        // Verifica se já imprimiu x vezes
        if (cont == stoi(argv[2])) {
            break;
        } else {
            cout << dado.first << ' ' << dado.second << endl;
            cont++;
        }
    }

    return 0;
}
