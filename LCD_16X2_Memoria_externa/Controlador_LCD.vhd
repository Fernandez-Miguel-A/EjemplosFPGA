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
            --getROM_DATA : in  STD_LOGIC;
				--led1 : out STD_LOGIC;
				--led2 : out STD_LOGIC;
				--led3 : out STD_LOGIC;
				--led4 : out STD_LOGIC;
				leds : out STD_LOGIC_VECTOR (7 downto 0);
            strataflash : out STD_LOGIC_VECTOR (2 downto 0);
            LCD_IO : out STD_LOGIC_VECTOR (6 downto 0));
end CTRL_LCD;



architecture Behavioral of CTRL_LCD is
signal out_Pico : STD_LOGIC_VECTOR (7 downto 0);
signal reading : std_logic;
signal writing : std_logic;
signal data_IN : STD_LOGIC_VECTOR (7 downto 0);
signal interrupcion_pulsador: std_logic;

signal next_data : std_logic;
signal interrupt_ack : std_logic;
signal out_REG : std_logic_vector(7 downto 0);
signal port_id_PICO : std_logic_vector(7 downto 0);

signal LCD_RW : STD_LOGIC;
signal ControlZ : STD_LOGIC;

signal direccion : std_logic_vector(3 downto 0); --integer
signal first_direc : STD_LOGIC;
signal next_direc : STD_LOGIC;
signal dato_rom : STD_LOGIC_VECTOR (7 downto 0);

signal cuenta: std_logic_vector(3 downto 0);

signal led11 : STD_LOGIC;
signal led22 : STD_LOGIC;
signal passed: STD_LOGIC;
signal HIGH : STD_LOGIC;

signal habilitador : STD_LOGIC;
signal direccion2 : integer; 
signal estable : STD_LOGIC;
signal dato_rom2 : STD_LOGIC_VECTOR (7 downto 0);


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

component antiReb is
    Port (p, clk, rst : in  std_logic;
			Estable_p : out  std_logic);
end component;

begin

microcontrolador: top_PB 
port map (write_strobe => writing, out_port => out_Pico, in_port => data_IN,
     interrupt => interrupcion_pulsador, port_id => port_id_PICO, reset => rst,
    interrupt_ack => interrupt_ack, read_strobe => reading, clk => clk);

    
registro2: registro_datos 
port map (clk => clk, rst => rst, in_data=> out_Pico,
    out_data=> out_REG, habilitador => next_data);

contr_boton: controlador_boton 
port map (clk => clk, rst => rst, ack => interrupt_ack,
    pulsador=> pulsador, norm_signal => interrupcion_pulsador);
  
memoria: MROM 
port map (dir => direccion, datos => dato_rom);



--antiRebote: antiReb 
--port map (clk => clk, rst => rst,
--    p=> getROM_DATA, Estable_p => estable);
  
--memoria2: MROM 
--port map (dir => direccion2, datos => dato_rom2);



--data_IN(3 downto 0) <= switchs;
next_data <= port_id_PICO(6) and writing and (not port_id_PICO(2));
LCD_RW <= out_REG(1) and out_REG(3);
ControlZ <= not(out_REG(1)) and out_REG(3); 
LCD_IO(6 downto 3) <= out_REG (7 downto 4) when ControlZ = '1' else (others =>'Z');
LCD_IO(2 downto 0) <= out_REG (2) & LCD_RW & out_REG (0);

strataflash <= (others => '1');


--seccion memoria externa
next_direc <= port_id_PICO(2) and reading and (not port_id_PICO(6));

process(clk,rst)
begin
if rst = '1' then
    direccion <= (others => '0');
	 habilitador <= '0';
	 passed <= '0';
elsif clk = '1' and clk'event then
	 if next_direc = '1' and passed = '0' then
		 passed <= '1'; -- la señal dura 40 ms, de no BLOQUEAR
		 -- se incrementaría a la velocidad del clock la señal 'direccion'
		 if CONV_INTEGER(direccion) > 12 then
				direccion <= (others => '0');
		 else
				direccion <= direccion + 1;
		 end if;
	 elsif next_direc = '0' and passed = '1' then
		 passed <= '0';
    end if;
end if;
end process;


process(reading, writing, rst)
begin
if next_direc = '1' then
	data_IN <= dato_rom;
else
	data_IN(6 downto 4) <= (others => '0');
	data_IN(3 downto 0) <= switchs;
end if ;
end process;


leds <= "0000"&direccion;
end Behavioral;

