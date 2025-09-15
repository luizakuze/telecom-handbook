# poo

## Construtor
- Deve ter o nome igual ao nome da classe;
- Pode ou não passar parâmetros;

```java
public class Data {
    // atributos
    private int dia;
    private int mes;
    private int ano;

    // método construtor
    public Data(int d, int m, int a) {
        this.dia = d;
        this.mes = m;
        this.ano = a;
    }
}
```

Pode ser feito com qualquer quantidade de atributos. <br> Até mesmo nenhum. O chamado "construtor vazio"

```java

// Construtor padrão
public Pessoa() {
}

// 1 parâmetro (atributo)
public Pessoa(String nome) {
    this.nome = nome;
}

// 2 parâmetros
public Pessoa(String nome, String cpf) {
    this.nome = nome;
    this.cpf = cpf;
}

// 3 parâmetros
public Pessoa(String nome, String dataNascimento, String cpf) {
    this.nome = nome;
    this.dataNascimento = dataNascimento;
    this.cpf = cpf;
}
```

## toString
- Formatar a saída de acordo com a classe

```java
public String toString() {
    return dia + "/" + mes + "/" + ano;
}
```
## this
- Serve para acessar os membros da classe

```java
public Data(int dia) {
    this.dia = dia;
}
```

## Classes

- A classe que tiver o método main é a única que pode ter saída de dados (sout)

## Atalho

`ctrl + mouse em cima método`
Vai direto para o método na sua classe

## Sobrecarga de método

```java
// método com 1 parâmetro 
public Pessoa(String nome) {
    this.nome = nome;
}

// método com 2 parâmetros
public Pessoa(String nome, String cpf) {
    this.nome = nome;
    this.cpf = cpf;
}
```

## Construtor padrão
- Não costumamos inicializar os valores dessa forma
```java
public class Pessoa {
    private String nome = "luiza";
    private String dataNascimento;
    private String cpf;
}
```

- Fazemos o construtor vazio
```java
public class Pessoa {
    private String nome;
    private String dataNascimento;
    private String cpf;

    // Construtor padrão
    public Pessoa() {
        this.nome = "ninguém";
        this.dataNascimento = "31/12/1969";
        this.cpf = "000.000.000-00";
    }
}
```