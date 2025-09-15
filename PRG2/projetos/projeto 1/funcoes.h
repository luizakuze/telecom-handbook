#ifndef PROJETO_1_FUNCOES_H
#define PROJETO_1_FUNCOES_H

#include <iostream>
#include <iomanip>
#include <fstream>
#include <list>
#include <vector>
#include <stack>

using namespace std;

// Função que verifica a quantidade de dias anteriores e consecutivos com preço ascendente de uma ação
// Recebe como parâmetro um vector com os preços de cada dia de uma ação
vector<int> dias_ascendentes(vector<float> & precos);

// Função que imprime a sequência de dias com valores ascendentes em um arquivo chamado "sequencia.txt"
// Recebe como parâmetros um vector com cada data de uma ação e um vector com sequência de dias ascendentes de uma ação
void imprime_sequencia (vector<string> & datas, vector<int> & dias_ascendentes);

// Função que calcula as probabilidades de cada quantidade de dias com valores ascendentes
// e imprime em um arquivo "probabilidade.txt"
// Recebe como parâmetro uma lista que armazena a sequência de dias ascendentes
void probabilidade(list<int> & sequencia);

#endif //PROJETO_1_FUNCOES_H
