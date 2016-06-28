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



entity normalizar_interrupcion is
    Port ( _signal, clk, rst, ack : in  STD_LOGIC;
           norm_signal : out  STD_LOGIC);
end normalizar_interrupcion;




architecture Behavioral of normalizar_interrupcion is
type estados_M is (s1,s2,s3,s4);
signal estado_MAIN: estados_M;
begin

process(clk,rst)
begin
if rst = '1' then
    estado_MAIN <= s1;
    norm_signal <= '0';
elsif clk = '1' and clk'event then
    case estado_MAIN is
        when s1 =>
            if _signal = '1' then
                estado_MAIN <= s2;
            end if;
        when s2 =>
            estado_MAIN <= s3;
        when s3 =>
            if ack = '1' then
                estado_MAIN <= s4;
            elsif _signal = '0' then
                estado_MAIN <= s1;
            end if;
        when s4 =>
            if _signal = '0' then
                estado_MAIN <= s1;
            end if;
    end case;
end if;
end process;

process(estado_MAIN)
begin
    case estado_MAIN is
        when s1 =>
            norm_signal <= '0';
        when s2 =>
            norm_signal <= '1';
        when s3 =>
            norm_signal <= '1';
        when s4 =>
            norm_signal <= '0';
    end case;
end process;


end Behavioral;

