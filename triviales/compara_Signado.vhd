--------------------------------------------------------------------------------
-- Company: DSI / FCEIA / UNR 
-- Engineer: Curso síntesis de sistemas digitales en FPGA - 2016
--
-- Create Date:    10:16:12 05/10/16
-- Design Name:    
-- Module Name:    compara - Behavioral
-- Project Name:   
-- Target Device:  
-- Tool versions:  
-- Description: comparador de números de 4 bits
--
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments: Modificar para que trabaje con números positivos sin signo.
-- 
--------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;

entity compara_S is
    Port ( a : in std_logic_vector(3 downto 0);
           b : in std_logic_vector(3 downto 0);
           mayor: out std_logic);  
end compara_S;

architecture Behavioral of compara_S is

begin
mayor <= '1' when a > b else '0';
end Behavioral;
