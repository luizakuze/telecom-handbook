// Endereçamento de I/O Direto
// Instruções "in" e "out" modificam todo GPIORO
// Muda todos os 32 bits de uso geral.

inc R0    
out 0x1E, R0  ; Escreve no GPIOR0 (0x1E) o R0
in R1, 0x1E   ; Lê do GPIOR0 (0x1E) para o R1
