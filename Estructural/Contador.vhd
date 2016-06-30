----------------------------------------------------------------------------------
-- Company: DSI / FCEIA / UNR
-- Engineer: Síntesis de sistemas digitales en FPGA
-- 
-- Create Date:    12:26:27 14/05/2016 
-- Design Name: 
-- Module Name:    Contador - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: contador de 4 bits con reset asincrónico prioritario y habilitación de cuenta.
-- TC asume el valor 1 cuando llega a la cuenta máxima.
-- cero asume el valor 1 cuando la cuenta es "0000".
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--entity Contador is
--    Port ( clk : in  STD_LOGIC;
--           reset : in  STD_LOGIC;
--           TC : out  STD_LOGIC;
--           En : in  STD_LOGIC;
--           cero : out  STD_LOGIC);
--end Contador;

--architecture Behavioral of Contador is
--signal cuenta:std_logic_vector (3 downto 0);
--begin
--process(clk,reset)
--begin
--if reset = '1' then cuenta <= (others => '0');
--elsif clk'event and clk = '1'then
--if En = '1' then cuenta <= cuenta + 1;
--end if;
--end if; 
--end process;
--TC <= '1' when cuenta = "1111" else '0';
--cero <= '1' when cuenta = "0000" else '0';


--end Behavioral;





entity contador is
    Port (enable, clk, rst : in  std_logic;
	 Min, Max : out std_logic);
end contador;


architecture Behavioral of contador is
signal cuenta: std_logic_vector(3 downto 0);
begin

process(clk,rst)
begin
if rst = '1' then
	cuenta <= (others => '0');
elsif clk = '1' and clk'event then
	if enable = '1' then
		cuenta <= cuenta + 1;
	end if;
end if;
end process;

Max <= '1' when cuenta = "1111" else '0';
Min <= '1' when cuenta = "0000" else '0';
end Behavioral;


