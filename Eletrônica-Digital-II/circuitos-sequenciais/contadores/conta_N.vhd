-- contador de 0 ate N (MAX_VALUE)
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity conta_N is
	generic(N_BITS: natural := 2;
			  MAX_VALUE: natural := 2);
	port(clk, rst: in std_logic;
		  q_out: out std_logic_vector (N_BITS-1 downto 0));
end entity;

architecture ifsc_v1 of conta_N is
	signal r_reg: unsigned(N_BITS-1 downto 0);
	signal r_next: unsigned(N_BITS-1 downto 0);
begin
	process(clk, rst) is
	begin
		if (rst = '1') then
			r_reg <= (others=>'0');
		elsif (rising_edge(clk)) then
			r_reg <= r_next;
		end if;
	end process;
	
	r_next <= (others=>'0') when (r_reg=MAX_VALUE) else
				 r_reg;
				 
	q_out <= std_logic_vector(r_reg);
	
end architecture;

configuration cfg_N of conta_N is
	for ifsc_v1 end for;
end configuration;