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

entity CTRL_LCD is
    Port ( clk, rst : in  STD_LOGIC;
            switchs : in  STD_LOGIC_VECTOR (3 downto 0);
            pulsador : in  STD_LOGIC;
            strataflash : out STD_LOGIC_VECTOR (2 downto 0);
            LCD_IO : out STD_LOGIC_VECTOR (6 downto 0));
end CTRL_LCD;



architecture Behavioral of CTRL_LCD is
signal out_Pico : STD_LOGIC_VECTOR (7 downto 0);
signal writing : std_logic;
signal data_IN : STD_LOGIC_VECTOR (7 downto 0);
signal interrupcion_pulsador: std_logic;

signal next_data : std_logic;
signal interrupt_ack : std_logic;
signal out_REG : std_logic_vector(7 downto 0);
signal port_id_PICO : std_logic_vector(7 downto 0);

signal LCD_RW : STD_LOGIC;
signal ControlZ : STD_LOGIC;



component top_PB is
      Port ( port_id : out std_logic_vector(7 downto 0);
           write_strobe : out std_logic;
               out_port : out std_logic_vector(7 downto 0);
            read_strobe : out std_logic;
                in_port : in std_logic_vector(7 downto 0);
              interrupt : in std_logic;
          interrupt_ack : out std_logic;
                  reset : in std_logic;
                    clk : in std_logic);
end component;


component registro_datos is --  de trabajo_UART
    Port ( in_data : in  STD_LOGIC_VECTOR (7 downto 0);
           out_data : out  STD_LOGIC_VECTOR (7 downto 0);
           clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           habilitador : in  STD_LOGIC);
end component;


component controlador_boton is
    Port ( clk, rst, ack : in  STD_LOGIC;
           pulsador : in  STD_LOGIC;
           norm_signal : out STD_LOGIC);
end component;



begin

microcontrolador: top_PB 
port map (write_strobe => writing, out_port => out_Pico, in_port => data_IN,
     interrupt => interrupcion_pulsador, port_id => port_id_PICO,
    interrupt_ack => interrupt_ack, reset => rst, clk => clk);

    
registro2: registro_datos 
port map (clk => clk, rst => rst, in_data=> out_Pico,
    out_data=> out_REG, habilitador => next_data);

  
--necesito una maquinita de estados para determinar cual
--es la señal FUENTE, la UART ó el 'boton estabilizado';
--si es el boton debo Normalizar!.


contr_boton: controlador_boton 
port map (clk => clk, rst => rst, ack => interrupt_ack,
    pulsador=> pulsador, norm_signal => interrupcion_pulsador);

data_IN(3 downto 0) <= switchs;
next_data <= port_id_PICO(6) and writing;
LCD_RW <= out_REG(1) and out_REG(3);
ControlZ <= not(out_REG(1)) and out_REG(3); 
LCD_IO(6 downto 3) <= out_REG (7 downto 4) when ControlZ = '1' else (others =>'Z');
LCD_IO(2 downto 0) <= out_REG (2) & LCD_RW & out_REG (0);

strataflash <= (others => '1');
              
end Behavioral;

