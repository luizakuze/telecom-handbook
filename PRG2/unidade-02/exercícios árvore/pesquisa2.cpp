/* Um arquivo chamado "matriculas.txt" contém uma relação de números de matrícula e nome de estudantes.

Cada linha desse arquivo tem este formato:
numero,Nome de Uma Pessoa

Escreva um programa que leia os dados desse arquivo e os armazene em uma árvore de pesquisa binária.
O nome do arquivo é informado no primeiro argumento de linha de comando.
Em seguida, seu programa deve entrar em um loop.

Em cada ciclo do loop o programa apresenta este prompt:
Digite matricula>

... e aguardar que seja fornecido um número de matrícula pelo teclado.

Ao ler a matrícula, deve-se apresentar na tela o nome do estudante neste formato:
Estudante: Um Nome de Um Estudante

Se em vez de uma matrícula for teclado ENTER, o programa deve terminar.

Se uma matrícula desconhecida for digitada, seu programa deve apresentar esta mensagem:
Matricula MATRICULA_DIGITADA desconhecida

Seu programa será testado com diferentes números de consultas.

Neste exercício, você precisará declarar um novo tipo de dados para representar esse par de dados formado por matrícula e nome de estudante.
Para que a árvore consiga armazenar valores desse novo tipo de dados, você precisará também especificar como esses valores devem ser comparados. */

#include <iostream>
#include <fstream>
#include <list>
#include <string>
#include <set>
#include <prglib.h>

using namespace std;
using prglib::arvore;

#define loop while(true)

struct Aluno {
    string nome;
    string matricula;
};

// Compara dois alunos
int f_compara(const Aluno & a1, const Aluno & a2) {
    if (a1.matricula < a2.matricula) return -1;
    // Se a1 > a2 for verdadeiro, retorna 1
    // Se a1 > a2 for falso, só sobra a opção de a1 == s2 e retorna 0
    return a1.matricula > a2.matricula;
}

// Cria um valor Aluno a partir de uma string
// String no formato: matricula nome
Aluno cria_aluno (const string & linha) {
    Aluno aluno;

    int sep = linha.find(",");

    string matricula = linha.substr(0, sep - 1 ); //início da linha até separador
    string nome = linha.substr(sep + 1); //do separador até o final da linha

    aluno = {nome, matricula};
    return aluno;
}

int main() {

    // Abre arquivo com base de dados
    ifstream arq("nomes.txt");
    if(!arq.is_open()) {
        perror ("ao abrir ");
        return errno;
    }

    // Cria árvore de pesquisa
   auto arv = prglib::cria_arvore<Aluno>(f_compara);

    // Percorre todos os nomes do arquivo e armazena em uma árvore
    string linha;
    while (getline(arq, linha)) {
           arv.adiciona(cria_aluno(linha));
    }


    // Confere se o nome existe na base
    loop {
        string matricula;
        cout << "Consultar>";
        getline(cin, matricula);
        if (matricula.empty()) break;

        // Cria uma variável p pesquisa do tipo "Aluno" com o campo nome vazio
        Aluno aluno {"", matricula};

        if (arv.existe(aluno)) {
            auto & alguem = arv.obtem(aluno);
            cout << "Estudante " << alguem.nome << endl;
        } else {
            cout << "Matricula: " << aluno.matricula << "inexistente" << endl;
        }
    }

    return 0;
}
