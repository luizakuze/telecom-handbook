# Anotações

## ArrayList

- Acesso em qualquer local da estrutura.
- Usar no lugar do vetor
- Guarda classes, não tipos primitivos. 

| Primitivo | Classe |
|---|---|
| int | Integer|
| double | Double


```java
ArrayList<String> lista = new ArrayList<>();

lista.sort(Comparator.naturalOrder()); //ordem alfabetica

lista.removeIf(elemento−>elemento.equals("IFSC")); //remove se tiver

lista.clear(); //limpa a lista
```

## Set
Elementos duplicados.

## Queue
Acesso direto ao dado final.

## UML 

Construtor aparece, já getters, setters e toString não.

## GB - Java

`Malloc` -> free"
"new -> delete"

O java não precisa nem do free e nem do delete.

## COncatenação em java
"a" + "b" <br>
"ab" <br>

A cada + é um "new"! sb.append pode ser mais atrativo em alguns casos (StringBuilder).

## Inferência de tipo de variável local (java 10)
O `auto` do C++ é o `var` no Java.

```java
for (var s: colecao) {
    sout(s);
}
```