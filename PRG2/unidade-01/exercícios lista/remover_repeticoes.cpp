/* Imagine que seja necessário remover valores repetidos de uma lista.
Supondo que esses dados estejam contíguos, crie a seguinte função:

// remove os valores repetidos de uma lista "l"
// esses valores devem estar contíguos na lista para que a função funcione corretamente !
void unicos(list<string> & l);

Por exemplo, se uma lista contiver estes valores:

banana,laranja,laranja,abacaxi,pitanga,pitanga,pitanga,limao

... após a chamada da função unicos, ela ficaria assim:

banana,laranja,abacaxi,pitanga,limao  */

#include "questao.h"

// A operação "unique", resolve o problema.

void unicos(list<string >& l) {
    if (l.empty()) return; // lista vazia

    auto it = l.begin(); // it principal

    // percorre a lista
    while (it != l.end()) {
        // um iterador que é o próximo do it principal
        auto it_next = next(it);

        // analisa se há repetições
        while (it_next != l.end()) {
        
            // encontra uma repetição
            if (*it == *it_next) 
                it_next = l.erase(it_next);
                
            // se não, atualiza o próximo iterador    
            else 
                ++it_next;
                
        }

        // Atualiza it principal
        ++it;
    }
}
