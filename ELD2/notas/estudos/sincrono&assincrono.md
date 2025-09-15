# Para Preset

## Preset Síncrono:
```vhdl
process (clock, preset)
begin
   if (rising_edge(clock)) then
      if (preset = '1') then
         q <= '1';
      else
         q <= d;
      end if;
   end if;
end process;
```

## Preset Assíncrono:

```vhdl
process (preset, d)
begin
   if (preset = '1') then
      q <= '1';
   else
      q <= d;
   end if;
end process;
```

---

# Para Contadores

## Contador Síncrono
- Utiliza reset síncrono
- Mudança imediata: ``9 > 0``

## Contador Assíncrono
- Ruim!
- Utiliza reset assíncrono
- Mudança não é imediata: ``9 > 10 > 0``. Tempo mínimo em '10'

library ieee;
-- STD_LOGIC and STD_LOGIC_VECTOR types, and relevant functions
use ieee.std_logic_1164.all;

entity conta_0_N is 
	generic(N_bits: natural := 4);
	port(clock, reset: in std_LOGIC; 
	q : out integer range 0 to 15);
	-- q: out std_LOGIC_VECTOR(N_bits-1 downto 0));
end entity;

-- process n pode ter fios, somente variaveis
-- := atribuicao de variavel e <= atribuicao de sinal
architecture ifsc_v1 of conta_0_N is
begin
	process (clock,reset)
		variable count : integer range 0 to 15;
	begin
		if (reset = '1') then
			count := 0;
		elsif (rising_edge(clock)) then
			count := count + 1;
		end if;
		q <= count;
	end process;
end architecture;

configuration cfg_ifsc of conta_0_N is
for ifsc_v1 end for;
end configuration;


Layout -> Reset, resetar interface do modelsim.


Todo circuito síncrono: dar um reset no início
