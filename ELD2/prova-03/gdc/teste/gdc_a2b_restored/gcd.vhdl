library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity gcd is
	generic(
		N: natural:= 8);
   port(
      clk, reset: in std_logic;
      start: in std_logic;
      a_in, b_in, c_in: in std_logic_vector(N-1 downto 0);
      ready: out std_logic;
      r: out std_logic_vector(N-1 downto 0)
   );
end entity;

--algoritmo E  
architecture euclidean_algorithm of gcd is
   type state_type is (idle, E1, E2);
   signal state_reg, state_next: state_type;
   signal a_reg, a_next, c_reg, c_next, r_reg, r_next: unsigned(N-1 downto 0); 
begin
   -- state & data registers
   process(clk,reset)
   begin
      if reset='1' then
         state_reg <= idle;
         a_reg <= (others=>'0');
         c_reg <= (others=>'0');
         r_reg <= (others=>'0');
      elsif (rising_edge(clk)) then
			state_reg <= state_next;
			a_reg <= a_next;
         c_reg <= c_next;
         r_reg <= r_next; 
      end if;
   end process;
   -- next-state logic & data path functional units/routing
   process(state_reg,a_reg,c_reg,start,a_in,c_in)
   begin
      a_next <= a_reg;
      c_next <= c_reg;
      r_next <= r_reg;
      case state_reg is
         when idle =>
            if start='1' then
               a_next <= unsigned(a_in);
               c_next <= unsigned(c_in);
               state_next <= E1;
            else
               state_next <= idle;
            end if;
         when E1 =>
            if (a_reg mod c_reg = 0) then
					r_next <= c_reg; -- MDC = C
               state_next <= idle; 
            else 
               state_next <= E2;
            end if;
         when E2 =>
            if (a_reg mod c_reg = 1) then  
					r_next <= to_unsigned(1,N); -- MDC = 1 
               state_next <= idle;  
				else   
					a_next <= c_reg;
					c_next <= a_reg mod c_reg; 
					state_next <= E1;
				end if; 
			end case; 
   end process;
	 
	
	-- output logic
	ready <= '1' when state_reg=idle else '0'; 
	r <= std_logic_vector(r_reg); 
end architecture;




architecture slow_arch of gcd is
   type state_type is (idle, swap, sub);
   signal state_reg, state_next: state_type;
   signal a_reg, a_next, b_reg, b_next: unsigned(7 downto 0);
begin
   -- state & data registers
   process(clk,reset)
   begin
      if reset='1' then
         state_reg <= idle;
         a_reg <= (others=>'0');
         b_reg <= (others=>'0');
      elsif (clk'event and clk='1') then
         state_reg <= state_next;
         a_reg <= a_next;
         b_reg <= b_next;
      end if;
   end process;
   -- next-state logic & data path functional units/routing
   process(state_reg,a_reg,b_reg,start,a_in,b_in)
   begin
      a_next <= a_reg;
      b_next <= b_reg;
      case state_reg is
         when idle =>
            if start='1' then
               a_next <= unsigned(a_in);
               b_next <= unsigned(b_in);
               state_next <= swap;
            else
               state_next <= idle;
            end if;
         when swap =>
            if (a_reg=b_reg) then
               state_next <= idle;
            else
               if (a_reg < b_reg) then
                  a_next <= b_reg;
                  b_next <= a_reg;
               end if;
               state_next <= sub;
            end if;
         when sub =>
            a_next <= a_reg - b_reg;
            state_next <= swap;
         end case;
   end process;
   -- output
   ready <= '1' when state_reg=idle else '0';
   r <= std_logic_vector(a_reg);
end slow_arch;


--=============================
-- Listing 12.7
--=============================
architecture fast_arch of gcd is
   type state_type is (idle, swap, sub, res);
   signal state_reg, state_next: state_type;
   signal a_reg, a_next, b_reg, b_next: unsigned(7 downto 0);
   signal n_reg, n_next: unsigned(2 downto 0);
begin
   -- state & data registers
   process(clk,reset)
   begin
      if reset='1' then
         state_reg <= idle;
         a_reg <= (others=>'0');
         b_reg <= (others=>'0');
         n_reg <= (others=>'0');
      elsif (clk'event and clk='1') then
         state_reg <= state_next;
         a_reg <= a_next;
         b_reg <= b_next;
         n_reg   <= n_next;
      end if;
   end process;
   -- next-state logic & data path functional units/routing
   process(state_reg,a_reg,b_reg,n_reg,start,a_in,b_in,n_next)
   begin
      a_next <= a_reg;
      b_next <= b_reg;
      n_next <= n_reg;
      case state_reg is
         when idle =>
            if start='1' then
               a_next <= unsigned(a_in);
               b_next <= unsigned(b_in);
               n_next <= (others=>'0');
               state_next <= swap;
            else
               state_next <= idle;
            end if;
         when swap =>
            if (a_reg=b_reg) then
               if (n_reg=0) then
                  state_next <= idle;
               else
                  state_next <= res;
               end if;
            else
               if (a_reg(0)='0') then -- a_reg even
                  a_next <= '0' & a_reg(7 downto 1);
                  if (b_reg(0)='0') then  -- both even
                     b_next <= '0' & b_reg(7 downto 1);
                     n_next <= n_reg + 1;
                  end if;
                  state_next <= swap;
               else -- a_reg odd
                  if (b_reg(0)='0') then  -- b_reg even
                     b_next <= '0' & b_reg(7 downto 1);
                     state_next <= swap;
                  else -- both a_reg and b_reg odd
                     if (a_reg < b_reg) then
                        a_next <= b_reg;
                        b_next <= a_reg;
                     end if;
                     state_next <= sub;
                  end if;
               end if;
            end if;
         when sub =>
            a_next <= a_reg - b_reg;
            state_next <= swap;
         when res =>
            a_next <= a_reg(6 downto 0) & '0';
            n_next <= n_reg - 1;
            if (n_next=0) then
               state_next <= idle;
            else
               state_next <= res;
            end if;
      end case;
   end process;
   --output
   ready <= '1' when state_reg=idle else '0';
   r <= std_logic_vector(a_reg);
end fast_arch;


configuration ifsc of gcd is
	for euclidean_algorithm end for;
	--for slow_arch end for;
	-- for fast_arch end for; 
end configuration;