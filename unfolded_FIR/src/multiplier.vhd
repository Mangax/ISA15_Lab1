library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity multiplier is 

generic (Nbit : integer := 8);

port(	ina : IN signed(Nbit-1 downto 0);
	inb : IN signed(Nbit-1 downto 0);
	o : OUT signed(Nbit+Nbit-1 downto 0)
	);
end entity;

architecture bhe of multiplier is 

begin

o <= resize(ina * inb, o'length); 

end bhe;
