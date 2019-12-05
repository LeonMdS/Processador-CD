library ieee;
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity comparador is 	
	port( 
			saida_banco : in std_logic_vector(15 downto 0);
			saida_comparador : out std_logic
		 );
end entity;


architecture behavior of comparador is 


begin

 saida_comparador <= '1' when unsigned(saida_banco) = 0 else '0';

end architecture;