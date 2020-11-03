library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity arith_module is
 generic(Nbit : integer := 8);
 port(	CLK : IN std_logic;
		RST_n : IN std_logic;
		Load : IN std_logic;
		S_in : IN signed(Nbit-1 downto 0);
		Sum_pre : IN signed(Nbit downto 0);
		a : IN signed(Nbit-1 downto 0);
		S_out : OUT signed(Nbit-1 downto 0);
		Sum_out : OUT signed(Nbit downto 0);
		Done : OUT std_logic);	
end entity; 

architecture bhe of arith_module is 

component registro
 GENERIC (N : integer := 8 );
 PORT(	DIN : IN signed((N-1) downto 0);
		clk, rst, LE : IN STD_LOGIC;
		DOUT : OUT signed((N-1) downto 0);
		Done : OUT std_logic);
END component;

signal n : signed(Nbit-1 downto 0) := (others => '0');
signal m16 : signed((Nbit+Nbit-1) downto 0) := (others => '0');
signal m9 : signed(Nbit downto 0) := (others => '0');
signal s : signed(Nbit downto 0) := (others => '0');

begin 

reg: registro generic map(N => 8)
	port map(DIN => S_in, clk => CLK, rst => RST_n, LE => Load, DOUT => n, Done => Done);

m16 <= n * a;
m9 <= m16(15 downto 7);
s <= m9 + sum_pre;
Sum_out <= s;
S_out <= n;

end bhe;	
