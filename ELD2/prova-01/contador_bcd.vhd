library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity contador_bcd is 
	generic (N: natural := 4);
	port(clk, rst, en: in std_logic;
		  unidade, dezena: out std_logic_vector(N-1 downto 0);
		  fim_contagem: out std_logic);
end entity;


architecture ifsc_v1 of contador_bcd is
	signal u_reg, d_reg: integer range 0 to 9;
	signal u_next, d_next: integer range 0 to 9; 
begin

	process(clk, rst)
	begin
		if (rst = '1') then
			u_reg <= 7;
			d_reg <= 2;
		elsif (rising_edge(clk)) then
			if (en = '1') then
				u_reg <= u_next;
				d_reg <= d_next;
			end if;
		end if;
	end process;
	
	u_next <= u_reg-1 when (u_reg/=0) else
				 9 when (d_reg/=0) else
				 u_reg;
	d_next <= d_reg-1 when (d_reg/=0 and u_reg=0) else
				 d_reg;
 
	fim_contagem <= '1' when (u_reg=0 and d_reg=0) else '0';
	unidade <= std_logic_vector(to_unsigned(u_reg, N));
	dezena <= std_logic_vector(to_unsigned(d_reg, N));
end architecture;





