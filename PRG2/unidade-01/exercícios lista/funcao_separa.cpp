/* Implemente a função separa, que deve separar uma string em substrings de acordo com uma string delimitadora, a qual pode ter um ou mais caracteres.

Assim, dentro da string informada pelo parâmetro texto, as substrings são separadas pela string informada pelo parâmetro sep.
O resultado dessa função deve ser uma lista contendo as substrings na ordem em que aparecem em texto.

list<string> separa(const string & texto, const string & sep);*/

#include "questao.h"

list <string> separa(const string & texto, const string & sep)
{
    list <string> sequencia;

    // aqui, algoritmo da função separa
    int pos1 = texto.find_first_not_of(sep);

    while (pos1 != string::npos) {
        // procura o próximo delimitador após pos1
        // e guarda sua posicção em pos2
        int pos2 = texto.find(sep, pos1 + 1);

        //enfileira a substring que está
        //entre pos1 e pos2
        if (pos2 != string::npos) {
            string trecho = texto.substr(pos1, pos2 - pos1);
            sequencia.push_back(trecho);
        } else { // não achou nenhum delimitador
            string trecho = texto.substr(pos1);
            sequencia.push_back(trecho);
            break;
        }

        //atualiza pos1 para a posição logo após pos2
        pos1 = texto.find_first_not_of(sep, pos2 + 1);
    }
    return sequencia;
}
