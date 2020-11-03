library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity arith_module is
 generic(
 Nbit : integer := 8);
 port (	CLK : IN std_logic;
		RST_n : IN std_logic;
		VIN : IN std_logic;
		S_in : IN signed(Nbit-1 downto 0);
		Sum_pre : IN signed(Nbit downto 0);
		a : IN signed(Nbit-1 downto 0);
		Sum_out : OUT signed(Nbit downto 0)); 	-- modified
end entity; 

architecture bhe of arith_module is 

component reg
generic( Nbit : integer := 8);

port ( 	CLK : IN std_logic;
		RST_n : IN std_logic;
		Load : IN std_logic;
		S_in : IN signed (Nbit-1 downto 0);
		S_out : OUT signed(Nbit-1 downto 0));
end component;

component multiplier
generic (Nbit : integer := 8);

port(	ina : IN signed(Nbit-1 downto 0);
		inb : IN signed(Nbit-1 downto 0);
		o : OUT signed(Nbit+Nbit-1 downto 0));
end component;

signal m : signed((Nbit+Nbit-1) downto 0) := (others => '0');
signal p_m : signed((Nbit+Nbit-1) downto 0) := (others => '0');

begin 
mx : multiplier port map (S_in, a, m); 

reg_m: reg generic map(Nbit => 16) port map(CLK,RST_n,VIN,m,p_m);

Sum_out <= p_m(Nbit+Nbit-1 downto Nbit-1) + Sum_pre;


end bhe;	
