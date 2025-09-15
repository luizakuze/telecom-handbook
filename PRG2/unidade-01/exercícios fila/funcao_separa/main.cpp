/* Seja o caso em que uma string seja composta por sequências de caracteres delimitadas por algum caractere específico.
 * Veja estes exemplos:

"um exemplo de string com trechos delimitados por espaço"
"outro,exemplo,com,trechos,separados,por,vírgula"
 
No primeiro exemplo, a string possui trechos (formados por alguns caracteres) separados por espaços e,
 no segundo exemplo, o caractere delimitador é a vírgula. Imagine que se deseje, a partir de uma string como essas,
 gerar uma sequência contendo esses trechos:

a partir de "um exemplo de string com trechos delimitados por espaço" gerar a sequência:
 
 "um", "exemplo", "de", "string", "com", "trechos", "delimitados", "por", "espaço"
 
a partir de "outro,exemplo,com,trechos,separados,por,vírgula" gerar a sequência:
 
 "outro", "exemplo", "com", "trechos", "separados", "por", "vírgula"
 
A sequência dos trechos extraídos da string poderia ser armazenada em uma fila.

Escreva uma função que transforme uma string em uma fila de substrings. As substrings estão separadas por algum caractere delimitador dentro da string.
Essa função deve ser declarada assim:


queue<string> separa(const string & algo, char sep);
 
O parâmetro algo é a string a ser separada em substrings.
O parâmetro sep é o caractere delimitador a ser usado para separar as substrings.
Por fim, as substrings devem ser enfileiradas na fila q na mesma ordem em que aparecem na string.

Você deve declarar a função no arquivo questao.h, e implementá-la no arquivo questao.cpp. */


#include <iostream>
#include "questao.h"

int main()
{
    string str; char sep;
    getline (cin, str);

    // Encontra qual o caracter separador da string (sep)
    for (int i = 0; i < str.size(); i++) {
        if ( ! isalpha(str[i])) {
            sep = str[i];
        }
    }

    queue <string> separado = separa(str, sep);

    return 0;
}
