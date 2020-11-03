library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_signed.all;
use ieee.numeric_std.all;
library std;
use std.textio.all;


entity FIR_bench is
end FIR_bench;

architecture test of FIR_bench is

component FIR_filter is
port(
	CLK : IN std_logic;
	RST_n : IN std_logic;
	VIN : IN std_logic;
	DIN : IN signed(7 downto 0);
	a1 : IN signed(7 downto 0);
	a2 : IN signed(7 downto 0);
	a3 : IN signed(7 downto 0);
	a4 : IN signed(7 downto 0);
	a5 : IN signed(7 downto 0);
	a6 : IN signed(7 downto 0);
	a7 : IN signed(7 downto 0);
	a8 : IN signed(7 downto 0);
	a9 : IN signed(7 downto 0);
	a10 : IN signed(7 downto 0);
	a11 : IN signed(7 downto 0);
	DOUT : OUT signed(7 downto 0);
	VOUT : OUT std_logic);


end component; 

signal clk : std_logic := '1';
signal rst_n, vin, vout : std_logic := '0';
signal a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11 : signed(7 downto 0); 
signal s_in : signed(7 downto 0);
signal s_out : signed(7 downto 0);

begin 

	a1 <= "11111111";
	a2 <= "11111110";
	a3 <= "11111100";
	a4 <= "00001000";
	a5 <= "00100011";
	a6 <= "00110010";
	a7 <= "00100011";
	a8 <= "00001000";
	a9 <= "11111100";
	a10 <= "11111110";
	a11 <= "11111111";

	clock : process
	begin
	clk <= not clk;
	wait for 10 ns; 
	end process;

	reset : process
	begin
	rst_n <= '0';
	vin <= '0';
	wait for 10 ns; 
	rst_n <= '1';
	wait for 2 ns;
	vin <= '1';	
	wait for 98 ns;
	vin <= '0';
	wait for 20 ns;
	vin <= '1';
	wait;
	end process; 

	read_file : process(clk, rst_n, vin)	
		file fpi : text open read_mode is "../data/samples.txt";
		variable lni : line; 
		variable sample : integer; 

	begin
		if rst_n = '0' then
			s_in <= (others => '0');
				
		elsif rising_edge(clk) then
			if not endfile(fpi) then
				if (VIN = '1') then
					readline(fpi,lni); 
					read(lni, sample);
					s_in <= to_signed(sample, s_in'length);
				end if;
			end if;
		end if;

	end process;

	DUT : FIR_filter port map(clk, rst_n, vin, s_in, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, s_out, vout);

	write_result : process (clk, rst_n, vin)
		file fpo : text open write_mode is "../data/results_Vin_a_zero.txt";
		variable lno : line; 
		variable sample_out : integer;
	begin 
		if RST_n = '0' then
			null;
			
		elsif (rising_edge(clk)) then 
			if (VIN = '1') then
				sample_out := to_integer(s_out);
				write(lno, sample_out);
				writeline(fpo, lno);
			end if;
		end if;
	end process; 

end test;
