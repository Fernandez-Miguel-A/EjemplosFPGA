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
           --b : in  STD_LOGIC_VECTOR (7 downto 0);
           leds : out STD_LOGIC_VECTOR (7 downto 0));
end uart_eje1;



architecture Behavioral of uart_eje1 is
--signal count: std_logic_vector(3 downto 0);


--SE�ALES para los leds
signal pre_leds : STD_LOGIC_VECTOR (7 downto 0);

--SE�ALES para los leds
signal byte_to_micro : STD_LOGIC_VECTOR (7 downto 0);

--SE�ALES para registro pre leds
--signal entrada_seg : STD_LOGIC_VECTOR (3 downto 0);
signal datos_entrada : STD_LOGIC_VECTOR (7 downto 0);

--SE�ALES para UART
signal UART_serial_in : STD_LOGIC;
signal UART_data_out : STD_LOGIC_vector(7 downto 0);
signal UART_read_buffer : STD_LOGIC;
signal UART_en_16_x_baud : STD_LOGIC;
signal UART_buffer_data_present : STD_LOGIC;
signal UART_buffer_full : STD_LOGIC;
signal UART_buffer_half_full : STD_LOGIC;

--SE�ALES para PICO_BLAZE
signal direcc : std_logic_vector(9 downto 0);
signal instruction : std_logic_vector(17 downto 0);
signal writing : std_logic;
signal reading : std_logic;
signal streaming_byte : std_logic_vector(7 downto 0);
signal interrupted : std_logic;
signal interrupt_ack : std_logic;

--SE�ALES para registro1
--signal habilitar : STD_LOGIC; -- reemplazado por 'interrupt_ack'

--SE�ALES para registro2
signal habilitar : STD_LOGIC;


--component dec_hex_7_SEG 
--    Port ( entr : in  STD_LOGIC_VECTOR (3 downto 0);
--          sal : out  STD_LOGIC_VECTOR (6 downto 0));   
--end component;


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


component registro_datos is
    Port ( in_data : in  STD_LOGIC_VECTOR (7 downto 0);
           out_data : out  STD_LOGIC_VECTOR (7 downto 0);
           clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           habilitador : in  STD_LOGIC);
end component;

component normalizar_interrupcion is
    Port ( _signal, clk, rst, ack : in  STD_LOGIC;
           norm_signal : out  STD_LOGIC);
end component;


begin

--segmentos: dec_hex_7_SEG 
--port map (entr => entrada_seg, sal => salida_leds);

div_frec: divisor 
port map (clk => clk, rst => rst, clk_4800=> UART_en_16_x_baud);

RX_UART: uart_rx 
port map (serial_in => entrada_serial, data_out => UART_data_out, read_buffer => UART_read_buffer,
    reset_buffer => rst, en_16_x_baud => UART_en_16_x_baud, buffer_data_present => UART_buffer_data_present,
    buffer_full => UART_buffer_full, buffer_half_full => UART_buffer_half_full, clk => clk);

registro1: registro_datos 
port map (clk => clk, rst => rst, in_data=> UART_data_out,
    out_data=> streaming_byte, habilitador => interrupt_ack);
    
    
microcontrolador: top_PB 
port map (write_strobe => writing, out_port => pre_leds, read_strobe => UART_read_buffer,
    in_port => streaming_byte, interrupt => interrupted,
    interrupt_ack => interrupt_ack, reset => rst, clk => clk);

registro2: registro_datos 
port map (clk => clk, rst => rst, in_data=> pre_leds,
    out_data=> leds, habilitador => writing);

    
int1: normalizar_interrupcion 
port map (clk => clk, rst => rst, _signal => UART_buffer_data_present, ack => interrupt_ack, norm_signal => interrupted);


--process(clk, rst)
--begin
--    --if rst = '1' then
--    --    leds <= (others => '0');
--    --els
--    if clk'event and clk = '1' then
--            case datos_entrada is
--                when "00110000" => streaming_byte <= "00000000"; -- 0, par
--                when "00110001" => streaming_byte <= "11111110"; -- 1, impar
--                when "00110010" => streaming_byte <= "00000010"; -- 2, par
--                when "00110011" => streaming_byte <= "11111100"; -- 3, impar
--                when "00110100" => streaming_byte <= "00000100"; -- 4, par
--                when "00110101" => streaming_byte <= "11111010"; -- 5, impar
--                when "00110110" => streaming_byte <= "00000110"; -- 6, par
--                when "00110111" => streaming_byte <= "11111000"; -- 7, impar
--                when "00111000" => streaming_byte <= "00001000"; -- 8, par
--                when "00111001" => streaming_byte <= "11110110"; -- 9, impar
--                when others => streaming_byte <= "11111111";-- todos los leds encendidos
--            end case;
--            --if datos_entrada(7 to 4) = "0011" then
--            --    leds <= datos_entrada;
--            --else
--            --    leds <= "11111111";-- todos los leds encendidos
--            --end if;

--    end if;
--end process;
            


end Behavioral;

