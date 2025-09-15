/* Escreva um programa que leia palavras de um arquivo, e, ao final, mostre cada palavra seguida de sua quantidade de ocorrências no arquivo. 
O nome do arquivo é fornecido como primeiro argumento de linha de comando. As palavras lidas estão separadas por espaços ou quebras de linha.
O resultado final deve ser apresentado desta forma na tela:

palavra1 número_de_ocorrências
palavra2 número_de_ocorrências
...
palavraN número_de_ocorrências
Exemplo: se as palavras lidas forem estas:

um tigre
dois tigres
tres tigres
... o resultado final deve ser este (a ordem das palavras não é relevante):

um 1
tigre 1
dois 1
tigres 2
tres 1 */

#include <iostream>
#include <string>
#include <fstream>
#include <list>
#include <unordered_map>

using namespace std;

// FUnção que indica para o sort que ele deve ordenar pela quantidade de palavras
bool compara_par (const pair<string,int> & p1, const pair<string,int> & p2) {
    return p1.second < p2.second;
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
    //resultado.reverse(); se quisesse fazer de forma decrescente

    // teste = Imprime os dados
    for (auto & dado: resultado) {
        cout << dado.first << ' ' << dado.second << endl;
    }

    return 0;
}


/*
Outro possível ajuste

bool compara_par (const pair<string,int> & p1, const pair<string,int> & p2) {

    if(p1.second == p2.second) {
        return p1.first < p2.first;
    }
    return p1.second > p2.second;
}
*/
