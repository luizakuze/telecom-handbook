/* Notação polonesa é uma forma de apresentação de expressões aritméticas em que o operador precede os operandos.
Por exemplo, a expressão 2 + 1 é escrita + 2 1 em notação polonesa.
Essa forma de escrever expressões elimina a necessidade de uso de parênteses, uma vez que a ordem em que a expressão é resolvida
está diretamente representada na própria expressão.

Nesta tarefa, você deve implementar uma calculadora capaz de resolver expressões aritméticas em notação polonesa como estas:

+ 1 2
* + 1 2 3
/ * + 1 2 3 5

... quer dizer, que consiga resolver expressões compostas por valores inteiros ou emponto flutuante e
operações básicas + (adição), - (subtração), * (multiplicação), / (divisão) e ^ (exponenciação).

Seu programa deve calcular a expressão informada no primeiro argumento de linha de comando (argv[1]),
e apresentar o resultado na saída padrão (na tela). Se a expressão for inválida, ele deve mostrar a mensagem ERRO.

Um algoritmo geral pode ser criado usando duas pilhas, e está descrito a seguir:

Seja as pilhas P1 e P2 inicialmente vazias
Empilhe os elementos da expressão na pilha P1 (números e operadores)
Desempilhe um elemento de P1
Se o elemento for um número, empilhe-o em P2 e volte para o passo 3
Se o elemento for um operador, desempilhe dois números de P2
Calcule a operação entre os dois números e o operador
Armazene o resultado da operação em P2
Se P1 não estiver vazia volte ao passo 3
Desempilhe o resultado que está em P2 */

#include <iostream>
#include <sstream>
#include <string>
#include <stack>
#include <queue>
#include <cmath>

using namespace std;

// Função que verifica se o elemento da expressão é um operador
// Se for, retorna verdadeiro
bool operador (char c) {
    return c == '+' || c == '-' || c == '*' || c == '/' || c == '^';
}

// Função que realiza os cálculos quando necessário
float calcula(float x, float y, char op) {
        switch (op) { case '+': return x + y;
            case '-': return x - y;
            case '*': return x * y;
            case '/': return x / y;
            case '^': return pow(x, y); // pow --> x^y
            default: return NAN; // opção inválida
    }
}

float avalia_expressao(const string & str) {
    stack<string> p1; // pilha que armazena tudo o que foi lido de expressao (operadores e números)
    stack<float> p2; // pilha que armazena apenas os números

    // trata a "expressao" como se fosse um arquivo
    istringstream expressao (str);

    // Armazena cada elemento da expressão
    string elemento;

    // Empilha todos os elementos da expressão na pilha p1
    while (expressao >> elemento) {
        p1.push(elemento);
    }

    // Desempilha um elemento de p1
    while (!p1.empty()) {
        elemento = p1.top();
        p1.pop();

        float num1, num2;

        // Verifica se o elemento é um número
        istringstream caracter(elemento);

        if (caracter >> num1) {
            // Se for um número, empilha na pilha p2
            p2.push(num1);
        } else if (operador(elemento[0])) {
            // Se for um operador, desempilha dois números de p2
            num1 = p2.top(); p2.pop();

            // Verifica se não há números suficientes na pilha
            if (p2.empty()) return NAN;

            num2 = p2.top(); p2.pop();

            // Calcula a operação entre os dois números e o operador
            float resultado = calcula(num1, num2, elemento[0]); // elemento[0] representa o operador

            // Armazena o resultado da operação em p2
            p2.push(resultado);
        } else {
            return NAN;
        }
    }

    // Desempilha o resultado final da pilha p2
    float resultado_final = p2.top();
    p2.pop();

    return resultado_final;
}

int main(int argc, char *argv[])
{
    string str = argv[1];

    float resultado = avalia_expressao(str);

    if (isnan(resultado)) {
        cout << "ERRO" << endl;
    } else {
        cout << resultado << endl;
    }
    return 0;
}
