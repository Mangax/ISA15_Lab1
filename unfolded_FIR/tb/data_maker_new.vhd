library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_textio.all;
--use numeric_std.all;

library std;
use std.textio.all;

entity data_maker is  
  port (CLK : in  std_logic;
    	RST_n : in  std_logic;
    	VOUT : out std_logic;
    	DOUT3k : out std_logic_vector(7 downto 0);
    	DOUT3k1 : out std_logic_vector(7 downto 0);
    	DOUT3k2 : out std_logic_vector(7 downto 0);
    	H0 : OUT signed(7 downto 0);
	H1 : OUT signed(7 downto 0);
	H2 : OUT signed(7 downto 0);
	H3 : OUT signed(7 downto 0);
	H4 : OUT signed(7 downto 0);
	H5 : OUT signed(7 downto 0);
	H6 : OUT signed(7 downto 0);
	H7 : OUT signed(7 downto 0);
	H8 : OUT signed(7 downto 0);
	H9 : OUT signed(7 downto 0);
	H10 : OUT signed(7 downto 0);
    	END_SIM : out std_logic);
end data_maker;

architecture beh of data_maker is

  constant tco : time := 1 ns;

  signal sEndSim : std_logic;
  signal END_SIM_i : std_logic_vector(0 to 10);  

begin  -- beh

  H0 <= "11111111";
  H1 <= "11111110";
  H2 <= "11111100";
  H3 <= "00001000";
  H4 <= "00100011";
  H5 <= "00110010";
  H6 <= "00100011";
  H7 <= "00001000";
  H8 <= "11111100";
  H9 <= "11111110";
  H10 <= "11111111"; 

  process (CLK, RST_n)
    file fp_in : text open READ_MODE is "../data/samples.txt";
    variable line_in1,line_in2,line_in3 : line;
    variable x,y,z : integer;
  begin  -- process
    if RST_n = '0' then                 -- asynchronous reset (active low)
      DOUT3k <= (others => '0') after tco;
      DOUT3k1 <= (others => '0') after tco;      
      DOUT3k2 <= (others => '0') after tco;      
      VOUT <= '0' after tco;
      sEndSim <= '0' after tco;
    elsif CLK'event and CLK = '1' then  -- rising clock edge
      if not endfile(fp_in) then
        readline(fp_in, line_in1);
        readline(fp_in, line_in2);
        readline(fp_in, line_in3);
        read(line_in1, x);
        read(line_in2, y);
        read(line_in3, z);
        DOUT3k <= conv_std_logic_vector(x, 8) after tco;
        DOUT3k1 <= conv_std_logic_vector(y, 8) after tco;
        DOUT3k2 <= conv_std_logic_vector(z, 8) after tco;
        VOUT <= '1' after tco;
        sEndSim <= '0' after tco;
      else
        VOUT <= '0' after tco;        
        sEndSim <= '1' after tco;
      end if;
    end if;
  end process;

  process (CLK, RST_n)
  begin  -- process
    if RST_n = '0' then                 -- asynchronous reset (active low)
      END_SIM_i <= (others => '0') after tco;
    elsif CLK'event and CLK = '1' then  -- rising clock edge
      END_SIM_i(0) <= sEndSim after tco;
      END_SIM_i(1 to 10) <= END_SIM_i(0 to 9) after tco;
    end if;
  end process;

  END_SIM <= END_SIM_i(10);  

end beh;
