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

entity Sistema is
    Port ( clk, rst : in  STD_LOGIC;
           entrada_serial : in  STD_LOGIC;
			  switchs : in  STD_LOGIC_VECTOR (3 downto 0);
           pulsador : in  STD_LOGIC;
           leds : out STD_LOGIC_VECTOR (7 downto 0);
           strataflash : out STD_LOGIC_VECTOR (2 downto 0);
           LCD_IO : out STD_LOGIC_VECTOR (6 downto 0));
end Sistema;



architecture Behavioral of Sistema is
signal interrupcion_pulsador: std_logic;
signal data_SWITCH : STD_LOGIC_VECTOR (7 downto 0);
signal data_UART : STD_LOGIC_VECTOR (7 downto 0);
--
signal data_IN : STD_LOGIC_VECTOR (7 downto 0);
signal streaming_BYTE : STD_LOGIC_VECTOR (7 downto 0);

signal salida_principal_H: std_logic;
signal buf_salida_principal_H : std_logic;
signal switch_UART_H : STD_LOGIC;
signal buf_switch_UART_H : STD_LOGIC;

signal Enable : STD_LOGIC;

signal out_micro : STD_LOGIC_VECTOR (7 downto 0);
signal reg_out_PBlaze : STD_LOGIC_VECTOR (7 downto 0);
signal pre_leds : STD_LOGIC_VECTOR (7 downto 0);
signal TO_LEDS : STD_LOGIC_VECTOR (7 downto 0);

--SEÃ‘ALES para UART
signal UART_read_buffer : STD_LOGIC;
signal UART_buffer_data_present : STD_LOGIC;
signal UART_buffer_full : STD_LOGIC;
signal UART_buffer_half_full : STD_LOGIC;

--SEÃ‘ALES para PICO_BLAZE
signal reading : std_logic;
signal writing : std_logic;
signal interrupted : std_logic;

signal interrupt_ack : std_logic;
signal interrupt_UART : std_logic;
signal interrupt_PULSADOR : std_logic;

--Memoria Interna
signal direccion : std_logic_vector(3 downto 0); --integer
signal dato_rom : STD_LOGIC_VECTOR (7 downto 0);

--LCD
signal passed: STD_LOGIC;
signal next_data : std_logic;
signal buf_next_direc : std_logic;
signal buf_next_data : std_logic;
signal out_REG : std_logic_vector(7 downto 0);
signal port_id_PICO : std_logic_vector(7 downto 0);

signal LCD_RW : STD_LOGIC;
signal ControlZ : STD_LOGIC;

signal next_direc : STD_LOGIC;



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

component MROM is 
	port ( dir : in std_logic_vector(3 downto 0); 
			datos : out std_logic_vector(7 downto 0) );  
end component; 



begin

RX_UART: UART_4800 
port map (clk => clk, rst => rst, next_data => interrupt_UART,
	entrada_serial => entrada_serial, dato_sal => streaming_BYTE,
	leer_data => interrupt_UART, data_present => UART_buffer_data_present,
   buff_full => UART_buffer_full, buff_half => UART_buffer_half_full);
	 
microcontrolador: top_PB 
port map (write_strobe => writing, out_port => out_micro, read_strobe => reading,--UART_read_buffer,
    in_port => data_IN, interrupt => interrupted, port_id => port_id_PICO,
    interrupt_ack => interrupt_ack, reset => rst, clk => clk);

    
registro_salida_PBlaze: registro_datos 
port map (clk => clk, rst => rst, in_data=> out_micro,
    out_data=> reg_out_PBlaze, habilitador => writing);


registro_salida_PBlaze_Princ: registro_datos 
port map (clk => clk, rst => rst, in_data=> reg_out_PBlaze,
    out_data=> pre_leds, habilitador => buf_salida_principal_H);

registro_salida_PBlaze_LCD: registro_datos 
port map (clk => clk, rst => rst, in_data=> reg_out_PBlaze,
    out_data=> out_REG, habilitador => buf_next_data);



contr_boton: controlador_boton 
port map (clk => clk, rst => rst, ack => interrupt_PULSADOR,
	pulsador=> pulsador, norm_signal => interrupcion_pulsador);


memoria_strings: MROM 
port map (dir => direccion, datos => dato_rom);


salida_principal_H <= port_id_PICO(0) and (not port_id_PICO(6)) and writing;


process(clk, rst)
begin
if clk = '1' and clk'event then
	buf_salida_principal_H <= salida_principal_H;
	buf_next_data <= next_data;
end if;
end process;


switch_UART_H <= buf_switch_UART_H;
next_direc <= buf_next_direc;


TO_LEDS <= pre_leds when CONV_INTEGER(direccion) = 0 else "0000"&direccion;
leds <= TO_LEDS;

data_SWITCH <= "0000"&switchs;
data_UART <= '1'&streaming_BYTE(6 downto 0);


interrupted <= interrupcion_pulsador or UART_buffer_data_present;


interrupt_UART <= interrupt_ack when UART_buffer_data_present = '1' else '0';
interrupt_PULSADOR <= interrupt_ack;

buf_switch_UART_H <= port_id_PICO(0) and (not port_id_PICO(2)) and reading;


UART_and_SWITCHs: process(clk, rst)
begin
if rst = '1' then
	data_IN <= dato_rom;
elsif clk = '1' and clk'event then
		if Enable = '1' then
			data_IN <= dato_rom;
		elsif Enable = '0' and interrupcion_pulsador = '1' and UART_buffer_data_present = '0' then
			data_IN <= data_SWITCH;
		elsif Enable = '0' and interrupcion_pulsador = '0' and UART_buffer_data_present = '1' then -- FUENTE_I = from_PC
			data_IN <= data_UART;
		end if;
end if;
end process;

--*****************************************************--
--Controlador LCD
next_data <= port_id_PICO(6) and (not port_id_PICO(0)) and writing;
LCD_RW <= out_REG(1) and out_REG(3);
ControlZ <= not(out_REG(1)) and out_REG(3); 
LCD_IO(6 downto 3) <= out_REG (7 downto 4) when ControlZ = '1' else (others =>'Z');
LCD_IO(2 downto 0) <= out_REG (2) & LCD_RW & out_REG (0);

strataflash <= (others => '1');


--seccion memoria externa
buf_next_direc <= port_id_PICO(2) and (not port_id_PICO(0)) and reading;--buf_
process(clk,rst)
begin
if rst = '1' then
    direccion <= (others => '0');
	 passed <= '0';
	 Enable <= '1';
elsif clk = '1' and clk'event then
	 if next_direc = '1' and passed = '0' then
		 passed <= '1'; -- la señal dura 40 ms, de no BLOQUEAR
		 -- se incrementaría a la velocidad del clock la señal 'direccion'
		 if CONV_INTEGER(direccion) > 12 then -- 0 to len(string)-1
				direccion <= (others => '0');
				Enable <= '0';
		 else
				direccion <= direccion + x"1";
		 end if;
	 elsif next_direc = '0' and passed = '1' then
		 passed <= '0';
    end if;
end if;
end process;
--*****************************************************--


end Behavioral;
