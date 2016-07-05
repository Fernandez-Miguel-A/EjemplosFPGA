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

entity controlador_boton is
    Port ( clk, rst, ack : in  STD_LOGIC;
           pulsador : in  STD_LOGIC;
           norm_signal : out STD_LOGIC);
end controlador_boton;



architecture Behavioral of controlador_boton is
signal pulsado_Estable: std_logic;


component normalizar_interrupcion is
    Port ( raw_signal, clk, rst, ack : in  STD_LOGIC;
           norm_signal : out  STD_LOGIC);
end component;

component antiReb is
    Port (p, clk, rst : in  std_logic;
			Estable_p : out  std_logic);
end component;

begin

antiRebote: antiReb 
port map (clk => clk, rst => rst, p=> pulsador, Estable_p=> pulsado_Estable);

int1: normalizar_interrupcion 
port map (clk => clk, rst => rst, raw_signal => pulsado_Estable,
	ack => ack, norm_signal => norm_signal);
	

end Behavioral;

