----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:37:37 06/25/2016 
-- Design Name: 
-- Module Name:    controlador_para_7_leds - Behavioral 
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

entity controlador_para_7_leds is
    Port ( entr : in  STD_LOGIC_VECTOR (3 downto 0);
	        --g,f,e,d,c,b,a : out  STD_LOGIC);	 
	        sal : out  STD_LOGIC_VECTOR (7 downto 0));	 
end controlador_para_7_leds;

architecture Behavioral of controlador_para_7_leds is
begin
		
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
		
end Behavioral;



