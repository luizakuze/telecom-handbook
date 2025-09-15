//PROGRAMA NÃO FINALIZADO
// falta comentar o código


/*Um arquivo de texto contém uma palavra por linha.
Escreva um programa que leia um arquivo e apresente suas palavras agrupadas de acordo com os comprimentos dessas palavras.
Obrigatoriamente deve ser usada uma tabela hash para realizar esta tarefa.
Listas somente podem ser usadas se forem obtidas a partir de operações da tabela hash.
Por exemplo, se o arquivo contiver estas palavras:

banana
ceu
mar
caju
pato
bola
... o resultado deve ser este:

ceu mar 
caju pato bola
banana
As linhas devem estar ordenadas de acordo com o comprimento de palavras. 
s palavras de cada linha devem aparecer na ordem em que foram lidas do arquivo.

O nome do arquivo de palavras é fornecido como primeiro argumento de linha de comando.
Se o arquivo não puder ser aberto, esta mensagem de erro deve ser apresentada:

Arquivo invalido
*/

#include <iostream>
#include <string>
#include <fstream>
#include <vector>
#include <list>
#include <unordered_map>

using namespace std;

// junta -> junta as strings e separa por espaços (função separa)
string junta (vector <string> & v) {
    string r; //resultado

    if (!v.empty()) {
        for (auto &dado: v) {
            r += dado + ' ';
        }
        r.pop_back();
    }
    return r;
}
int main(int argc, char *argv[])
{
    // Abre arquivo para leitura
    ifstream arq (argv[1]);

    // Verifica se o arquivo foi realmente aberto
    if (!arq.is_open()) {
        cerr << "Arquivo invalido" << endl;
        return 1;
    }

    unordered_map<int, vector<string>> tab;
    string palavra;
    while (arq >> palavra) {
        //vector<string> & v = tab[palavra.size()];
        //v.push_back(palavra);
        tab[palavra.size()].push_back(palavra);
    }

    list <int> l_chaves;
    for (auto & par: tab) {
        l_chaves.push_back(par.first);
    }
    l_chaves.sort();

    // Imprime palavras
    for (auto & chave: l_chaves) {
        cout << junta(tab[chave]) << endl;
    }

    return 0;
}
