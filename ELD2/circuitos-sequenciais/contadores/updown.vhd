--updown: 1 incrementa e 0 decrementa

library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

entity updown is 
	generic (N: natural := 4;
				MAX: natural := 3;
				MIN: natural := 0;
				UPDOWN: natural := 1);
	port(clk, rst: in std_logic;
		  q_logic: out std_logic_vector (N-1 downto 0);
		  q_integer: out integer range MIN to MAX);
end entity;

-- versao concorrente
architecture updown_v1 of updown is
	signal r_reg: unsigned (N-1 downto 0);
	signal r_next: unsigned (N-1 downto 0);
begin
	process(clk, rst) is
	begin
		if (rst = '1') then
			r_reg <= (others => '0');
		elsif (rising_edge(clk)) then
			r_reg <= r_next;
		end if;
	end process;
	
l1: 
	if UPDOWN=1 generate
		r_next <= (r_reg+1) when (r_reg/=MAX) else r_reg;
	end generate;
	
l2: 
	if UPDOWN=0 generate
		r_next <= (r_reg-1) when (r_reg/=MIN) else r_reg;
	end generate;
		
	q_logic <= std_logic_vector(r_reg);
	q_integer <= to_integer(r_reg);
	
	
end architecture;


--versao sequencial 
architecture updown_v2 of updown is
	signal r_reg: unsigned (N-1 downto 0);
	signal r_next: unsigned (N-1 downto 0);
begin
	process(clk, rst) is
	begin
		if (rst = '1') then
			r_reg <= (others => '0');
		elsif (rising_edge(clk)) then
			if (UPDOWN=1) then
				if (r_reg/=MAX) then
					r_next <= r_reg + 1;
				end if;
			elsif (UPDOWN=0) then 
				if (r_reg/=MIN) then
					r_next <= r_reg - 1;
				end if;
			end if;
			r_reg <= r_next;
		end if;
	end process;


	q_logic <= std_logic_vector(r_reg);
	q_integer <= to_integer(r_reg);
		
end architecture;