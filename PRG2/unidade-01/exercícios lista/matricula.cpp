/* Um arquivo contém todos os números de matrículas de alunos de um curso.
Em outro arquivo, estão as matrículas dos alunos que realizaram matrícula para um novo semestre.
A coordenação de curso deseja identificaram todos os alunos que NÃO renovaram suas matrículas.

Escreva um programa que ajude a coordenação nessa tarefa.
Seu programa deve receber o nome do arquivo com todos os alunos, seguido do nome do arquivo com os alunos que renovaram matrícula,
respectivamente no primeiro e segundo argumentos de linha de comando.

O resultado da execução de seu programa deve ser as matrículas dos alunos que não renovaram matrícula.*/

#include <iostream>
#include <list>
#include <string>
#include <fstream>

using namespace std;

int main(int argc, char *argv[])
{
    // Abre arquivo1 com todas as matrículas
    ifstream arq1(argv[1]);
    if (!arq1.is_open()) {
        perror("ERRO: ");
        return errno;
    }

    // Abre arquivo2 com quem fez a matrícula
    ifstream arq2(argv[2]);
    if (!arq2.is_open()) {
        perror("ERRO: ");
        return errno;
    }


    list <string> matriculados;

    // Para cada matrícula de aluno, add na lista de matricula
    string matricula;
    while (arq1 >> matricula) {
        matriculados.push_back(matricula);
    }

    // Lê os que renovaram e remove os nomes que já fizeram a matrícula
    string renovado;
    while (arq2 >> renovado) {
        matriculados.remove(renovado);
    }


    // Imprime na tela alunos que não fizeram a matrícula
    for (const string & dado : matriculados) {
        cout << dado << ' ';
    }

    return 0;
}
