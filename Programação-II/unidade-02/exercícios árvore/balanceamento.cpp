/* O arquivo de projeto CLion possui alguns arquivos que serão usados neste exercício.

Crie a árvore que armazena as palavras contidas no arquivo portugues.txt.
Investigue a altura e fator de balanceamento dessa árvore
Balanceie sua árvore, e verifique o novo fator de balanceamento e altura. Compare-os com a menor altura possível teoricamente.
Agora refaça a criação da árvore, porém a partir do arquivo palavras.txt. Note que ele está ordenado !
O que se pode notar ao se criar a árvore a partir desse arquivo ordenado ? Como isso poderia ser melhorado ?*/

#include <iostream>
#include <string>
#include <fstream>
#include <prglib.h>

using namespace std;
using prglib::arvore;

int main() {
    arvore <string> arv;

    ifstream arq("../portugues.txt");
    if (!arq.is_open()) {
        perror ("Ao abrir ");
        return errno;
    }

    string palavra;
    while (arq >> palavra) {
        arv.adiciona(palavra);
    }

    // Altura antes da árvore ser balanceada
    cout << "Altura: " << arv.altura() << endl;

    //Cria um diagrama da árvore
    //ofstream out2("arv2.dot");
    //out2 << prglib::desenha_arvore(arv);
    
    // Altura após balanceamento
    arv.balanceia();
    cout << "Altura: " << arv.altura() << endl;

    return 0;
}
