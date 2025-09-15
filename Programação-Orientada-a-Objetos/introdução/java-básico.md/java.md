# Introdução Java

Código fonte -> bytecode -> JVM

- Bytecode: Còdigo intermediário 
- JVM: Executa o bytecode

`tiobe.com/tiobe-index`

- Usar 'CamelCase' para nomenclatura de classes.
- O nome do arquivo java tem que ser o mesmo da classe.
- métodos = funções


## Compilação e Execução Java
### Compilar 
    javac programa.java
_Gera um .class para executar_

### Executar
    java programa
_Não precisa escrever .class_

### Compilar e Executar
    java programa.java
_Opção alternativa!_

## Pacotes / Package
O pacote é um diretório do projeto. <br> Esses pacotes "empacotam" classes. <br> Uma classe sempre deve estar dentro de um pacote. <br>
A convensão de nomenclatura de um pacote é o domínio da empresa/instituição invertido.

- Por exemplo, temos: poo.engtelecom.sj.ifsc.edu.br
- No pacote: br.edu.ifsc.aj.engtelecom.poo
- **Nas aulas: engtelecom.poo**


_O projeto que criamos durante as aulas fica com uma aparência assim: `src/main/java/engtelecom/poo/Main.java`_
