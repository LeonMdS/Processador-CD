library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity Controller is
	port(
		clk: in std_logic; -- clock
		data: in std_logic_vector(15 downto 0); -- instrução
		RF_rp_zero: in std_logic;
		PC_clr: out std_logic; -- clear do contador
		PC_inc: out std_logic; -- ativar incremento contador
		PC_ld: out std_logic;-- ativar pc
		IR_ld: out std_logic; -- ativar leitura do registrador de instruções
		I_rd: out std_logic; -- ativar leitura do banco de registradores de instruções
		D_addr: out std_logic_vector(7 downto 0); -- endereço da memória
		D_rd: out std_logic; -- ativar leitura memoria
		D_wr: out std_logic; -- ativar escrita memoria
		RF_s: out std_logic_vector(1 downto 0); -- sinal de controle do MUX
		RF_W_addr: out std_logic_vector(3 downto 0); -- endereço de escrita do banco de registradores
		RF_W_wr: out std_logic; -- ativar escrita do banco de registradores
		RF_Rp_addr: out std_logic_vector(3 downto 0); -- endereço de leitura do banco de registradores
		RF_Rp_rd: out std_logic; -- ativar leitura do banco de registradores
		RF_Rq_addr: out std_logic_vector(3 downto 0); -- endereço de leitura do banco de registradores
		RF_Rq_rd: out std_logic; -- ativar leitura do banco de registradores
		alu_s: out std_logic_vector(1 downto 0); -- sinal OPCODE pra ULA
		RF_W_data: out std_logic_vector(7 downto 0)
		);
end Controller;


architecture arq of Controller is
	signal estado: INTEGER := 0;
	signal opcode: std_logic_vector(3 downto 0);
	
	begin
		process(clk)
			begin
			if rising_edge(clk) then
				case estado is
					when 0 => -- Inicio
						PC_clr <= '1'; -- zerar contador
						estado <= 1;
					when 1 => -- Busca
						PC_clr <= '0';
						I_rd <= '1';
						PC_inc <= '1';
						IR_ld <= '1';
						estado <= 2;
					when 2 => -- Decodificação
						PC_clr <= '0';
						PC_inc <= '0';
						I_rd <= '0';
						IR_ld <= '0';
						case data(15 downto 12) is -- opcode
							when "0000" => -- LDA
								D_rd <= '1';
								D_wr <= '0';
								RF_s <= "01"; -- pegar o que vem da memória
								RF_W_wr <= '1'; -- salvar no banco de registradores
								RF_Rp_rd <= '0';
								RF_Rq_rd <= '0';
								alu_s <= "00"; -- ULA não faz operação
								D_addr <= data(7 downto 0); -- endereço de memória a ser guardado
								RF_W_addr <= data(11 downto 8);
								RF_Rp_addr <= "0000";
								RF_Rq_addr <= "0000";
								estado <= 1; 
							when "0001" => -- STA
								D_rd <= '0';
								D_wr <= '1'; -- escrever na memória
								RF_s <= "00";
								RF_W_wr <= '0';
								RF_Rp_rd <= '1'; -- ler do banco de registradores
								RF_Rq_rd <= '0';
								alu_s <= "00";
								D_addr <= data(7 downto 0);
								RF_W_addr <= "0000";
								RF_Rp_addr <= data(11 downto 8);
								RF_Rq_addr <= "0000";
								estado <= 1; 
							when "0010" => -- ADD
								D_rd <= '0';
								D_wr <= '0';
								RF_s <= "00";
								RF_W_wr <= '1';
								RF_Rp_rd <= '1';
								RF_Rq_rd <= '1';
								alu_s <= "01";
								RF_W_addr <= data(11 downto 8);
								RF_Rp_addr <= data(7 downto 4);
								RF_Rq_addr <= data(3 downto 0);
								estado <= 1; 
							when "0011" => -- CARREGAR CONSTANTE
								alu_s <= "00"; -- ULA não faz operação
								RF_s <= "10";
								RF_W_wr <= '1';
								RF_W_addr <= data(11 downto 8);
								estado <= 1; 
							when "0100" => -- SUB
								D_rd <= '0';
								D_wr <= '0';
								RF_s <= "00";
								RF_W_wr <= '1';
								RF_Rp_rd <= '1';
								RF_Rq_rd <= '1';
								alu_s <= "10";
								RF_W_addr <= data(11 downto 8);
								RF_Rp_addr <= data(7 downto 4);
								RF_Rq_addr <= data(3 downto 0);
								estado <= 1; 
							when "0101" => -- SALTAR SE ZERO
								RF_Rp_rd <= '1';
								RF_Rp_addr <= data(7 downto 4);
								case RF_rp_zero is 
									when '1' =>
										PC_ld <= '1';
									when others => null;
								end case;
								estado<= 1;
							when "0110" => -- Armazenamento indireto
								alu_s <= "00"; -- ULA não faz operação
								D_rd <= '0';
								D_wr <= '1'; -- escrever na memória
								RF_s <= "00";
								RF_W_wr <= '0';
								RF_Rp_rd <= '0'; -- ler do banco de registradores
								RF_Rq_rd <= '1';
								alu_s <= "00";
								D_addr <= "00000000"+data(7 downto 4);
								RF_Rq_addr <= data(3 downto 0);
								estado <= 1; 	
							when others => null;
						end case;
						when others => null;
				end case;
			end if;
		end process;
end arq;