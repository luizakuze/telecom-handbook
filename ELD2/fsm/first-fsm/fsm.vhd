LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
----------------------------------------------------------
ENTITY fsm IS
PORT (
	clk, rst : IN STD_LOGIC;
	x : IN integer range 0 to 2;
	y : OUT bit);
END entity;
----------------------------------------------------------
ARCHITECTURE ifsc_v1 OF fsm IS
	TYPE state IS (A, B, C);
	SIGNAL pr_state, nx_state : state;
	-- ATTRIBUTE ENUM_ENCODING : STRING; --optional attribute
	-- ATTRIBUTE ENUM_ENCODING OF state : TYPE IS "sequential";
	-- ATTRIBUTE SYN_ENCODING OF state : TYPE IS "safe";
BEGIN
	------Logica Sequencial da FSM:------------
	PROCESS (clk, rst)
	BEGIN
		IF (rst = '1') THEN
			pr_state <= A;
		ELSIF rising_edge(clk) THEN
			-- apenas na borda do "clk" ocorre a mudança de estado da FSM
			pr_state <= nx_state;
		END IF;
	END PROCESS;
	------Logica Combinacional da FSM:------------
	PROCESS (pr_state, x)
	BEGIN
		------Valores default das saidas------------
            y <= '0' ;
		CASE pr_state IS
			WHEN A =>
				-- é necessário um  WHEN para definir as "saidas" durante cada estado 
				-- e analisar as "entradas" para definir o próximo estado
				y <= '0';   -- apenas se diferente do valor default
				IF (x = 0 or x = 1) THEN
					nx_state <= A;
				ELSE
					nx_state <= B;
				END IF;
			WHEN B =>
				y <= '0' ; -- apenas se diferente do valor default
				-- dependendo das "entradas", pode ser que hajam mais de um estados de destino
				IF (x = 0) THEN
					nx_state <= C;
				ELSIF (x = 1) THEN
					nx_state <= A;
				ELSE
					nx_state <= B;
				END IF;
			WHEN C =>
				y <= '1' ; -- apenas se diferente do valor default
				-- a passagem para outro estado pode não depender de nenhuma "entrada"
				IF (x = 0 or x = 2) THEN
					nx_state <= C;
				ELSE 
					nx_state <= A;
				END IF;
		END CASE;
	END PROCESS;
	------Seção de Saída (opcional):-------
	-- Essa seção visa garantir que a saida new_output esteja sincronizada com o clk.  
	-- Se isso não for importante, ela pode ser suprimida
--	PROCESS (clk, rst)
--	BEGIN
--		IF (rst = '1') THEN
--			y <= 0 ;
--		ELSIF rising_edge(clk) THEN --or falling_edge(clk)
--			y <= output;
--		END IF;
--	END PROCESS;
END architecture;