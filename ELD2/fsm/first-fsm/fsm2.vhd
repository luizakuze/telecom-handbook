LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
----------------------------------------------------------
ENTITY fsm2 IS
PORT (
	clk, rst : IN STD_LOGIC;
	TEMPO: IN integer range 0 to 30;
	START, GAMBI, NIVEL:  IN integer range 0 to 1;
	M1, M2, B, V: OUT bit);
END entity;
----------------------------------------------------------
ARCHITECTURE ifsc_v1 OF fsm2 IS
	TYPE state IS (PARADO, ENCHE1, BATE1,
						MOLHO, BATE2, ESVAZIA1,
						ENCHE2, ENXAGUA, ESVAZIA2, 
						CENTRIFUGA);
	SIGNAL pr_state, nx_state : state;
BEGIN
	------Logica Sequencial da FSM:------------
	PROCESS (clk, rst)
	BEGIN
		IF (rst = '1') THEN
			pr_state <= PARADO;
		ELSIF rising_edge(clk) THEN
			pr_state <= nx_state;
		END IF;
	END PROCESS;
	------Logica Combinacional da FSM:------------
	PROCESS (pr_state, START)
	BEGIN
		------Valores default das saidas------------
      M1 <= '0';
		M2 <= '0';
		B <= '0';
		V <= '0';
		CASE pr_state IS
			WHEN PARADO =>
				IF (START = 1) THEN
					nx_state <= ENCHE1;
				ELSE
					nx_state <= PARADO;
				END IF;
			WHEN ENCHE1 =>
				V <= '1';
				IF (NIVEL = 1) THEN
					nx_state <= BATE1;
				ELSE
					nx_state <= ENCHE1;
				END IF;
			WHEN BATE1 =>
				M1 <= '1';
				IF (TEMPO >= 2) THEN
					nx_state <= MOLHO;
				ELSE
					nx_state <= BATE1;
				END IF;
			WHEN MOLHO =>
				IF (TEMPO >= 30) THEN
					nx_state <= BATE2;
				ELSE
					nx_state <= MOLHO;
				END IF;
			WHEN BATE2 =>
				M1 <= '1';
				IF (TEMPO >= 15) THEN
					nx_state <= ESVAZIA1;
				ELSE
					nx_state <= BATE2;
				END IF;
			-- arrumar
			WHEN ESVAZIA1 =>
				B <= '1';
				IF (GAMBI = 1) THEN
					nx_state <= CENTRIFUGA;
				ELSIF (NIVEL = 0) THEN
					nx_state <= ENCHE2;
				ELSE
					nx_state <= ESVAZIA1;
				END IF;
			WHEN ENCHE2 =>
				V <= '1';
				IF (NIVEL = 1) THEN
					nx_state <= ENXAGUA;
				ELSE
					nx_state <= ENCHE2;
				END IF;
			WHEN ENXAGUA =>
				M1 <= '1';
				IF (TEMPO >= 3) THEN
					nx_state <= ESVAZIA2;
				ELSE
					nx_state <= ENXAGUA;
				END IF;
			WHEN ESVAZIA2 =>
				B <= '1';
				IF (NIVEL = 0) THEN
					nx_state <= CENTRIFUGA;
				ELSE
					nx_state <= ESVAZIA2;
				END IF;
			WHEN CENTRIFUGA =>
				M2 <= '1';
				B <= '1';
				IF (TEMPO >= 20) THEN
					nx_state <= PARADO;
				ELSE
					nx_state <= CENTRIFUGA;
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