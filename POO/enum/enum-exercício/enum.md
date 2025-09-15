# Enumerações

- Dias da semana só podem ter essas constantes

```java
package engtelecom.poo;

public enum DiasDaSemana {
    
    DOMINGO,  // "uma instância da enum"
    SEGUNDA, 
    TERCA,
    QUARTA, 
    QUINTA, 
    SEXTA, 
    SABADO

}
```

- Podem ter valores iniciais no enum

```java
package engtelecom.poo;

public enum DiasDaSemana {
    
    DOMINGO(0),  // "uma instância da enum c valor"
    SEGUNDA(1), 
    TERCA(2),
    QUARTA(3), 
    QUINTA(4), 
    SEXTA(5), 
    SABADO(6)

}
```