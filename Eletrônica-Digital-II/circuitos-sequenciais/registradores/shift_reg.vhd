-- universal shift register (wt control left/right)


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity shift_reg is
	generic (N_BITS: natural := 4;
				CTRL: natural := 1);
	port (clk, rst: in std_logic;
			ctrl2: in std_logic; -- 1 shift right and 0 shift left 
			--ctrl: in natural;
			d: in std_logic_vector(N_BITS-1 downto 0);
			q: out std_logic_vector(N_BITS-1 downto 0));
end entity;

-- ctrl GENERIC
architecture reg_v1 of shift_reg is
	signal r_reg: std_logic_vector(N_BITS-1 downto 0);
	signal r_next: std_logic_vector(N_BITS-1 downto 0);
begin
	process(clk, rst) is
	begin	
		if (rst = '1') then
			r_reg <= (others => '0');
		elsif (rising_edge(clk)) then
			r_reg <= r_next;
		end if;
	end process;
	
	
	--v1 logic (generate)
l1: 
	if ctrl=1 generate
		r_next <= d(N_BITS-1) & r_reg(N_BITS-1 downto 1);
	end generate;
	
l2: 
	if ctrl=0 generate
		r_next <= r_reg(N_BITS-2 downto 0) & d(0);
	end generate;
	
	q <= r_reg;
end architecture;

-- ctrl INPUT std_logic_vector
architecture reg_v2 of shift_reg is
	signal r_reg: std_logic_vector(N_BITS-1 downto 0);
	signal r_next: std_logic_vector(N_BITS-1 downto 0);
begin
	process(clk, rst) is
	begin	
		if (rst = '1') then
			r_reg <= (others => '0');
		elsif (rising_edge(clk)) then
			r_reg <= r_next;
		end if;
	end process;
	
	
	--v2 logic (with-select)
	with ctrl2 select
	r_next <= d(N_BITS-1) & r_reg(N_BITS-1 downto 1) when '1', --right
				 r_reg(N_BITS-2 downto 0) & d(0) when others; --left

	
	q <= r_reg;
end architecture;

configuration reg_cfg of shift_reg is
--	for reg_v1 end for;
	for reg_v2 end for;
end configuration;