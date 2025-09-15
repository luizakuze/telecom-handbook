waitUM:
    sbis 0x09,7 ; Salta a pr´oxima instru¸c~ao se o bit 7 do registrado PIND (0x09) ´e UM.
    rjmp waitUM ; Bit 7 do PIND n~ao setado. Salta para wait.
waitZERO:
    sbic 0x09,7 ; Salta a pr´oxima instru¸c~ao se o mesmo bit ´e ZERO.
    rjmp waitZERO ; Sen~ao, aguarda.
    nop ; Continua o programa (instru¸c~ao "n~ao faz nada")