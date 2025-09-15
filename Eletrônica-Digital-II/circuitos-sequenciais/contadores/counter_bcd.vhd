library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter_bcd is 
	generic (N: natural := 4);
	port (clk, rst: std_logic;
			d1, d10, d100: out std_logic_vector(N-1 downto 0));
end entity;

-- versao concorrente e sincrona
architecture sincrono_bcd of counter_bcd is
	signal d1_reg, d10_reg, d100_reg: unsigned (N-1 downto 0);
	signal d1_next, d10_next, d100_next: unsigned (N-1 downto 0);
begin
	process (clk, rst) is
	begin
		if (rst = '1') then
			d1_reg <= (others => '0');
			d10_reg <= (others => '0');
			d100_reg <= (others => '0');
		elsif (rising_edge(clk)) then
			d1_reg <= d1_next;
			d10_reg <= d10_next;
			d100_reg <= d100_next;
		end if;
	end process;
	
	d1_next <= (others=>'0') when d1_reg=9 else d1_reg+1;
	d10_next <= (others=>'0') when (d1_reg and d10_reg=9) else
					d10_reg+1 when (d1_reg=9) else
					d10_reg;
	d1_next <= (others=>'0') when (d1_reg and d10_reg=9 and d100_reg=9) else
					d100_reg+1 when (d1_reg=9 and d10_reg=9) else
					d100_reg;
	
	d1 <= std_logic_vector(d1_reg);
	d10 <= std_logic_vector(d10_reg);
	d100 <= std_logic_vector(d100_reg);
end architecture;

-- versao concorrente e assincrona
architecture sincrono_bcd of counter_bcd is
	signal d1_reg, d10_reg, d100_reg: unsigned (N-1 downto 0);
	signal d1_next, d10_next, d100_next: unsigned (N-1 downto 0);
	signal clk_d, dlk_u: std_logic := 1; -- inicia em 1 (reset)
begin
	process (clk, rst) is
	begin
		if (rst = '1') then
			d1_reg <= (others => '0'); 
		elsif (rising_edge(clk)) then
			d1_reg <= d1_next; 
		end if;
	end process;
	process (clk_d, rst) is
	begin
		if (rst = '1') then 
			d10_reg <= (others => '0'); 
		elsif (rising_edge(clk_d)) then 
			d10_reg <= d10_next; 
		end if;
	end process;
	
	process (clk_u, rst) is
	begin
		if (rst = '1') then 
			d100_reg <= (others => '0');
		elsif (rising_edge(clk_u)) then 
			d100_reg <= d100_next;
		end if;
	end process;
	
	clk_d <= '1' when d1_reg=9 else 0;
	clk_u <= '1' when d10_reg=9 else 0;
	
	d1_next <= (others=>'0') when d1_reg=9 else d1_reg+1;
	d10_next <= (others=>'0') when (d10_reg=9) else d10_reg+1;
	d100_next <= (others=>'0') when (d100_reg=9) else d100_reg+1;
	
	d1 <= std_logic_vector(d1_reg);
	d10 <= std_logic_vector(d10_reg);
	d100 <= std_logic_vector(d100_reg);
end architecture;