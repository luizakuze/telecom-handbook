library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity carry_ripple is
	generic (N: natural := 4);
	port (a, b: std_logic_vector(N-1 downto 0);
			cin: in std_logic;
			cout: out std_logic;
			s: out std_logic_vector(N-1 downto 0));
end entity;

-- versao sequencial
-- (Tudo dentro do process)
architecture cr_sequencial of carry_ripple is
begin
	process (a, b, cin) is
		variable c: std_logic;
	begin
		c := cin;
		for i in 0 to N-1 loop
			s(i) <= a(i) xor b(i) xor c;
			c := (a(i) and b(i)) or (a(i) and c) or (b(i) and c);
		end loop;
		cout <= c;
	end process;
end architecture;

-- versao concorrente
architecture cr_concorrente of carry_ripple is
	signal c: std_logic_vector(N downto 0);
begin
	c(0) <= cin;

l1:for i in 0 to N-1 generate
		s(i) <= a(i) xor b(i) xor c(i);
		c(i+1) <= (a(i) and b(i)) or (a(i) and c(i)) or (b(i) and c(i));
	end generate;
	cout <= c(N);
	
end architecture;