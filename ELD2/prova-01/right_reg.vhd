library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity right_reg is 
	generic (N: natural := 4);
	port(clk, rst: in std_logic;
		  d: in std_logic;
		  q: out std_logic);
end entity;

architecture ifsc_v1 of right_reg is
	signal r_reg, r_next: std_logic_vector(N-1 downto 0);
begin
	process(clk, rst)
	begin
		if (rst = '1') then
			r_reg <= (others => '0'); 
		elsif (rising_edge(clk)) then
			r_reg <= r_next;
		end if;
	end process;
	
	r_next <= d & r_reg(N-1 downto 1);
	q <= r_reg(0);
end architecture;