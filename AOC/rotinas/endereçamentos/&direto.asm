# LDS e STS - Endereçamentos Direto  
# Guarda um valor constante em um registrador  
## Sintaxe: "lds Rd, k"; Rd <- (k)
## Sintaxe: "sts k, Rr"; (k) <- Rr

lds R0, 0x0100 ; guarda no R0 o que tem no endereço 0x0100
sts 0x0101, R0 ; guarda na SRAM em 0x0101 o que tem em R0