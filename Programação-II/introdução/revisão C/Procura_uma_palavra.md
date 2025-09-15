# Procura uma palavra
O programa procura uma palavra dentro de um arquivo e imprime as linhas que não tiverem essa palavra.

## Com linha de Comando
```
#include <iostream>
#include <string>
#include <fstream>
#include <errno.h>

using namespace std;

// agrc: Quantos argumento
// argv: Vetor de argumentos
int main(int argc, char *argv[])
{
    // Caso o usuário informe o num errado de argumentos
    if(argc < 3) {
        cout << "Uso: " << argv[0] << " arquivo sequencia" << endl;
        return 1;
    }
    
    // Abre o arquivo que tem esse diretório
    ifstream arq(argv[1]);

    // Verifica se o arquivo foi mesmo aberto
    if (! arq.is_open()){
        perror("Ao abrir");
        return errno;
    }

    string linha;

    // Lê cada linha do arquivo
    while (getline(arq, linha)) {

        // Procura a substring dentro do texto usando o find
        // Procura enquanto o texto não terminar
        // "Enquanto o arquivo tiver posições p/ procurar" (string::npos) 
        if(linha.find(argv[2]) != string::npos)
            cout << linha << endl;
    }


    return 0;
}
```

## Sem linha de Comando
```
#include <iostream>
#include <string>
#include <fstream>
#include <errno.h>

using namespace std;

int main()
{
    string seq_caracter;
    cin >> seq_caracter;

    // Abre o arquivo que tem esse diretório
    ifstream arq("/etc/hosts");

    // Verifica se o arquivo foi mesmo aberto
    if (! arq.is_open()){
        perror("Ao abrir /etc/hosts");
        return errno;
    }

    string linha;

    // Lê cada linha do arquivo
    while (getline(arq, linha)) {

        // Procura a substring dentro do texto usando o find
        // Procura enquanto o texto não terminar (string::npos)
        if(linha.find(seq_caracter) != string::npos)
            cout << linha << endl;
    }


    return 0;
}
```
