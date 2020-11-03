library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity FIR_scheme is
  port(	IN0 : IN signed(7 downto 0);
	IN1 : IN signed(7 downto 0);
	IN2 : IN signed(7 downto 0);
	IN3 : IN signed(7 downto 0);
	IN4 : IN signed(7 downto 0);
	IN5 : IN signed(7 downto 0);
	IN6 : IN signed(7 downto 0);
	IN7 : IN signed(7 downto 0);
	IN8 : IN signed(7 downto 0);
	IN9 : IN signed(7 downto 0);
	IN10 : IN signed(7 downto 0);
	H0 : IN signed(7 downto 0);
	H1 : IN signed(7 downto 0);
	H2 : IN signed(7 downto 0);
	H3 : IN signed(7 downto 0);
	H4 : IN signed(7 downto 0);
	H5 : IN signed(7 downto 0);
	H6 : IN signed(7 downto 0);
	H7 : IN signed(7 downto 0);
	H8 : IN signed(7 downto 0);
	H9 : IN signed(7 downto 0);
	H10 : IN signed(7 downto 0);
	DOUT : OUT signed(7 downto 0));
end entity;

architecture bhe of fir_scheme is

component  arith_module is
  generic( Nbit : integer := 8);
  port(	S_in : IN signed(Nbit-1 downto 0);
	Sum_pre : IN signed(Nbit downto 0);
	a : IN signed(Nbit-1 downto 0);
	Sum_out : OUT signed(Nbit downto 0));
end component; 

signal s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11 : signed(8 downto 0);
signal s0 : signed(15 downto 0);

begin

s0 <= H0*IN0;
s1 <= s0(15 downto 7);

arith1: arith_module generic map(Nbit => 8) port map(IN1,s1,H1,s2);
arith2: arith_module generic map(Nbit => 8) port map(IN2,s2,H2,s3);
arith3: arith_module generic map(Nbit => 8) port map(IN3,s3,H3,s4);
arith4: arith_module generic map(Nbit => 8) port map(IN4,s4,H4,s5);
arith5: arith_module generic map(Nbit => 8) port map(IN5,s5,H5,s6);
arith6: arith_module generic map(Nbit => 8) port map(IN6,s6,H6,s7);
arith7: arith_module generic map(Nbit => 8) port map(IN7,s7,H7,s8);
arith8: arith_module generic map(Nbit => 8) port map(IN8,s8,H8,s9);
arith9: arith_module generic map(Nbit => 8) port map(IN9,s9,H9,s10);
arith10: arith_module generic map(Nbit => 8) port map(IN10,s10,H10,s11);

DOUT <= resize(s11, 8);

end bhe;

