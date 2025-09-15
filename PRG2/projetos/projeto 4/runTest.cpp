//
// Created by msobral on 22/11/2022.
//

//
// Created by sobral on 27/07/19.
//
#include <limits.h>
#include <time.h>
#include <string>
#include <algorithm>
#include <ostream>
#include <sstream>
#include <fstream>
#include <list>
#include <string>
#include <cmath>
#include "thash.h"
#include "gtest/gtest.h"

using namespace std;

class TesteThash: public ::testing::Test {
protected:
    virtual void SetUp() {
        srand(clock());
    }

    void escreva_lista(const list<int> & l, const string & sep, ostream & out) {
        if (l.empty()) return;
        int n = l.size();
        auto it=l.begin();
        for (; n > 1; it++, n--) out << *it << sep;
        out << *it;
    }

};

TEST_F(TesteThash, CriarVazio) {
    auto v = prg2::thash_cria<int>();
    ASSERT_TRUE(prg2::thash_vazio(v));
    ASSERT_EQ(prg2::thash_tamanho(v), 0);
}

TEST_F(TesteThash, DestroiArray) {
    auto v = prg2::thash_cria<float>();
    ASSERT_NO_THROW(prg2::thash_destroi(v));
}

TEST_F(TesteThash, Adicionar) {
    auto v = prg2::thash_cria<int>();

    for (auto j=0; j < 10; j++) {
        prg2::thash_adiciona(v, to_string(j), j);
        ASSERT_FALSE(prg2::thash_vazio(v));
        ASSERT_EQ(prg2::thash_tamanho(v), j+1);
    }
}

TEST_F(TesteThash, ObtemVazio) {
    auto v = prg2::thash_cria<int>();

    ASSERT_THROW(prg2::thash_obtem(v, "um"), std::invalid_argument);
}

TEST_F(TesteThash, Existe) {
    auto v = prg2::thash_cria<int>();

    thash_adiciona(v, "um", 1);
    thash_adiciona(v, "dois", 2);
    thash_adiciona(v, "tres", 3);
    ASSERT_EQ(prg2::thash_existe(v, "um"), true);
    ASSERT_EQ(prg2::thash_existe(v, "dois"), true);
    ASSERT_EQ(prg2::thash_existe(v, "tres"), true);
    ASSERT_EQ(prg2::thash_existe(v, "quatro"), false);
}

TEST_F(TesteThash, Obtem) {
    auto v = prg2::thash_cria<int>();

    thash_adiciona(v, "um", 1);
    thash_adiciona(v, "dois", 2);
    thash_adiciona(v, "tres", 3);
    ASSERT_EQ(prg2::thash_obtem(v, "um"), 1);
    ASSERT_EQ(prg2::thash_obtem(v, "dois"), 2);
    ASSERT_EQ(prg2::thash_obtem(v, "tres"), 3);
    ASSERT_THROW(prg2::thash_obtem(v, "quatro"), std::invalid_argument);
}

TEST_F(TesteThash, Remove) {
    auto v = prg2::thash_cria<int>();

    thash_adiciona(v, "um", 1);
    thash_adiciona(v, "dois", 2);
    thash_adiciona(v, "tres", 3);
    ASSERT_NO_THROW(prg2::thash_remove(v, "um"));
    ASSERT_EQ(prg2::thash_existe(v, "um"), false);
    ASSERT_EQ(prg2::thash_tamanho(v), 2);
    ASSERT_NO_THROW(prg2::thash_remove(v, "dois"));
    ASSERT_EQ(prg2::thash_existe(v, "dois"), false);
    ASSERT_EQ(prg2::thash_tamanho(v), 1);
}
