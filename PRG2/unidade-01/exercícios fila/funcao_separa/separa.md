#### 1 opcão de implementação
```
queue <string> separa(const string & algo, char sep) {
    queue <string> sequencia;

    // aqui, algoritmo da função separa
    int pos1 = algo.find_first_not_of(sep);

    while (pos1 != string::npos) {
        // procura o próximo delimitador após pos1
        // e guarda sua posicção em pos2
        int pos2 = algo.find(sep, pos1+1);

        //enfileira a substring que está
        //entre pos1 e pos2
        if (pos2 != string::npos) {
            string trecho = algo.substr(pos1, pos2 - pos1);
                sequencia.push(trecho);
        } else { // não achou nenhum delimitador
            string trecho = algo.substr(pos1);
            sequencia.push(trecho);
            break;
        }

        //atualiza pos1 para a posição logo após pos2
        pos1 = algo.find_first_not_of(sep, pos2 + 1);
    }
    return sequencia;
}
```

#### 2 opcão de implementação

```
queue <string> separa(const string & algo, char sep) {
    queue <string> sequencia;
    istringstream inp(algo);
    
    string treacho;
    while(getline(inp, treacho, sep)) {
        sequencia.push(treacho);
    }
    return sequencia;
}
```
