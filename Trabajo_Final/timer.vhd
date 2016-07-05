----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:59:25 06/11/2016 
-- Design Name: 
-- Module Name:    uart_eje1 - Behavioral 
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

entity timer is
    Port (enable, clk, rst : in  std_logic;
     shot : out  std_logic);
end timer;






architecture Behavioral of timer is
begin

process(clk,rst)
    variable cuenta: integer range 0 to 200000;
    begin
    if rst = '1' then
        cuenta := 0;
    elsif clk = '1' and clk'event then
        if cuenta < 166667 then
				cuenta := cuenta + 1;
            shot <= '0';
        else
            shot <= '1';
            cuenta := 0;
        end if;
    end if;
end process;

end Behavioral;






