/*Escreva um programa que testa se uma frase não muda se for invertida.
Por exemplo, estas frases são as mesmas se forem invertidas:

gentileza gera gentileza
coisa feita feita coisa

Seu programa deve usar uma pilha. Para separar as palavras, você pode aproveitar a função separa.

A frase a ser verificada é informada pela entrada padrão.
Seu programa não deve imprimir nenhuma mensagem na tela antes de ler essa frase. Após a verificação, seu programa deve imprimir na tela o seguinte:

VERDADEIRO se a frase não muda após ser invertida
FALSO caso contrário */

#include <iostream>
#include <string>
#include <stack>

using namespace std;

stack <string> inverte_pilha (const stack <string> & pilha) {

    stack <string> pilha_invertida;
    stack <string> pilha_original = pilha;

    while ( ! pilha_original.empty()) {
        pilha_invertida.push(pilha_original.top());
        pilha_original.pop();
    }

    return pilha_invertida;
}

bool analisa_string (const string & str)
{
    char sep = ' ';
    stack<string> pilha; // Cria pilha que armazena as palavras da string
    string substr;
    int i = 0;


    // Lê a string completa
    while (str[i] != '\0') {

        // Encontra um separador
        if (str[i] == sep) {

            // Add a palavra na pilha
            if (!substr.empty()) {
                pilha.push(substr);
                substr.clear();
            }

        // Caso não encontre separador, continua lendo
        } else substr += str[i];

        i++;
    }

    // Add última palavra da string
    if (!substr.empty())
        pilha.push(substr);

    stack<string> pilha_invertida = inverte_pilha(pilha);
    bool resultado;

    // Compara a pilha original com uma pilha invertida
    while ( !pilha.empty()) {
        if (pilha_invertida.top() == pilha.top())
            resultado = true;
        else {
            resultado = false;
            break;
        }
        pilha.pop();
        pilha_invertida.pop();
    }

    return resultado;
}

int main()
{
    string str; bool resultado;

    getline(cin, str);

    resultado = analisa_string(str);

    if (resultado)
        cout << "VERDADEIRO" << endl;
    else
        cout << "FALSO" << endl;

    return 0;
}
