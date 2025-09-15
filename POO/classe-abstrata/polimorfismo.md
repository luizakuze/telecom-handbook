# Polimorfismo

- Principal conceito em POO;
- Estudamos o polimorfismo do tipo `herança`.

```java
Animal animal = new Cachorro(); // Animal é a classe base, Cachorro é a subclasse
```
## Palavra-Chave instanceof

- Usada para verificar se um objeto é uma instância de uma determinada classe ou interface antes de realizar operações específicas.

- Exemplo:
```java
if (animal instanceof Cachorro) {
    // ...
    Cachorro cachorro = (Cachorro) animal; // cast para Cachorro
}
```