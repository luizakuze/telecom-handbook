/* Um arquivo possui a quantidade de minutos que usuários utilizaram um sistema ao longo de um certo período. Cada linha do arquivo tem este formato:

usuario horario minutos
Ex: a linha a seguir significa que usuário "aluno" utilizou o sistema por 25 minutos, iniciando às 13:32.

aluno 13:32 25
Escreva um programa mostre quantas vezes um usuário entrou no sistema, e também a duração total de sua utilização do sistema.
O nome do usuário é fornecido no primeiro argumento de linha de comando.
Se o nome do usuário for vazio, o programa deve mostrar essas informações para cada um dos usuários (ordenado por nome de usuário).
O resultado a ser apresentado por seu programa deve ser, portanto:

Se for fornecido um nome de usuário: deve-se apresentar uma linha com este formato:
usuário acessos duração_total
OBS: se o usuário não existir no arquivo, seu programa deve mostrar o seguinte:
usuario invalido
Se não for fornecido um nome de usuário: devem-se apresentar os totais para cada usuário contido no arquivo, ordenados por nome de usuário. */

#include <unordered_map>
#include <iostream>
#include <string>
#include <fstream>
#include <list>

using namespace std;

struct dado_usuario {
    int acessos;
    int duracao;
};

bool ordena (const pair<string, dado_usuario> & p1, const pair <string, dado_usuario> & p2) {
    return p1.first < p2.first;
}

int main(int argc, char *argv[]) {

    // Abre arquivo para leitura
    ifstream arq("usuarios.txt");


    // Armazena o nome de um usuário como chave para
    // os dados de qtd e tempo de acessos do usuário
    unordered_map<string, dado_usuario> usuario;

    string nome;
    string horario;
    int tempo;

    // Lendo os dados do arquivo para dentro de uma tabela hash
    while (arq >> nome >> horario >> tempo) {

        // Se já encontrar um usuário com esse nome
        if (usuario.count(nome) > 0) {
            usuario[nome].acessos++;
            usuario[nome].duracao += tempo;

        // Se não houver ainda esse usuário, adiciona ele
        } else {
            dado_usuario aux = {1, tempo};
            usuario[nome] = aux;
        }
    }


    // Se tiver um usuário especificado para imprimir
    if (argc == 2) {
        
        // Imprime
        string nome_busca = argv[1];
        if (usuario.count(nome_busca) > 0) {
            dado_usuario du = usuario[nome_busca];
            cout << nome_busca << ' ' << du.acessos << ' ' << du.duracao << endl;
            
        // Se não encontrar o usuário    
        } else {
            cout << "Usuario invalido" << endl;
        }
        
    // Se não houver um usuário específico    
    } else {
        // Ordena os dados dos usuários
        list <pair<string, dado_usuario>> resultado (usuario.begin(), usuario.end());
        resultado.sort(ordena);

        // Imprime todos os dados de todos os usuários
        for (auto & dado: resultado) {
            cout << dado.first << ' ' << dado.second.acessos << ' ' << dado.second.duracao << endl;
        }
    }

    return 0;
}
