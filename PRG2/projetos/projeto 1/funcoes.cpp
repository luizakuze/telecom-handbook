#include "funcoes.h"

// Verifica a sequência de dias com valores ascendentes
vector<int> dias_ascendentes(vector<float> & precos) {

    // Armazena índice do dia atual
    stack<float> indice_atual;

    // Resultado da qt dias anteriores menores (ascendentes)
    vector<int> resultado(precos.size());

    // Percorre o vector de precos
    for (int i = 0; i < precos.size(); i++) {

        // Enquanto o dia anterior mais próximo com preço da ação maior do que o do dia atual (topo da pilha)
        // for menor ou igual ao preço de ação do dia atual. Não será mais útil no cálculo
        while (!indice_atual.empty() && precos[indice_atual.top()] <= precos[i]) {
            indice_atual.pop();
        }

        // Se pilha vazia, não existe nenhum dia anterior com preço de ação maior do que o dia atual.
        // Se não,  o valor é igual a 'i' menos o índice do dia anterior mais próximo com preço de ação maior do que o do dia atual,
        resultado[i] = indice_atual.empty() ? (i + 1) : (i - indice_atual.top());
        indice_atual.push(i);
    }

    // Retorna o resultado final
    return resultado;
}

// Imprime a sequência de dias ascendentes em um arquivo chamado "sequencia.txt"
void imprime_sequencia (vector <string> & datas, vector <int> & dias_ascendentes) {

    // Cria um arquivo com os resultados do programa
    ofstream arq2("sequencia.txt");

    // Verifica se o arquivo foi aberto corretamente
    if (!arq2.is_open()) {
        perror ("Erro ");
        exit(errno);
    }

    // Imprimindo os resultados no arquivo
    for (int i = 0; i < datas.size(); i++) {
        arq2 << datas[i] << ' ' << dias_ascendentes[i] << endl;
    }
}

// Calcula e imprime as probabilidades de cada quantidade de dias com valores ascendentes
void probabilidade(list<int> & sequencia) {

    // Cria um arquivo com os resultados do programa
    ofstream arq3("probabilidade.txt");

    // Verifica se o arquivo foi aberto corretamente
    if (!arq3.is_open()) {
        perror ("Erro ");
    }

    // Tamanho da sequência de dias
    int tamanho = sequencia.size();

    // Ordena a sequência (vaolres iguais são colocados consecutivamente)
    sequencia.sort();

    // Armazena quantas vezes um número apareceu repetidamente
    list<float> ocorrencia;

    auto it = sequencia.begin();

    // Percorre a sequência de dias com valores ascendentes
    while (it != sequencia.end()) {

        // Conta um número (tem pelo menos um número de cada valor da sequência)
        float cont = 1;

        auto it_next = next(it);

        // Analisa se há repetições
        while (it_next != sequencia.end()) {

            // encontra uma repetição e "conta"
            if (*it == *it_next) {
                it_next = sequencia.erase(it_next);
                cont++;
            }
                // se não, atualiza o próximo iterador (só há uma palavra)
            else {
                ++it_next;
            }

        }

        // Atualiza it principal
        ++it;

        ocorrencia.push_back(cont);
    }

    // Percorre todos os dados da sequência
    for (auto &x: sequencia) {

        // Calcula a porcentagem/probabilidade de cada dia
        float porcentagem;
        porcentagem = (float) ocorrencia.front() / tamanho;

        // Imprime no arquivo de texto a probabilidade com apenas 4 casas após a vírgula
        arq3 << x << ' ' << fixed << setprecision(4) << porcentagem << endl;
        ocorrencia.pop_front();
    }

}
