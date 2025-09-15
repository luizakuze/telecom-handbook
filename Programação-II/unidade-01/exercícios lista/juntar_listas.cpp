/* Suponha que duas listas estejam ordenadas, mas seja necessário mesclá-las.
A lista que é resultado da mesclagem também deve estar ordenada.
Esse tipo de operação é útil para um tipo de algoritmo de ordenamento de lista, e possivelmente em outras situações.

Escreva a função mescla, que faz a mesclagem de duas listas ordenadas. Essa função deve ser declarada assim:


// mescla duas listas previamente ordenadas
// o resultado deve ser uma lista também ordenada
list<int> mescla(const list<int> & l1, const list<int> & l2);

Por exemplo, se as listas tiverem estes valores:
l1: 1,3,4,8,10
l2: 1,2,6,7,9,11

... após a chamada da função mescla, seria obtida uma lista assim:
1,1,2,3,4,6,7,8,9,10,11 */

#include "questao.h"

// Função que já tinha feita
// Ordena um dado dentro de uma lista
void insere_ordenado(list<int> & l, const int & algo)
{
    // Obtem iterador do primeiro dado da lista
    auto it = l.begin();

    // Enquanto a string não chegar no final e o valor
    // da posição que o iterador estiver for menor que a de "algo"
    while (it!= l.end() && *it < algo) {
        it++;
    }

    // Insere "algo" na posição que o iterador está
    l.insert(it, algo);
}

list<int> mescla(const list<int> & l1, const list<int> & l2)
{
    // lista 3 já tem os valores da lista 1 ordenados
    list <int> l3 = l1;

    // coloca também os valores da lista 2 
    for (auto & dado: l2) {
        insere_ordenado(l3, dado);
    }

    return l3;
}
