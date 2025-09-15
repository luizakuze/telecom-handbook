library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;


entity carry_ripple_adder is
	generic (N : natural := 3);
	port (
		a, b : std_logic_vector (N-1 downto 0);
		cin  : std_logic;
		s    : out std_logic_vector (N-1 downto 0);
		cout : out std_logic
	);
end entity;

-- versao concorrente
architecture ifsc_v1 of carry_ripple_adder is
	signal c: std_logic_vector (N downto 0);
begin
	c(0) <= cin;
	l1: for i in 0 to N-1 generate
			s(i) <= a(i) xor b(i) xor c(i);
			c(i+1) <= (a(i) and b(i)) or (a(i) and c(i)) or (b(i) and c(i));
		end generate;
	cout <= c(N);
end architecture;

-- versao sequencial
architecture ifsc_v2 of carry_ripple_adder is
begin
	process(a, b, cin) is
		variable c : std_logic;
	begin
		c := cin;
		-- carry loop
		for i in 0 to N-1 loop
			s(i) <= a(i) xor b(i) xor c;
			c := (a(i) and b(i)) or (a(i) and c) or (b(i) and c);
		end loop;
		cout <= c;
	end process;
end architecture;

configuration cfg_name of carry_ripple_adder is
	for ifsc_v1	end for;
--	for ifsc_v2 end for;
end cfg_name; 
