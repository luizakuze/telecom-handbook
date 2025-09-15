## Tabela de Hash
- Uma tabela de hash é uma estrutura de dados associativa, onde a posição dos dados depende do seu valor. Também é chamada de hash map ou dicionário hash. O termo "hash" se refere ao processo de dispersar ou espalhar os dados.
- Cada elemento de dados tem uma chave única que é usada para acessar e armazenar os dados na tabela.

### Necessidades
- Buscar elementos dentro de um conjunto de dados grande.
- Encontrar duplicatas em um conjunto de dados.
- Armazenar e recuperar elementos rapidamente de um conjunto de dados grande.

### Como Funciona
Uma consulta ou busca é realizada usando a chave dos dados sendo pesquisados. Uma função hash é usada para calcular um valor numérico a partir da chave. Esse valor numérico é então usado para acessar um "bucket" ou uma posição em um array onde os dados são armazenados. Os dados desejados são obtidos do bucket durante a busca. A principal vantagem de uma tabela de hash é que o cálculo da posição usando a função hash é altamente eficiente, permitindo uma rápida recuperação de dados.

### Implementações
- unordered_map: É uma implementação de uma tabela de hash, onde os dados são armazenados como pares chave-valor. A chave é usada para acessar o valor correspondente.
- unordered_set: É uma implementação de um conjunto, que contém apenas valores únicos. É útil para verificar duplicatas.

### Biblioteca

```
#include <unordered_map>
#include <unordered_set>
```

### Criando uma Tabela de Hash

```
// A chave é do tipo string e o valor é do tipo inteiro
unordered_map<string, int> tabelaDeHash;
```

### Criando um Conjunto

```
// Conjunto que armazena elementos do tipo string
unordered_set<string> conjuntoDeHash;
```

### Iterando sobre os Elementos

```
for (auto& elemento : tabelaDeHash) {
    cout << elemento.first << ' ' << elemento.second;
}
```

Usar auto torna o código mais limpo e legível, e o seguinte é o que ele representa:

```
for (pair<string, int>& elemento : tabelaDeHash) {
    cout << elemento.first << ' ' << elemento.second;
}
```

Uma terceira forma, menos comum e menos recomendada:

```
auto it = tabelaDeHash.begin(); it != tabelaDeHash.end(); it++) {
cout << it->first << ": " << it->second;
}
```

### Operações
- count: Verifica quantas vezes um determinado elemento de dados aparece na tabela de hash.

```
// Lê pares de valores de um arquivo
// Cada par consiste em um nome de produto e sua quantidade
while (arquivo >> produto >> quantidade) {

    // Se a chave (nome do produto) já existe na tabela de hash (ou seja, já está presente no conjunto de dados)
    if (totais.count(produto) > 0) {

        // Acessa o valor associado e adiciona a quantidade lida a ele
        totais[produto] += quantidade;

    } else {

        // Caso contrário, armazena a quantidade lida e associa com o nome do produto
        totais[produto] = quantidade;
    }
}
```

### Map x Set
Mapas e conjuntos são semelhantes a tabelas de hash, mas a principal diferença é que eles já estão ordenados. Eles são implementados internamente como árvores de busca binária.