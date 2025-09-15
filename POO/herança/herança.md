# Herança

## Introdução

- Reaproveitar código -> classes;
- Herdar atributos e métodos de uma outra classe;
- Não tem heranã múltipla.

## Nomenclatura

- Classe `filha/subclasse/derivada` - Herda funcionalidades;
- Classe `pai/superclasse/base` - Funcionalidades herdadas.

## Diagrama UML

- Classe filha aponta para classe pai;
- Seta branca.

```java
public class subclasse extends superclasse {

    public subclasse(...) {
        super (.,.,.) // invoca construtor da superclasse
    }

    public void metodoSubClasse() {
        super.metodoSuperClasse(); // invoca método superclasse
    }

}
```

## Protected

- Intermediário entre public e private.

- Abre atributo somente para classes que estejam no mesmo pacote da classe pai, outras classes de fora não tem acesso. 

## Quando usar

- Pergunta: "É um?"
- Diferente de composição, que a pergunta é "é composto por?"

