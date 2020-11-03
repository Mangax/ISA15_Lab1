library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_textio.all;

library std;
use std.textio.all;

entity data_sink is
  port (CLK   : in std_logic;
    	RST_n : in std_logic;
    	VIN   : in std_logic;
    	DIN3k   : in std_logic_vector(7 downto 0);
    	DIN3k1   : in std_logic_vector(7 downto 0);
    	DIN3k2   : in std_logic_vector(7 downto 0));
end data_sink;

architecture beh of data_sink is

begin  -- beh

  process (CLK, RST_n)
    file res_fp : text open WRITE_MODE is "../data/tb_results.txt";
    variable line_out1 : line;
    variable line_out2 : line;    
    variable line_out3 : line;       
  begin  -- process
    if RST_n = '0' then                 -- asynchronous reset (active low)
      null;
    elsif CLK'event and CLK = '1' then  -- rising clock edge
      if (VIN = '1') then
        write(line_out1, conv_integer(signed(DIN3k)));
        writeline(res_fp, line_out1);
		write(line_out2, conv_integer(signed(DIN3k1)));
        writeline(res_fp, line_out2);
		write(line_out3, conv_integer(signed(DIN3k2)));
        writeline(res_fp, line_out3);
      end if;
    end if;
  end process;

end beh;
