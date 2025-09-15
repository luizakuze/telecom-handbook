**anotação sobre como chamar toString**

Para converter um objeto para string:

```java
System.out.println(c.toString());
```

Maneira simplificada:

```java
System.out.println(c);
```

--- 

# Métodos e Atributos Estáticos
São os métodos e atributos que pertencem a classe e não a uma instância específica. Eles são compartilhados e acessados pelo próprio nome da classe.

- Exemplo de método estático

```java
public class Exemplo {
    public static void metodoEstatico() {
        System.out.println("Este é um método estático.");
    }

    public static void main(String[] args) {
        Exemplo.metodoEstatico(); 
    }
}
```

- Exemplo de atributo estático

```java
public class Exemplo {
    public static int contadorDeInstancias = 0;

    public Exemplo() {
        this.contadorDeInstancias++; // Aumenta o contador sempre que uma nova instância é criada
    }

    public static void main(String[] args) {
        // Criando algumas instâncias da classe Exemplo
        Exemplo obj1 = new Exemplo();
        Exemplo obj2 = new Exemplo();
        Exemplo obj3 = new Exemplo();

        System.out.println("Número de instâncias criadas: " + Exemplo.contadorDeInstancias);
    }
}
```

## Onde encontramos o método estático?

_Classe utilitária Math_
- `Math.` é um método estático


