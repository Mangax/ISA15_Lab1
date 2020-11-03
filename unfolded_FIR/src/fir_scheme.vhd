library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity FIR_scheme is
  port(	CLK : IN std_logic;
		RST_n : IN std_logic;
		VIN : IN std_logic_vector(5 downto 0);
		IN0 : IN signed(7 downto 0);
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

component reg
generic( Nbit : integer := 8);

port ( 	CLK : IN std_logic;
		RST_n : IN std_logic;
		Load : IN std_logic;
		S_in : IN signed (Nbit-1 downto 0);
		S_out : OUT signed(Nbit-1 downto 0));
end component;

component  arith_module is
  generic( Nbit : integer := 8);
  port(	CLK : IN std_logic;
		RST_n : IN std_logic;
		VIN : IN std_logic;
		S_in : IN signed(Nbit-1 downto 0);
		Sum_pre : IN signed(Nbit downto 0);
		a : IN signed(Nbit-1 downto 0);
		Sum_out : OUT signed(Nbit downto 0));
	end component; 

signal s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11 : signed(8 downto 0);
signal s0,p_s0 : signed(15 downto 0);
signal p_in3,p_in4,p_in5,p_in6,p_in7,p_in8,p_in9,p_in10 : signed(7 downto 0);
signal p2_in5,p2_in6,p2_in7,p2_in8,p2_in9,p2_in10 : signed(7 downto 0);
signal p3_in7,p3_in8,p3_in9,p3_in10 : signed(7 downto 0);
signal p4_in9,p4_in10 : signed(7 downto 0);
signal p_s3,p_s5,p_s7,p_s9 : signed(8 downto 0);

begin

s0 <= H0*IN0;
reg_s0: reg generic map(Nbit => 16) port map(CLK,RST_n,VIN(1),s0,p_s0);

s1 <= p_s0(15 downto 7);

arith1: arith_module generic map(Nbit => 8) port map(CLK,RST_n,VIN(1),IN1,s1,H1,s2);
arith2: arith_module generic map(Nbit => 8) port map(CLK,RST_n,VIN(1),IN2,s2,H2,s3);

-- Primo livello di pipe
reg_in3: reg generic map(Nbit => 8) port map(CLK,RST_n,VIN(2),IN3,p_in3);
reg_in4: reg generic map(Nbit => 8) port map(CLK,RST_n,VIN(2),IN4,p_in4);
reg_in5: reg generic map(Nbit => 8) port map(CLK,RST_n,VIN(2),IN5,p_in5);
reg_in6: reg generic map(Nbit => 8) port map(CLK,RST_n,VIN(2),IN6,p_in6);
reg_in7: reg generic map(Nbit => 8) port map(CLK,RST_n,VIN(2),IN7,p_in7);
reg_in8: reg generic map(Nbit => 8) port map(CLK,RST_n,VIN(2),IN8,p_in8);
reg_in9: reg generic map(Nbit => 8) port map(CLK,RST_n,VIN(2),IN9,p_in9);
reg_in10: reg generic map(Nbit => 8) port map(CLK,RST_n,VIN(2),IN10,p_in10);
reg_s3 : reg generic map(Nbit => 9) port map(CLK,RST_n,VIN(2),s3,p_s3);

arith3: arith_module generic map(Nbit => 8) port map(CLK,RST_n,VIN(2),p_in3,p_s3,H3,s4);
arith4: arith_module generic map(Nbit => 8) port map(CLK,RST_n,VIN(2),p_in4,s4,H4,s5);

-- Secondo livello di pipe
reg2_in5: reg generic map(Nbit => 8) port map(CLK,RST_n,VIN(3),p_in5,p2_in5);
reg2_in6: reg generic map(Nbit => 8) port map(CLK,RST_n,VIN(3),p_in6,p2_in6);
reg2_in7: reg generic map(Nbit => 8) port map(CLK,RST_n,VIN(3),p_in7,p2_in7);
reg2_in8: reg generic map(Nbit => 8) port map(CLK,RST_n,VIN(3),p_in8,p2_in8);
reg2_in9: reg generic map(Nbit => 8) port map(CLK,RST_n,VIN(3),p_in9,p2_in9);
reg2_in10: reg generic map(Nbit => 8) port map(CLK,RST_n,VIN(3),p_in10,p2_in10);
reg_s5 : reg generic map(Nbit => 9) port map(CLK,RST_n,VIN(3),s5,p_s5);

arith5: arith_module generic map(Nbit => 8) port map(CLK,RST_n,VIN(3),p2_in5,p_s5,H5,s6);
arith6: arith_module generic map(Nbit => 8) port map(CLK,RST_n,VIN(3),p2_in6,s6,H6,s7);

-- Terzo livello di pipe
reg3_in7: reg generic map(Nbit => 8) port map(CLK,RST_n,VIN(4),p2_in7,p3_in7);
reg3_in8: reg generic map(Nbit => 8) port map(CLK,RST_n,VIN(4),p2_in8,p3_in8);
reg3_in9: reg generic map(Nbit => 8) port map(CLK,RST_n,VIN(4),p2_in9,p3_in9);
reg3_in10: reg generic map(Nbit => 8) port map(CLK,RST_n,VIN(4),p2_in10,p3_in10);
reg_s7 : reg generic map(Nbit => 9) port map(CLK,RST_n,VIN(4),s7,p_s7);

arith7: arith_module generic map(Nbit => 8) port map(CLK,RST_n,VIN(4),p3_in7,p_s7,H7,s8);
arith8: arith_module generic map(Nbit => 8) port map(CLK,RST_n,VIN(4),p3_in8,s8,H8,s9);

-- Quarto livello di pipe
reg4_in9: reg generic map(Nbit => 8) port map(CLK,RST_n,VIN(5),p3_in9,p4_in9);
reg4_in10: reg generic map(Nbit => 8) port map(CLK,RST_n,VIN(5),p3_in10,p4_in10);
reg4_s9: reg generic map(Nbit => 9) port map(CLK,RST_n,VIN(5),s9,p_s9);

arith9: arith_module generic map(Nbit => 8) port map(CLK,RST_n,VIN(5),p4_in9,p_s9,H9,s10);
arith10: arith_module generic map(Nbit => 8) port map(CLK,RST_n,VIN(5),p4_in10,s10,H10,s11);

DOUT <= resize(s11, 8);

end bhe;

