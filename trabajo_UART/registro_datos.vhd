----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:20:39 06/25/2016 
-- Design Name: 
-- Module Name:    registro_datos - Behavioral 
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

entity registro_datos is
    Port ( in_data : in  STD_LOGIC_VECTOR (7 downto 0);
           out_data : out  STD_LOGIC_VECTOR (7 downto 0);
           clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           habilitador : in  STD_LOGIC);
end registro_datos;

architecture Behavioral of registro_datos is
tmp_data : out  STD_LOGIC_VECTOR (7 downto 0);
type estados_M is (s1,s2,s3,s4);
signal estado_MAIN: estados_M;
begin

process(clk,rst)
begin
if rst = '1' then
    estado_MAIN <= s1;
    out_data <= (others => '0');
elsif clk = '1' and clk'event then
    case estado_MAIN is
        when s1 =>
            if habilitador = '1' then
                estado_MAIN <= s2;
            end if;
        when s2 =>
            estado_MAIN <= s3;
        when s3 =>
            estado_MAIN <= s4;
        when s4 =>
            if habilitador = '0' then
                estado_MAIN <= s1;
            end if;
    end case;
end if;
end process;

process(estado_MAIN)
begin
    case estado_MAIN is
        when s2 =>
            out_data <= tmp_data;
        when s3 =>
            tmp_data <= in_data;
    end case;
end process;



end Behavioral;

