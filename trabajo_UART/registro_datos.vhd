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
--signal tmp_data : STD_LOGIC_VECTOR (7 downto 0);
type estados_M is (s1,s2,s3);
signal estado_MAIN: estados_M;
begin

process(clk,rst)
begin
if rst = '1' then
    estado_MAIN <= s1;
elsif clk = '1' and clk'event then
    case estado_MAIN is
        when s1 =>
            if habilitador = '1' then
                estado_MAIN <= s2;
            end if;
        when s2 =>
            if habilitador = '0' then
                estado_MAIN <= s3;
            end if;
        when s3 =>
            if habilitador = '1' then
                estado_MAIN <= s2;
            end if;
    end case;
end if;
end process;

process(estado_MAIN)
variable tmp_data1, tmp_data2 : STD_LOGIC_VECTOR (7 downto 0):= (others => '0'); 
begin
    case estado_MAIN is
        when s2 =>
            tmp_data1 := in_data;
            out_data <= tmp_data2;
        when s3 =>
            tmp_data2 := tmp_data1;
        when others => null;
    end case;
end process;

end Behavioral;

