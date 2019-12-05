library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity MUX is
	port(
		saida_ula : in std_logic_vector(15 downto 0);
		saida_memoria: in std_logic_vector(15 downto 0);
		constante : in std_logic_vector(7 downto 0 );
		seletor : in std_logic_vector(1 downto 0);
		saida_mux : out std_logic_vector(15 downto 0)
		);
end MUX;

architecture mux_arq of MUX is
	begin
		process (seletor, saida_ula, saida_memoria) begin
			
			case seletor is 
			
				when "00" =>
					saida_mux <= saida_ula;
				
				when "01" =>
					saida_mux <= saida_memoria;
				
				when "10" =>
					saida_mux(7 downto 0) <= constante;
					saida_mux(15 downto 9) <= (others => '0');
				
				when "11" =>
					saida_mux <= (others => '0');
				
			end case;
				
		
		end process;
end mux_arq;