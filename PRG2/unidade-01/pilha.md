## Pilhas

É uma estrutura de dado linear, armazena em sequência. <br>
A localização de um dado não depende do seu valor. <br>
Tem o comportamento **LIFO** (Last In First Out).

### Biblioteca
```
#include <stack>
```

### Criar uma pilha
```
// Pilha que armazena números inteiros
stack <int> pilha;
```
### Comandos

- push: empilha um dado;
- pop: desempilha um dado; (Lembrando que ele desempilha o primeiro dado colocado, modelo LIFO)

```
pilha.push(1);
pilha.push(2);
pilha.push(3);
pilha.push(4);

// lifo (last in first out)
// Aqui, saí o 4
pilha.pop();
```
- top: retorna o último dado empilhado;
```
top << "Ultimo dado empilhado (topo)=" << pilha.top() << endl;
```
- size: retorna o comprimento da pilha (quantos dados estão armazenados);
- empty: retorna 'true' se a pilha estiver vazia, e 'false' caso contrário.
```
cout << "Pilha de numeros tem comprimento=" << pilha.size() << endl;

while (! pilha.empty()) {
   cout << "Numero: " << pilha.front() << endl;
   pilha.pop(); // desempilha um dado
}
```
