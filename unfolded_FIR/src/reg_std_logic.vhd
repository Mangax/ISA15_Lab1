library ieee;
use ieee.std_logic_1164.all;

entity reg_std_logic is 
port (	CLK : IN std_logic;
		RST_n : IN std_logic;
		S_in : IN std_logic;
		S_out : OUT std_logic);
end reg_std_logic;

architecture bhe of reg_std_logic is 

begin
process(CLK, RST_n)
begin 
	if (RST_n = '0') then S_out <= '0';
	elsif (rising_edge(CLK)) then S_out <= S_in; 
	end if; 
end process;

end bhe;  
