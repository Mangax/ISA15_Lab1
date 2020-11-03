library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity FIR_filter is
  generic(
	Nbit : integer := 8);

  port(
	CLK : IN std_logic;
	RST_n : IN std_logic;
	VIN : IN std_logic;
	DIN : IN signed(Nbit-1 downto 0);
	H0 : IN signed(Nbit-1 downto 0);
	H1 : IN signed(Nbit-1 downto 0);
	H2 : IN signed(Nbit-1 downto 0);
	H3 : IN signed(Nbit-1 downto 0);
	H4 : IN signed(Nbit-1 downto 0);
	H5 : IN signed(Nbit-1 downto 0);
	H6 : IN signed(Nbit-1 downto 0);
	H7 : IN signed(Nbit-1 downto 0);
	H8 : IN signed(Nbit-1 downto 0);
	H9 : IN signed(Nbit-1 downto 0);
	H10 : IN signed(Nbit-1 downto 0);
	DOUT : OUT signed((Nbit-1) downto 0);
	VOUT : OUT std_logic);

end entity; 

architecture bhe of FIR_filter is 

component reg is 
generic(
	Nbit : integer := 8);

port (
	CLK : IN std_logic;
	RST_n : IN std_logic;
	Load : IN std_logic;
	S_in : IN signed (Nbit-1 downto 0);
	S_out : OUT signed(Nbit-1 downto 0)
	);
end component;

component multiplier
generic (Nbit : integer := 8);

port(
	ina : IN signed(Nbit-1 downto 0);
	inb : IN signed(Nbit-1 downto 0);
	o : OUT signed(Nbit+Nbit-1 downto 0)
	);
end component;

component  arith_module is
 generic(
 Nbit : integer := 8);

 port(
	S_in : IN signed(Nbit-1 downto 0);
	Sum_pre : IN signed(Nbit downto 0);
	a : IN signed(Nbit-1 downto 0);
	Sum_out : OUT signed(Nbit downto 0)); 	-- modified

end component; 


signal t1,t2,t3,t4,t5,t6,t7,t8,t9,t10 : signed(Nbit downto 0) := (others => '0'); -- sum signals 
signal s0,s1,s2,s3,s4,s5,s6,s7,s8,s9,s10 : signed(Nbit-1 downto 0) := (others => '0'); -- samples signals
signal m : signed(Nbit+Nbit-1 downto 0) := (others => '0'); -- multiplication signal

begin 

R_0 : reg port map (CLK, RST_n, VIN , DIN, s0);
mx : multiplier port map (s0, H0, m);

R_1 : reg port map (CLK, RST_n, VIN, s0, s1);
M_1 : arith_module port map (s1, m(Nbit+Nbit-1 downto Nbit-1), H1, t1);

R_2 : reg port map (CLK, RST_n, VIN, s1, s2);
M_2 : arith_module port map (s2, t1, H2, t2);

R_3 : reg port map (CLK, RST_n, VIN, s2, s3);
M_3 : arith_module port map (s3, t2, H3, t3);

R_4 : reg port map (CLK, RST_n, VIN, s3, s4);
M_4 : arith_module port map (s4, t3, H4, t4);

R_5 : reg port map (CLK, RST_n, VIN, s4, s5);
M_5 : arith_module port map (s5, t4, H5, t5);

R_6 : reg port map (CLK, RST_n, VIN, s5, s6);
M_6 : arith_module port map (s6, t5, H6, t6);

R_7 : reg port map (CLK, RST_n, VIN, s6, s7);
M_7 : arith_module port map (s7, t6, H7, t7);

R_8 : reg port map (CLK, RST_n, VIN, s7, s8);
M_8 : arith_module port map (s8, t7, H8, t8);

R_9 : reg port map (CLK, RST_n, VIN, s8, s9);
M_9 : arith_module port map (s9, t8, H9, t9);

R_10 : reg port map (CLK, RST_n, VIN, s9, s10);
M_10 : arith_module port map (s10, t9, H10, t10);


DOUT <= resize(t10, DOUT'length);

process(CLK, RST_n)
begin 
if(RST_n = '0') then 
	VOUT <= '0';
elsif (rising_edge(CLK)) then 
	if (VIN = '1') then
	  VOUT <= '1'; 
	else 
	  VOUT <= '0';
	end if; 
end if;
end process;
				
end bhe;