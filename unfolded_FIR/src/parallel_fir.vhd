library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity parallel_fir is
  port(	CLK : IN std_logic;
	RST_n : IN std_logic;
	VIN : IN std_logic;
	IN3k : IN signed(7 downto 0);
	IN3k1 : IN signed(7 downto 0);
	IN3k2 : IN signed(7 downto 0);
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
	OUT3k : OUT signed(7 downto 0);
	OUT3k1 : OUT signed(7 downto 0);
	OUT3k2 : OUT signed(7 downto 0);
	VOUT : OUT std_logic);
end parallel_fir;

architecture bhe of parallel_fir is

component fir_scheme
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
end component;

component reg 
  generic(	Nbit : integer := 8);
  port (	CLK : IN std_logic;
		RST_n : IN std_logic;
		Load : IN std_logic;
		S_in : IN signed (Nbit-1 downto 0);
		S_out : OUT signed(Nbit-1 downto 0));
end component;

signal k_0,k_1,k_2,k_3,k1_0,k1_1,k1_2,k1_3,k2_0,k2_1,k2_2,k2_3,k2_4 : signed(7 downto 0);

begin

-- Genero tutti i segnali k per il primo ingresso x[3k]
reg_k_0: reg generic map(Nbit => 8) port map(CLK,RST_n,VIN,IN3k,k_0);
reg_k_1: reg generic map(Nbit => 8) port map(CLK,RST_n,VIN,k_0,k_1);
reg_k_2: reg generic map(Nbit => 8) port map(CLK,RST_n,VIN,k_1,k_2);
reg_k_3: reg generic map(Nbit => 8) port map(CLK,RST_n,VIN,k_2,k_3);

-- Genero tutti i sengnali k1 per il secondo ingresso x[3k+1]
reg_k1_0: reg generic map(Nbit => 8) port map(CLK,RST_n,VIN,IN3k1,k1_0);
reg_k1_1: reg generic map(Nbit => 8) port map(CLK,RST_n,VIN,k1_0,k1_1);
reg_k1_2: reg generic map(Nbit => 8) port map(CLK,RST_n,VIN,k1_1,k1_2);
reg_k1_3: reg generic map(Nbit => 8) port map(CLK,RST_n,VIN,k1_2,k1_3);

-- Genero tutti i segnali k2 per il terzo ingresso x[3k+2]
reg_k2_0: reg generic map(Nbit => 8) port map(CLK,RST_n,VIN,IN3k2,k2_0);
reg_k2_1: reg generic map(Nbit => 8) port map(CLK,RST_n,VIN,k2_0,k2_1);
reg_k2_2: reg generic map(Nbit => 8) port map(CLK,RST_n,VIN,k2_1,k2_2);
reg_k2_3: reg generic map(Nbit => 8) port map(CLK,RST_n,VIN,k2_2,k2_3);
reg_k2_4: reg generic map(Nbit => 8) port map(CLK,RST_n,VIN,k2_3,k2_4);

-- Implemento il primo ramo
branch3k: fir_scheme port map(	k_0,k2_1,k1_1,k_1,k2_2,k1_2,k_2,k2_3,k1_3,k_3,k2_4,
								H0,H1,H2,H3,H4,H5,H6,H7,H8,H9,H10,OUT3k);

-- Implemento il secondo ramo
branch3k1: fir_scheme port map(	k1_0,k_0,k2_1,k1_1,k_1,k2_2,k1_2,k_2,k2_3,k1_3,k_3,
								H0,H1,H2,H3,H4,H5,H6,H7,H8,H9,H10,OUT3k1);

-- Implemento il terzo ramo
branch3k2: fir_scheme port map(	k2_0,k1_0,k_0,k2_1,k1_1,k_1,k2_2,k1_2,k_2,k2_3,k1_3,
								H0,H1,H2,H3,H4,H5,H6,H7,H8,H9,H10,OUT3k2);

-- Genero il segnale di DONE
process(CLK, RST_n)
begin 
  if(RST_n = '0') then VOUT <= '0';
  elsif (rising_edge(CLK)) then 
    if (VIN = '1') then VOUT <= '1'; 
    else VOUT <= '0';
    end if; 
  end if;
end process;
				
end bhe;







