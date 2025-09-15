library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity contador_gray is
	generic(N: natural := 4);
	port(clk, rst: in std_logic;
		  q: out std_logic_vector(N-1 downto 0));
end entity;

architecture ifsc_v1 of contador_gray is
	signal g_reg: unsigned(N-1 downto 0);
	signal g_next: unsigned(N-1 downto 0);
	signal binary: unsigned(N-1 downto 0);
	signal binary_increment: unsigned(N-1 downto 0);
begin
	process (clk, rst) is
	begin
		if (rst = '1') then
			g_reg <= (others=>'0');
		elsif (rising_edge(clk)) then
			g_reg <= g_next;
		end if;
	end process;
	
	-- converte GRAY -> BINARIO
	binary <= g_reg xor ('0' & binary(N-1 downto 1));
	
	-- incrementa em binario 
	binary_increment <= binary + 1;
	
	-- converte BINARIO -> GRAY
	g_next <= binary_increment xor ('0' & binary_increment(N-1 downto 1));
	
   q <= std_logic_vector(g_reg);
end architecture;

configuration cfg_gray of contador_gray is
	for ifsc_v1 end for;
end configuration;