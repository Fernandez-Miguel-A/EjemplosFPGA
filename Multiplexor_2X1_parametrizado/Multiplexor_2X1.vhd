----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:15:46 05/28/2016 
-- Design Name: 
-- Module Name:    Multiplexor_2X1 - Behavioral 
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

entity Multiplexor_2X1 is
	 generic (SIZE: integer range 1 to 32:= 16);
    Port ( a : in  STD_LOGIC_VECTOR (SIZE-1 downto 0);
           b : in  STD_LOGIC_VECTOR (SIZE-1 downto 0);
           sel : in  STD_LOGIC;
           c : out  STD_LOGIC_VECTOR (SIZE-1 downto 0));
end Multiplexor_2X1;

architecture Behavioral of Multiplexor_2X1 is

begin
c <= a when sel = '1' else b;
end Behavioral;

