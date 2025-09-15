## Templates para tipos de dados genéricos

Os templates generalizam as estruturas de dados. <br>
É a possibilidade da estrutura guardar qualquer tipo de dado que o usuário deseja. <br>

### Exemplo nas declarações de lista e pilha:
```
queue<string> q;
stack<int> s;
```

### Implementação

A declaração do template tem que estar em um arquivo .h <br>
Tem que ser algo mais ou menos assim:

```
template <typename T> struct Vetor {

// declarações de atributos da struct

};
```

```
template <typename T> struct Vetor {
    int capacidade; // quantos dados cabem neste vetor atualmente
    int itens; // quantos dados estão armazenados neste vetor
    T* mem; // área de memória para guardar os dados de tipo T 
};
```