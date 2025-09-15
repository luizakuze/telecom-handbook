# Programação Orientada a Objetos

# Parte 1

_LEMBRETE: Comparar strings usando o equals `str1.equals(str2);`_

## Paradigmas

Um paradigma é uma abordagem/estilo de escrever um código de programação.

- **Paradigma sequencial** - Usar uma sequência (goto, jump..)
- **Paradigma procedural/estruturada** - Sequências e repetições.
- **Paradigma poo** -  Cada objeto tem uma tarefa específica e esses objetos trocam mensagens entre si.

## Objetos
- **Identificável** - 
- **Estado** - Características - `atributo`
- **Comportamento** - Função - `método`

Criando um objeto Caneta
```java
public class Caneta {

    // Atributos ..

    // Métodos ....
}
```

Como trazer o objeto para o main? 
"Quero criar uma caneta" 
```java
Caneta c = new Caneta();
```

Inicialmente...<br>
Classes - PUBLIC <br>
Atributos - PRIVATE <br>

## Atributos
- São as características do objeto.
- Podemos ver no código os atributos como variáveis privadas dentro de um objeto.
- Sendo privadas, não são acessíveis de fora da classe. É preciso do método `getter` e `setter` para acessar e alterar o seu valor.


Então... dada uma classe Pessoa que tem o atributo "nome"
```java
public class Pessoa {
    private String nome;
    ///(...)
}
```

### Getter 
Poderiamos usar o getter para **acessar** o atributo.
```java
public String getNome() {
    return nome;
}
```
### Setter
Além disso, utilizar o setter para **modificar** o atributo.
```java
public void setNome(String novoNome) {
    nome = novoNome;
}
```

## Métodos
Quando é preciso que esse objeto realize alguma função, é preciso criar um método para isso. 

No exemplo abaixo, foi criado um método para uma classe Calculadora. Uma calculadora tem funções como somar, subtrair, multiplicar e dividir. Assim, criamos um método para somar.
```java
public class Calculadora {
    public int somar(int a, int b) {
        return a + b;
    }
}
```

---

# Parte 2

Não criando objeto
```java
Caneta c; // null
```

Criando objeto 
```java
Caneta c = new CAneta():
```

Em, se uma variável inteira não é inicializada, ela começã com o valor 0
```java
int i; // guarda 0
```

Criando uma classe caneta que todas as canetas vão ser azuiz e com nível 100
```java
public class Caneta {
    
    // Atributos
    private String cor = "azul";
    private double nivelTinta = 100;
```



_Para criar o getter e o setter automáticos no vscode, utilizar o `Source Action`_

## Encapsulamento
Deixar dentro do método somente a lógica.
Quem usar o metodo não precisa saber como funciona!

## uml
Uma maneira simplificada de mostrar o código (antes de codificar).
