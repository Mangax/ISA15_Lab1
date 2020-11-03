library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity FIR_filter is
	port(	CLK : IN std_logic;
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
end entity; 

architecture bhe of FIR_filter is 

component registro GENERIC (N : integer := 8 );
	PORT(	DIN : IN signed( (N-1) downto 0 );
		clk, rst, LE : IN STD_LOGIC;
		DOUT : OUT signed( (N-1) downto 0 );
		Done : OUT std_logic);
END component;

component arith_module generic(Nbit : integer := 8);
	port(	CLK : IN std_logic;
		RST_n : IN std_logic;
		Load : IN std_logic;
		S_in : IN signed(Nbit-1 downto 0);
		Sum_pre : IN signed(Nbit downto 0);
		a : IN signed(Nbit-1 downto 0);
		S_out : OUT signed(Nbit-1 downto 0);
		Sum_out : OUT signed(Nbit downto 0);
		Done : OUT std_logic);	
end component;  

type coefficients is array (0 to 10) of signed(7 downto 0);
type signal_in is array (0 to 10) of signed(8 downto 0);
type signal_out is array (0 to 10) of signed(7 downto 0);
type enable_signal is array(0 to 10) of std_logic;
type done_signal is array(0 to 10) of std_logic;

signal a : coefficients := (others => (others =>'0'));
signal sumpre : signal_in := (others => (others =>'0'));
signal sout : signal_out := (others => (others =>'0'));
signal enable : enable_signal := (others => '0');
signal done : done_signal := (others => '0');

signal m, s16 : signed(15 downto 0) := (others =>'0');
signal m9, s9 : signed(8 downto 0);

begin
    
a(0) <= a1;
a(1) <= a2;
a(2) <= a3;
a(3) <= a4;
a(4) <= a5;
a(5) <= a6;
a(6) <= a7;
a(7) <= a8;
a(8) <= a9;
a(9) <= a10;
a(10) <= a11;
enable(0) <= VIN; 


reg0: registro generic map(N => 8)
	port map(DIN => DIN, clk => CLK, rst => RST_n, LE => VIN, DOUT => sout(0), Done => done(0));
	
s16 <= sout(0)*a(0);
sumpre(0) <= s16(15 downto 7);

arith: for i in 1 to 9 generate
	reg: arith_module generic map(Nbit => 8)
		port map(CLK=>clk, RST_n=>RST_n, Load=>VIN, S_in=>sout(i-1), Sum_pre=>sumpre(i-1), a=>a(i), S_out=>sout(i), Sum_out=>sumpre(i), Done=>done(i));
end generate arith;
		
reg10: registro generic map(N => 8)
	port map(DIN => sout(9), clk => CLK, rst => RST_n, LE => VIN, DOUT => sout(10), Done => done(10));

VOUT <= VIN;
m <= sout(10)*a(10);
m9 <= m(15 downto 7);
s9 <= m9 + sumpre(9);
DOUT <= resize(s9, 8);

end bhe;



