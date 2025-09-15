#include <iostream>
#include "thash.h"

using namespace prg2;
using namespace std;

struct Ponto {
    int x,y;
};

bool operator==(const Ponto & p1, const Ponto & p2) {
    return p1.x == p2.x && p1.y == p2.y;
}

uint32_t f_hash(const Ponto & p, int N) {
    return f_hash_simples((uint8_t*)&p, sizeof(p), N);
}



int main() {
    auto tab = thash_cria<Ponto,string>();

    for (int j = 0; j < 50; j++) {
        thash_adiciona(tab, Ponto{j, j}, to_string(j*111)+"xyz");
        cout << j << ": buckets (linhas) " << tab.tabela.size() << endl;
    }

//    for (int j = 0; j < 50; j++) {
//        cout << "Valor na chave Ponto{" << j<< ',' << j << "}:" << thash_obtem(tab, j*0.1) << endl;
//    }

//    thash_adiciona(tab, "coisa", 10);
//    thash_adiciona(tab, "algo", 20);
//    thash_adiciona(tab, "trecos", 30);

      cout << "Tamanho da tabela: " << thash_tamanho(tab) << endl;
//    cout << "Valor da chave \"coisa\": " << thash_obtem(tab, "coisa") << endl;
//    cout << "Valor da chave \"trecos\": " << thash_obtem(tab, "trecos") << endl;
//    cout << "Chave \"bagaça\" existe na tabela ? " << thash_existe(tab, "teste") << endl;

    thash_destroi(tab);

    return 0;
}
