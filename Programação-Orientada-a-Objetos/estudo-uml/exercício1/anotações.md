# Anotações

- 'Objeto parte' conntinua existindo mesmo que não exista mais o 'objeto principal'.
- No nosso projeto atual, o objt principal foi o carro e o objt parte foi o motor. Ao vender um carro, ainda era possível pegar seu motor na garagem.


## O que é que cada classe faz
- Uma classe tem que estar bem definida quanto as suas atribuições. Por exemplo: existe uma classe carro, um carro pode andar se usar o acelerador. Não queremos saber como funciona o motor do carro, só o "botão" de acelerar

- Nesse sentido, houve um momento em que estava assim nosso App:

```java
public void comprarCarro(Jogador j) {

    //verificar se tem espaço na garagem
    if (j.totalDeCarrosNaGaragem() < TOTAL_CARROS) {

        Carro c = new Carro("fusca", new Motor(300, 4));

        Carro antigo = j.getCarroAtual();
        j.adicionarCarro(antigo);
        j.setCarroAtual(c);
        System.out.println("Carro comprado com sucesso!");
    } else {
        System.out.println("Garagem cheia");
    }
}
```

- Então, no próprio App (a nossa garagem de carros do exercício) tinha uma confusão ao usar esse método em App, sendo que adicionarCarro é uma funcionalidade que deve ser do jogador.
- O **refatoramento do método** ficou da seguinte forma:

```java
// em App
public void comprarCarro(Jogador j) {
    if (j.comprarCarro(new Carro("fusca", new Motor(300, 4)))) {
        System.out.println("Motor comprado com sucesso!");
    } else {
        System.out.println("Estante cheia");
    }
}
```

```java
// em Jogador
public boolean comprarCarro(Carro c) {
    if (this.totalDeCarrosNaGaragem() < App.TOTAL_CARROS) {

        Carro antigo = carroAtual;

        this.adicionarCarro(antigo);
        this.setCarroAtual(c);
        
        return true;
    } 
    return false;
}
```

## Revisando 'static' e 'final'

### final
- Constante.
- Valor não pode ser alterado no programa.

```java
public class Exemplo {
    public static final double PI = 3.14;  // Constante (variável final)
    
    public final void metodoFinal() {
        // Conteúdo do método
    }
}
```

### static
- Atributo pertencente a classe toda
- Não é um atributo de instâncias individuais.

```java
public class Exemplo {
    public static int contador = 0;  // Variável estática
    
    public Exemplo() {
        contador++;
    }
}

// Uso da variável estática
Exemplo.contador++;
```

## App app = new App()
- Imaginar usando o exemplo de um jogo de tabuleiro.
- Poderia se chamar `Tabuleiro.java`, para ficar mais claro a necessidade de instanciar app. 
- No tabuleiro podemos ter as peças de xadrez, por exemplo.
- Tudo meio que gira entorno desse tabuleiro, então esta é minha classe principal.

## App
- Interação com usuário!
- Jogo agora está em modo texto, se quiser mudar p gráfico só altera App

## Agregação
- Objeto parte existe mesmo que o objeto parte não exista mais.
- Se não colcoar o losango, é agregação.

## Composição
- Objeto parte não existe se objeto todo não existir na memória.

## Debug 
`Motor@60`
- Motor - Nome da classe 
- 60 - Qual a instância (para onde está apontando da memória)

## Dependência
- Exemplo um jogador rolar dados para jogar
- É uma dependência! Não é um atributo, precisa de um método dela ali e não atribuições.

