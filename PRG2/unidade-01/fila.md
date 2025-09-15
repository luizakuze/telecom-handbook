## Filas

É uma estrutura de dado linear, armazena em sequência. A localização de um dado não depende do seu valor. <br> A sua posição na sequência não altera seu valor. <br>
Tem o comportamento **FIFO** (First In First Out).

### Onde a fila aparece
- Escalonamento de processos
- Dados que esperam para serem implementados
- Resolve problemas de mapeamento

### Biblioteca
```
#include <queue>
```

### Criar uma fila
```
// Fila que armazena números inteiros
queue <int> num;

// Fila que armazena strings
queue <string> str;
  ```
### Comandos

- push: enfileira um dado;
- pop: desenfileira um dado; (Lembrando que ele desenfileira o primeiro dado colocado, modelo FIFO)

```
num.push(1);
num.push(4);
num.push(10);
num.pop();

str.push("Luiza");
str.push("Kuze");
str.pop();
```
- front: retorna o dado que está na frente da fila;
- back: retorna o dado que está no fim da fila (último dado enfileirado);
```
cout << "Ultimo dado enfileirado (final da fila)=" << num.back() << endl;
cout << "Primeiro dado enfileirado (inicio da fila)=" << num.front() << endl;
```
- size: retorna o comprimento da fila (quantos dados estão armazenados);
- empty: retorna true se fila estiver vazia, e false caso contrário.
```
cout << "Fila de numeros tem comprimento=" << num.size() << endl;
cout << "Fila de string tem comprimento=" << str.size() << endl;

while (! num.empty()) {
   cout << "Numero: " << num.front() << endl;
   num.pop(); // desenfileira um número
}
```