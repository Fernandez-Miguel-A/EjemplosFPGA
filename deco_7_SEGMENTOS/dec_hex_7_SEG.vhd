----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:33:38 05/28/2016 
-- Design Name: 
-- Module Name:    dec_hex_7_SEG - Behavioral 
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

entity dec_hex_7_SEG is
    Port ( entr : in  STD_LOGIC_VECTOR (3 downto 0);
	        --g,f,e,d,c,b,a : out  STD_LOGIC);	 
	        sal : out  STD_LOGIC_VECTOR (6 downto 0));	 
end dec_hex_7_SEG;


architecture Behavioral of dec_hex_7_SEG is
--signal sal : STD_LOGIC_VECTOR (6 downto 0);
begin				

--with entr select
    --sal <= "0111111" when "0000",  -- Cero
           --"0000110" when "0001",  -- Uno
           --"1011011" when "0010",  -- Dos	
           --"1001111" when "0011",  -- Tres
           --"1100110" when "0100",  -- Cuatro
           --"1101101" when "0101",  -- Cinco
           --"1111101" when "0110",  -- Seis
           --"0000111" when "0111",  -- Siete
           --"1111111" when "1000",  -- Ocho
           --"1100111" when "1001",  -- Nueve
           --"0000000" when others; --(others '0');
			
--sal <= "0111111" when entr = "0000" else -- Cero
     --  "0000110" when entr ="0001" else -- Uno
   --    "1011011" when entr ="0010" else -- Dos	
    --   "1001111" when entr ="0011" else -- Tres
    --   "1100110" when entr ="0100" else -- Cuatro
   --    "1101101" when entr ="0101" else -- Cinco
   --    "1111101" when entr ="0110" else -- Seis
    --   "0000111" when entr ="0111" else -- Siete
    --   "1111111" when entr ="1000" else -- Ocho
    --   "1100111" when entr ="1001" else -- Nueve
    --   "0000000"; --(others '0');
				
sal <= "0111111" when (NOT entr(0) = '0' )AND(NOT entr(1) = '0' )AND(NOT entr(2) = '0' )AND(NOT entr(3) = '0' ) else -- Cero "0000"
       "0000110" when (NOT entr(0) = '0' )AND(NOT entr(1) = '0' )AND(NOT entr(2) = '0' )AND(    entr(3) = '0' ) else -- Uno "0001"
       "1011011" when (NOT entr(0) = '0' )AND(NOT entr(1) = '0' )AND(    entr(2) = '0' )AND(NOT entr(3) = '0' ) else -- Dos "0010"
       "1001111" when (NOT entr(0) = '0' )AND(NOT entr(1) = '0' )AND(    entr(2) = '0' )AND(    entr(3) = '0' ) else -- Tres "0011"
       "1100110" when (NOT entr(0) = '0' )AND(    entr(1) = '0' )AND(NOT entr(2) = '0' )AND(NOT entr(3) = '0' ) else -- Cuatro "0100"
       "1101101" when (NOT entr(0) = '0' )AND(    entr(1) = '0' )AND(NOT entr(2) = '0' )AND(    entr(3) = '0' ) else -- Cinco "0101"
       "1111101" when (NOT entr(0) = '0' )AND(    entr(1) = '0' )AND(    entr(2) = '0' )AND(NOT entr(3) = '0' ) else -- Seis "0110"
       "0000111" when (NOT entr(0) = '0' )AND(    entr(1) = '0' )AND(    entr(2) = '0' )AND(    entr(3) = '0' ) else -- Siete "0111"
       "1111111" when (    entr(0) = '0' )AND(NOT entr(1) = '0' )AND(NOT entr(2) = '0' )AND(NOT entr(3) = '0' ) else -- Ocho "1000"
       "1100111" when (    entr(0) = '0' )AND(NOT entr(1) = '0' )AND(NOT entr(2) = '0' )AND(    entr(3) = '0' ) else -- Nueve "1001"
       "0000000"; --(others '0');
		
--process (sal)
--begin
--g,f,e,d,c,b,a <= sal;
--g <= sal(0);
--f <= sal(1);
--e <= sal(2);
--d <= sal(3);
--c <= sal(4);
--b <= sal(5);
--a <= sal(6);
--end process;

end Behavioral;

