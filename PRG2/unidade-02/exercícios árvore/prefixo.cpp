/* Em programas em que o usuário deve digitar alguma informação, como nome de pessoa ou um comando,
é comum existir uma funcionalidade que sugere opções para completar o que está sendo digitado.

Por exemplo, se o usuário precisar informar um nome de pessoa,
o programa pode sugerir nomes conhecidos à medida que o usuário digita suas primeiras letras.

Nesse caso, se o usuário digitar "Mar", o programa pode sugerir "Marcos", "Marcia", "Marcio", "Mario", e outros que já tenha cadastrados.
Essa funcionalidade pode ajudar o usuário a fornecer informações válidas, e agilizar a entrada de dados do programa.

Escreva um programa que possibilite consultas a um conjunto de informações, porém sugerindo valores com base no que o usuário já digitou. Para fins de demonstração, as informações a serem consultadas são palavras da língua portuguesa. O programa deve funcionar da seguinte maneira:

O programa deve apresentar o seguinte prompt para o usuário:
>
O usuário deve digitar uma sequência de letras, e pressionar ENTER. Ex:
> mar
O programa então deve mostrar, em ordem alfabética, todas as palavras cujas letras iniciais sejam idênticas às que foram digitadas:
marasmo
maravilha
marco
martelo
Se o usuário digitar uma linha vazia (apenas teclar ENTER), o programa deve terminar.
As palavras a serem consultadas estão armazenadas no arquivo dados.txt. */

// Falta comentar algumas partes do código
#include <iostream>
#include <fstream>
#include <list>
#include <vector>
#include <string>
#include <set>
#include <prglib.h>

using namespace std;
using prglib::arvore;

#define loop while(true)

//const string NomeArq = "../dados.txt";

void remove_palavras (vector<string> & v, const string & palavra) {
    for (auto it = v.begin(); it != v.end(); it++) {
        if (*it == palavra) {
            v.erase(it); break;
        }
    }
}

vector<string> procura_palavras(const<string> & arv, const string & prefixo) {
    string fim = prefixo;
    fim.back()++;
    auto palavras = arv.obtemIntervalo(prefixo, fim);
    
    remove_palavras(palavras,fim);
    
    return palavras;
}

int main() {

    // Abre arquivo com base de dados
    ifstream arq("dados.txt");
    if(!arq.is_open()) {
        perror ("ao abrir ");
        return errno;
    }

    // Cria árvore de pesquisa diretamente do arquivo
    arvore <string> arv(arq);

    // Confere palavras que tem a sequência enviada pelo usuário
    loop {
        string prefixo;
        cout << "> ";
        cin >> prefixo;
        if (prefixo.empty()) break;

        string fim = prefixo;
        fim.back()++; // acesso ao último caracter por referência

        auto palavras =  procura_palavras(arv, prefixo);

        for (auto & dado: palavras) cout << dado << endl;
    }

    return 0;
}
