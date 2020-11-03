library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg is 
generic(
	Nbit : integer := 8);

port (
	CLK : IN std_logic;
	RST_n : IN std_logic;
	Load : IN std_logic;
	S_in : IN signed (Nbit-1 downto 0);
	S_out : OUT signed(Nbit-1 downto 0)
	);
end reg;

architecture bhe of reg is 

begin

process(CLK, RST_n)

begin 
	if (RST_n = '0') then
 
		S_out <= (others => '0');
	
	elsif (rising_edge(CLK)) then
		if (Load = '1') then 
			S_out <= S_in; 
		end if; 
	end if; 
end process;

end bhe;  
