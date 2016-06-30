--------------------------------------------------------------------------------
-- Company: DSI / FCEIA / UNR 
-- Engineer: Curso síntesis de sistemas digitales en FPGA _ 2016
--
-- Create Date:    17:32:25 04/25/16
-- Design Name:    
-- Module Name:    Sumador - Behavioral
-- Project Name:   
-- Target Device:  
-- Tool versions:  
-- Description: sumador de cuatro bits. Prevé la posibilidad de overflow.
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

entity Sumador is
Port ( a : in std_logic_vector(3 downto 0);
       b : in std_logic_vector(3 downto 0);
		 
       s : out std_logic_vector(4 downto 0));
end ;

architecture Behavioral of Sumador is
begin

s <= (a(3)& a)+  b;

end;