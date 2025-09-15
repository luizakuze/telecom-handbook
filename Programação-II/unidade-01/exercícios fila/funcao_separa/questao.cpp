#include "questao.h"

// função que separa o caminho em seus componentes (diretórios e arquivos)
queue<string> separa(const string &caminho, char sep) {
    queue<string> sequencia;
    int pos1 = caminho.find_first_not_of(sep);

    while (pos1 != string::npos) {
        int pos2 = caminho.find(sep, pos1 + 1);
        if (pos2 != string::npos) {
            string trecho = caminho.substr(pos1, pos2 - pos1);
            sequencia.push(trecho);
        } else {
            string trecho = caminho.substr(pos1);
            sequencia.push(trecho);
            break;
        }
        pos1 = caminho.find_first_not_of(sep, pos2 + 1);
    }
    return sequencia;
}

// função que reduz o caminho absoluto
string reduz_caminho(const string &caminho) {
    stack<string> pilha;
    queue<string> componentes = separa(caminho, '/');
    while (!componentes.empty()) {
        string componente = componentes.front();
        componentes.pop();
        if (componente == "." || componente == "") {
            // nada a fazer
        } else if (componente == "..") {
            if (!pilha.empty()) {
                pilha.pop();
            }
        } else
            pilha.push(componente);

    }
    string resultado;
    while (!pilha.empty()) {
        resultado = "/" + pilha.top() + resultado;
        pilha.pop();
    }
    if (resultado.empty()) {
        resultado = "/";
    }
    return resultado;
}
