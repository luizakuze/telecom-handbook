/* Escreva um programa que leia palavras de um arquivo, e, ao final, mostre cada palavra seguida de sua quantidade de ocorrências no arquivo. 
O nome do arquivo é fornecido como primeiro argumento de linha de comando. As palavras lidas estão separadas por espaços ou quebras de linha.
O resultado final deve ser apresentado desta forma na tela:

palavra1 número_de_ocorrências
palavra2 número_de_ocorrências
...
palavraN número_de_ocorrências

Exemplo: se as palavras lidas forem estas:

um tigre
dois tigres
tres tigres

... o resultado final deve ser este (a ordem das palavras não é relevante):

um 1
tigre 1
dois 1
tigres 2
tres 1 */

#include <iostream>
#include <fstream>
#include <string>
#include <list>

using namespace std;

int main(int argc, char* argv[]) {

    // Abre o arquivo para leitura
    ifstream arq(argv[1]);

    // Confere se o arquivo realmente abriu
    if (!arq.is_open()) {
        perror ("Erro ");
        return errno;
    }

    // Armazena lista do arquivo em uma lista
    list<string> lista;
    string palavra;
    while (arq >> palavra) {
        lista.push_back(palavra);
    }

    // Ordena as lista,
    // ou seja, se houverem repitições elas estão juntas
    lista.sort();

    auto it = lista.begin();

    // Percorre a lista
    while (it != lista.end()) {

        // Conta palavras (tem pelo menos uma palavra)
        int cont = 1;

        auto it_next = next(it);

        // analisa se há repetições
        while (it_next != lista.end()) {

            // encontra uma repetição e "conta"
            if (*it == *it_next) {
                it_next = lista.erase(it_next);
                cont++;
            }
            // se não, atualiza o próximo iterador (só há uma palavra)
            else
                ++it_next;

        }

        // Atualiza it principal
        ++it;

        // Imprime os resultados
        cout << lista.front() << ' ' << cont << endl;
        lista.pop_front();
    }

    return 0;
}
