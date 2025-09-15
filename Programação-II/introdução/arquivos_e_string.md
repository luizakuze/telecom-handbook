# Resumo de arquivos e string

## **Conceito de *Stream*, "Correnteza"**

1. Abre-se o arquivo, identificando seu *pathname* (caminho). Informa o diretório e o nome do arquivo. <br>
   **Ex )** /home/luiza/main.cpp <br> O arquivo pode ser aberto para leitura, escrita ou ambas as operações.
2. Realizam-se as operações de leitura e/ou escrita. Se forem as 2 operações, elas ocorrem sucessivamente como descrito.
3. Fecha-se o arquivo.

<br>



## **Funcionamento**
Bibliotecas para trabalhar com arquivos:
```
#include <errno.h>
#include <fstream>
```
<br>
Existem 3 classes para acessar arquivos:

- ofstream - modo escrita
- ifstream - modo leitura
- fstream - modo escrita/leitura

<br>

Exemplo no código:
- Criando um objeto "arq" da classe "ifstream"
```
ifstream arq("/users/luiza");
```

<br> 

Verificando se o arquivo foi aberto:
- Caso o arquivo não seja aberto, envia a mensagem do tipo de erro que aconteceu.
```
if (! arq.is_open()){
  perror("Ao abrir /etc/hosts");
  return errno;
}
```

<br>


## **Fechar arquivo**
Em C++, o arquivo não precisa ser fechado. Ele faz isso automaticamente. <BR> Já o C puro, precisa do comando *fclose(nome_arquivo)*

<br>

# Leitura de Arquivos

## Lendo linha por linha
O getline gera um resultado falso interpretado como falso caso não consiguir ler uma nova linha. <BR> Então o código abaixo usa essa ideia "enquanto o getline conseguir ler a linha, faça alguma coisa com o conteúdo de 'linha' ".

```
string linha;
ifstream arq("teste.txt");

while (getline(arq, linha)) {
  // faz algo com o conteúdo de "linha"
}
```


## Lendo palavra por palavra
Aqui o operador >> extrai uma palavra de cada vez do arquivo.
```
string palavra;
ifstream arq("teste.txt");

while (arq >> palavra) {
  // faz algo com o conteúdo de "palavra"
}
```