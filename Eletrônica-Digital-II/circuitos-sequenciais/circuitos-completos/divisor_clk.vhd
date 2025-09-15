library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

entity divisor_clk is
	generic(MAX: natural := 10;
			  MIN: natural := 0;
			  UPDOWN: std_logic := '1'); -- 1 incrementa e 0 decrementa
	port(clk, rst: in std_logic;
		  clk_out: out std_logic); -- 1 quando for um numero par
end entity;

architecture ifsc_v1 of divisor_clk is
	signal r_reg: unsigned (MAX downto MIN);
	signal r_next: unsigned (MAX downto MIN);
begin
	process(clk,rst) is
	begin 
		if (rst = '1') then
			r_reg <= (others=>'0');
		elsif (rising_edge(clk)) then
			r_reg <= r_next;
		end if;
	end process;
	
	-- incrementa
L1: if UPDOWN='1' generate
	r_next <= r_reg+1 when (r_reg/=MAX) else
				 r_reg;
	end generate;
	
	-- decrementa
L2: if UPDOWN='0' generate
	r_next <= r_reg-1 when (r_reg /= MIN) else
				 r_reg;
	end generate;
	
	clk_out <= '1' when (r_reg mod 2 = 0) else
				  '0';
end architecture;

configuration cfg_clk of divisor_clk is
	for ifsc_v1 end for;
end configuration;