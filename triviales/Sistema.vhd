----------------------------------------------------------------------------------
-- Company: DSI / FCEIA / UNR
-- Engineer: Síntesis de sistemas digitales en FPGA
-- 
-- Create Date:    18:07:34 14/05/2016 
-- Design Name: 
-- Module Name:    Sistema - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: Top estructural que incluye como componentes 2 instancias de un
-- FF y dos instancias de un contador.
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Sistema  is -- requiere contador y registro
    Port ( e1 : in  STD_LOGIC;
           e2 : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           sal1 : out  STD_LOGIC;
           sal2 : out  STD_LOGIC);
end Sistema;

architecture Behavioral of Sistema is
component contador 
 Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           TC : out  STD_LOGIC;
           En : in  STD_LOGIC;
           cero : out  STD_LOGIC);
end component;
component registro
Port ( IH : in  STD_LOGIC;
           IL : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           s : out  STD_LOGIC);
end component;
signal TC1, TC2, cero1,cero2: std_logic;

begin
Cuenta1: contador 
port map (clk => clk, reset=>reset,En => e1, TC => TC1, cero => cero1);

Cuenta2: contador 
port map (clk => clk, reset=>reset,En => e2, TC => TC2, cero => cero2);

Reg1: registro
port map (clk => clk, reset=>reset,Ih => TC1, Il => cero2, s => sal1);

Reg2: registro
port map (clk => clk, reset=>reset,Ih => TC2, Il => cero1, s => sal2);


end Behavioral;

