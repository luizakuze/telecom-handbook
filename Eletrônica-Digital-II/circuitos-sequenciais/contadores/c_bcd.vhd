library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity c_bcd is
	generic(N_BITS: natural := 6;
			  MAX_VALUE: natural:= 6);
	port(clk, rst: in std_logic;
		  d1, d10, d100: out std_logic_vector(N_BITS-1 downto 0));
end entity;

--versao concorrente - sincrono (MELHOR!)
architecture ifsc_v1 of c_bcd is
	signal reg_d1, reg_d10, reg_d100: unsigned(N_BITS-1 downto 0);
	signal next_d1, next_d10, next_d100: unsigned(N_BITS-1 downto 0);
begin
	process(clk, rst) is
	begin
		if (rst = '1') then
			reg_d1 <= (others=>'0');
			reg_d10 <= (others=>'0');
			reg_d100 <= (others=>'0');
		elsif (rising_edge(clk)) then
			reg_d1 <= next_d1;
			reg_d10 <= next_d10;
			reg_d100 <= next_d100;
		end if;
	end process;
	
	next_d1 <= (others=>'0') when (reg_d1=9) else
				  reg_d1+1;
	next_d10 <= (others=>'0') when (reg_d1=9 and reg_d10=9) else
					reg_d10+1 when (reg_d1=9) else
					reg_d10;
	next_d100 <= (others=>'0') when (reg_d1=9 and reg_d10=9 and reg_d100=9) else
					reg_d100+1 when (reg_d1=9 and reg_d10=9) else
					reg_d100;
					
	d1 <= std_logic_vector(reg_d1);
	d10 <= std_logic_vector(reg_d10);
	d100 <= std_logic_vector(reg_d100);
end architecture;

--versao sequencial - sincrono
architecture ifsc_v2 of c_bcd is
	signal reg_d1, reg_d10, reg_d100: unsigned(N_BITS-1 downto 0);
	signal next_d1, next_d10, next_d100: unsigned(N_BITS-1 downto 0);
begin
	process(clk, rst) is
	begin
		if (rst = '1') then
			reg_d1 <= (others=>'0');
			reg_d10 <= (others=>'0');
			reg_d100 <= (others=>'0');
		elsif (rising_edge(clk)) then
			reg_d1 <= next_d1;
			reg_d10 <= next_d10;
			reg_d100 <= next_d100;
		end if;
	end process;
	
	process(reg_d1, reg_d10, reg_d100) is
	begin
	   next_d10 <= reg_d10;
      next_d100 <= reg_d100;
		if reg_d1/=9 then
         next_d1 <= reg_d1 + 1;
      else -- reach --9
         next_d1 <= (others=>'0');
         if reg_d10/=9 then
            next_d10 <= reg_d10 + 1;
         else -- reach -99
            next_d10 <= (others=>'0');
            if reg_d100/=9 then
               next_d100 <= reg_d100 + 1;
            else -- reach 999
               next_d100 <= (others=>'0');
            end if;
         end if;
      end if;
   end process;
   -- output
   d1 <= std_logic_vector(reg_d1);
   d10 <= std_logic_vector(reg_d10);
   d100 <= std_logic_vector(reg_d100);
end architecture;

-- versao concorrente assincrono
architecture ifsc_v3 of c_bcd is
	signal d1_reg, d10_reg, d100_reg: unsigned(N_BITS-1 downto 0);
	signal d1_next, d10_next, d100_next: unsigned(N_BITS-1 downto 0);
	signal clk_d, clk_u: std_logic := '1'; -- inicia em 1 ....
begin

	process(clk, rst) is
	begin
		if (rst = '1') then
			d1_reg <= (others => '0');
		elsif (rising_edge(clk)) then
			d1_reg <= d1_next;
		end if;
 	end process;
	
	process(clk_d, rst) is
	begin
		if (rst = '1') then
			d10_reg <= (others => '0');
		elsif (rising_edge(clk_d)) then
			d10_reg <= d10_next;
		end if;
 	end process;
	
	process(clk_u, rst) is
	begin
		if (rst = '1') then
			d100_reg <= (others => '0');
		elsif (rising_edge(clk_u)) then
			d100_reg <= d100_next;
		end if;
 	end process;
	
	-- logic
	d1_next <= (others => '0') when (d1_reg = 9) else d1_reg+1;
	clk_d <= '1' when d1_reg=0 else '0';
	d10_next <= (others => '0') when (d10_reg = 9) else d10_reg+1;
	clk_u <= '1' when d10_reg=0 else '0';
	d100_next <= (others => '0') when (d100_reg = 9) else d100_reg+1;
	
   -- output
   d1 <= std_logic_vector(d1_reg);
   d10 <= std_logic_vector(d10_reg);
   d100 <= std_logic_vector(d100_reg);
end architecture;

configuration cfg_bcd of c_bcd is
--	for ifsc_v1 end for;
--	for ifsc_v2 end for;
	for ifsc_v3 end for;
end configuration;