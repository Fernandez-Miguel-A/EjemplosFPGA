----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:52:07 06/04/2016 
-- Design Name: 
-- Module Name:    2prueba - Behavioral 
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
--use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;




entity datos_suma is
    Port (nivelespulsadores : in  std_logic_vector(3 downto 0);
     leds : out std_logic_vector(4 downto 0);
     rst, enable1,enable2 : out std_logic);
end datos_suma;




architecture Behavioral of datos_suma is
signal niveles: std_logic_vector(3 downto 0);
type estados is (s1,s2,s3);
signal estado: estados;
begin

process(rst)
begin
if rst = '1' then
    leds <= (others => '0');
    niveles <= (others => '0');
    estado <= s1;
elsif clk = '1' and clk'event then
    case estado is
        when s1 =>
            if enable1 = '1' then
                estado <= s2;
            end if;
        when s2 =>
            if enable2 = '1' then
                estado <= s3;
            end if;
        when s3 =>
            if enable1 = '1' then
                estado <= s2;
            end if;
    end case;
end if;
end process;

process(estado)
begin
    if estado = s2 then
        niveles <= nivelespulsadores;
    elsif estado = s3 then
        leds <= nivelespulsadores + niveles(3)&niveles;
    end if;
end process;

end Behavioral;
