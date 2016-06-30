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




entity 2prueba is
    Port ( p : in  std_logic);
end 2prueba;






architecture Behavioral of 2prueba is

signal lr1, lr2: std_logic;
signal pulsadores: std_logic_vector(3 downto 0);
signal leds: std_logic_vector(4 downto 0);
type estados is (s1,s2,s3,s4);
signal estado: estados;
signal estado, enable, finCuenta, pulsador, entrada_p: std_logic;

component contador
    Port (enable, clk, rst : in  std_logic;
     Min, Max : out  std_logic);
end component;

component antiReb
    Port (p, clk, rst : in  std_logic;
     Estable_p : out  std_logic);
end component;

component datos_suma
    Port (nivelespulsadores : in  std_logic_vector(3 downto 0);
     leds : out std_logic_vector(4 downto 0));
     rst, enable1,enable2 : out std_logic);
end component;

begin

contador1: contador
port map (clk => clk, rst=>rst,enable => enable, Max => finCuenta);

antirebote1: antiReb
port map (clk => clk, rst=>rst,Estable_p => pulsador,p => entrada_p);

sumar: datos_suma
port map (nivelespulsadores => pulsadores,leds => leds,rst=>rst,enable1=>lr1,enable2=>lr2);

process(clk,rst)
begin
if rst = '1' then
    reg <= (others '0');
elsif clk = '1' and clk'event then
    case estado is
        when s1 =>
            if p = '1' then
                estado <= s2;
            end if;
        when s2 =>
            if p = '0' then
                estado <= s3;
            end if;
        when s3 =>
            if p = '1' then
                estado <= s4;
            end if;
        when s4 =>
            if p = '0' then
                estado <= s1;
            end if;
    end case;
end if;
end process;

process(estado)
begin
    case estado is
        when s1 =>
            lr1 <= '0';
            lr2 <= '0';
        when s2 =>
            lr1 <= '1';
            lr2 <= '0';
        when s3 =>
            lr1 <= '0';
            lr2 <= '0';
        when s4 =>
            lr1 <= '0';
            lr2 <= '1';
    end case;
end process;

end Behavioral;






