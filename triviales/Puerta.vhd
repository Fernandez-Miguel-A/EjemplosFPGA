----------------------------------------------------------------------------------
-- Company: DSI/FCEIA /UNR
-- Engineer: S�ntesis de Sistemas Digitales en FPGA - Edici�n 2016
-- 
-- Create Date:    16:15:43 04/10/2016 
-- Design Name: 
-- Module Name:    Puerta - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: Descripci�n de una puerta and con par�metro de tama�o para entradas y salida.
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments:Modificar para trabajar con datos de 8 bits. Modificar utilizando otra
-- funci�n l�gica.  
--
----------------------------------------------------------------------------------
library IEEE; -- Biblioteca IEEE
use IEEE.STD_LOGIC_1164.ALL; -- Paquete con los tipos de datos orientados a s�ntesis

-- Descripci�n de la interfaz del componente
entity Puerta is
	generic (WIDTH: integer range 1 to 32:= 1); -- Par�metro con valor por defecto
    Port ( a : in  STD_LOGIC_VECTOR (WIDTH - 1 downto 0);
           b : STD_LOGIC_VECTOR (WIDTH - 1 downto 0);
           s : out  STD_LOGIC_VECTOR (WIDTH - 1 downto 0));
end Puerta;

-- Descripci�n del comportamiento del componente
architecture Behavioral of Puerta is

begin
s <= a and b;

end Behavioral;

