-- FLIP FLOPS

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ff_d is
	generic (N: natural := 8);
	port (clk, rst, set, ena: in std_logic;
			d: in std_logic;
			d2: std_logic_vector(N-1 downto 0);
			q: out std_logic; 
			q2: out std_logic_vector(N-1 downto 0)); 
end entity;

-- reset assincrono e sensivel a borda de subida
architecture ff_v1 of ff_d is
begin	
	process(clk, rst)
	begin
		if (rst = '1') then
			q <= '0';
		elsif (rising_edge(clk)) then
			q <= d;
		end if;
	end process;
end architecture;

-- preset (set) assincrono, sensivel a borda de descida e sinal de enable (ena) sincrono
architecture ff_v2 of ff_d is
begin	
	process(clk, rst)
	begin
		if (set = '1') then
			q <= '1';
		elsif (falling_edge(clk)) then
			if (ena = '1') then
				q <= d;
			end if;
		end if;
	end process;
end architecture;

-- gerando N flip flops 
architecture ff_v3 of ff_d is
begin	
l1: 
	for k in N-1 downto 0 generate  
		process(clk, rst)
		begin
			if (rst = '1') then
				q2(k) <= '0';
			elsif (rising_edge(clk)) then
				q2(k) <= d2(N-1-k); -- k...?
			end if; 
		end process;
	end generate; 
end architecture;

-- gerando N flip flops - MEU TESTE
architecture ff_v4 of ff_d is
begin	
l1: 
	for k in N-1 downto 0 generate  
		process(clk, rst)
		begin
			if (rst = '1') then
				q2(k) <= '0';
			elsif (rising_edge(clk)) then
				q2(k) <= d2(k); -- ?????????
			end if; 
		end process;
	end generate; 
end architecture;

--configuration ff_cfg of ff_d is
--	for ff_v1 end for;
--	for ff_v2 end for;
--	for ff_v3 end for;
--end configuration;