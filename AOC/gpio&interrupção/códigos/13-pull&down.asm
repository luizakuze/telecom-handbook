Pull-up:
Quando o botão não está pressionado: O pino é puxado para 1 (alto), ou seja, o pino está em Vcc.
Quando o botão é pressionado: O pino é puxado para 0 (baixo), ou seja, o pino é conectado ao GND.
Uso comum: Em circuitos onde o botão é "normalmente aberto" (botão sem pressionar), o pino é 1 (alto) quando o botão não está pressionado, e vai para 0 (baixo) quando o botão é pressionado.

PULL UP ATIVADO:  Botão não foi pressionado, porque o pino está em 1 (alto).
PULL UP DESATIVADO:  Botão foi pressionado, porque o pino está em 0 (baixo).

Pull-down:
Quando o botão não está pressionado: O pino é puxado para 0 (baixo), ou seja, o pino está em GND.
Quando o botão é pressionado: O pino é puxado para 1 (alto), ou seja, o pino é conectado ao Vcc.
Uso comum: Em circuitos onde o botão é "normalmente fechado" (botão sem pressionar), o pino é 0 (baixo) quando o botão não está pressionado, e vai para 1 (alto) quando o botão é pressionado.

PULL DOWN ATIVADO:  Botão foi pressionado, porque o pino está em 0 (baixo).
PULL DOWN DESATIVADO:  Botão não foi pressionado, porque o pino está em 1 (alto)


----------------------

Com pull-up:
Botão não pressionado (pino PD7 em 1) → O LED está apagado.
Botão pressionado (pino PD7 em 0) → O LED está aceso.

Com pull-down:
Botão não pressionado (pino PD7 em 0) → O LED está aceso.
Botão pressionado (pino PD7 em 1) → O LED está apagado.



----------------------


.INCLUDE <m328Pdef.inc>

setup:
sbi DDRD, PD2 ;configura o pino PD2 como sa´ıda

cbi DDRD, PD7 ;configura o pino PD7 como entrada
sbi PORTD, PD7 ;habilita o pull-up para o bot~ao
//Quando o botão não está pressionado, o pino PD7 está em 1, e o LED fica apagado.
//Quando o botão está pressionado, o pino PD7 vai para 0, e o LED acende.


;----------------------
;LA¸CO PRINCIPAL
;----------------------
naoPress: ;loop bot~ao n~ao pressionado (pull-up)
    sbi PORTD,PD2 ;desliga LED
    sbic PIND,PD7 ;verifica se o bot~ao foi pressionado,
    rjmp naoPress ;sen~ao volta e fica preso no la¸co naoPress

press: ;loop bot~ao pressionado
    cbi PORTD,PD2 ;liga LED
    sbis PIND,PD7 ;verifica se o bot~ao foi solto, sen~ao
    rjmp press ;sen~ao, aguarda.

    rjmp naoPress ;vai para o loop do "bot~ao pressionado"