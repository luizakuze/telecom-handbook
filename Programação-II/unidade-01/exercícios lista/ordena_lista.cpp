/*  Escreva uma função que verifique se uma lista de números inteiros está ordenada em ordem crescente.
 * Essa função deve retornar um valor do tipo bool, sendo que true significa que a lista está ordenada.
 * A lista pode ter uma quantidade arbitrária de números. Se a lista estiver vazia, ou contiver apenas um número, o resultado deve ser true.

bool ordenada(const list<int> & umaLista) */


#include "questao.h"

bool ordenada(const list<int> & umaLista)
{
    if (umaLista.empty()) return true;

    bool resultado;
    int aux = umaLista.front();

    for (auto & dado: umaLista) {

        if (aux <= dado)
            resultado = true;
        else
            return false;

        aux = dado;
    }

    return resultado;
}
