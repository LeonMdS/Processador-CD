LIBRARY Ieee;
USE ieee.std_logic_1164.ALL;
use ieee.std_logic_signed.ALL;

ENTITY contador IS

		PORT (
		data_in: in std_LOGIC_vector(15 downto 0);
		clr : IN STD_LOGIC;
		up  : IN STD_LOGIC;
		clk : IN STD_LOGIC;
		ld: in std_LOGIC;
		I_ADDR : OUT STD_LOGIC_vector(15 downto 0));
		
END ENTITY;

ARCHITECTURE arquitetura OF contador IS
	signal contador : std_logic_vector(15 downto 0) := "0000000000000000";
	BEGIN

	PROCESS(clk,up,ld,clr,contador)

	BEGIN
		IF( clr='1') THEN 
			contador <= "0000000000000000";

		elsif (rising_edge(clk) and up = '1') then
			contador <= contador + 1;
		elsif (rising_edge(clk) and ld ='1') then
			contador <= data_in;
		end if;

		I_ADDR <= contador;
END PROCESS;

END ARCHITECTURE;