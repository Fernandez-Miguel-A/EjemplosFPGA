----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:26:37 06/25/2016 
-- Design Name: 
-- Module Name:    divisor - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity divisor is
    Port ( clk, rst : in STD_LOGIC;
			clk_4800 : out STD_LOGIC);
end divisor;


architecture Behavioral of divisor is
signal cuenta: integer range 0 to 700;
begin

process(clk,rst)
begin
	if rst = '1' then
		cuenta <= 0;
		clk_4800 <= '0';
	elsif clk = '1' and clk'event then
		if cuenta < 651 then
			cuenta <= cuenta + 1;
			clk_4800 <= '0';
		else
			clk_4800 <= '1';
			cuenta <= 0;
		end if;
	end if;
end process;

end Behavioral;

