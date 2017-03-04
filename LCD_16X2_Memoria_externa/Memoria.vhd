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
library ieee; 
use ieee.std_logic_1164.all; 
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity MROM is 
port ( dir : in std_logic_vector(3 downto 0); 
      datos : out std_logic_vector(7 downto 0) ); 
end  MROM; 



architecture behavioral of MROM is 
begin 

process
subtype DATA is string(1 to 14);
--variable texto2: character := NUL ;
variable texto: DATA := "TP Final FPGA"&NUL;--variable texto: DATA := "TP Final FPGA"&NUL;
variable Mi_rom :  std_logic_vector(8*(texto'length+1) - 1 downto 0); -- 96
begin
	for i in DATA'range loop
			Mi_rom((8*i-1) downto (8*(i-1))) :=  conv_std_logic_vector(character'pos(texto(i)), 8);
	end loop; 
	--Mi_romMi_rom((8*i-1) downto (8*(i-1))) :=  x"";
	datos <= Mi_rom ((8*(CONV_INTEGER(dir)+1)-1) downto (8*CONV_INTEGER(dir)));
end process;



end  behavioral;






--architecture behavioral of MROM is 
--type mem is array (0 to 15) of std_logic_vector(7 downto 0); 
--signal mi_Rom : mem; 
--begin 
--mi_Rom <= ( 
--    0  => x"54",  -- T
--    1  => x"43",  -- C
--    2  => x"20",  --  
--    3  => x"46",  -- F
--    4  => x"50",  -- P 50
--    5  => x"47",  -- G 47
--    6  => x"41",  -- A
--    7  => x"20",  --  
--    8  => x"32",  -- 2
--    9  => x"30",  -- 0
--    10  => x"31",  -- 1
--    11  => x"36",  -- 6
--   others => x"20");
--    
--datos <= Mi_rom (CONV_INTEGER(dir));
----datos <= Mi_rom (dir);
--end  behavioral;
