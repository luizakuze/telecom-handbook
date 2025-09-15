#include "funcoes.h"

int main(int argc, char *argv[]){

    // Abre arquivo das ações para leitura
    ifstream arq(argv[1]);

    // Verifica se o arquivo foi aberto corretamente
    if (!arq.is_open()) {
        perror ("Erro ");
        return errno;
    }

    // Armazenam dados das ações
    vector<float> precos;
    vector<string> datas;

    // Lê o arquivo com os dados das ações
    // Armazena as datas e os preços nos dois vectors
    float p; string d;
    while (arq >> d >> p) {
        datas.push_back(d);
        precos.push_back(p);
    }

    // Vector que armazena a sequência de dias com valores ascendentes
    vector <int> sequencia_dias = dias_ascendentes(precos);

    // Imprime a sequência desses dias em um arquivo chamado "sequencia.txt"
    imprime_sequencia(datas, sequencia_dias);

    // Transforma vector em lista
    list<int> l_sequencia_dias(sequencia_dias.begin(), sequencia_dias.end());

    // Calcula e imprime as probabilidades de cada quantidade de dias com valores ascendentes
    // em um arquivo chamado "probabilidade.txt"
    probabilidade(l_sequencia_dias);

    return 0;
}
