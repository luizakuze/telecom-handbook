### Problema 
Escreva uma função que crie uma árvore de pesquisa binária com exatamente esta topologia:
```
           mar
          /   \
    ferias     praia
    /     \    /    \
 areia    luz onda  sol
 ```
 
A função deve ser declarada assim: "arvore<string> cria_arvore();"


### Arquivo.h 
```
#ifndef PROG_QUESTAO_H
#define PROG_QUESTAO_H

#include <iostream>
#include <prglib.h>

using namespace std;

using prglib::arvore;

arvore<string> cria_arvore();


#endif //PROG_QUESTAO_H
```

### Arquivo.cpp
```
#include "questao.h"

arvore<string> cria_arvore() {
    
    // std::vector<string>v = {mar, ferias, praia, areia, luz, onda, sol};
    // arvore<string> a (v);
    arvore<string> a;
    
    a.adiciona(string("mar"));
    a.adiciona(string("ferias"));
    a.adiciona(string("praia"));
    a.adiciona(string("areia"));
    a.adiciona(string("luz"));
    a.adiciona(string("onda"));
    a.adiciona(string("sol"));
    
return a;
}
```
