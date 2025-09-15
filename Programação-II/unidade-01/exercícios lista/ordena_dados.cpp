/* Escreva uma função que insere um valor em uma lista ordenada. A lista deve continuar ordenada após essa inserção.
Sua função não pode usar a operação de ordenamento da lista (sort), e, portanto, deve se limitar às operações de iteração e insert.

A função deve ser declarada assim:

// insere "algo" na lista "l", que deve continuar ordenada após
// esta função
void insere_ordenado(list<float> & l, const float & algo); 

*/

#include "questao.h"

void insere_ordenado(list<float> & l, const float & algo)
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
