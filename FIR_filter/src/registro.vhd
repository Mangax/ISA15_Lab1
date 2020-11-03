library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity registro is 
GENERIC ( N : integer := 5 ); --default 5 bit
PORT(	DIN : IN signed( (N-1) downto 0 );
		clk, rst, LE : IN STD_LOGIC;
		DOUT : OUT signed( (N-1) downto 0 );
		Done : OUT std_logic);
END registro;

ARCHITECTURE Behavior OF registro IS
BEGIN
PROCESS (clk, rst)
BEGIN
	IF (rst = '0') THEN
		dout <= (OTHERS => '0');
	ELSIF (clk'EVENT AND clk = '1') THEN
		if LE = '1' then 
			DOUT <= DIN;
			Done <= '1';
		else
			Done <= '0';
		end if;
	END IF;
END PROCESS;

END Behavior;
