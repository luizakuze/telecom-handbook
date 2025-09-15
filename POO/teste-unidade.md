# Teste de Software

- Existem vários teste: de integração, de interface (...)

## Estratégia de teste: Caixa preta
- Só sabemos entrada e saída, não a implementação.

## Teste de Unidade
- Somente métodos e classes.
- Tem um framework p cada linguagem.
- Sem relação com POO.

- Gradle verifica os testes automaticamento `./gradlew build`.
- Github tem integração com testes.
<br> <br>

### JUnit Framework
- É o framework mais usado p Java.
- (@Test)
- O que testar: Todo método público. Não testar _set_ e _get_

Para cada classe, uma equivalente no teste. <br> A convenção é `NomeCLasseTest`

Primeiro código de teste:
```java
package engtelecom.poo;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.assertEquals;

public class CalculadoraTest {
    
    @Test
    public void testarSomaPositivos(){

        int a = 1;
        int b = 2;
        int resultado = Calculadora.soma(a, b);

        assertEquals(3, resultado, "Não somou corretamente 1 e 2");

    }
    
    @Test
    public void testarSomaNegativos(){

    }
}
```