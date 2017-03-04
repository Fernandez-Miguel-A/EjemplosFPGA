--------------------------------------------------------------------------------
-- Company: DSI / FCEIA / UNR
-- Engineer: Síntesis de sistemas digitales en FPGA
--
-- Create Date:    10:13:17 05/06/2016
-- Design Name:    
-- Module Name:    top_PB - Behavioral
-- Project Name:   
-- Target Device:  
-- Tool versions: ISE 9.2 
-- Description:
--
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments: Descripción estructural de la conexión -- de PicoBlaze con el block RAM que contiene el programa
-- 
--------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity top_PB is
 Port (      
                port_id : out std_logic_vector(7 downto 0);
           write_strobe : out std_logic;
               out_port : out std_logic_vector(7 downto 0);
            read_strobe : out std_logic;
                in_port : in std_logic_vector(7 downto 0);
              interrupt : in std_logic;
          interrupt_ack : out std_logic;
                  reset : in std_logic;
                    clk : in std_logic);
end;

architecture Behavioral of top_PB is
signal direccion :  std_logic_vector( 9 downto 0);
signal instruccion : std_logic_vector(17 downto 0);
component KCPSM3 -- IP PicoBlaze
port (
address : out std_logic_vector( 9 downto 0);
instruction : in std_logic_vector(17 downto 0);
port_id : out std_logic_vector( 7 downto 0);
write_strobe : out std_logic;
out_port : out std_logic_vector( 7 downto 0);
read_strobe : out std_logic;
in_port : in std_logic_vector( 7 downto 0);
interrupt : in std_logic;
interrupt_ack : out std_logic;
reset : in std_logic;
clk : in std_logic
);
end component;

component memoria -- BRAM con el programa
port (
address : in std_logic_vector( 9 downto 0);
instruction : out std_logic_vector(17 downto 0);
clk : in std_logic
);
end component;
begin
--Instanciación y mapeo de puertos
processor: kcpsm3
port map(
address => direccion,
instruction => instruccion,
port_id => port_id,
write_strobe => write_strobe,
out_port => out_port,
read_strobe => read_strobe,
in_port => in_port,
interrupt => interrupt,
interrupt_ack => interrupt_ack,
reset => reset,
clk => clk
);

program: memoria
port map( address => direccion,
instruction => instruccion,
clk => clk
);
end Behavioral;
