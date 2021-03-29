library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;	
use ieee.std_logic_arith.all;

entity ALU is 			
	port (		
    NR1:in std_logic_vector(7 downto 0);	
	NR2:in std_logic_vector(7 downto 0); 
	Sel : in std_logic_vector(1 downto 0);
	Rez: out std_logic_vector(15 downto 0)); 
end entity;


architecture arch of ALU is	

component full_adder is
	port (A,B :in std_logic_vector(7 downto 0);
	Cin :in std_logic;
	S: out std_logic_vector (7 downto 0);
	Cout :out std_logic:='0');
end component full_adder;	 

component Multiplier_8 is
    Port ( X : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
           Y : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
           REZ : OUT STD_LOGIC_VECTOR(13 DOWNTO 0)); 
end component Multiplier_8;			

component divider is		
	port (
    A:in std_logic_vector(7 downto 0);	
	B:in std_logic_vector(7 downto 0);  
	Q:out std_logic_vector(7 downto 0)); 
end component divider;	 

component C2 is
	port (inside : in std_logic_vector(15 downto 0);
	outside : out std_logic_vector (15 downto 0));
end component C2;

signal a1,s1 : std_logic_vector(7 downto 0):="00000000";	
signal b1 : std_logic_vector(7 downto 0):="00000000";
signal cin1: std_logic:='0';
signal cout1: std_logic:='0';	
signal rez0  : std_logic_vector(7 downto 0):="00000000"; 
signal rez1  : std_logic_vector(7 downto 0):="00000000"; 
signal rez2  : std_logic_vector(13 downto 0):="00000000000000";	 
signal Rezultat, RezInt : std_logic_vector(15 downto 0):="0000000000000000";
begin
	
process (NR1,NR2,Sel,a1,b1,s1,cin1,cout1,rez0,rez1,rez2,Rezultat, RezInt)
begin
	
	case Sel is 
		when "00" => 		--adunare
			a1 <= NR1;
			b1 <= NR2;
			--Rez <= "00000000" & rez0;
			Rez <= rez0(7)&rez0(7)&rez0(7)&rez0(7)&rez0(7)&rez0(7)&rez0(7)&rez0(7)& rez0;
			
		when "01" => 	  --scadere
			a1 <= NR1;
			b1 <= not(NR2) + '1'; 	 
			--Rez <= "00000000" & rez0;
			--Rez <= "0000000" & cout1 & s1;
			Rez <= rez0(7)&rez0(7)&rez0(7)&rez0(7)&rez0(7)&rez0(7)&rez0(7)&rez0(7)& rez0;
			
		when "10" => 		--impartire
		if (NR1(7)='1') and (NR2(7)='0') then 
			a1 <= not(NR1) + '1'; 
			b1 <=NR2;
		end if;	  
		if (NR1(7)='0') and (NR2(7)='1') then 
			a1<=NR1;
			b1<=not(NR2) + '1';
		end if;
		
		if (NR1(7)='1') and (NR2(7)='1') then 
			a1<=not(NR1) + '1'; 
			b1<=not(NR2) + '1';
		end if;	 
		
		if (NR1(7)='0') and (NR2(7)='0') then 
			a1<=NR1; 
			b1<=NR2;
		end if;		 
		
		Rezultat <= (Nr1(7) xor NR2(7))& (Nr1(7) xor NR2(7)) & '0' & '0' & '0' & '0' & '0' & '0' & rez1;
		REZ <= RezInt;
	
		when others => 	  --inmultire
			if (NR1(7)='1') and (NR2(7)='0') then 
			a1<=not(NR1) + '1'; 
			b1<=NR2;
		end if;	  
		if (NR1(7)='0') and (NR2(7)='1') then 
			a1<=NR1;
			b1<=not(NR2) + '1';
		end if;
		
		if (NR1(7)='1') and (NR2(7)='1') then 
			a1<=not(NR1) + '1'; 
			b1<=not(NR2) + '1';
		end if;	 
		
		if (NR1(7)='0') and (NR2(7)='0') then 
			a1<=NR1; 
			b1<=NR2;
		end if;
		Rezultat <=  (Nr1(7) xor NR2(7)) & (Nr1(7) xor NR2(7)) & rez2;
		REZ <= RezInt;
	end case;  
	
end process;

Add: full_adder port map (a1,b1,cin1,rez0,cout1);
Divide: divider port map (a1, b1,rez1);			
Multi: Multiplier_8 port map (a1(6 DOWNTO 0),b1(6 DOWNTO 0),rez2);	
Comp2: C2 port map (Rezultat,RezInt);	
end architecture;
