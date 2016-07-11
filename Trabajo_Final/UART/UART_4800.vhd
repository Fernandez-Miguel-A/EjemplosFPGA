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

entity UART_4800 is
    Port ( clk, rst : in STD_LOGIC;
           entrada_serial : in STD_LOGIC;
           leer_data : in STD_LOGIC;
           next_data : in STD_LOGIC;
           data_present : out STD_LOGIC;
           buff_full : out STD_LOGIC;
           buff_half : out STD_LOGIC;
           dato_sal : out STD_LOGIC_VECTOR (7 downto 0));
end UART_4800 ;



architecture Behavioral of UART_4800 is
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
signal UART_en_16_x_baud : STD_LOGIC;
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
signal interrupt_ack1 : std_logic;

signal interrupt_ack2 : std_logic;
signal port_id_PICO : std_logic_vector(7 downto 0);

--SEÑALES para registro1
--signal habilitar : STD_LOGIC; -- reemplazado por 'interrupt_ack'

--SEÑALES para registro2
signal habilitar : STD_LOGIC;



component divisor is
    Port ( clk, rst : in STD_LOGIC;
            clk_4800 : out STD_LOGIC);
end component;



component uart_rx 
    Port (            serial_in : in std_logic;
                       data_out : out std_logic_vector(7 downto 0);
                    read_buffer : in std_logic;
                   reset_buffer : in std_logic;
                   en_16_x_baud : in std_logic;
            buffer_data_present : out std_logic;
                    buffer_full : out std_logic;
               buffer_half_full : out std_logic;
                            clk : in std_logic);
end component;


component registro_datos is --  de trabajo_UART
    Port ( in_data : in  STD_LOGIC_VECTOR (7 downto 0);
           out_data : out  STD_LOGIC_VECTOR (7 downto 0);
           clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           habilitador : in  STD_LOGIC);
end component;


begin

div_frec: divisor 
port map (clk => clk, rst => rst, clk_4800=> UART_en_16_x_baud);

RX_UART: uart_rx 
port map (serial_in => entrada_serial, data_out => UART_data_out, read_buffer => leer_data,
    reset_buffer => rst, en_16_x_baud => UART_en_16_x_baud, buffer_data_present => data_present,
    buffer_full => buff_full, buffer_half_full => buff_half, clk => clk);


--registro1: registro_datos 
--port map (clk => clk, rst => rst, in_data=> UART_data_out,
--    out_data=> dato_sal, habilitador => next_data); 
dato_sal <= UART_data_out;
	  
end Behavioral;

