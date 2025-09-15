// Sintaxe: SBIS/SBIC PORTX, bit

SBIS PINB, PB3  ; Se PB3 estiver em nível alto (1), pula a próxima instrução
RJMP main       ; Caso contrário, executa essa instrução e retorna ao início do loop


SBIC PINB, PB3  ; Se PB3 estiver em nível baixo (0), pula a próxima instrução
RJMP main       ; Caso contrário, executa essa instrução e retorna ao início do loop