/* Escreva um programa que verifica se duas palavras são anagramas.
Se uma palavra ou expressão puder ser transformada em outra, mediante a mudança de posições de caracteres, então ambas são anagramas.
Alguns exemplos de anagramas são:

ator rota
iracema america
pedro poder

As palavras (ou expressões) a serem verificadas são informadas por meio de argumentos de linha de comando.

Se as palavras forem anagramas, seu programa deve mostrar a palavra VERDADEIRO na tela. Caso contrário, ele deve apresentar FALSO. */

#include <algorithm>
#include <string>
#include <iostream>

using namespace std;

int main(int argc, char *argv[]) {

    // Armazena palavras a serem comparadas em strings
    string str1 = argv[1];
    string str2 = argv[2];

    // Ordena as strings
    sort(str1.begin(), str1.end());
    sort(str2.begin(), str2.end());

    // Confere igualdade
    if (str1 == str2)
        cout << "VERDADEIRO" << endl;
    else
        cout << "FALSO" << endl;

    return 0;
}
