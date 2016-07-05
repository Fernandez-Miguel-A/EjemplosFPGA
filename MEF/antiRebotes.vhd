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


entity antiReb is
    Port (p, clk, rst : in  std_logic;
			Estable_p : out  std_logic);
end antiReb;


architecture Behavioral of antiReb is -- Antirebote sin terminar ('Estable_p'), cambiar al
signal triggered: std_logic;
signal habilitador: std_logic; 

type estados_M is (s1,s2,s3,s4,s5);
signal estado_MAIN: estados_M;

component timer is
    Port (enable, clk, rst : in  std_logic;
     shot : out  std_logic);
end component;

begin

timer1: timer 
port map (clk => clk, rst => rst, enable => habilitador, shot => triggered);


process(clk,rst)
begin
if rst = '1' then
    estado_MAIN <= s1;
elsif clk = '1' and clk'event then
    case estado_MAIN is
        when s1 =>
            if p = '1' then
                estado_MAIN <= s2;
            end if;
        when s2 =>
            estado_MAIN <= s3;
        when s3 =>
            if triggered = '1' then
                estado_MAIN <= s4;
            end if;
        when s4 =>
            if p = '0' then
                estado_MAIN <= s5;
            end if;
        when s5 =>
            if triggered = '1' then
                estado_MAIN <= s1;
            end if;
    end case;
end if;
end process;

process(estado_MAIN)
begin
    case estado_MAIN is
        when s1 =>
            Estable_p <= '0';
            habilitador <= '0';
        when s2 =>
            Estable_p <= '1';
            habilitador <= '1';
        when s3 =>
            Estable_p <= '0';
            habilitador <= '1';
        when s4 =>
            Estable_p <= '0';
            habilitador <= '0';
        when s5 =>
            Estable_p <= '0';
            habilitador <= '1';
        when others => null;
    end case;
end process;


end Behavioral;
