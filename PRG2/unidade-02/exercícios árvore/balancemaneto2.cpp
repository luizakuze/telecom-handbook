#include <iostream>
#include <string>
#include <fstream>
#include <prglib.h>
#include <cmath>

using namespace std;
using prglib::arvore;

// Retorna qual deveria ser a altura ideal de uma árvore 
int altura_ideal (const prglib::arvore<string> & arv) {
    auto N = arv.tamanho();
    
    return (int)(-1 + ceil (log2(1+N)));
}

int main() {
    ifstream arq("../portugues.txt");
    if (!arq.is_open()) {
        perror ("Ao abrir ");
        return errno;
    }

    /* Para um arquivo com palavras ordenadas, é preciso embaralhar as palavras
     * antes de criar uma árvore com essas palavras.
     * Para isso, foi é necessário colocar os dados em uma outra estrutura de dados 
     * p/ conseguir fazer esse embaralhamento */
    vector<string>v;
    string palavra;
    while (arq >> palavra) {
        v.push_back(palavra);
    }
    
    // Embaralha as palavras dentro do vector
    random_shuffle(v.begin(), v.end());

    // Cria árvore com os dados embaralhados do vector
    arvore<string> arv(v);
    
    // Altura após balanceamento
    arv.balanceia();
    cout << "Altura: " << arv.altura() << endl;

    return 0;
}
