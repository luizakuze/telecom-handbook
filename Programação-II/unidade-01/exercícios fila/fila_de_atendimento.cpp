/* Uma loja automotiva implantou um programa para organizar a fila de atendimento de clientes.
 * Cada cliente que chega na loja se apresenta a um atendente, que inclui seu nome em uma fila
 * e lhe informa quantos clientes estão na sua frente. Os clientes são atendidos por ordem de chegada.
 * Os atendimentos são feitos por uma equipe de profissionais, e sempre que um dos membros dessa equipe fica ocioso,
 * ele obtém da fila de espera o nome do próximo cliente. */

/* Escreva um programa que funcione como esse sistema de atendimento da loja.
 * Para simplificar, seu programa deve implementar um laço que executa repetidamente o seguinte:

 * 1 - O programa deve apresentar este prompt: ">"
 * 2 - Se for digitado o caractere "?", o programa deve apresentar o nome do próximo cliente (caso exista), e retirá-lo da fila
 * 3 - Se for digitado o comando "sair" o programa deve terminar
 * 4 - Se for digitado um nome de cliente, ele deve adicioná-lo à fila, e apresentar na tela quantos clientes estão na sua frente */


#include <iostream>
#include <string>
#include <queue>

using namespace std;

int main()
{
    queue <string> clientes; //criar fila
    string input;  //resposta do usuário

    // Controle de fluxo
    while (true) {

        cout << "> " << endl;
        getline (cin, input);

        // A comparação deve ser com aspas duplas
        // Pois o compilador com aspas simples entende como um caracter multi-byte
        if (input == "?") {
            cout << clientes.front() << endl;
            clientes.pop();

        } else if (input == "sair") break;

        // Nome cliente
        else {
            clientes.push(input);
            cout << clientes.size() - 1 << endl;
        }


    }


    return 0;
}
