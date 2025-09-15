/* Implemente a função junta, que concatena todas as strings de uma lista, unindo-as com uma string delimitadora.
Essa função tem esta declaração:

// Parâmetros:
//  l: uma lista de strings
//  delim: uma string a ser usada entre as strings a serem unidas (pode ser vazia)
// Resultado: a função junta deve retornar a string contendo todas as strings da lista intercaladas por "delim" */

string junta(list<string> & l, const string & delim);


#include "questao.h"

string junta(list<string> & l, const string & delim)
{
    // Armazena cada elemento da lista "l" com delimitadores
    string juncao;
    
    int i = 0;

    for (auto & dado: l) {
        // Add dado a string
        juncao += dado;
        
        // Verifica em que posição da lista o dado está
        i++;
        
        // Se a lista chegar ao final,
        // não imprime mais delimitador
        if (i != l.size()) {
            juncao += delim;
        }
    }
    return juncao;
}
