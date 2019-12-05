library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
entity ULA is

	port(
		sinal_controle: in std_logic_vector(1 downto 0);
		A: in std_logic_vector(15 downto 0);
		B: in std_logic_vector(15 downto 0);
		output: out std_logic_vector(15 downto 0)
	);
end ULA;

architecture arq of ULA is

	begin
		uso_ula: process(sinal_controle, A, B)
			begin
				case sinal_controle is 
					when "00" => 
					output <= A; 
					when "01" => 
					output <= A + B; -- ADD
					when "10" => 
					output <= A - B; -- SUB
					when others => null;
				end case;
		end process uso_ula;
end arq;