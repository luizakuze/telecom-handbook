## Comandos Sequenciais:
### Processos Sequenciais:

No VHDL, os processos definidos usando a estrutura process são sequenciais por natureza. Eles são sensíveis a mudanças em sinais específicos e executam suas instruções de forma sequencial.
Exemplo:

```vhdl
process (clock, reset)
begin
    if (reset = '1') then
        q <= '0';
    elsif (rising_edge(clock)) then
        q <= d;
    end if;
end process;
```

### Instruções dentro do Processo:

Dentro de um processo, as instruções são executadas em ordem sequencial, uma após a outra.
Exemplo:

```vhdl
if (reset = '1') then
    q <= '0';
elsif (rising_edge(clock)) then
    q <= d;
end if;
```

## Comandos Concorrentes:
### Blocos Generate:

Os blocos generate permitem criar instâncias de código com base em loops ou condições. Dentro desses blocos, múltiplos processos podem ser gerados e executados concorrentemente.
Exemplo:

```vhdl
architecture ifsc_v5 of ff_D is
begin
    L1: 
        for k in N - 1 downto 0 generate
            process (clock, reset)
            begin
                if (reset = '1') then
                    q(k) <= '0';
                elsif (rising_edge(clock)) then    
                    q(k) <= d(k);      
                end if;
            end process;
        end generate;
end architecture;
```
Neste código, o bloco generate for está sendo usado para criar múltiplos processos concorrentes para cada bit do vetor q. Cada processo gerado opera de forma independente dos outros, mas todos compartilham os sinais de controle clock e reset.
