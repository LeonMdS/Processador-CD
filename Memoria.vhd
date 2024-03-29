library ieee;
use ieee.std_logic_1164.all;
--use ieee.std_logic_arith.all;
--use ieee.std_logic_unsigned.all;
--use IEEE.std_logic_signed.all;
use IEEE.NUMERIC_STD.ALL;

entity Memoria is
	port(
		addr: in std_logic_vector(7 downto 0);
		clk: in std_logic;
		rd: in std_logic;
      wr: in std_logic;
		W_data: in std_logic_vector(15 downto 0);
		R_data: out std_logic_vector(15 downto 0));
end Memoria;

architecture arq of Memoria is
	type memoria_matriz is array (0 to 255) of std_logic_vector(15 downto 0);
	signal memoria : memoria_matriz := (others => (others =>'0'));
	signal addr_s : integer;
	begin
		process(clk)
			begin
				addr_s <= to_integer(unsigned(addr));
				if rising_edge(clk) and wr='1' then
					memoria(addr_s) <= W_data;
				
				ELSIF rising_edge(clk) and rd='1' THEN
					memoria(0)<="0000000000000011"; -- 3 
					memoria(1)<="0000000000000010"; -- 2
					R_data <= memoria(addr_s);
				end if;
		end process;
end arq;