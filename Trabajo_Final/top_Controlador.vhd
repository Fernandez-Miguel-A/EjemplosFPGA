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

entity uart_eje1 is
    Port ( clk, rst : in  STD_LOGIC;
           entrada_serial : in  STD_LOGIC;
			  switchs : in  STD_LOGIC_VECTOR (3 downto 0);
           pulsador : in  STD_LOGIC;
           leds : out STD_LOGIC_VECTOR (7 downto 0));
end uart_eje1;



architecture Behavioral of uart_eje1 is
signal interrupcion_pulsador: std_logic;
signal from_PC : STD_LOGIC;

signal data_IN : STD_LOGIC_VECTOR (7 downto 0);
--signal data_leds : STD_LOGIC_VECTOR (7 downto 0);


--SEÑALES para los leds
signal pre_leds : STD_LOGIC_VECTOR (7 downto 0);

--SEÑALES para registro pre leds
--signal entrada_seg : STD_LOGIC_VECTOR (3 downto 0);
signal datos_entrada : STD_LOGIC_VECTOR (7 downto 0);
signal datos_salida : STD_LOGIC_VECTOR (7 downto 0);

--SEÑALES para UART
signal UART_serial_in : STD_LOGIC;
signal UART_data_out : STD_LOGIC_vector(7 downto 0);
signal UART_read_buffer : STD_LOGIC;
signal UART_buffer_data_present : STD_LOGIC;
signal UART_buffer_full : STD_LOGIC;
signal UART_buffer_half_full : STD_LOGIC;

--SEÑALES para PICO_BLAZE
signal direcc : std_logic_vector(9 downto 0);
signal instruction : std_logic_vector(17 downto 0);
signal writing : std_logic;
signal reading : std_logic;
signal streaming_byte : std_logic_vector(7 downto 0);
signal interrupted : std_logic;

signal interrupt_ack : std_logic;
signal interrupt_ack1 : std_logic;

signal interrupt_ack2 : std_logic;
signal port_id_PICO : std_logic_vector(7 downto 0);

--SEÑALES para registro1
--signal habilitar : STD_LOGIC; -- reemplazado por 'interrupt_ack'

--SEÑALES para registro2
signal habilitar : STD_LOGIC;


component UART_4800 is
    Port ( clk, rst : in STD_LOGIC;
           entrada_serial : in STD_LOGIC;
           leer_data : in STD_LOGIC;
           next_data : in STD_LOGIC;
           data_present : out STD_LOGIC;
           buff_full : out STD_LOGIC;
           buff_half : out STD_LOGIC;
           dato_sal : out STD_LOGIC_VECTOR (7 downto 0));
end component ;


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

RX_UART: UART_4800 
port map (clk => clk, rst => rst, next_data => interrupt_ack1,
	entrada_serial => entrada_serial, dato_sal => streaming_byte,
	leer_data => UART_read_buffer, data_present => UART_buffer_data_present,
   buff_full => UART_buffer_full, buff_half => UART_buffer_half_full);

microcontrolador: top_PB 
port map (write_strobe => writing, out_port => pre_leds, read_strobe => UART_read_buffer,
    in_port => data_IN, interrupt => interrupted, port_id => port_id_PICO,
    interrupt_ack => interrupt_ack, reset => rst, clk => clk);

    
registro2: registro_datos 
port map (clk => clk, rst => rst, in_data=> pre_leds,
    out_data=> leds, habilitador => writing);

  
--necesito una maquinita de estados para determinar cual
--es la se�al FUENTE, la UART � el 'boton estabilizado';
--si es el boton debo Normalizar!.


contr_boton: controlador_boton 
port map (clk => clk, rst => rst, ack => interrupt_ack2,
	pulsador=> pulsador, norm_signal => interrupcion_pulsador);



interrupted <= interrupcion_pulsador or UART_buffer_data_present;
data_IN <= streaming_byte when from_PC = '1' else ("0000"&switchs);

from_PC <= '1' when interrupcion_pulsador = '1' and UART_buffer_data_present = '1' else
			  '0' when interrupcion_pulsador = '1' else '1';
			  
			  
--interrupt_ack1 <= interrupt_ack; -- en realidad debo 
--interrupt_ack2 <= interrupt_ack; -- 

interrupt_ack1 <= interrupt_ack when from_PC = '1' else '0';
interrupt_ack2 <= interrupt_ack when from_PC = '0' else '0';
			
-- debo comunicar a los 2 dispositivos de entrada que estoy 
-- tomando datos 'UART_read_buffer'!
			  
end Behavioral;

