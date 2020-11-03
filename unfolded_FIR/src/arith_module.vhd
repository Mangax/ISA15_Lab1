library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity arith_module is
 generic(
 Nbit : integer := 8);
 port (	S_in : IN signed(Nbit-1 downto 0);
	Sum_pre : IN signed(Nbit downto 0);
	a : IN signed(Nbit-1 downto 0);
	Sum_out : OUT signed(Nbit downto 0)); 	-- modified
end entity; 

architecture bhe of arith_module is 

component multiplier
generic (Nbit : integer := 8);

port(	ina : IN signed(Nbit-1 downto 0);
	inb : IN signed(Nbit-1 downto 0);
	o : OUT signed(Nbit+Nbit-1 downto 0)
	);
end component;

signal m : signed((Nbit+Nbit-1) downto 0) := (others => '0');

begin 

mx : multiplier port map (S_in, a, m); 
--m <= S_in * a;
Sum_out <= m(Nbit+Nbit-1 downto Nbit-1) + Sum_pre; -- modified


end bhe;	
