--testando qual arquitetura de N ffs
library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

entity nFF is 
	generic(N: natural := 3);
	port(clk, rst: in std_logic;
		  d: in std_logic_vector(N-1 downto 0);
		  q: out std_logic_vector(N-1 downto 0));
end entity;

architecture with_process of nFF is
begin

	process(clk, rst) is
	begin
		if (rst = '1') then
			q(0) <= '0';
		elsif (rising_edge(clk)) then
			q(0) <= d(0);
		end if;
	end process;
	
	process(clk, rst) is
	begin
		if (rst = '1') then
			q(1) <= '0';
		elsif (rising_edge(clk)) then
			q(1) <= d(1);
		end if;
	end process;
	
	process(clk, rst) is
	begin
		if (rst = '1') then
			q(2) <= '0';
		elsif (rising_edge(clk)) then
			q(2) <= d(2);
		end if;
	end process;
end architecture;


architecture with_generate of nFF is
begin 

l1:for k in N-1 downto 0 generate 
		process(clk, rst) is
		begin
			if (rst = '1') then
				q(k) <= '0' ;
			elsif (rising_edge(clk)) then
				q(k) <= d(N-1-k);
			end if;
		end process;  
	end generate;
end architecture;

architecture without_generate of nFF is
begin    
		process(clk, rst) is
		begin
			if (rst = '1') then
				q <= (others => '0');
			elsif (rising_edge(clk)) then
				q <= d;
			end if;
		end process;   
end architecture;

configuration cfg_ff_teste of nFF is
--   for with_process end for;
--   for with_generate end for;
	for without_generate end for;
end configuration;