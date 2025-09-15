// Setar e zerar apenas um bit diretamente
// Diferente do código anterior contendo as instruções "in" e "out", estes últimos zeravam completamente o GPIOR0
// Movimentação de leitura e escrita intermediada pelos 32 registradores de uso geral.


sbi 0x04, 5   ; Seta o bit 5 do registrador DDRB (0x04) como 4
cbi 0x04, 5   ; Reseta o bit 5 do registrador DDRB (0x04) como 4
