# Abstract

# Classe

- Não é possível criar instâncias diretas de uma classe abstrata.
- A ideia é que ela seja estendida por outras classes que implementam os métodos abstratos.

## Método

- Um método abstrato é aquele de uma classe mãe que pertence a diversas classes filhas, porém a implementação de todas é muito distinta. Então na class emãe o método é vazio e somente as classes filhas tem a implementação.

- Exemplo na própria classe mãe:

```java
    public abstract void desenhar(Draw d);
```

- O método não tem implementação na classe mãe!!!


- Exemplo do método em uma das classes filhas, onde deve contém implementação!

```java
   @Override
    public void desenhar(Draw d) {
        d.picture(this.posicaoX, this.posicaoY, "robo.png");

    }
```

### Exemplo de Aula

`FormaGeometrica <- Retângulo <- Cubo`
- Retângulo precisa implementar desenhar()
- Cubo não precisa obrigatoriamente implementar desenhar(), já que herda o desenhar() de retângulo