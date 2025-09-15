## Listas

- Armazenados dinamicamente em memória, de forma a se organizarem em uma sequência.
- Qualquer dado da lista pode ser acessado, independente da posição.
- Cada dado armazenado possui referências tanto do seu sucessor quando do seu antecessor, então <br>
  quando quiser acessar um dado do meio da lista, tem que ser ou pelo inicio ou final da lista.

### Aplicações

- Armazenar um conjunto de dados cuja quantidade não pode ser conhecida anteoriormente.
- Quando tiver que retirar um dados do início (push_front) ou do meio, a lista é melhor que o vector. <br> Se tiver que somente alterar dados que chegam no final, o vector é melhor.
- Armazenar dados cuja ordem em memória é modificada frequentemente.
- Ex. Banco de dados e playlists de música.

### Biblioteca
```
#include <list> lista;
```

### Criar uma lista
```
// Lista que armazena strings
list <string> nomes;
```
### Comandos

- push_front: Add um dado ao início da lista;
- push_back: Add um dado ao final da lista;
- pop_front: Retira um dado de frente da lista;
- pop_back: Retira um dado do final da lista.

```
lista.push_front("luiza");
lista.push_back("kuze");
lista.push_back("oi");

lista.pop_front(); // Tira a string "luiza"
lista.pop_back(); // Tira a string "oi"
```
#### Algumas operações da lista precisam usar ITERADORES como parâmetros. Comandos como, por exemplo, o insert e o erase.
- begin(): Início da lista;
- back(): Fim da lista;
- insert: Insere um dado em determinada posição;
- erase: Remove um dado ou  mais de determinada posição.
```
// Lista com alguns valores iniciados
list <string> lista = {"luiza", "lulu", "luizinha"}

// Obtém o iterador do primeiro dado da lista
auto it = lista.begin();

// Incrementando o iterador
it++;

// Add a string "ola mundo" na posição 2 da lista
// Ficando na frente de "lulu"
lista.insert (it, "ola mundo";
```
- size: retorna o comprimento da lista;
- empty: retorna 'true' se a lista estiver vazia, e 'false' caso contrário.
```
cout << "Lista de strings tem comprimento=" << lista.size() << endl;

while (! lista.empty()) {
   cout << "String: " << lista.front() << endl;
   lista.pop_front(); 
}
```
- clear: Remove todos os dados da lista de uma vez.
```
lista.clear();
```
#### Método sort
- sort: Ordena elementos em uma sequência em ordem crescente;
- reverse: Ordena em ordem decrescente.

**Sintaxe inicial**
```
sort(início, fim, comparação);
```
**Explicação** <br>
"início" é um ponteiro para o primeiro elemento da sequência a ser ordenada, "fim" é um ponteiro para o elemento seguinte ao último <br> elemento da sequência, e "comparação" é uma função opcional que especifica como os elementos devem ser comparados para a ordenação.
<br>
Se a "comparação" não for encontrada, o sort utiliza o operador '<'. Isso significa que os elementos estarão ordenados em ordem crescente.
<br> <br>
**Exemplo 1**
```
numeros.push_back(21);
numeros.push_back(8);
numeros.push_back(12);
numeros.push_back(17);

// ordena a lista
numeros.sort();

// mostra o conteúdo da lista
for (auto & x: numeros) {
   cout << x << endl;
}
```
**Exemplo 2**
```
#include <algorithm>
#include <vector>
#include <iostream>

bool greater(int a, int b) {
    return a > b;
}

int main() {
    std::vector<int> v = {4, 2, 7, 1, 3};
    std::sort(v.begin(), v.end(), greater);
    for (int i = 0; i < v.size(); i++) {
        std::cout << v[i] << " ";
    }
    std::cout << std::endl;
    return 0;
}

```