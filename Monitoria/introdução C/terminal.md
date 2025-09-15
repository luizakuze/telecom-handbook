# Terminal 👩🏻‍💻

Comando | Descrição 
----|----
**ls** | Lista conteúdo do diretório.
**cd** |  Muda de diretório.
**mkdir** | Cria diretório.
**rm** | Remove arquivo.
**rm -r** | Remove diretório com conteúdo.
**rmdir** | Remove diretório vazio.
**cp** | Copia arquivo.
**mv** | Move ou renomeia arquivo 


## Alguns dos comandos 📍

### cp 
- Copiar arquivo

```bash
cp origem destino
```

Poderia ser...

```bash
cp documento.txt backup/
```

... Entendendo que copiará o arquivo para um diretório chamado backup

### mv 

- Mover arquivo

```bash
mv origem destino
```

```bash
mv documento.txt backup/
```

- Renomear arquivo 

```bash
mv documento.txt novo_documento.txt
```

Entendendo que o "documento.txt" era o nome anterior do arquivo e "novo_documento.txt" é o nomo nome do arquivo.

## Compilar e executar um código 📖


1) `Escrever o Código Fonte` - Primeiro, você precisa escrever seu código-fonte em um arquivo com extensão .c usando um editor de texto ou uma IDE (Ambiente Integrado de Desenvolvimento). <br> Se usar o gedit, utilizar o comando:
   
```bash
gedit seu_arquivo.c
```

3) `Compilar o Código` -  Você pode usar o compilador GCC (GNU Compiler Collection) para compilar o código. Abra o terminal e navegue até o diretório onde seu arquivo .c está localizado. Use o comando a seguir para compilar o código:

```bash
gcc seu_arquivo.c -o nome_do_programa
```

Isso criará um arquivo executável com o nome especificado em nome_do_programa.

3) `Executar o Programa` - Após a compilação bem-sucedida, você pode executar o programa compilado no terminal:

```bash
./nome_do_programa
```

### Exemplo ☘

1) Código fonte que está no arquivo hello.c
```c
#include <stdio.h>

int main() {
    printf("Hello, world!\n");
    return 0;
}
```

2) Abra o terminal, navegue até o diretório do arquivo hello.c e digite o comando para compilar um código em C.

```bash
gcc hello.c -o hello
```

3) Depois de compilar, executar o programa.

```bash
./hello
```
