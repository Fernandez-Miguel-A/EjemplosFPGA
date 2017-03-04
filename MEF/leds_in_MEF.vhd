----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:59:25 06/11/2016 
-- Design Name: 
-- Module Name:    uart_eje1 - Behavioral 
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

entity control_leds is
    Port ( clk, rst : in  STD_LOGIC;
            P1,P2 : in  STD_LOGIC;
           LEDS : out  STD_LOGIC_VECTOR (8 downto 0));
end control_leds;





architecture Behavioral of control_leds is

signal pulsador: std_logic;
signal entrada_p: std_logic;
signal startRotation: std_logic;
signal timer300: std_logic;
signal finalice300: std_logic;
type estados_M is (s0,s1,s2,s3,s4,s5);
type estados_S is (sSUB_1,sSUB_2);
signal estado_MAIN: estados_M;
signal estado_SUB1,estado_SUB2: estados_S;

component antiReb
    Port (p, clk, rst : in  std_logic;
     Estable_p : out  std_logic);
end component;

component timer
    Port (enable, clk, rst : in  std_logic;
     shot : out  std_logic);
end component;


begin

antirebote1: antiReb
port map (clk => clk, rst=>rst,Estable_p => pulsador,p => entrada_p);

timer1: contador
port map (clk => clk, rst=>rst,enable => timer300, shot => finalice300);

process(clk,rst)
begin
if rst = '1' then
    estado_MAIN <= s0;
elsif clk = '1' and clk'event then
    case estado_MAIN is
        when s0 =>
            estado_MAIN <= s1;
        when s1 =>
            if P1 = '1' then
                estado_MAIN <= s2;
            end if;
        when s2 =>
            if P1 = '0' then
                estado_MAIN <= s3;
            end if;
        when s3 =>
            if P2 = '1' then
                estado_MAIN <= s4;
            end if;
        when s4 =>
            if P2 = '0' then
                estado_MAIN <= s5;
            end if;
    end case;
end if;
end process;

process(estado_MAIN)
begin
    case estado_MAIN is
        when s1 =>
            LEDS <= "000000001";
            startRotation <= '0';
        when s2 =>
            startRotation <= '1';
        when s3 =>
            startRotation <= '1';
        when s4 =>
            LEDS <= "111111111";
            startRotation <= '0';
        when s5 =>
            LEDS <= "111111111";
        --when others =>
            --LEDS <= "111111111";
    end case;
end process;




process(clk,rst)
begin
if rst = '1' then
    estado_SUB1 <= sSUB_1;
elsif clk = '1' and clk'event then
    case estado_SUB1 is
        when sSUB_1 =>
            if finalice300 = '0' and startRotation = '1' then
                estado_SUB1 <= sSUB_2;
            end if;
        when sSUB_2 =>
            if finalice300 = '1' then
                estado_SUB1 <= sSUB_1;
            end if;
    end case;
end if;
end process;

process(estado_SUB1)
begin
    case estado_SUB1 is
        when sSUB_1 =>
            timer300 <= '0';
        when sSUB_2 =>
            timer300 <= '1';
        --when others =>
            --LEDS <= "111111111";
    end case;
end process;




process(clk,rst)
begin
if rst = '1' then
    estado_SUB2 <= sSUB_1;
elsif clk = '1' and clk'event then
    case estado_SUB2 is
        when sSUB_1 =>
            if startRotation = '1' then
                estado_SUB2 <= sSUB_2;
            end if;
        when sSUB_2 =>
            if startRotation = '0' then
                estado_SUB2 <= sSUB_1;
            end if;
    end case;
end if;
end process;

process(estado_SUB2)
    variable cuenta: integer 0 to 200000; -- Innecesario
    begin
    case estado_SUB2 is
        when sSUB_1 =>
            LEDS <= '0'; -- Incongruencia de Tipos, debiera ser de tamaño (8). Antes estaba "timer300 <= '0';"
        when sSUB_2 =>
            timer300 <= '1';
        --when others =>
            --LEDS <= "111111111";
    end case;
end process;

end Behavioral;






