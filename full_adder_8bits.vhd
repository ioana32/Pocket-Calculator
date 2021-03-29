library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
   
entity full_adder is
	port (A,B :in std_logic_vector(7 downto 0);
	Cin :in std_logic;
	S: out std_logic_vector (7 downto 0);
	Cout :out std_logic:='0');
end  full_adder;	

architecture arch1 of full_adder is
component adder is 
	   port (Cin,A,B :in std_logic;
	   S,Cout:out std_logic);
   end   component;	
signal CinS : STD_logic_vector(7 downto 0):="00000000";
signal CoutS : STD_logic_vector(7 downto 0):="00000000";

begin 	
	adder_0:adder port map (Cin, A(0), B(0), S(0), CoutS(0)); 
	adder_1:adder port map (CoutS(0), A(1), B(1), S(1), CoutS(1));
	adder_2:adder port map (CoutS(1), A(2), B(2), S(2), CoutS(2));
	adder_3:adder port map (CoutS(2), A(3), B(3), S(3), CoutS(3));
	adder_4:adder port map (CoutS(3), A(4), B(4), S(4), CoutS(4));
	adder_5:adder port map (CoutS(4), A(5), B(5), S(5), CoutS(5));
	adder_6:adder port map (CoutS(5), A(6), B(6), S(6), CoutS(6));
	adder_8:adder port map (CoutS(6), A(7), B(7), S(7), Cout);
	
	end arch1;
	
	
