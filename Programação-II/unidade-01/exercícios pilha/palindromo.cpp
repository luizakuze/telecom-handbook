/*Escreva um programa que testa se uma palavra é um palíndromo (quer dizer, essa palavra não muda se for invertida).
Por exemplo, estas palavras são palíndromos:

ana
anilina
mirim

Seu programa deve usar uma pilha.

A palavra a ser verificada é informada pelo primeiro argumento de linha de comando.
Após a verificação, seu programa deve imprimir na tela o seguinte:

- VERDADEIRO se a palavra for um palíndromo
- FALSO caso contrário */


#include <iostream>
#include <string>
#include <stack>

using namespace std;

int main(int argc, char *argv[])
{
    stack <char> pilha; // Pilha que armazena cada caracter da palavra
    string palavra = argv[1]; // Recebe a palavra a ser verificada pelo argv[1]
    bool resultado = true;

    for (int i = 0, j = palavra.size() - 1; i < palavra.size(); i++, j--) {

        // Pega os caracteres da palavra
        pilha.push(palavra[i]);

        if (palavra[j] == pilha.top()) {
            resultado = true;
        } else {
            resultado = false;
        }


    }

    // Imprime o resultado
    if (resultado) cout << "VERDADEIRO" << endl;
    else cout << "FALSO" << endl;


    return 0;
}
