--------------------------------------------------------------------------------
-- Company: DSI / FCEIA / UNR 
-- Engineer: Curso Síntesis de sistemas digitales en FPGA - 2016
--
-- Create Date:    17:32:25 04/25/16
-- Design Name:    
-- Module Name:    RomContConv - Behavioral
-- Project Name:   
-- Target Device:  
-- Tool versions:  
-- Description: Módulo de memoria ROM 16x8
--
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
--------------------------------------------------------------------------------
library ieee; 
use ieee.std_logic_1164.all; 
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity MROM is 
port ( dir : in std_logic_vector(3 downto 0); 
      datos : out std_logic_vector(7 downto 0) ); 
end  MROM; 

architecture behavioral of MROM is 
type mem is array (0 to 15) of std_logic_vector(7 downto 0); 
signal mi_Rom : mem; 
begin 
mi_Rom <= ( 
    0  => "00000000", 
    1  => "00000001", 
    2  => "00000010", 
    3  => "00000011", 
    4  => "00000100", 
    5  => "11110000", 
    6  => "11110011", 
    7  => "11110111", 
	 others => "11111111");
	  
datos <= Mi_rom (CONV_INTEGER(dir));
end  behavioral;