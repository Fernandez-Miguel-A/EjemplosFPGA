----------------------------------------------------------------------------------
-- Company: DSI / FCEIA / UNR
-- Engineer: Síntesis de sistemas digitales en FPGA
-- 
-- Create Date:    17:59:34 14/05/2016 
-- Design Name: 
-- Module Name:    Registro - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: FF con reset asincrónico prioritario,asume el valor alto si IH es uno. Cae a cero si IH es cero e IL es uno.
--
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

entity Registro is
    Port ( IH : in  STD_LOGIC;
           IL : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           s : out  STD_LOGIC);
end Registro;

architecture Behavioral of Registro is
signal aux:std_logic_vector(1 downto 0);
begin
aux <= Ih & Il;
process (clk, reset)
begin
if reset = '1' then s <= '0'; 
elsif clk = '1' and clk'event then
case aux is
when "10" => s <= '1';
when "01"=> s <= '0';
when "11"=> s <= '1';
when others => null;
end case;
end if;
end process;

end Behavioral;

