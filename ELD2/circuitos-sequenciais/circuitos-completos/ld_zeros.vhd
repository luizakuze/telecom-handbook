-- VERSAO SEQUENCIAL SOMENTE
library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

entity ld_zeros is 
	generic(N: natural := 4);
	port(data: in std_logic_vector(N-1 downto 0);
		  qt_zeros: out unsigned(N-1 downto 0));
end entity;

--versao 1 sequencial - total de zeros
architecture ifsc_v1 of ld_zeros is
begin
	process (data)
		variable N_ZEROS : integer range 0 to N;
	begin
	N_ZEROS := 0;
	for i in data'range loop
			if (data(i) = '1') then
				N_ZEROS := N_ZEROS + 1;
			end if;
		end loop;
	qt_zeros <= (to_unsigned(N_ZEROS,N));
	end process;
end architecture;

--versao 2 sequencial - total de zeros
architecture ifsc_v2 of ld_zeros is
begin
	process (data)
		variable N_ZEROS : integer range 0 to N;
	begin
	N_ZEROS := 0;
	for i in data'range loop
		case data(i) is
			when '0' => N_ZEROS := N_ZEROS + 1;
			when others => next;
		end case;
	end loop;
	qt_zeros <= (to_unsigned(N_ZEROS,N));
	end process;
end architecture;

--versao 3 sequencial - zeros antes do primeiro um
architecture ifsc_v3 of ld_zeros is
begin
	process (data)
		variable N_ZEROS : integer range 0 to N;
	begin
	N_ZEROS := 0;
	for i in data'range loop
			case data(i) is
				when '0' => N_ZEROS := N_ZEROS + 1;
				when others => exit;
			end case;
		end loop;
	qt_zeros <= (to_unsigned(N_ZEROS,N));
	end process;
end architecture;

-- versao 4 - zeros apos o primeiro 1
architecture ifsc_v4 of ld_zeros is
begin
	process (data)
		variable N_ZEROS : integer range 0 to N;
	begin
	N_ZEROS := 0;
	for i in 0 to N-1 loop
			case data(i) is
				when '0' => N_ZEROS := N_ZEROS + 1;
				when others => exit;
			end case;
		end loop;
	qt_zeros <= (to_unsigned(N_ZEROS,N));
	end process;
end architecture;

configuration cfg_zeros of ld_zeros is
--	for ifsc_v1 end for;
--	for ifsc_v2 end for;
--	for ifsc_v3 end for;
	for ifsc_v4 end for;
end configuration;