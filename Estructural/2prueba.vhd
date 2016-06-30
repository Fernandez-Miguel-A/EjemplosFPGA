----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:52:07 06/04/2016 
-- Design Name: 
-- Module Name:    2prueba - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
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
--use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;


entity antiReb is
    Port (p, clk, rst : in  std_logic;
			Estable_p : out  std_logic);
end antiReb;


architecture Behavioral of antiReb is
signal reg: std_logic_vector(11 downto 0);
begin

process(clk,rst)
begin
if rst = '1' then
	reg <= (others => '0');
elsif clk = '1' and clk'event then
	reg <= reg(10 downto 0)&p;    -- [10-0][p]. p va al bit menos significativo (desplazamiento a izquierda)
end if;
end process;

end Behavioral;
