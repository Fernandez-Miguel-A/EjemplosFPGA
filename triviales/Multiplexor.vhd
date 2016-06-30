--------------------------------------------------------------------------------
-- Company: DSI / FCEIA / UNR 
-- Engineer: Curso Síntesis de sistemas digitales en FPGA - 2016
--
-- Create Date:    10:29:51 04/20/16
-- Design Name:    
-- Module Name:    Multiplexor - Behavioral
-- Project Name:   
-- Target Device:  
-- Tool versions:  
-- Description: Multiplexor 2 a 1.
--
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:Modificar para elegir entre 4 entradas (MUX 4X1)de 4 bits cada una.
-- 
--------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Multiplexor is
    Port ( a : in std_logic_vector(1 downto 0);
           b : in std_logic_vector(1 downto 0);
           sel : in std_logic;
           s : out std_logic_vector(1 downto 0));
end Multiplexor;

architecture Behavioral of Multiplexor is

begin
  s <= a when sel ='1' else b;
end Behavioral;
