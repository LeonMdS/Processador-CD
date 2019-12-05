library ieee;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;

entity banco_instrucao is
	port(
		addr: in std_logic_vector(15 downto 0);
		data: out std_logic_vector(15 downto 0);
		rd: in std_logic;
		clk: in std_logic
		);
end banco_instrucao;


architecture arq of banco_instrucao is
	type memoria_matriz is array (0 to 100) of std_logic_vector(15 downto 0);--oito bits
	signal memoria : memoria_matriz;
	signal addr_s : integer;
	begin
		process(clk)
		begin
	   memoria(0) <= "0000000100000000";--carrega memoria(0)
		memoria(1) <= "0000001000000001";--carrega memoria(1)
		memoria(2) <= "0110000000010010";--armazenamento indireto
		memoria(3) <= "0001001100000001";--carrega o resultado 
			addr_s <= to_integer(unsigned(addr));
			if rd='1' then
				data <= memoria(addr_s);
			end if;
		end process;
	end arq;