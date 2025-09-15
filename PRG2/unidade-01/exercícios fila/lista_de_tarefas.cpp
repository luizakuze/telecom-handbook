/* Um arquivo contém uma listagem das tarefas de um projeto, as quais possuem uma prioridade.
Cada linha desse arquivo se apresenta desta forma:

prioridade: tarefa
Por exemplo:

4: documentar o subsistema A
1: entrevistar o cliente
2: modelar o subsistema B
2: modelar o subsistema A
1: identificar os requisitos do subsistema A
3: implementar o subsistema A
2: implementar o subsistema B

Escreva um programa que leia um arquivo desses e apresente as tarefas ordenadas por suas prioridades (valores menores significam maiores prioridades). 
O nome do arquivo é informado no primeiro argumento de linha de comando. No exemplo acima, o resultado seria este:

1: entrevistar o cliente
1: identificar os requisitos do subsistema A
2: modelar o subsistema B
2: modelar o subsistema A
2: implementar o subsistema B
3: implementar o subsistema A
4: documentar o subsistema A
Observe que as tarefas de mesma prioridade devem estar na mesma ordem que no arquivo original.

Sabendo que existem, no máximo, 5 níveis de prioridade (de 1 até 5), implemente o programa que faz esse ordenamento.*/


#include <iostream>
#include <string>
#include <fstream>
#include <queue>

using namespace std;

void imprimir_tarefas(queue<string> & tarefas) {
    while(! tarefas.empty()) {
        cout <<tarefas.front() << endl;
        tarefas.pop();
    }
}

int main(int argc, char *argv[])
{
    // Filas com cada nível de prioridade (1-5)
    queue <string> tarefas1;
    queue <string> tarefas2;
    queue <string> tarefas3;
    queue <string> tarefas4;
    queue <string> tarefas5;

    // Número de parâmetros errado
    if (argc < 2) {
        cout << "Uso: " << argv[0] << " arquivo_de_tarefas" << endl;
        return 1;
    }

    // Abre arquivo para leitura
    ifstream arq(argv[1]);

    // Mensagem de erro caso não abra o arquivo
    if ( ! arq.is_open()) {
        perror ("Ao abrir");
        return errno;
    }


    string linha;
    while (getline(arq, linha)) {

        // A variável "prioridade" é quem mostra o nível de 1-5 de prioridade
        // de cada linha lida pelo arquivo
        int prioridade = stoi(linha.substr(0, linha.find(':')));

        // Armazena cada nível de prioridade
        // em sua respectiva fila
        switch (prioridade) {
            case 1:
                tarefas1.push(linha);
                break;
            case 2:
                tarefas2.push(linha);
                break;
            case 3:
                tarefas3.push(linha);
                break;
            case 4:
                tarefas4.push(linha);
                break;
            case 5:
                tarefas5.push(linha);
                break;
            default:
                cout << "Nivel de prioridade nao aceito" << endl;
        }

    }

    // Saída de dados
    imprimir_tarefas(tarefas1);
    imprimir_tarefas(tarefas2);
    imprimir_tarefas(tarefas3);
    imprimir_tarefas(tarefas4);
    imprimir_tarefas(tarefas5);

    return 0;
}
